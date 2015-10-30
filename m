From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 3/3][v3] Thermal: do thermal zone update after a cooling device registered
Date: Fri, 30 Oct 2015 16:32:10 +0800
Message-ID: <ffb964a5ec9f93e68814071a5d03bb9b65600b62.1446192980.git.yu.c.chen@intel.com>
References: <cover.1446192980.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1446192980.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: javi.merino@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When a new cooling device is registered, we need to update the
thermal zone to set the new registered cooling device to a proper
state.

This fixes a problem that the system is cool, while the fan devices
are left running on full speed after boot, if fan device is registered
after thermal zone device.

Here is the history of why current patch looks like this:
https://patchwork.kernel.org/patch/7273041/

CC: <stable@vger.kernel.org> #3.18+
Reference:https://bugzilla.kernel.org/show_bug.cgi?id=92431
Tested-by: Manuel Krause <manuelkrause@netscape.net>
Tested-by: szegad <szegadlo@poczta.onet.pl>
Tested-by: prash <prash.n.rao@gmail.com>
Tested-by: amish <ammdispose-arch@yahoo.com>
Reviewed-by: Javi Merino <javi.merino@arm.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/thermal/thermal_core.c | 14 +++++++++++++-
 include/linux/thermal.h        |  2 ++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9aae767..ba08b55 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1341,6 +1341,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	if (!result) {
 		list_add_tail(&dev->tz_node, &tz->thermal_instances);
 		list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
+		atomic_set(&tz->need_update, 1);
 	}
 	mutex_unlock(&cdev->lock);
 	mutex_unlock(&tz->lock);
@@ -1450,6 +1451,7 @@ __thermal_cooling_device_register(struct device_node *np,
 				  const struct thermal_cooling_device_ops *ops)
 {
 	struct thermal_cooling_device *cdev;
+	struct thermal_zone_device *pos = NULL;
 	int result;
 
 	if (type && strlen(type) >= THERMAL_NAME_LENGTH)
@@ -1494,6 +1496,12 @@ __thermal_cooling_device_register(struct device_node *np,
 	/* Update binding information for 'this' new cdev */
 	bind_cdev(cdev);
 
+	mutex_lock(&thermal_list_lock);
+	list_for_each_entry(pos, &thermal_tz_list, node)
+		if (atomic_cmpxchg(&pos->need_update, 1, 0))
+			thermal_zone_device_update(pos);
+	mutex_unlock(&thermal_list_lock);
+
 	return cdev;
 }
 
@@ -1826,6 +1834,8 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	tz->trips = trips;
 	tz->passive_delay = passive_delay;
 	tz->polling_delay = polling_delay;
+	/* A new thermal zone needs to be updated anyway. */
+	atomic_set(&tz->need_update, 1);
 
 	dev_set_name(&tz->device, "thermal_zone%d", tz->id);
 	result = device_register(&tz->device);
@@ -1921,7 +1931,9 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	INIT_DELAYED_WORK(&(tz->poll_queue), thermal_zone_device_check);
 
 	thermal_zone_device_reset(tz);
-	thermal_zone_device_update(tz);
+	/* Update the new thermal zone and mark it as already updated. */
+	if (atomic_cmpxchg(&tz->need_update, 1, 0))
+		thermal_zone_device_update(tz);
 
 	return tz;
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 5bcabc7..385d411 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -168,6 +168,7 @@ struct thermal_attr {
  * @forced_passive:	If > 0, temperature at which to switch on all ACPI
  *			processor cooling devices.  Currently only used by the
  *			step-wise governor.
+ * @need_update:	if equals 1, thermal_zone_device_update needs to be invoked.
  * @ops:	operations this &thermal_zone_device supports
  * @tzp:	thermal zone parameters
  * @governor:	pointer to the governor for this thermal zone
@@ -195,6 +196,7 @@ struct thermal_zone_device {
 	int emul_temperature;
 	int passive;
 	unsigned int forced_passive;
+	atomic_t need_update;
 	struct thermal_zone_device_ops *ops;
 	struct thermal_zone_params *tzp;
 	struct thermal_governor *governor;
-- 
1.8.4.2
