From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH 3/3] thermal: show the sub thermal zones in sysfs
Date: Fri, 30 Oct 2015 16:46:11 +0000
Message-ID: <1446223571-23272-4-git-send-email-javi.merino@arm.com>
References: <1446223571-23272-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446223571-23272-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rui.zang@intel.com, edubezval@gmail.com, Punit.Agrawal@arm.com, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

When a thermal zone is created that has sub thermal zones via
devicetree or via thermal_zone_add_subtz() expose that relationship in
sysfs.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 Documentation/thermal/sysfs-api.txt |  5 +++++
 drivers/thermal/thermal_core.c      | 22 ++++++++++++++++++++++
 include/linux/thermal.h             |  3 +++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index 5650b7eaaf7e..53972973792a 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -220,6 +220,7 @@ Thermal zone device sys I/F, created once it's registered:
     |---trip_point_[0-*]_type:	Trip point type
     |---trip_point_[0-*]_hyst:	Hysteresis value for this trip point
     |---emul_temp:		Emulated temperature set node
+    |---subtz[0-*]              Slave thermal zones of this thermal zone
     |---sustainable_power:      Sustainable dissipatable power
     |---k_po:                   Proportional term during temperature overshoot
     |---k_pu:                   Proportional term during temperature undershoot
@@ -355,6 +356,10 @@ emul_temp
 	  because userland can easily disable the thermal policy by simply
 	  flooding this sysfs node with low temperature values.
 
+subtz[0-*]
+	sysfs link to the slave thermal zone device.
+        RO, Optional
+
 sustainable_power
 	An estimate of the sustained power that can be dissipated by
 	the thermal zone. Used by the power allocator governor. For
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index a2ab482337f3..af72b704af36 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -62,6 +62,8 @@ static DEFINE_MUTEX(thermal_governor_lock);
 static struct thermal_governor *def_governor;
 
 struct thermal_zone_link {
+	int id;
+	char name[THERMAL_NAME_LENGTH];
 	struct thermal_zone_device *slave;
 	struct list_head node;
 };
@@ -2076,6 +2078,23 @@ int thermal_zone_add_subtz(struct thermal_zone_device *tz,
 	link->slave = subtz;
 	list_add_tail(&link->node, &tz->slave_tzs);
 
+	ret = get_idr(&tz->link_idr, NULL, &link->id);
+	if (ret) {
+		/*
+		 * Even if we couldn't create the symlink in sysfs,
+		 * we've linked the thermal zones, so return success
+		 */
+		ret = 0;
+		goto unlock;
+	}
+
+	snprintf(link->name, ARRAY_SIZE(link->name), "subtz%d", link->id);
+	ret = sysfs_create_link(&tz->device.kobj, &subtz->device.kobj,
+				link->name);
+	if (ret)
+		pr_warn("Failed to create symlink to sub thermal zone: %d\n",
+			ret);
+
 	ret = 0;
 
 unlock:
@@ -2107,6 +2126,9 @@ int thermal_zone_del_subtz(struct thermal_zone_device *tz,
 
 	list_for_each_entry(link, &tz->slave_tzs, node) {
 		if (link->slave == subtz) {
+			sysfs_remove_link(&tz->device.kobj, link->name);
+			release_idr(&tz->link_idr, NULL, link->id);
+
 			list_del(&link->node);
 			kfree(link);
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 7996b4e7e61a..c5ca3be8b7ec 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -174,6 +174,8 @@ struct thermal_attr {
  * @thermal_instances:	list of &struct thermal_instance of this thermal zone
  * @idr:	&struct idr to generate unique id for this zone's cooling
  *		devices
+ * @link_idr:	&struct idr to generate unique ids for this zone's links to
+ *		other thermal zones
  * @lock:	lock to protect thermal_instances list
  * @node:	node in thermal_tz_list (in thermal_core.c)
  * @poll_queue:	delayed work for polling
@@ -202,6 +204,7 @@ struct thermal_zone_device {
 	void *governor_data;
 	struct list_head thermal_instances;
 	struct idr idr;
+	struct idr link_idr;
 	struct mutex lock;
 	struct list_head node;
 	struct delayed_work poll_queue;
-- 
1.9.1
