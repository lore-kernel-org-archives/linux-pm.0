From: Miquel Raynal <miquel.raynal@free-electrons.com>
Subject: [PATCH v7 05/11] thermal: armada: Use real status register name
Date: Fri, 22 Dec 2017 17:14:07 +0100
Message-ID: <20171222161413.20816-6-miquel.raynal@free-electrons.com>
References: <20171222161413.20816-1-miquel.raynal@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:55744 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756414AbdLVQOi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Dec 2017 11:14:38 -0500
In-Reply-To: <20171222161413.20816-1-miquel.raynal@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Miquel Raynal <miquel.raynal@free-electrons.com>, Baruch Siach <baruch@tkos.co.il>, David Sniatkiwicz <davidsn@marvell.com>

Three 32-bit registers are used to drive the thermal IP: control0,
control1 and status. The two control registers share the same name both
in the documentation and in the code, while the latter is referred as
"sensor" in the code. Rename this pointer to be called "status" in order
to be aligned with the documentation.

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/thermal/armada_thermal.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index d58376eba6d9..ceebabf45c53 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -51,7 +51,7 @@ struct armada_thermal_data;
 
 /* Marvell EBU Thermal Sensor Dev Structure */
 struct armada_thermal_priv {
-	void __iomem *sensor;
+	void __iomem *status;
 	void __iomem *control0;
 	void __iomem *control1;
 	struct armada_thermal_data *data;
@@ -99,9 +99,9 @@ static void armadaxp_init_sensor(struct platform_device *pdev,
 	writel(reg, priv->control1);
 
 	/* Enable the sensor */
-	reg = readl_relaxed(priv->sensor);
+	reg = readl_relaxed(priv->status);
 	reg &= ~PMU_TM_DISABLE_MASK;
-	writel(reg, priv->sensor);
+	writel(reg, priv->status);
 }
 
 static void armada370_init_sensor(struct platform_device *pdev,
@@ -157,7 +157,7 @@ static void armada380_init_sensor(struct platform_device *pdev,
 
 static bool armada_is_valid(struct armada_thermal_priv *priv)
 {
-	u32 reg = readl_relaxed(priv->sensor);
+	u32 reg = readl_relaxed(priv->status);
 
 	return reg & priv->data->is_valid_bit;
 }
@@ -176,7 +176,7 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
 		return -EIO;
 	}
 
-	reg = readl_relaxed(priv->sensor);
+	reg = readl_relaxed(priv->status);
 	reg = (reg >> priv->data->temp_shift) & priv->data->temp_mask;
 
 	/* Get formula coeficients */
@@ -279,9 +279,9 @@ static int armada_thermal_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->sensor = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(priv->sensor))
-		return PTR_ERR(priv->sensor);
+	priv->status = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->status))
+		return PTR_ERR(priv->status);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	control = devm_ioremap_resource(&pdev->dev, res);
-- 
2.11.0
