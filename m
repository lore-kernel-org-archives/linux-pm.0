From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2 11/14] thermal: mvebu: Add support for Marvell Dove
 SoC family
Date: Mon, 25 Mar 2013 06:34:32 -0300
Message-ID: <20130325093430.GA2502@localhost>
References: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1363991114-4225-12-git-send-email-ezequiel.garcia@free-electrons.com>
 <514D914D.3010105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:45550 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755522Ab3CYJeh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Mar 2013 05:34:37 -0400
Content-Disposition: inline
In-Reply-To: <514D914D.3010105@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>, Lior Amsalem <alior@marvell.com>, Zhang Rui <rui.zhang@intel.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>

Hi Sebastian,

Thanks again for your testing.

On Sat, Mar 23, 2013 at 12:26:05PM +0100, Sebastian Hesselbarth wrote:
[...]
>=20
> maybe Dove thermal isn't that compatible with the others as you thoug=
ht.
>=20
> Have a look at DOVE_THERMAL_TEMP_OFFSET above, it is 1 while MVEBU_TH=
ERMAL_TEMP_OFFSET
> is 10. I've tested your patches on Dove and they break thermal. You e=
ither need
> a dove_get_temp() that uses correct DOVE_THERMAL_TEMP_OFFSET or have =
it stored
> within mvebu_thermal_ops and use it in mvebu_get_temp().
>=20

Can you try replacing this patch (i.e. the whole Dove patch) with the
one below?

If you confirm this is working, I can send v3 patchset.

-------------------------------------8<--------------------------------=
-----------

=46rom 8695c7cbdb4922cf0ab7004fd185fea199db6174 Mon Sep 17 00:00:00 200=
1
=46rom: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Date: Fri, 15 Mar 2013 18:28:41 -0300
Subject: [PATCH] thermal: mvebu: Add support for Marvell Dove SoC
 family

With the infrastructure added in mvebu-thermal to support multiple SoC
families, it is now possible to add support for Dove SoC.
This patch adds such support taking the implementation from the
dove-thermal driver, and then removing it.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../devicetree/bindings/thermal/dove-thermal.txt   |   18 --
 .../devicetree/bindings/thermal/mvebu-thermal.txt  |    8 +
 drivers/thermal/Kconfig                            |    8 -
 drivers/thermal/Makefile                           |    1 -
 drivers/thermal/dove_thermal.c                     |  210 ------------=
--------
 drivers/thermal/mvebu_thermal.c                    |   86 ++++++++
 6 files changed, 94 insertions(+), 237 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/dove-ther=
mal.txt
 delete mode 100644 drivers/thermal/dove_thermal.c

diff --git a/Documentation/devicetree/bindings/thermal/dove-thermal.txt=
 b/Documentation/devicetree/bindings/thermal/dove-thermal.txt
deleted file mode 100644
index 6f47467..0000000
--- a/Documentation/devicetree/bindings/thermal/dove-thermal.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-* Dove Thermal
-
-This driver is for Dove SoCs which contain a thermal sensor.
-
-Required properties:
-- compatible : "marvell,dove-thermal"
-- reg : Address range of the thermal registers
-
-The reg properties should contain two ranges. The first is for the
-three Thermal Manager registers, while the second range contains the
-Thermal Diode Control Registers.
-
-Example:
-
-	thermal@10078 {
-		compatible =3D "marvell,dove-thermal";
-		reg =3D <0xd001c 0x0c>, <0xd005c 0x08>;
-	};
diff --git a/Documentation/devicetree/bindings/thermal/mvebu-thermal.tx=
t b/Documentation/devicetree/bindings/thermal/mvebu-thermal.txt
index 49d55a9..2c5297a 100644
--- a/Documentation/devicetree/bindings/thermal/mvebu-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/mvebu-thermal.txt
@@ -6,6 +6,7 @@ Required properties:
 		marvell,kirkwood-thermal
 		marvell,armadaxp-thermal
 		marvell,armada370-thermal
+		marvell,dove-thermal
=20
 - reg:		Device's register space.
 		One or two entries are expected, see the examples below.
