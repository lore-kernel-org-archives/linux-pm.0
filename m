From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 08/14] thermal: mvebu: Add infrastructure to support more multiple SoC variants
Date: Fri, 22 Mar 2013 19:25:08 -0300
Message-ID: <1363991114-4225-9-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:33454 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423413Ab3CVWZy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Mar 2013 18:25:54 -0400
In-Reply-To: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Lior Amsalem <alior@marvell.com>, Zhang Rui <rui.zhang@intel.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

This commit adds the infrastructure required for mvebu thermal driver
to support multiple SoC variants.
In particular, we add support for an optional memory resource, and a
new struct to contain the operation for each SoC variant.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/thermal/mvebu_thermal.c |   80 +++++++++++++++++++++++++++++++--------
 1 files changed, 64 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
index 39ddded..a7c9b34 100644
--- a/drivers/thermal/mvebu_thermal.c
+++ b/drivers/thermal/mvebu_thermal.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/of_device.h>
 #include <linux/thermal.h>
 
 #define MVEBU_THERMAL_VALID_OFFSET	9
@@ -27,36 +28,56 @@
 #define MVEBU_THERMAL_TEMP_OFFSET	10
 #define MVEBU_THERMAL_TEMP_MASK		0x1FF
 
+struct mvebu_thermal_ops;
+
 /* Marvell EBU Thermal Sensor Dev Structure */
 struct mvebu_thermal_priv {
 	void __iomem *sensor;
+	void __iomem *control;
+	struct mvebu_thermal_ops *ops;
+};
+
+struct mvebu_thermal_ops {
+	/* Converts the sensor register to ajunction temperature */
+	unsigned long (*sensor_temp)(struct mvebu_thermal_priv *);
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
+static unsigned long orion_sensor_temp(struct mvebu_thermal_priv *priv)
+{
+	unsigned long reg = readl_relaxed(priv->sensor);
+
+	reg = (reg >> MVEBU_THERMAL_TEMP_OFFSET) &
+		MVEBU_THERMAL_TEMP_MASK;
+	return (3220000000UL - (10000000UL * reg)) / 13625;
+}
+
 static int mvebu_get_temp(struct thermal_zone_device *thermal,
 			  unsigned long *temp)
 {
-	unsigned long reg;
 	struct mvebu_thermal_priv *priv = thermal->devdata;
 
-	reg = readl_relaxed(priv->sensor);
-
 	/* Valid check */
-	if (!((reg >> MVEBU_THERMAL_VALID_OFFSET) &
-	    MVEBU_THERMAL_VALID_MASK)) {
+	if (priv->ops->is_valid && !priv->ops->is_valid(priv)) {
 		dev_err(&thermal->device,
 			"Temperature sensor reading not valid\n");
 		return -EIO;
 	}
 
-	/*
-	 * Calculate temperature. According to Marvell internal
-	 * documentation the formula for this is:
-	 * Celsius = (322-reg)/1.3625
-	 */
-	reg = (reg >> MVEBU_THERMAL_TEMP_OFFSET) &
-		MVEBU_THERMAL_TEMP_MASK;
-	*temp = ((3220000000UL - (10000000UL * reg)) / 13625);
-
+	*temp = priv->ops->sensor_temp(priv);
 	return 0;
 }
 
@@ -64,18 +85,33 @@ static struct thermal_zone_device_ops ops = {
 	.get_temp = mvebu_get_temp,
 };
 
+static const struct mvebu_thermal_ops kirkwood_ops = {
+	.sensor_temp = orion_sensor_temp,
+	.is_valid = mvebu_is_valid,
+};
+
 static const struct of_device_id mvebu_thermal_id_table[] = {
-	{ .compatible = "marvell,kirkwood-thermal" },
-	{}
+	{
+		.compatible = "marvell,kirkwood-thermal",
+		.data       = &kirkwood_ops,
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
@@ -90,6 +126,18 @@ static int mvebu_thermal_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->sensor))
 		return PTR_ERR(priv->sensor);
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (res) {
+		priv->control = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(priv->control))
+			return PTR_ERR(priv->control);
+	}
+
+	priv->ops = (struct mvebu_thermal_ops *)match->data;
+
+	if (priv->ops->init_sensor)
+		priv->ops->init_sensor(priv);
+
 	thermal = thermal_zone_device_register("mvebu_thermal", 0, 0,
 					       priv, &ops, NULL, 0, 0);
 	if (IS_ERR(thermal)) {
-- 
1.7.8.6

