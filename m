From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/2] Thermal: spear_thermal: convert to devm_ioremap_resource
Date: Thu, 16 May 2013 10:16:20 +0800
Message-ID: <1368670581-4846-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47941 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020Ab3EPCQn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 15 May 2013 22:16:43 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, Zhang Rui <rui.zhang@intel.com>, Vincenzo Frascino <vincenzo.frascino@st.com>

Use the newly introduced devm_ioremap_resource().

devm_ioremap_resource() provides its own error messages; so all explicit
error messages can be removed from the failure code paths.

CC: Vincenzo Frascino <vincenzo.frascino@st.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/spear_thermal.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 1a14eaa..1b652ab 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -104,7 +104,7 @@ static int spear_thermal_probe(struct platform_device *pdev)
 	struct thermal_zone_device *spear_thermal = NULL;
 	struct spear_thermal_dev *stdev;
 	struct device_node *np = pdev->dev.of_node;
-	struct resource *stres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct resource *res;
 	int ret = 0, val;
 
 	if (!np || !of_property_read_u32(np, "st,thermal-flags", &val)) {
@@ -112,23 +112,23 @@ static int spear_thermal_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	if (!stres) {
-		dev_err(&pdev->dev, "memory resource missing\n");
-		return -ENODEV;
-	}
-
 	stdev = devm_kzalloc(&pdev->dev, sizeof(*stdev), GFP_KERNEL);
 	if (!stdev) {
 		dev_err(&pdev->dev, "kzalloc fail\n");
 		return -ENOMEM;
 	}
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "memory resource missing\n");
+		return -ENODEV;
+	}
+
 	/* Enable thermal sensor */
-	stdev->thermal_base = devm_ioremap(&pdev->dev, stres->start,
-			resource_size(stres));
-	if (!stdev->thermal_base) {
+	stdev->thermal_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(stdev->thermal_base)) {
 		dev_err(&pdev->dev, "ioremap failed\n");
-		return -ENOMEM;
+		return PTR_ERR(stdev->thermal_base);
 	}
 
 	stdev->clk = devm_clk_get(&pdev->dev, NULL);
-- 
1.7.9.5