@@ -21,3 +22,10 @@ Kirkwood example:
 		compatible =3D "marvell,kirkwood-thermal";
 		reg =3D <0x10078 0x4>;
 	};
+
+Dove example:
+
+	thermal: thermal@d001c {
+		compatible =3D "marvell,dove-thermal";
+		reg =3D <0xd001c 0x0c>, <0xd005c 0x08>;
+	};
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 74f6b97..237c3e6 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -126,14 +126,6 @@ config EXYNOS_THERMAL_EMUL
 	  device directory to support emulation mode. With emulation mode sys=
fs
 	  node, you can manually input temperature to TMU for simulation purp=
ose.
=20
-config DOVE_THERMAL
-	tristate "Temperature sensor on Marvell Dove SoCs"
-	depends on ARCH_DOVE
-	depends on OF
-	help
-	  Support for the Dove thermal sensor driver in the Linux thermal
-	  framework.
-
 config DB8500_THERMAL
 	bool "DB8500 thermal management"
 	depends on ARCH_U8500
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 40293a1..ddd77f4 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -17,7 +17,6 @@ obj-$(CONFIG_SPEAR_THERMAL)	+=3D spear_thermal.o
 obj-$(CONFIG_RCAR_THERMAL)	+=3D rcar_thermal.o
 obj-$(CONFIG_MVEBU_THERMAL)	+=3D mvebu_thermal.o
 obj-$(CONFIG_EXYNOS_THERMAL)	+=3D exynos_thermal.o
-obj-$(CONFIG_DOVE_THERMAL)  	+=3D dove_thermal.o
 obj-$(CONFIG_DB8500_THERMAL)	+=3D db8500_thermal.o
 obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+=3D db8500_cpufreq_cooling.o
 obj-$(CONFIG_INTEL_POWERCLAMP)	+=3D intel_powerclamp.o
diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_ther=
mal.c
deleted file mode 100644
index ddd73a5..0000000
--- a/drivers/thermal/dove_thermal.c
+++ /dev/null
@@ -1,210 +0,0 @@
-/*
- * Dove thermal sensor driver
- *
- * Copyright (C) 2013 Andrew Lunn <andrew@lunn.ch>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, an=
d
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- */
-#include <linux/device.h>
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/of.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/thermal.h>
-
-#define DOVE_THERMAL_TEMP_OFFSET	1
-#define DOVE_THERMAL_TEMP_MASK		0x1FF
-
-/* Dove Thermal Manager Control and Status Register */
-#define PMU_TM_DISABLE_OFFS		0
-#define PMU_TM_DISABLE_MASK		(0x1 << PMU_TM_DISABLE_OFFS)
-
-/* Dove Theraml Diode Control 0 Register */
-#define PMU_TDC0_SW_RST_MASK		(0x1 << 1)
-#define PMU_TDC0_SEL_VCAL_OFFS		5
-#define PMU_TDC0_SEL_VCAL_MASK		(0x3 << PMU_TDC0_SEL_VCAL_OFFS)
-#define PMU_TDC0_REF_CAL_CNT_OFFS	11
-#define PMU_TDC0_REF_CAL_CNT_MASK	(0x1FF << PMU_TDC0_REF_CAL_CNT_OFFS)
-#define PMU_TDC0_AVG_NUM_OFFS		25
-#define PMU_TDC0_AVG_NUM_MASK		(0x7 << PMU_TDC0_AVG_NUM_OFFS)
-
-/* Dove Thermal Diode Control 1 Register */
-#define PMU_TEMP_DIOD_CTRL1_REG		0x04
-#define PMU_TDC1_TEMP_VALID_MASK	(0x1 << 10)
-
-/* Dove Thermal Sensor Dev Structure */
-struct dove_thermal_priv {
-	void __iomem *sensor;
-	void __iomem *control;
-};
-
-static int dove_init_sensor(const struct dove_thermal_priv *priv)
-{
-	u32 reg;
-	u32 i;
-
-	/* Configure the Diode Control Register #0 */
-	reg =3D readl_relaxed(priv->control);
-
-	/* Use average of 2 */
-	reg &=3D ~PMU_TDC0_AVG_NUM_MASK;
-	reg |=3D (0x1 << PMU_TDC0_AVG_NUM_OFFS);
-
-	/* Reference calibration value */
-	reg &=3D ~PMU_TDC0_REF_CAL_CNT_MASK;
-	reg |=3D (0x0F1 << PMU_TDC0_REF_CAL_CNT_OFFS);
-
-	/* Set the high level reference for calibration */
-	reg &=3D ~PMU_TDC0_SEL_VCAL_MASK;
-	reg |=3D (0x2 << PMU_TDC0_SEL_VCAL_OFFS);
-	writel(reg, priv->control);
-
-	/* Reset the sensor */
-	reg =3D readl_relaxed(priv->control);
-	writel((reg | PMU_TDC0_SW_RST_MASK), priv->control);
-	writel(reg, priv->control);
-
-	/* Enable the sensor */
-	reg =3D readl_relaxed(priv->sensor);
-	reg &=3D ~PMU_TM_DISABLE_MASK;
-	writel(reg, priv->sensor);
-
-	/* Poll the sensor for the first reading */
-	for (i =3D 0; i < 1000000; i++) {
-		reg =3D readl_relaxed(priv->sensor);
-		if (reg & DOVE_THERMAL_TEMP_MASK)
-			break;
-	}
-
-	if (i =3D=3D 1000000)
-		return -EIO;
-
-	return 0;
-}
-
-static int dove_get_temp(struct thermal_zone_device *thermal,
-			  unsigned long *temp)
-{
-	unsigned long reg;
-	struct dove_thermal_priv *priv =3D thermal->devdata;
-
-	/* Valid check */
-	reg =3D readl_relaxed(priv->control + PMU_TEMP_DIOD_CTRL1_REG);
-	if ((reg & PMU_TDC1_TEMP_VALID_MASK) =3D=3D 0x0) {
-		dev_err(&thermal->device,
-			"Temperature sensor reading not valid\n");
-		return -EIO;
-	}
-
-	/*
-	 * Calculate temperature. According to Marvell internal
-	 * documentation the formula for this is:
-	 * Celsius =3D (322-reg)/1.3625
-	 */
-	reg =3D readl_relaxed(priv->sensor);
-	reg =3D (reg >> DOVE_THERMAL_TEMP_OFFSET) & DOVE_THERMAL_TEMP_MASK;
-	*temp =3D ((3220000000UL - (10000000UL * reg)) / 13625);
-
-	return 0;
-}
-
-static struct thermal_zone_device_ops ops =3D {
-	.get_temp =3D dove_get_temp,
-};
-
-static const struct of_device_id dove_thermal_id_table[] =3D {
-	{ .compatible =3D "marvell,dove-thermal" },
-	{}
-};
-
-static int dove_thermal_probe(struct platform_device *pdev)
-{
-	struct thermal_zone_device *thermal =3D NULL;
-	struct dove_thermal_priv *priv;
-	struct resource *res;
-	int ret;
-
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Failed to get platform resource\n");
-		return -ENODEV;
-	}
-
-	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	priv->sensor =3D devm_request_and_ioremap(&pdev->dev, res);
-	if (!priv->sensor) {
-		dev_err(&pdev->dev, "Failed to request_ioremap memory\n");
-		return -EADDRNOTAVAIL;
-	}
-
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res) {
-		dev_err(&pdev->dev, "Failed to get platform resource\n");
-		return -ENODEV;
-	}
-	priv->control =3D devm_request_and_ioremap(&pdev->dev, res);
-	if (!priv->control) {
-		dev_err(&pdev->dev, "Failed to request_ioremap memory\n");
-		return -EADDRNOTAVAIL;
-	}
-
-	ret =3D dove_init_sensor(priv);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to initialize sensor\n");
-		return ret;
-	}
-
-	thermal =3D thermal_zone_device_register("dove_thermal", 0, 0,
-					       priv, &ops, NULL, 0, 0);
-	if (IS_ERR(thermal)) {
-		dev_err(&pdev->dev,
-			"Failed to register thermal zone device\n");
-		return PTR_ERR(thermal);
-	}
-
-	platform_set_drvdata(pdev, thermal);
-
-	return 0;
-}
-
-static int dove_thermal_exit(struct platform_device *pdev)
-{
-	struct thermal_zone_device *dove_thermal =3D
-		platform_get_drvdata(pdev);
-
-	thermal_zone_device_unregister(dove_thermal);
-	platform_set_drvdata(pdev, NULL);
-
-	return 0;
-}
-
-MODULE_DEVICE_TABLE(of, dove_thermal_id_table);
-
-static struct platform_driver dove_thermal_driver =3D {
-	.probe =3D dove_thermal_probe,
-	.remove =3D dove_thermal_exit,
-	.driver =3D {
-		.name =3D "dove_thermal",
-		.owner =3D THIS_MODULE,
-		.of_match_table =3D of_match_ptr(dove_thermal_id_table),
-	},
-};
-
-module_platform_driver(dove_thermal_driver);
-
-MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch>");
-MODULE_DESCRIPTION("Dove thermal driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_th=
ermal.c
index 60d50c7..b043da3 100644
--- a/drivers/thermal/mvebu_thermal.c
+++ b/drivers/thermal/mvebu_thermal.c
@@ -2,6 +2,7 @@
  * Marvell EBU thermal sensor driver
  *
  * Copyright (C) 2013 Marvell
+ * Copyright (C) 2013 Andrew Lunn <andrew@lunn.ch>
  * Copyright (C) 2012 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
  *
  * This software is licensed under the terms of the GNU General Public
@@ -30,6 +31,9 @@
 #define MVEBU_THERMAL_TEMP_OFFSET	10
 #define MVEBU_THERMAL_TEMP_MASK		0x1FF
=20
+#define DOVE_THERMAL_TEMP_OFFSET	1
+#define DOVE_THERMAL_TEMP_MASK		0x1FF
+
 /* Thermal Manager Control and Status Register */
 #define PMU_TDC0_SW_RST_MASK		(0x1 << 1)
 #define PMU_TM_DISABLE_OFFS		0
@@ -38,6 +42,14 @@
 #define PMU_TDC0_REF_CAL_CNT_MASK	(0x1ff << PMU_TDC0_REF_CAL_CNT_OFFS)
 #define PMU_TDC0_OTF_CAL_MASK		(0x1 << 30)
 #define PMU_TDC0_START_CAL_MASK		(0x1 << 25)
+#define PMU_TDC0_AVG_NUM_OFFS		25
+#define PMU_TDC0_AVG_NUM_MASK		(0x7 << PMU_TDC0_AVG_NUM_OFFS)
+#define PMU_TDC0_SEL_VCAL_OFFS		5
+#define PMU_TDC0_SEL_VCAL_MASK		(0x3 << PMU_TDC0_SEL_VCAL_OFFS)
+
+/* Dove Thermal Diode Control 1 Register */
+#define PMU_TEMP_DIOD_CTRL1_REG		0x04
+#define PMU_TDC1_TEMP_VALID_MASK	(0x1 << 10)
=20
 struct mvebu_thermal_ops;
=20
@@ -113,6 +125,53 @@ static void armada370_init_sensor(struct mvebu_the=
rmal_priv *priv)
 	mdelay(10);
 }
