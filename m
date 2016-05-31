From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 15/15] thermal: sysfs: add comments describing locking strategy
Date: Mon, 30 May 2016 23:31:36 -0700
Message-ID: <1464676296-5610-16-git-send-email-edubezval@gmail.com>
References: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

The locking strategy of sysfs entries in thermal subsystem
is to hold a lock to serialize access to struct thermal_zone_device
and struct thermal_cooling_device data. Besides, the respective
locks will also be held if calls to ops need to be done to fetch
data or to trigger driver actions.

The exception of the locking strategy are functions called
during initialization of cdev and tz.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_sysfs.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 31314be..743df50 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -23,7 +23,14 @@
 
 #include "thermal_core.h"
 
-/* sys I/F for thermal zone */
+/*
+ * sys I/F for thermal zone
+ *
+ * Note on locking. The sysfs interface will always first
+ * lock the zone to serialize data access and ops calls.
+ * All calls to thermal_core and thermal_helpers are assumed
+ * to handle locking properly.
+ */
 
 static ssize_t
 type_show(struct device *dev, struct device_attribute *attr, char *buf)
@@ -555,6 +562,9 @@ static const struct attribute_group *thermal_zone_attribute_groups[] = {
  * helper function to instantiate sysfs entries for every trip
  * point and its properties of a struct thermal_zone_device.
  *
+ * This function is assumed to be called only during probe,
+ * and therefore no locking in the thermal zone device is done.
+ *
  * Return: 0 on success, the proper error value otherwise.
  */
 static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
@@ -770,6 +780,10 @@ static const struct attribute_group *cooling_device_attr_groups[] = {
 	NULL,
 };
 
+/*
+ * Assumed to be called at the creation of the cooling device
+ * and for this reason, no locking is done
+ */
 void thermal_cooling_device_setup_sysfs(struct thermal_cooling_device *cdev)
 {
 	cdev->device.groups = cooling_device_attr_groups;
-- 
2.1.4
