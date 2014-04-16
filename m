From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 1/6] thermal: armada: Rename armada_thermal_ops struct
Date: Wed, 16 Apr 2014 11:15:15 -0300
Message-ID: <1397657720-10893-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1397657720-10893-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:48870 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161272AbaDPOP7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Apr 2014 10:15:59 -0400
In-Reply-To: <1397657720-10893-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, Jason Cooper <jason@lakedaemon.net>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

As preparation work to add a generic infrastructure to support
different SoC variants, the armada_thermal_ops will be used
to host the SoC-specific fields, such as formula values and
register offsets.

For this reason, the name armada_thermal_ops is no longer suitable,
and this commit replaces it with armada_thermal_data.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/thermal/armada_thermal.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 5e53212..c5db071 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -38,16 +38,16 @@
 #define PMU_TDC0_OTF_CAL_MASK		(0x1 << 30)
 #define PMU_TDC0_START_CAL_MASK		(0x1 << 25)
 
-struct armada_thermal_ops;
+struct armada_thermal_data;
 
 /* Marvell EBU Thermal Sensor Dev Structure */
 struct armada_thermal_priv {
 	void __iomem *sensor;
 	void __iomem *control;
-	struct armada_thermal_ops *ops;
+	struct armada_thermal_data *data;
 };
 
-struct armada_thermal_ops {
+struct armada_thermal_data {
 	/* Initialize the sensor */
 	void (*init_sensor)(struct armada_thermal_priv *);
 
@@ -113,7 +113,7 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
 	unsigned long reg;
 
 	/* Valid check */
-	if (priv->ops->is_valid && !priv->ops->is_valid(priv)) {
+	if (priv->data->is_valid && !priv->data->is_valid(priv)) {
 		dev_err(&thermal->device,
 			"Temperature sensor reading not valid\n");
 		return -EIO;
@@ -129,11 +129,11 @@ static struct thermal_zone_device_ops ops = {
 	.get_temp = armada_get_temp,
 };
 
-static const struct armada_thermal_ops armadaxp_ops = {
+static const struct armada_thermal_data armadaxp_data = {
 	.init_sensor = armadaxp_init_sensor,
 };
 
-static const struct armada_thermal_ops armada370_ops = {
+static const struct armada_thermal_data armada370_data = {
 	.is_valid = armada_is_valid,
 	.init_sensor = armada370_init_sensor,
 };
@@ -141,11 +141,11 @@ static const struct armada_thermal_ops armada370_ops = {
 static const struct of_device_id armada_thermal_id_table[] = {
 	{
 		.compatible = "marvell,armadaxp-thermal",
-		.data       = &armadaxp_ops,
+		.data       = &armadaxp_data,
 	},
 	{
 		.compatible = "marvell,armada370-thermal",
-		.data       = &armada370_ops,
+		.data       = &armada370_data,
 	},
 	{
 		/* sentinel */
@@ -178,8 +178,8 @@ static int armada_thermal_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->control))
 		return PTR_ERR(priv->control);
 
-	priv->ops = (struct armada_thermal_ops *)match->data;
-	priv->ops->init_sensor(priv);
+	priv->data = (struct armada_thermal_data *)match->data;
+	priv->data->init_sensor(priv);
 
 	thermal = thermal_zone_device_register("armada_thermal", 0, 0,
 					       priv, &ops, NULL, 0, 0);
-- 
1.9.1