=20
+static void dove_init_sensor(struct mvebu_thermal_priv *priv)
+{
+	unsigned long reg;
+	int i;
+
+	if (!priv->control)
+		return;
+
+	/* Configure the Diode Control Register #0 */
+	reg =3D readl_relaxed(priv->control);
+
+	/* Use average of 2 */
+	reg &=3D ~PMU_TDC0_AVG_NUM_MASK;
+	reg |=3D (0x1 << PMU_TDC0_AVG_NUM_OFFS);
+
+	/* Reference calibration value */
+	reg &=3D ~PMU_TDC0_REF_CAL_CNT_MASK;
+	reg |=3D (0x0F1 << PMU_TDC0_REF_CAL_CNT_OFFS);
+
+	/* Set the high level reference for calibration */
+	reg &=3D ~PMU_TDC0_SEL_VCAL_MASK;
+	reg |=3D (0x2 << PMU_TDC0_SEL_VCAL_OFFS);
+	writel(reg, priv->control);
+
+	/* Reset the sensor */
+	reg =3D readl_relaxed(priv->control);
+	writel((reg | PMU_TDC0_SW_RST_MASK), priv->control);
+	writel(reg, priv->control);
+
+	/* Enable the sensor */
+	reg =3D readl_relaxed(priv->sensor);
+	reg &=3D ~PMU_TM_DISABLE_MASK;
+	writel(reg, priv->sensor);
+
+	/*
+	 * FIXME: This looks really ugly. Can't we just remove it?
+	 * Poll the sensor for the first reading
+	 */
+	for (i =3D 0; i < 1000000; i++) {
+		reg =3D (readl_relaxed(priv->sensor) >> MVEBU_THERMAL_TEMP_OFFSET)
+			& MVEBU_THERMAL_TEMP_MASK;
+		if (reg)
+			break;
+	}
+	return;
+}
+
 static bool mvebu_is_valid(struct mvebu_thermal_priv *priv)
 {
 	unsigned long reg =3D readl_relaxed(priv->sensor);
@@ -130,6 +189,15 @@ static unsigned long kirkwood_sensor_temp(struct m=
vebu_thermal_priv *priv)
 	return (3220000000UL - (10000000UL * reg)) / 13625;
 }
