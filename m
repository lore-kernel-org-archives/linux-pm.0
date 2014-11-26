From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 7/9] bus: brcmstb_gisb: Add register offset tables for older chips
Date: Tue, 25 Nov 2014 16:49:52 -0800
Message-ID: <1416962994-27095-8-git-send-email-cernekee@gmail.com>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:58818 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbaKZAvg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 19:51:36 -0500
In-Reply-To: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, arnd@arndb.de, linux@prisktech.co.nz, stern@rowland.harvard.edu, gregkh@linuxfoundation.org, f.fainelli@gmail.com
Cc: grant.likely@linaro.org, robh+dt@kernel.org, computersforpeace@gmail.com, marc.ceeeee@gmail.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mips@linux-mips.org

This will select the appropriate register layout based on the DT
"compatible" string.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 .../devicetree/bindings/bus/brcm,gisb-arb.txt      |  6 ++-
 drivers/bus/brcmstb_gisb.c                         | 52 +++++++++++++++++++---
 2 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
index e2d501d..1eceefb 100644
--- a/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
+++ b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
@@ -2,7 +2,11 @@ Broadcom GISB bus Arbiter controller
 
 Required properties:
 
-- compatible: should be "brcm,gisb-arb"
+- compatible:
+    "brcm,gisb-arb" or "brcm,bcm7445-gisb-arb" for 28nm chips
+    "brcm,bcm7435-gisb-arb" for newer 40nm chips
+    "brcm,bcm7400-gisb-arb" for older 40nm chips and all 65nm chips
+    "brcm,bcm7038-gisb-arb" for 130nm chips
 - reg: specifies the base physical address and size of the registers
 - interrupt-parent: specifies the phandle to the parent interrupt controller
   this arbiter gets interrupt line from
diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index ef1e423..172908d 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -47,6 +47,36 @@ enum {
 	ARB_ERR_CAP_MASTER,
 };
 
+static const int gisb_offsets_bcm7038[] = {
+	[ARB_TIMER]		= 0x00c,
+	[ARB_ERR_CAP_CLR]	= 0x0c4,
+	[ARB_ERR_CAP_HI_ADDR]	= -1,
+	[ARB_ERR_CAP_ADDR]	= 0x0c8,
+	[ARB_ERR_CAP_DATA]	= 0x0cc,
+	[ARB_ERR_CAP_STATUS]	= 0x0d0,
+	[ARB_ERR_CAP_MASTER]	= -1,
+};
+
+static const int gisb_offsets_bcm7400[] = {
+	[ARB_TIMER]		= 0x00c,
+	[ARB_ERR_CAP_CLR]	= 0x0c8,
+	[ARB_ERR_CAP_HI_ADDR]	= -1,
+	[ARB_ERR_CAP_ADDR]	= 0x0cc,
+	[ARB_ERR_CAP_DATA]	= 0x0d0,
+	[ARB_ERR_CAP_STATUS]	= 0x0d4,
+	[ARB_ERR_CAP_MASTER]	= 0x0d8,
+};
+
+static const int gisb_offsets_bcm7435[] = {
+	[ARB_TIMER]		= 0x00c,
+	[ARB_ERR_CAP_CLR]	= 0x168,
+	[ARB_ERR_CAP_HI_ADDR]	= -1,
+	[ARB_ERR_CAP_ADDR]	= 0x16c,
+	[ARB_ERR_CAP_DATA]	= 0x170,
+	[ARB_ERR_CAP_STATUS]	= 0x174,
+	[ARB_ERR_CAP_MASTER]	= 0x178,
+};
+
 static const int gisb_offsets_bcm7445[] = {
 	[ARB_TIMER]		= 0x008,
 	[ARB_ERR_CAP_CLR]	= 0x7e4,
@@ -230,10 +260,20 @@ static struct attribute_group gisb_arb_sysfs_attr_group = {
 	.attrs = gisb_arb_sysfs_attrs,
 };
 
+static const struct of_device_id brcmstb_gisb_arb_of_match[] = {
+	{ .compatible = "brcm,gisb-arb",         .data = gisb_offsets_bcm7445 },
+	{ .compatible = "brcm,bcm7445-gisb-arb", .data = gisb_offsets_bcm7445 },
+	{ .compatible = "brcm,bcm7435-gisb-arb", .data = gisb_offsets_bcm7435 },
+	{ .compatible = "brcm,bcm7400-gisb-arb", .data = gisb_offsets_bcm7400 },
+	{ .compatible = "brcm,bcm7038-gisb-arb", .data = gisb_offsets_bcm7038 },
+	{ },
+};
+
 static int brcmstb_gisb_arb_probe(struct platform_device *pdev)
 {
 	struct device_node *dn = pdev->dev.of_node;
 	struct brcmstb_gisb_arb_device *gdev;
+	const struct of_device_id *of_id;
 	struct resource *r;
 	int err, timeout_irq, tea_irq;
 	unsigned int num_masters, j = 0;
@@ -254,7 +294,12 @@ static int brcmstb_gisb_arb_probe(struct platform_device *pdev)
 	if (IS_ERR(gdev->base))
 		return PTR_ERR(gdev->base);
 
-	gdev->gisb_offsets = gisb_offsets_bcm7445;
+	of_id = of_match_node(brcmstb_gisb_arb_of_match, dn);
+	if (!of_id) {
+		pr_err("failed to look up compatible string\n");
+		return -EINVAL;
+	}
+	gdev->gisb_offsets = of_id->data;
 
 	err = devm_request_irq(&pdev->dev, timeout_irq,
 				brcmstb_gisb_timeout_handler, 0, pdev->name,
@@ -307,11 +352,6 @@ static int brcmstb_gisb_arb_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id brcmstb_gisb_arb_of_match[] = {
-	{ .compatible = "brcm,gisb-arb" },
-	{ },
-};
-
 static struct platform_driver brcmstb_gisb_arb_driver = {
 	.probe	= brcmstb_gisb_arb_probe,
 	.driver = {
-- 
2.1.0

