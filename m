From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: intel_pch_thermal: Enable Skylake PCH thermal
Date: Tue,  2 Feb 2016 00:03:41 -0800
Message-ID: <1454400221-10628-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:3297 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753110AbcBBIEW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Feb 2016 03:04:22 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Enabled temperature reporting device of Skylake Platform Controller hub.
The register map is same as the wildcat point thermal currently implemented
in this driver.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel_pch_thermal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/intel_pch_thermal.c b/drivers/thermal/intel_pch_thermal.c
index 00d81af..6a6ec1c 100644
--- a/drivers/thermal/intel_pch_thermal.c
+++ b/drivers/thermal/intel_pch_thermal.c
@@ -24,6 +24,7 @@
 
 /* Intel PCH thermal Device IDs */
 #define PCH_THERMAL_DID_WPT	0x9CA4 /* Wildcat Point */
+#define PCH_THERMAL_DID_SKL	0x9D31 /* Skylake PCH */
 
 /* Wildcat Point-LP  PCH Thermal registers */
 #define WPT_TEMP	0x0000	/* Temperature */
@@ -201,6 +202,10 @@ static int intel_pch_thermal_probe(struct pci_dev *pdev,
 		ptd->ops = &pch_dev_ops_wpt;
 		dev_name = "pch_wildcat_point";
 		break;
+	case PCH_THERMAL_DID_SKL:
+		ptd->ops = &pch_dev_ops_wpt;
+		dev_name = "pch_skylake";
+		break;
 	default:
 		dev_err(&pdev->dev, "unknown pch thermal device\n");
 		return -ENODEV;
@@ -266,6 +271,7 @@ static void intel_pch_thermal_remove(struct pci_dev *pdev)
 
 static struct pci_device_id intel_pch_thermal_id[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_WPT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_SKL) },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, intel_pch_thermal_id);
-- 
2.5.0