=20
+static unsigned long dove_sensor_temp(struct mvebu_thermal_priv *priv)
+{
+	unsigned long reg =3D readl_relaxed(priv->sensor);
+
+	reg =3D (reg >> DOVE_THERMAL_TEMP_OFFSET) &
+		DOVE_THERMAL_TEMP_MASK;
+	return (3220000000UL - (10000000UL * reg)) / 13625;
+}
+
 static unsigned long armada_sensor_temp(struct mvebu_thermal_priv *pri=
v)
 {
 	unsigned long reg =3D readl_relaxed(priv->sensor);
@@ -139,6 +207,13 @@ static unsigned long armada_sensor_temp(struct mve=
bu_thermal_priv *priv)
 	return (3153000000UL - (10000000UL*reg)) / 13825;
 }
=20
+static bool dove_is_valid(struct mvebu_thermal_priv *priv)
+{
+	unsigned long reg =3D
+		readl_relaxed(priv->control + PMU_TEMP_DIOD_CTRL1_REG);
+	return reg & PMU_TDC1_TEMP_VALID_MASK;
+}
+
 static int mvebu_get_temp(struct thermal_zone_device *thermal,
 			  unsigned long *temp)
 {
@@ -164,6 +239,12 @@ static const struct mvebu_thermal_ops kirkwood_ops=
 =3D {
 	.is_valid =3D mvebu_is_valid,
 };
=20
+static const struct mvebu_thermal_ops dove_ops =3D {
+	.sensor_temp =3D dove_sensor_temp,
+	.is_valid =3D dove_is_valid,
+	.init_sensor =3D dove_init_sensor,
+};
+
 static const struct mvebu_thermal_ops armadaxp_ops =3D {
 	.sensor_temp =3D armada_sensor_temp,
 	.init_sensor =3D armadaxp_init_sensor,
@@ -189,6 +270,10 @@ static const struct of_device_id mvebu_thermal_id_=
table[] =3D {
 		.data       =3D &armada370_ops,
 	},
 	{
+		.compatible =3D "marvell,dove-thermal",
+		.data       =3D &dove_ops,
+	},
+	{
 		/* sentinel */
 	},
 };
@@ -267,6 +352,7 @@ static struct platform_driver mvebu_thermal_driver =
=3D {
=20
 module_platform_driver(mvebu_thermal_driver);
=20
+MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch>");
 MODULE_AUTHOR("Nobuhiro Iwamatsu <iwamatsu@nigauri.org>");
 MODULE_AUTHOR("Ezequiel Garcia <ezequiel.garcia@free-electrons.com>");
 MODULE_DESCRIPTION("mvebu thermal driver");
--=20
1.7.8.6

------------------------------------->8--------------------------------=
-----------


Thanks a lot,
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
