From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 12/16] thermal: mvebu: Add support for Armada 370 thermal sensor
Date: Wed, 20 Mar 2013 19:36:33 -0300
Message-ID: <1363818997-23137-13-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:50651 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab3CTWhi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Mar 2013 18:37:38 -0400
In-Reply-To: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Florian Fainelli <florian@openwrt.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

The Armada 370 has a register to check a valid temperature,
and its own formula to obtain the temperature from the thermal
sensor output register.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../devicetree/bindings/thermal/mvebu-thermal.txt  |    1 +
 drivers/thermal/mvebu_thermal.c                    |   39 ++++++++++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/mvebu-thermal.txt b/Documentation/devicetree/bindings/thermal/mvebu-thermal.txt
index 7cc3fd4..49d55a9 100644
--- a/Documentation/devicetree/bindings/thermal/mvebu-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/mvebu-thermal.txt
@@ -5,6 +5,7 @@ Required properties:
 - compatible:	Should be set to one of the following:
 		marvell,kirkwood-thermal
 		marvell,armadaxp-thermal
+		marvell,armada370-thermal
 
 - reg:		Device's register space.
 		One or two entries are expected, see the examples below.
diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
index 50f13e7..0b1e7a8 100644
--- a/drivers/thermal/mvebu_thermal.c
+++ b/drivers/thermal/mvebu_thermal.c
@@ -20,12 +20,14 @@
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/module.h>
+#include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/of_device.h>
 #include <linux/thermal.h>
 
 #define MVEBU_THERMAL_SOC_VARIANT_KIRKWOOD    0x1
 #define MVEBU_THERMAL_SOC_VARIANT_ARMADA_XP   0x2
+#define MVEBU_THERMAL_SOC_VARIANT_ARMADA_370  0x3
 
 #define MVEBU_THERMAL_VALID_OFFSET	9
 #define MVEBU_THERMAL_VALID_MASK	0x1
@@ -39,6 +41,7 @@
 #define PMU_TDC0_REF_CAL_CNT_OFFS	11
 #define PMU_TDC0_REF_CAL_CNT_MASK	(0x1ff << PMU_TDC0_REF_CAL_CNT_OFFS)
 #define PMU_TDC0_OTF_CAL_MASK		(0x1 << 30)
+#define PMU_TDC0_START_CAL_MASK		(0x1 << 25)
 
 /* Marvell EBU Thermal Sensor Dev Structure */
 struct mvebu_thermal_priv {
@@ -82,6 +85,31 @@ static void armadaxp_init_sensor(struct mvebu_thermal_priv *priv)
 	writel(reg, priv->sensor);
 }
 
+static void armada370_init_sensor(struct mvebu_thermal_priv *priv)
+{
+	unsigned long reg;
+
+	if (!priv->control)
+		return;
+
+	/* ??? */
+	reg = readl_relaxed(priv->control);
+	reg |= PMU_TDC0_OTF_CAL_MASK;
+	writel(reg, priv->control);
+
+	/* Reference calibration value */
+	reg &= ~PMU_TDC0_REF_CAL_CNT_MASK;
+	reg |= (0xf1 << PMU_TDC0_REF_CAL_CNT_OFFS);
+	writel(reg, priv->control);
+
+	/* ??? */
+	reg &= ~PMU_TDC0_START_CAL_MASK;
+	writel(reg, priv->control);
+
+	/* FIXME: Why do we need this delay? */
+	mdelay(10);
+}
+
 static bool mvebu_is_valid(struct mvebu_thermal_priv *priv)
 {
 	unsigned long reg = readl_relaxed(priv->sensor);
@@ -113,6 +141,9 @@ static int mvebu_get_temp(struct thermal_zone_device *thermal,
 	case MVEBU_THERMAL_SOC_VARIANT_ARMADA_XP:
 		*temp = (3153000000UL - (10000000UL*reg)) / 13825;
 		break;
+	case MVEBU_THERMAL_SOC_VARIANT_ARMADA_370:
+		*temp = (228000UL - 723*reg);
+		break;
 	default:
 		*temp = 0;
 		break;
@@ -134,6 +165,10 @@ static const struct of_device_id mvebu_thermal_id_table[] = {
 		.data       = (void *) MVEBU_THERMAL_SOC_VARIANT_ARMADA_XP,
 	},
 	{
+		.compatible = "marvell,armada370-thermal",
+		.data       = (void *) MVEBU_THERMAL_SOC_VARIANT_ARMADA_370,
+	},
+	{
 		/* sentinel */
 	},
 };
@@ -179,6 +214,10 @@ static int mvebu_thermal_probe(struct platform_device *pdev)
 	case MVEBU_THERMAL_SOC_VARIANT_ARMADA_XP:
 		priv->init_sensor = armadaxp_init_sensor;
 		break;
+	case MVEBU_THERMAL_SOC_VARIANT_ARMADA_370:
+		priv->is_valid = mvebu_is_valid;
+		priv->init_sensor = armada370_init_sensor;
+		break;
 	default:
 		break;
 	}
-- 
1.7.8.6

