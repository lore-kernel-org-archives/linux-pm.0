From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: [PATCH v2] thermal: intel_pch_thermal: Support skylake PCH 100 series thermal
Date: Wed, 19 Oct 2016 05:59:29 +0900
Message-ID: <871szdcr0u.fsf_-_@mail.parknet.co.jp>
References: <87pomyd515.fsf@mail.parknet.co.jp>
        <1476813814.132953.50.camel@intel.com>
        <87eg3dctaj.fsf@mail.parknet.co.jp>
        <1476821756.132953.56.camel@intel.com>
        <8760opcr4y.fsf@mail.parknet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.parknet.co.jp ([210.171.160.6]:48471 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754205AbcJRU7c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Oct 2016 16:59:32 -0400
In-Reply-To: <8760opcr4y.fsf@mail.parknet.co.jp> (OGAWA Hirofumi's message of
        "Wed, 19 Oct 2016 05:57:01 +0900")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


This patch uses .driver_data and board_info[] to make per pci device
behavior table (name and ops), instead of adding the code for each pci
device in switch-case. This will make easier to add new pci device
ids.

Then this adds new device id actually for skylake PCH 100 series
(using registers are compatible with currently driver, so no need to
change except adding device id to table).

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 drivers/thermal/intel_pch_thermal.c |   48 +++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff -puN drivers/thermal/intel_pch_thermal.c~intel_pch_thermal-cleanup drivers/thermal/intel_pch_thermal.c
--- linux/drivers/thermal/intel_pch_thermal.c~intel_pch_thermal-cleanup	2016-10-18 06:02:07.469831874 +0900
+++ linux-hirofumi/drivers/thermal/intel_pch_thermal.c	2016-10-19 05:13:39.028672579 +0900
@@ -26,6 +26,7 @@
 /* Intel PCH thermal Device IDs */
 #define PCH_THERMAL_DID_WPT	0x9CA4 /* Wildcat Point */
 #define PCH_THERMAL_DID_SKL	0x9D31 /* Skylake PCH */
+#define PCH_THERMAL_DID_SKL_H	0xA131 /* Skylake PCH 100 series */
 
 /* Wildcat Point-LP  PCH Thermal registers */
 #define WPT_TEMP	0x0000	/* Temperature */
@@ -220,32 +221,39 @@ static struct thermal_zone_device_ops tz
 	.get_trip_temp = pch_get_trip_temp,
 };
 
+enum board_ids {
+	board_wpt,
+	board_skl,
+};
+
+static const struct board_info {
+	const char *name;
+	const struct pch_dev_ops *ops;
+} board_info[] = {
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
-	default:
-		dev_err(&pdev->dev, "unknown pch thermal device\n");
-		return -ENODEV;
-	}
+	ptd->ops = bi->ops;
 
 	pci_set_drvdata(pdev, ptd);
 	ptd->pdev = pdev;
@@ -273,11 +281,11 @@ static int intel_pch_thermal_probe(struc
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
@@ -322,8 +330,12 @@ static int intel_pch_thermal_resume(stru
 }
 
 static struct pci_device_id intel_pch_thermal_id[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_WPT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_SKL) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_WPT),
+	  .driver_data = board_wpt, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_SKL),
+	  .driver_data = board_skl, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_SKL_H),
+	  .driver_data = board_skl, },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, intel_pch_thermal_id);
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
