From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 3/3] thermal: pch: Add Cannon Lake support
Date: Wed,  1 Nov 2017 09:39:51 -0700
Message-ID: <20171101163951.27332-4-srinivas.pandruvada@linux.intel.com>
References: <20171101163951.27332-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171101163951.27332-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Added Cannon Lake PCH ids.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel_pch_thermal.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/thermal/intel_pch_thermal.c b/drivers/thermal/intel_pch_thermal.c
index c60b1cfcc64e..8a7f69b4b022 100644
--- a/drivers/thermal/intel_pch_thermal.c
+++ b/drivers/thermal/intel_pch_thermal.c
@@ -30,6 +30,8 @@
 #define PCH_THERMAL_DID_WPT	0x9CA4 /* Wildcat Point */
 #define PCH_THERMAL_DID_SKL	0x9D31 /* Skylake PCH */
 #define PCH_THERMAL_DID_SKL_H	0xA131 /* Skylake PCH 100 series */
+#define PCH_THERMAL_DID_CNL	0x9Df9 /* CNL PCH */
+#define PCH_THERMAL_DID_CNL_H	0xA379 /* CNL-H PCH */
 
 /* Wildcat Point-LP  PCH Thermal registers */
 #define WPT_TEMP	0x0000	/* Temperature */
@@ -278,6 +280,7 @@ enum board_ids {
 	board_hsw,
 	board_wpt,
 	board_skl,
+	board_cnl,
 };
 
 static const struct board_info {
@@ -296,6 +299,10 @@ static const struct board_info {
 		.name = "pch_skylake",
 		.ops = &pch_dev_ops_wpt,
 	},
+	[board_cnl] = {
+		.name = "pch_cannonlake",
+		.ops = &pch_dev_ops_wpt,
+	},
 };
 
 static int intel_pch_thermal_probe(struct pci_dev *pdev,
@@ -398,6 +405,10 @@ static const struct pci_device_id intel_pch_thermal_id[] = {
 		.driver_data = board_skl, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_SKL_H),
 		.driver_data = board_skl, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_CNL),
+		.driver_data = board_cnl, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_CNL_H),
+		.driver_data = board_cnl, },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, intel_pch_thermal_id);
-- 
2.13.6
