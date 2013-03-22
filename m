From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 10/14] thermal: mvebu: Add support for Armada 370 thermal sensor
Date: Fri, 22 Mar 2013 19:25:10 -0300
Message-ID: <1363991114-4225-11-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:33477 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423375Ab3CVW0D (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Mar 2013 18:26:03 -0400
In-Reply-To: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Lior Amsalem <alior@marvell.com>, Zhang Rui <rui.zhang@intel.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

The Armada 370 has a register to check a valid temperature,
its own function to initialize (i.e. calibrate) the thermal sensor.
The temperature formula is the same as the one for Armada XP.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../devicetree/bindings/thermal/mvebu-thermal.txt  |    1 +
 drivers/thermal/mvebu_thermal.c                    |   37 ++++++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

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
index fc4d9f4..56c58b1 100644
--- a/drivers/thermal/mvebu_thermal.c
+++ b/drivers/thermal/mvebu_thermal.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/module.h>
+#include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/of_device.h>
 #include <linux/thermal.h>
@@ -36,6 +37,7 @@
 #define PMU_TDC0_REF_CAL_CNT_OFFS	11
 #define PMU_TDC0_REF_CAL_CNT_MASK	(0x1ff << PMU_TDC0_REF_CAL_CNT_OFFS)
 #define PMU_TDC0_OTF_CAL_MASK		(0x1 << 30)
+#define PMU_TDC0_START_CAL_MASK		(0x1 << 25)
 
 struct mvebu_thermal_ops;
 
@@ -86,6 +88,31 @@ static void armadaxp_init_sensor(struct mvebu_thermal_priv *priv)
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
@@ -142,6 +169,12 @@ static const struct mvebu_thermal_ops armadaxp_ops = {
 	.init_sensor = armadaxp_init_sensor,
 };
 
+static const struct mvebu_thermal_ops armada370_ops = {
+	.sensor_temp = armada_sensor_temp,
+	.is_valid = mvebu_is_valid,
+	.init_sensor = armada370_init_sensor,
+};
+
 static const struct of_device_id mvebu_thermal_id_table[] = {
 	{
 		.compatible = "marvell,kirkwood-thermal",
@@ -152,6 +185,10 @@ static const struct of_device_id mvebu_thermal_id_table[] = {
 		.data       = &armadaxp_ops,
 	},
 	{
+		.compatible = "marvell,armada370-thermal",
+		.data       = &armada370_ops,
+	},
+	{
 		/* sentinel */
 	},
 };
-- 
1.7.8.6

