From: Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH 2/3] thermal: armada: add support for AP806
Date: Wed, 22 Nov 2017 16:42:04 +0200
Message-ID: <320800cce532d6ae1927b36f82b007f04c740a15.1511361725.git.baruch@tkos.co.il>
References: <7102bb32704ac9f70ef3ae61682d50de8af61b57.1511361725.git.baruch@tkos.co.il>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:56532 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751338AbdKVOnL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Nov 2017 09:43:11 -0500
In-Reply-To: <7102bb32704ac9f70ef3ae61682d50de8af61b57.1511361725.git.baruch@tkos.co.il>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Miquel Raynal <miquel.raynal@free-electrons.com>, Baruch Siach <baruch@tkos.co.il>

The AP806 component is integrated in the Armada 8k and 7k lines of processors.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/thermal/armada_thermal.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index ae75328945f7..1f7f81628040 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -41,6 +41,10 @@
 #define A375_HW_RESETn			BIT(8)
 #define A380_HW_RESET			BIT(8)
 
+#define AP806_START			BIT(0)
+#define AP806_RESET			BIT(1)
+#define AP806_ENABLE			BIT(2)
+
 struct armada_thermal_data;
 
 /* Marvell EBU Thermal Sensor Dev Structure */
@@ -147,6 +151,18 @@ static void armada380_init_sensor(struct platform_device *pdev,
 	}
 }
 
+static void armada_ap806_init_sensor(struct platform_device *pdev,
+				     struct armada_thermal_priv *priv)
+{
+	u32 reg = readl_relaxed(priv->control);
+
+	reg &= ~AP806_RESET;
+	reg |= AP806_START;
+	reg |= AP806_ENABLE;
+	writel(reg, priv->control);
+	mdelay(10);
+}
+
 static bool armada_is_valid(struct armada_thermal_priv *priv)
 {
 	unsigned long reg = readl_relaxed(priv->sensor);
@@ -230,6 +246,18 @@ static const struct armada_thermal_data armada380_data = {
 	.inverted = true,
 };
 
+static const struct armada_thermal_data armada_ap806_data = {
+	.is_valid = armada_is_valid,
+	.init_sensor = armada_ap806_init_sensor,
+	.is_valid_shift = 16,
+	.temp_shift = 0,
+	.temp_mask = 0x3ff,
+	.coef_b = 1172499100UL,
+	.coef_m = 2000096UL,
+	.coef_div = 4201,
+	.inverted = true,
+};
+
 static const struct of_device_id armada_thermal_id_table[] = {
 	{
 		.compatible = "marvell,armadaxp-thermal",
@@ -247,6 +275,10 @@ static const struct of_device_id armada_thermal_id_table[] = {
 		.compatible = "marvell,armada380-thermal",
 		.data       = &armada380_data,
 	},
+	{
+		.compatible = "marvell,armada-ap806-thermal",
+		.data       = &armada_ap806_data,
+	},
 	{
 		/* sentinel */
 	},
-- 
2.15.0
