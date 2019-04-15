From: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Subject: [PATCH] thermal: intel: int340x: processor_thermal_device: simplify to get driver data
Date: Mon, 15 Apr 2019 20:18:30 +0530
Message-ID: <1555339710-28028-1-git-send-email-sumeet.r.pawnikar@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, srinivas.pandruvada@linux.intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com, sumeet.r.pawnikar@intel.com
List-Id: linux-pm@vger.kernel.org

From: "Pawnikar, Sumeet R" <sumeet.r.pawnikar@intel.com>

This simplifies getting the 'driver_data' from 'struct device' directly.
Going through platform_device or pci_dev is not required. Also removes
condition check as the private data stored with dev pointer, means
irrespective of enumeration mode, we can use dev_get_drvdata().
This removes the unnecessary step back and forth.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 .../int340x_thermal/processor_thermal_device.c     |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 8e1cf4d..2a7cbaa 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -81,22 +81,13 @@ enum proc_thermal_emum_mode_type {
 					struct device_attribute *attr, \
 					char *buf) \
 { \
-	struct pci_dev *pci_dev; \
-	struct platform_device *pdev; \
-	struct proc_thermal_device *proc_dev; \
+	struct proc_thermal_device *proc_dev = dev_get_drvdata(dev); \
 	\
 	if (proc_thermal_emum_mode == PROC_THERMAL_NONE) { \
 		dev_warn(dev, "Attempted to get power limit before device was initialized!\n"); \
 		return 0; \
 	} \
 	\
-	if (proc_thermal_emum_mode == PROC_THERMAL_PLATFORM_DEV) { \
-		pdev = to_platform_device(dev); \
-		proc_dev = platform_get_drvdata(pdev); \
-	} else { \
-		pci_dev = to_pci_dev(dev); \
-		proc_dev = pci_get_drvdata(pci_dev); \
-	} \
 	return sprintf(buf, "%lu\n",\
 	(unsigned long)proc_dev->power_limits[index].suffix * 1000); \
 }
-- 
1.7.9.5
