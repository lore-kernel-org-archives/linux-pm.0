From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] thermal: intel_pch_thermal: Enable Haswell PCH
Date: Mon,  3 Oct 2016 12:36:02 -0700
Message-ID: <1475523362-64566-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:42263 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751583AbcJCTgF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Oct 2016 15:36:05 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Added missing support for Haswell PCH thermal sensor.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
	Added one more PCI vendor id for Haswell


 drivers/thermal/intel_pch_thermal.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/thermal/intel_pch_thermal.c b/drivers/thermal/intel_pch_thermal.c
index 9b4815e..b19cecc2 100644
--- a/drivers/thermal/intel_pch_thermal.c
+++ b/drivers/thermal/intel_pch_thermal.c
@@ -24,6 +24,8 @@
 #include <linux/pm.h>
 
 /* Intel PCH thermal Device IDs */
+#define PCH_THERMAL_DID_HSW_1	0x9C24 /* Haswell PCH */
+#define PCH_THERMAL_DID_HSW_2	0x8C24 /* Haswell PCH */
 #define PCH_THERMAL_DID_WPT	0x9CA4 /* Wildcat Point */
 #define PCH_THERMAL_DID_SKL	0x9D31 /* Skylake PCH */
 
@@ -242,6 +244,11 @@ static int intel_pch_thermal_probe(struct pci_dev *pdev,
 		ptd->ops = &pch_dev_ops_wpt;
 		dev_name = "pch_skylake";
 		break;
+	case PCH_THERMAL_DID_HSW_1:
+	case PCH_THERMAL_DID_HSW_2:
+		ptd->ops = &pch_dev_ops_wpt;
+		dev_name = "pch_haswell";
+		break;
 	default:
 		dev_err(&pdev->dev, "unknown pch thermal device\n");
 		return -ENODEV;
@@ -324,6 +331,8 @@ static int intel_pch_thermal_resume(struct device *device)
 static struct pci_device_id intel_pch_thermal_id[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_WPT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_SKL) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_HSW_1) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_HSW_2) },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, intel_pch_thermal_id);
-- 
2.5.5

