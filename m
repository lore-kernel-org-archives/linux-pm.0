From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1] thermal: core: Fix use-after-free in thermal_cooling_device_destroy_sysfs
Date: Mon, 13 Aug 2018 20:14:00 +0300
Message-ID: <20180813171400.15345-1-digetx@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch fixes use-after-free that was detected by KASAN. The bug is
triggered on a CPUFreq driver module unload by freeing 'cdev' on device
unregister and then using the freed structure during of the cdev's sysfs
data destruction. The solution is to unregister the sysfs at first, then
destroy sysfs data and finally release the cooling device.

Cc: <stable@vger.kernel.org> # v4.17+
Fixes: 8ea229511e06 ("thermal: Add cooling device's statistics in sysfs")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/thermal/thermal_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6ab982309e6a..441778100887 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1102,8 +1102,9 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 	mutex_unlock(&thermal_list_lock);
 
 	ida_simple_remove(&thermal_cdev_ida, cdev->id);
-	device_unregister(&cdev->device);
+	device_del(&cdev->device);
 	thermal_cooling_device_destroy_sysfs(cdev);
+	put_device(&cdev->device);
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
 
-- 
2.18.0
