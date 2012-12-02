From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 01/34] Thermal: Refactor thermal.h file
Date: Sun,  2 Dec 2012 22:44:35 +0800
Message-ID: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:60872 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301Ab2LBOpd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:33 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Durgadoss R <durgadoss.r@intel.com>, Zhang Rui <rui.zhang@intel.com>

From: Durgadoss R <durgadoss.r@intel.com>

This patch rearranges the code in thermal.h file,
in the following order, so that it is easy to
read/maintain.
1. All #defines
2. All enums
3. All fops structures
4. All device structures
5. All function declarations

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 include/linux/thermal.h |   78 ++++++++++++++++++++++++++---------------------
 1 files changed, 43 insertions(+), 35 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 91b3481..8611e3e 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -29,6 +29,23 @@
 #include <linux/device.h>
 #include <linux/workqueue.h>
 
+#define THERMAL_TRIPS_NONE	-1
+#define THERMAL_MAX_TRIPS	12
+#define THERMAL_NAME_LENGTH	20
+
+/* No upper/lower limit requirement */
+#define THERMAL_NO_LIMIT	-1UL
+
+/* Unit conversion macros */
+#define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >= 0) ?	\
+				((long)t-2732+5)/10 : ((long)t-2732-5)/10)
+#define CELSIUS_TO_KELVIN(t)	((t)*10+2732)
+
+/* Adding event notification support elements */
+#define THERMAL_GENL_FAMILY_NAME                "thermal_event"
+#define THERMAL_GENL_VERSION                    0x01
+#define THERMAL_GENL_MCAST_GROUP_NAME           "thermal_mc_group"
+
 struct thermal_zone_device;
 struct thermal_cooling_device;
 
@@ -50,6 +67,30 @@ enum thermal_trend {
 	THERMAL_TREND_DROPPING, /* temperature is dropping */
 };
 
+/* Events supported by Thermal Netlink */
+enum events {
+	THERMAL_AUX0,
+	THERMAL_AUX1,
+	THERMAL_CRITICAL,
+	THERMAL_DEV_FAULT,
+};
+
+/* attributes of thermal_genl_family */
+enum {
+	THERMAL_GENL_ATTR_UNSPEC,
+	THERMAL_GENL_ATTR_EVENT,
+	__THERMAL_GENL_ATTR_MAX,
+};
+#define THERMAL_GENL_ATTR_MAX (__THERMAL_GENL_ATTR_MAX - 1)
+
+/* commands supported by the thermal_genl_family */
+enum {
+	THERMAL_GENL_CMD_UNSPEC,
+	THERMAL_GENL_CMD_EVENT,
+	__THERMAL_GENL_CMD_MAX,
+};
+#define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
+
 struct thermal_zone_device_ops {
 	int (*bind) (struct thermal_zone_device *,
 		     struct thermal_cooling_device *);
@@ -83,11 +124,6 @@ struct thermal_cooling_device_ops {
 	int (*set_cur_state) (struct thermal_cooling_device *, unsigned long);
 };
 
-#define THERMAL_NO_LIMIT -1UL /* no upper/lower limit requirement */
-
-#define THERMAL_TRIPS_NONE -1
-#define THERMAL_MAX_TRIPS 12
-#define THERMAL_NAME_LENGTH 20
 struct thermal_cooling_device {
 	int id;
 	char type[THERMAL_NAME_LENGTH];
@@ -100,10 +136,6 @@ struct thermal_cooling_device {
 	struct list_head node;
 };
 
-#define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >= 0) ?	\
-				((long)t-2732+5)/10 : ((long)t-2732-5)/10)
-#define CELSIUS_TO_KELVIN(t)	((t)*10+2732)
-
 struct thermal_attr {
 	struct device_attribute attr;
 	char name[THERMAL_NAME_LENGTH];
@@ -131,38 +163,13 @@ struct thermal_zone_device {
 	struct list_head node;
 	struct delayed_work poll_queue;
 };
-/* Adding event notification support elements */
-#define THERMAL_GENL_FAMILY_NAME                "thermal_event"
-#define THERMAL_GENL_VERSION                    0x01
-#define THERMAL_GENL_MCAST_GROUP_NAME           "thermal_mc_group"
-
-enum events {
-	THERMAL_AUX0,
-	THERMAL_AUX1,
-	THERMAL_CRITICAL,
-	THERMAL_DEV_FAULT,
-};
 
 struct thermal_genl_event {
 	u32 orig;
 	enum events event;
 };
-/* attributes of thermal_genl_family */
-enum {
-	THERMAL_GENL_ATTR_UNSPEC,
-	THERMAL_GENL_ATTR_EVENT,
-	__THERMAL_GENL_ATTR_MAX,
-};
-#define THERMAL_GENL_ATTR_MAX (__THERMAL_GENL_ATTR_MAX - 1)
-
-/* commands supported by the thermal_genl_family */
-enum {
-	THERMAL_GENL_CMD_UNSPEC,
-	THERMAL_GENL_CMD_EVENT,
-	__THERMAL_GENL_CMD_MAX,
-};
-#define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
 
+/* Function declarations */
 struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
 		void *, const struct thermal_zone_device_ops *, int, int);
 void thermal_zone_device_unregister(struct thermal_zone_device *);
@@ -173,6 +180,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
 int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
 				       struct thermal_cooling_device *);
 void thermal_zone_device_update(struct thermal_zone_device *);
+
 struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
 		const struct thermal_cooling_device_ops *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
-- 
1.7.7.6

