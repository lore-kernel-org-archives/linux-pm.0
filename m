From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 06/34] Thermal: Add thermal governor registration APIs
Date: Sun,  2 Dec 2012 22:44:40 +0800
Message-ID: <1354459508-3707-6-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:33009 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441Ab2LBOpe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:34 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Durgadoss R <durgadoss.r@intel.com>, Zhang Rui <rui.zhang@intel.com>

From: Durgadoss R <durgadoss.r@intel.com>

This patch creates a structure to hold platform
thermal governor information, and provides APIs
for individual thermal governors to register/unregister
with the Thermal framework.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_sys.c |   90 +++++++++++++++++++++++++++++++++++++++++
 include/linux/thermal.h       |   16 +++++++
 2 files changed, 106 insertions(+), 0 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index dca3bfc..0afd84c 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -49,7 +49,86 @@ static DEFINE_MUTEX(thermal_idr_lock);
 
 static LIST_HEAD(thermal_tz_list);
 static LIST_HEAD(thermal_cdev_list);
+static LIST_HEAD(thermal_governor_list);
+
 static DEFINE_MUTEX(thermal_list_lock);
+static DEFINE_MUTEX(thermal_governor_lock);
+
+static struct thermal_governor *__find_governor(const char *name)
+{
+	struct thermal_governor *pos;
+
+	list_for_each_entry(pos, &thermal_governor_list, governor_list)
+		if (!strnicmp(name, pos->name, THERMAL_NAME_LENGTH))
+			return pos;
+
+	return NULL;
+}
+
+int thermal_register_governor(struct thermal_governor *governor)
+{
+	int err;
+	const char *name;
+	struct thermal_zone_device *pos;
+
+	if (!governor)
+		return -EINVAL;
+
+	mutex_lock(&thermal_governor_lock);
+
+	err = -EBUSY;
+	if (__find_governor(governor->name) == NULL) {
+		err = 0;
+		list_add(&governor->governor_list, &thermal_governor_list);
+	}
+
+	mutex_lock(&thermal_list_lock);
+
+	list_for_each_entry(pos, &thermal_tz_list, node) {
+		if (pos->governor)
+			continue;
+		if (pos->tzp)
+			name = pos->tzp->governor_name;
+		else
+			name = DEFAULT_THERMAL_GOVERNOR;
+		if (!strnicmp(name, governor->name, THERMAL_NAME_LENGTH))
+			pos->governor = governor;
+	}
+
+	mutex_unlock(&thermal_list_lock);
+	mutex_unlock(&thermal_governor_lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(thermal_register_governor);
+
+void thermal_unregister_governor(struct thermal_governor *governor)
+{
+	struct thermal_zone_device *pos;
+
+	if (!governor)
+		return;
+
+	mutex_lock(&thermal_governor_lock);
+
+	if (__find_governor(governor->name) == NULL)
+		goto exit;
+
+	mutex_lock(&thermal_list_lock);
+
+	list_for_each_entry(pos, &thermal_tz_list, node) {
+		if (!strnicmp(pos->governor->name, governor->name,
+						THERMAL_NAME_LENGTH))
+			pos->governor = NULL;
+	}
+
+	mutex_unlock(&thermal_list_lock);
+	list_del(&governor->governor_list);
+exit:
+	mutex_unlock(&thermal_governor_lock);
+	return;
+}
+EXPORT_SYMBOL_GPL(thermal_unregister_governor);
 
 static int get_idr(struct idr *idr, struct mutex *lock, int *id)
 {
@@ -1437,6 +1516,16 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	if (result)
 		goto unregister;
 
+	/* Update 'this' zone's governor information */
+	mutex_lock(&thermal_governor_lock);
+
+	if (tz->tzp)
+		tz->governor = __find_governor(tz->tzp->governor_name);
+	else
+		tz->governor = __find_governor(DEFAULT_THERMAL_GOVERNOR);
+
+	mutex_unlock(&thermal_governor_lock);
+
 	result = thermal_add_hwmon_sysfs(tz);
 	if (result)
 		goto unregister;
@@ -1500,6 +1589,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	if (tz->ops->get_mode)
 		device_remove_file(&tz->device, &dev_attr_mode);
 	remove_trip_attrs(tz);
+	tz->governor = NULL;
 
 	thermal_remove_hwmon_sysfs(tz);
 	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 58cb1c0..6182bd5 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -46,6 +46,9 @@
 #define THERMAL_GENL_VERSION                    0x01
 #define THERMAL_GENL_MCAST_GROUP_NAME           "thermal_mc_group"
 
+/* Default Thermal Governor: Does Linear Throttling */
+#define DEFAULT_THERMAL_GOVERNOR	"step_wise"
+
 struct thermal_zone_device;
 struct thermal_cooling_device;
 
@@ -158,6 +161,7 @@ struct thermal_zone_device {
 	unsigned int forced_passive;
 	const struct thermal_zone_device_ops *ops;
 	const struct thermal_zone_params *tzp;
+	struct thermal_governor *governor;
 	struct list_head thermal_instances;
 	struct idr idr;
 	struct mutex lock; /* protect thermal_instances list */
@@ -165,6 +169,14 @@ struct thermal_zone_device {
 	struct delayed_work poll_queue;
 };
 
+/* Structure that holds thermal governor information */
+struct thermal_governor {
+	char name[THERMAL_NAME_LENGTH];
+	int (*throttle)(struct thermal_zone_device *tz, int trip);
+	struct list_head	governor_list;
+	struct module		*owner;
+};
+
 /* Structure that holds binding parameters for a zone */
 struct thermal_bind_params {
 	struct thermal_cooling_device *cdev;
@@ -189,6 +201,7 @@ struct thermal_bind_params {
 
 /* Structure to define Thermal Zone parameters */
 struct thermal_zone_params {
+	char governor_name[THERMAL_NAME_LENGTH];
 	int num_tbps;	/* Number of tbp entries */
 	struct thermal_bind_params *tbp;
 };
@@ -219,6 +232,9 @@ int get_tz_trend(struct thermal_zone_device *, int);
 struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
 		struct thermal_cooling_device *, int);
 
+int thermal_register_governor(struct thermal_governor *);
+void thermal_unregister_governor(struct thermal_governor *);
+
 #ifdef CONFIG_NET
 extern int thermal_generate_netlink_event(u32 orig, enum events event);
 #else
-- 
1.7.7.6

