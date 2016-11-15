From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3] thermal: intel_pch_thermal: Support skylake PCH 100
 series thermal
Date: Tue, 15 Nov 2016 20:20:04 +0800
Message-ID: <1479212404.2224.10.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23093 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933170AbcKOMUh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Nov 2016 07:20:37 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, hirofumi@mail.parknet.co.jp

>From c7be2d16f2d469e0dfb7b1e5f06f2b32a4958938 Mon Sep 17 00:00:00 2001
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 19 Oct 2016 05:59:29 +0900
Subject: [PATCH] thermal: intel_pch_thermal: Support skylake PCH 100 series
 thermal

This patch uses .driver_data and board_info[] to make per pci device
behavior table (name and ops), instead of adding the code for each pci
device in switch-case. This will make easier to add new pci device
ids.

Then this adds new device id actually for skylake PCH 100 series
(using registers are compatible with currently driver, so no need to
change except adding device id to table).

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/intel_pch_thermal.c | 64 ++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/drivers/thermal/intel_pch_thermal.c b/drivers/thermal/intel_pch_thermal.c
index 19bf202..2b49e8d 100644
--- a/drivers/thermal/intel_pch_thermal.c
+++ b/drivers/thermal/intel_pch_thermal.c
@@ -29,6 +29,7 @@
 #define PCH_THERMAL_DID_HSW_2	0x8C24 /* Haswell PCH */
 #define PCH_THERMAL_DID_WPT	0x9CA4 /* Wildcat Point */
 #define PCH_THERMAL_DID_SKL	0x9D31 /* Skylake PCH */
+#define PCH_THERMAL_DID_SKL_H	0xA131 /* Skylake PCH 100 series */
 
 /* Wildcat Point-LP  PCH Thermal registers */
 #define WPT_TEMP	0x0000	/* Temperature */
@@ -273,37 +274,44 @@ static struct thermal_zone_device_ops tzd_ops = {
 	.get_trip_temp = pch_get_trip_temp,
 };
 
+enum board_ids {
+	board_hsw,
+	board_wpt,
+	board_skl,
+};
+
+static const struct board_info {
+	const char *name;
+	const struct pch_dev_ops *ops;
+} board_info[] = {
+	[board_hsw] = {
+		.name = "pch_haswell",
+		.ops = &pch_dev_ops_wpt,
+	},
+	[board_wpt] = {
+		.name = "pch_wildcat_point",
+		.ops = &pch_dev_ops_wpt,
+	},
+	[board_skl] = {
+		.name = "pch_skylake",
+		.ops = &pch_dev_ops_wpt,
+	},
+};
 
 static int intel_pch_thermal_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *id)
 {
+	enum board_ids board_id = id->driver_data;
+	const struct board_info *bi = &board_info[board_id];
 	struct pch_thermal_device *ptd;
 	int err;
 	int nr_trips;
-	char *dev_name;
 
 	ptd = devm_kzalloc(&pdev->dev, sizeof(*ptd), GFP_KERNEL);
 	if (!ptd)
 		return -ENOMEM;
 
-	switch (pdev->device) {
-	case PCH_THERMAL_DID_WPT:
-		ptd->ops = &pch_dev_ops_wpt;
-		dev_name = "pch_wildcat_point";
-		break;
-	case PCH_THERMAL_DID_SKL:
-		ptd->ops = &pch_dev_ops_wpt;
-		dev_name = "pch_skylake";
-		break;
-	case PCH_THERMAL_DID_HSW_1:
-	case PCH_THERMAL_DID_HSW_2:
-		ptd->ops = &pch_dev_ops_wpt;
-		dev_name = "pch_haswell";
-		break;
-	default:
-		dev_err(&pdev->dev, "unknown pch thermal device\n");
-		return -ENODEV;
-	}
+	ptd->ops = bi->ops;
 
 	pci_set_drvdata(pdev, ptd);
 	ptd->pdev = pdev;
@@ -331,11 +339,11 @@ static int intel_pch_thermal_probe(struct pci_dev *pdev,
 	if (err)
 		goto error_cleanup;
 
-	ptd->tzd = thermal_zone_device_register(dev_name, nr_trips, 0, ptd,
+	ptd->tzd = thermal_zone_device_register(bi->name, nr_trips, 0, ptd,
 						&tzd_ops, NULL, 0, 0);
 	if (IS_ERR(ptd->tzd)) {
 		dev_err(&pdev->dev, "Failed to register thermal zone %s\n",
-			dev_name);
+			bi->name);
 		err = PTR_ERR(ptd->tzd);
 		goto error_cleanup;
 	}
@@ -380,10 +388,16 @@ static int intel_pch_thermal_resume(struct device *device)
 }
 
 static struct pci_device_id intel_pch_thermal_id[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_WPT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_SKL) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_HSW_1) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_HSW_2) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_HSW_1),
+		.driver_data = board_hsw, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_HSW_2),
+		.driver_data = board_hsw, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_WPT),
+		.driver_data = board_wpt, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_SKL),
+		.driver_data = board_skl, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_SKL_H),
+		.driver_data = board_skl, },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, intel_pch_thermal_id);
-- 
2.7.4

