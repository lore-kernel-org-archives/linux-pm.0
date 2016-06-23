From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: intel_pch_thermal: Add suspend/resume callback
Date: Thu, 23 Jun 2016 15:02:46 -0700
Message-ID: <1466719366-18514-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44374 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752117AbcFWWB0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 23 Jun 2016 18:01:26 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, edubezval@gmail.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Added suspend/resume callback to disable/enable PCH thermal sensor
respectively. If the sensor is enabled by the BIOS, then the sensor status
will not be changed during suspend/resume.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel_pch_thermal.c | 60 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel_pch_thermal.c b/drivers/thermal/intel_pch_thermal.c
index 6a6ec1c..9b4815e 100644
--- a/drivers/thermal/intel_pch_thermal.c
+++ b/drivers/thermal/intel_pch_thermal.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/thermal.h>
+#include <linux/pm.h>
 
 /* Intel PCH thermal Device IDs */
 #define PCH_THERMAL_DID_WPT	0x9CA4 /* Wildcat Point */
@@ -65,6 +66,7 @@ struct pch_thermal_device {
 	unsigned long crt_temp;
 	int hot_trip_id;
 	unsigned long hot_temp;
+	bool bios_enabled;
 };
 
 static int pch_wpt_init(struct pch_thermal_device *ptd, int *nr_trips)
@@ -75,8 +77,10 @@ static int pch_wpt_init(struct pch_thermal_device *ptd, int *nr_trips)
 	*nr_trips = 0;
 
 	/* Check if BIOS has already enabled thermal sensor */
-	if (WPT_TSS_TSDSS & readb(ptd->hw_base + WPT_TSS))
+	if (WPT_TSS_TSDSS & readb(ptd->hw_base + WPT_TSS)) {
+		ptd->bios_enabled = true;
 		goto read_trips;
+	}
 
 	tsel = readb(ptd->hw_base + WPT_TSEL);
 	/*
@@ -130,9 +134,39 @@ static int pch_wpt_get_temp(struct pch_thermal_device *ptd, int *temp)
 	return 0;
 }
 
+static int pch_wpt_suspend(struct pch_thermal_device *ptd)
+{
+	u8 tsel;
+
+	if (ptd->bios_enabled)
+		return 0;
+
+	tsel = readb(ptd->hw_base + WPT_TSEL);
+
+	writeb(tsel & 0xFE, ptd->hw_base + WPT_TSEL);
+
+	return 0;
+}
+
+static int pch_wpt_resume(struct pch_thermal_device *ptd)
+{
+	u8 tsel;
+
+	if (ptd->bios_enabled)
+		return 0;
+
+	tsel = readb(ptd->hw_base + WPT_TSEL);
+
+	writeb(tsel | WPT_TSEL_ETS, ptd->hw_base + WPT_TSEL);
+
+	return 0;
+}
+
 struct pch_dev_ops {
 	int (*hw_init)(struct pch_thermal_device *ptd, int *nr_trips);
 	int (*get_temp)(struct pch_thermal_device *ptd, int *temp);
+	int (*suspend)(struct pch_thermal_device *ptd);
+	int (*resume)(struct pch_thermal_device *ptd);
 };
 
 
@@ -140,6 +174,8 @@ struct pch_dev_ops {
 static const struct pch_dev_ops pch_dev_ops_wpt = {
 	.hw_init = pch_wpt_init,
 	.get_temp = pch_wpt_get_temp,
+	.suspend = pch_wpt_suspend,
+	.resume = pch_wpt_resume,
 };
 
 static int pch_thermal_get_temp(struct thermal_zone_device *tzd, int *temp)
@@ -269,6 +305,22 @@ static void intel_pch_thermal_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
+static int intel_pch_thermal_suspend(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct pch_thermal_device *ptd = pci_get_drvdata(pdev);
+
+	return ptd->ops->suspend(ptd);
+}
+
+static int intel_pch_thermal_resume(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct pch_thermal_device *ptd = pci_get_drvdata(pdev);
+
+	return ptd->ops->resume(ptd);
+}
+
 static struct pci_device_id intel_pch_thermal_id[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_WPT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_SKL) },
@@ -276,11 +328,17 @@ static struct pci_device_id intel_pch_thermal_id[] = {
 };
 MODULE_DEVICE_TABLE(pci, intel_pch_thermal_id);
 
+static const struct dev_pm_ops intel_pch_pm_ops = {
+	.suspend = intel_pch_thermal_suspend,
+	.resume = intel_pch_thermal_resume,
+};
+
 static struct pci_driver intel_pch_thermal_driver = {
 	.name		= "intel_pch_thermal",
 	.id_table	= intel_pch_thermal_id,
 	.probe		= intel_pch_thermal_probe,
 	.remove		= intel_pch_thermal_remove,
+	.driver.pm	= &intel_pch_pm_ops,
 };
 
 module_pci_driver(intel_pch_thermal_driver);
-- 
2.5.5

