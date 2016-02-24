From: Srikar Srimath Tirumala <srikars@nvidia.com>
Subject: [RFC][PATCH] thermal: add sysfs_notify on some attributes
Date: Tue, 23 Feb 2016 20:11:58 -0800
Message-ID: <1456287118-32510-1-git-send-email-srikars@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: srikars@nvidia.com, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add a sysfs_notify on thermal_zone*/temp and cooling_device*/
cur_state whenever a passive or critical trip is triggered.

This change allows usermode apps to register itself to get notified,
when certain thermal conditions occur and reduce their workload.
This workload throttling can reduce\prevent throttling of hardware
clocks while allowing some other critical apps to run longer reliably.

Signed-off-by: Srikar Srimath Tirumala <srikars@nvidia.com>
---
 drivers/thermal/thermal_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index a0a8fd1..d8d257d 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -567,6 +567,8 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 
 	for (count = 0; count < tz->trips; count++)
 		handle_thermal_trip(tz, count);
+
+	sysfs_notify(&tz->device.kobj, NULL, "temp");
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
 
@@ -1638,6 +1640,7 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 	cdev->updated = true;
 	trace_cdev_update(cdev, target);
 	dev_dbg(&cdev->device, "set to state %lu\n", target);
+	sysfs_notify(&cdev->device.kobj, NULL, "cur_state");
 }
 EXPORT_SYMBOL(thermal_cdev_update);
 
-- 
2.1.4
