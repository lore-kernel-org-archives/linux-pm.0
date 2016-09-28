From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: intel_pch_thermal: Enable Haswell PCH
Date: Wed, 28 Sep 2016 12:17:28 -0700
Message-ID: <1475090248-122614-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:28795 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932287AbcI1TRa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Sep 2016 15:17:30 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Added missing support for Haswell PCH thermal sensor.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel_pch_thermal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/intel_pch_thermal.c b/drivers/thermal/intel_pch_thermal.c
index 6a6ec1c..bee8dd9 100644
--- a/drivers/thermal/intel_pch_thermal.c
+++ b/drivers/thermal/intel_pch_thermal.c
@@ -23,6 +23,7 @@
 #include <linux/thermal.h>
 
 /* Intel PCH thermal Device IDs */
+#define PCH_THERMAL_DID_HSW	0x9C24 /* Haswell PCH */
 #define PCH_THERMAL_DID_WPT	0x9CA4 /* Wildcat Point */
 #define PCH_THERMAL_DID_SKL	0x9D31 /* Skylake PCH */
 
@@ -206,6 +207,10 @@ static int intel_pch_thermal_probe(struct pci_dev *pdev,
 		ptd->ops = &pch_dev_ops_wpt;
 		dev_name = "pch_skylake";
 		break;
+	case PCH_THERMAL_DID_HSW:
+		ptd->ops = &pch_dev_ops_wpt;
+		dev_name = "pch_haswell";
+		break;
 	default:
 		dev_err(&pdev->dev, "unknown pch thermal device\n");
 		return -ENODEV;
@@ -272,6 +277,7 @@ static void intel_pch_thermal_remove(struct pci_dev *pdev)
 static struct pci_device_id intel_pch_thermal_id[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_WPT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_SKL) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_HSW) },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, intel_pch_thermal_id);
-- 
2.5.0

