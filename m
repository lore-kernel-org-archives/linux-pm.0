From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCHv4 1/9] Thermal: Check for validity before doing kfree
Date: Wed,  2 Oct 2013 00:08:00 +0530
Message-ID: <1380652688-5787-2-git-send-email-durgadoss.r@intel.com>
References: <1380652688-5787-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1380652688-5787-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, eduardo.valentin@ti.com, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, hongbo.zhang@freescale.com, wni@nvidia.com, Durgadoss R <durgadoss.r@intel.com>
List-Id: linux-pm@vger.kernel.org

The thermal_release function is called whenever
any device belonging to 'thermal' class unregisters.
This function performs kfree(cdev) without any check.
In cases where there are more device registrations
other than just 'thermal_zone' and 'cooling_device'
this might accidently free memory allocated them
silently; and cause memory errors.

This patch changes this behavior by doing
kfree(cdev) only when the device pointer belongs
to a real cdev i.e. cooling_device.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/thermal_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 1f02e8e..8c5131d 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1280,7 +1280,8 @@ static void thermal_release(struct device *dev)
 		     sizeof("thermal_zone") - 1)) {
 		tz = to_thermal_zone(dev);
 		kfree(tz);
-	} else {
+	} else if(!strncmp(dev_name(dev), "cooling_device",
+			sizeof("cooling_device") - 1)){
 		cdev = to_cooling_device(dev);
 		kfree(cdev);
 	}
-- 
1.7.9.5
