From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 10/16] thermal: mvebu: Add infrastructure to support more multiple SoC variants
Date: Wed, 20 Mar 2013 19:36:31 -0300
Message-ID: <1363818997-23137-11-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:50629 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab3CTWh1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Mar 2013 18:37:27 -0400
In-Reply-To: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Florian Fainelli <florian@openwrt.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

This commit adds the infrastructure required for mvebu thermal driver
to support multiple SoC variants.
In particular, we add support for an optional memory resource, and a
couple of optionals function pointers:
  * one to handle the case where the thermal sensor needs initialization,
  * another one to support for valid sensor value checking

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/thermal/mvebu_thermal.c |   68 ++++++++++++++++++++++++++++++++++----
 1 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
index 3304057..bfe4817 100644
--- a/drivers/thermal/mvebu_thermal.c
+++ b/drivers/thermal/mvebu_thermal.c
@@ -20,8 +20,11 @@
 #include <linux/of.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/of_device.h>
 #include <linux/thermal.h>
 
+#define MVEBU_THERMAL_SOC_VARIANT_KIRKWOOD    0x1
+
 #define MVEBU_THERMAL_VALID_OFFSET	9
 #define MVEBU_THERMAL_VALID_MASK	0x1
 #define MVEBU_THERMAL_TEMP_OFFSET	10
@@ -30,28 +33,48 @@
 /* Marvell EBU Thermal Sensor Dev Structure */
 struct mvebu_thermal_priv {
 	void __iomem *sensor;
+	void __iomem *control;
+	int soc_variant;
+
+	/* Initialize the sensor (optional) */
+	void (*init_sensor)(struct mvebu_thermal_priv *);
+
+	/* Test for a valid sensor value (optional) */
+	bool (*is_valid)(struct mvebu_thermal_priv *);
 };
 
+static bool mvebu_is_valid(struct mvebu_thermal_priv *priv)
+{
+	unsigned long reg = readl_relaxed(priv->sensor);
+
+	return (reg >> MVEBU_THERMAL_VALID_OFFSET) &
+		MVEBU_THERMAL_VALID_MASK;
+}
+
 static int mvebu_get_temp(struct thermal_zone_device *thermal,
 			  unsigned long *temp)
 {
 	unsigned long reg;
 	struct mvebu_thermal_priv *priv = thermal->devdata;
 
-	reg = readl_relaxed(priv->sensor);
-
 	/* Valid check */
-	if (!((reg >> MVEBU_THERMAL_VALID_OFFSET) &
-	    MVEBU_THERMAL_VALID_MASK)) {
+	if (priv->is_valid && !priv->is_valid(priv)) {
 		dev_err(&thermal->device,
 			"Temperature sensor reading not valid\n");
 		return -EIO;
 	}
 
-	reg = (reg >> MVEBU_THERMAL_TEMP_OFFSET) &
+	reg = (readl_relaxed(priv->sensor) >> MVEBU_THERMAL_TEMP_OFFSET) &
 		MVEBU_THERMAL_TEMP_MASK;
-	*temp = ((2363302UL - (7339*reg)) / 10);
 
+	switch (priv->soc_variant) {
+	case MVEBU_THERMAL_SOC_VARIANT_KIRKWOOD:
+		*temp = ((2363302UL - (7339*reg)) / 10);
+		break;
+	default:
+		*temp = 0;
+		break;
+	}
 	return 0;
 }
 
@@ -60,17 +83,27 @@ static struct thermal_zone_device_ops ops = {
 };
 
 static const struct of_device_id mvebu_thermal_id_table[] = {
-	{ .compatible = "marvell,kirkwood-thermal" },
-	{}
+	{
+		.compatible = "marvell,kirkwood-thermal",
+		.data       = (void *) MVEBU_THERMAL_SOC_VARIANT_KIRKWOOD,
+	},
+	{
+		/* sentinel */
+	},
 };
 MODULE_DEVICE_TABLE(of, mvebu_thermal_id_table);
 
 static int mvebu_thermal_probe(struct platform_device *pdev)
 {
 	struct thermal_zone_device *thermal;
+	const struct of_device_id *match;
 	struct mvebu_thermal_priv *priv;
 	struct resource *res;
 
+	match = of_match_device(mvebu_thermal_id_table, &pdev->dev);
+	if (!match)
+		return -ENODEV;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "Failed to get platform resource\n");
@@ -85,6 +118,25 @@ static int mvebu_thermal_probe(struct platform_device *pdev)
 	if (!priv->sensor)
 		return -EADDRNOTAVAIL;
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (res) {
+		priv->control = devm_ioremap_resource(&pdev->dev, res);
+		if (!priv->control)
+			return -EADDRNOTAVAIL;
+	}
+
+	priv->soc_variant = (int)match->data;
+	switch (priv->soc_variant) {
+	case MVEBU_THERMAL_SOC_VARIANT_KIRKWOOD:
+		priv->is_valid = mvebu_is_valid;
+		break;
+	default:
+		break;
+	}
+
+	if (priv->init_sensor)
+		priv->init_sensor(priv);
+
 	thermal = thermal_zone_device_register("mvebu_thermal", 0, 0,
 					       priv, &ops, NULL, 0, 0);
 	if (IS_ERR(thermal)) {
-- 
1.7.8.6

