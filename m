From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2 1/4] thermal: Add driver for Armada 370/XP SoC thermal
 management
Date: Mon, 1 Apr 2013 22:37:41 -0300
Message-ID: <20130402013740.GA28373@localhost>
References: <1364292988-8358-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1364292988-8358-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <1364435017.2275.20.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:45963 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759098Ab3DAQgQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Apr 2013 12:36:16 -0400
Content-Disposition: inline
In-Reply-To: <1364435017.2275.20.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Lior Amsalem <alior@marvell.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>

Hi Zhang,

On Thu, Mar 28, 2013 at 09:43:37AM +0800, Zhang Rui wrote:
> On Tue, 2013-03-26 at 07:16 -0300, Ezequiel Garcia wrote:
> > This driver supports both Armada 370 and Armada XP SoC
> > thermal management controllers.
> >=20
> > Armada 370 has a register to check a valid temperature, whereas
> > Armada XP does not. Each has a different initialization (i.e. calib=
ration)
> > function. The temperature conversion formula is the same for both.
> >=20
> > The controller present in each SoC have a very similar feature set,
> > so it corresponds to have one driver to support both of them.
> >=20
> > Although this driver may present similarities to Dove and Kirkwood
> > thermal driver, the exact differences and coincidences are not full=
y
> > known. For this reason, support is given through a separate driver.
> >=20
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---

[...]

> > +static void armadaxp_init_sensor(struct armada_thermal_priv *priv)
> > +{
> > +	unsigned long reg;
> > +
> > +	/* ??? */
>=20
> what does this comment mean?
>=20

In the case you'd prefer those comments to be removed,
here's a patch that does just that.

Is it possible for you to take it instead of the previous one,
in this form?

------------------------------------8<---------------------------------=
-------
diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.t=
xt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
new file mode 100644
index 0000000..fff93d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
@@ -0,0 +1,22 @@
+* Marvell Armada 370/XP thermal management
+
+Required properties:
+
+- compatible:	Should be set to one of the following:
+		marvell,armada370-thermal
+		marvell,armadaxp-thermal
+
+- reg:		Device's register space.
+		Two entries are expected, see the examples below.
+		The first one is required for the sensor register;
+		the second one is required for the control register
+		to be used for sensor initialization (a.k.a. calibration).
+
+Example:
+
+	thermal@d0018300 {
+		compatible =3D "marvell,armada370-thermal";
+                reg =3D <0xd0018300 0x4
+		       0xd0018304 0x4>;
+		status =3D "okay";
+	};
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index a764f16..9eddf74 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -144,6 +144,14 @@ config DB8500_THERMAL
 	  created. Cooling devices can be bound to the trip points to cool th=
is
 	  thermal zone if trip points reached.
=20
+config ARMADA_THERMAL
+	tristate "Armada 370/XP thermal management"
+	depends on ARCH_MVEBU
+	depends on OF
+	help
+	  Enable this option if you want to have support for thermal manageme=
nt
+	  controller present in Armada 370 and Armada XP SoC.
+
 config DB8500_CPUFREQ_COOLING
 	tristate "DB8500 cpufreq cooling"
 	depends on ARCH_U8500
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index d3a2b38..7f6509a 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_KIRKWOOD_THERMAL)  +=3D kirkwood_thermal=
=2Eo
 obj-$(CONFIG_EXYNOS_THERMAL)	+=3D exynos_thermal.o
 obj-$(CONFIG_DOVE_THERMAL)  	+=3D dove_thermal.o
 obj-$(CONFIG_DB8500_THERMAL)	+=3D db8500_thermal.o
+obj-$(CONFIG_ARMADA_THERMAL)	+=3D armada_thermal.o
 obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+=3D db8500_cpufreq_cooling.o
 obj-$(CONFIG_INTEL_POWERCLAMP)	+=3D intel_powerclamp.o
=20
diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_=
thermal.c
new file mode 100644
index 0000000..5b4d75f
--- /dev/null
+++ b/drivers/thermal/armada_thermal.c
@@ -0,0 +1,232 @@
+/*
+ * Marvell Armada 370/XP thermal sensor driver
+ *
+ * Copyright (C) 2013 Marvell
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, an=
d
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <linux/thermal.h>
+
+#define THERMAL_VALID_OFFSET		9
+#define THERMAL_VALID_MASK		0x1
+#define THERMAL_TEMP_OFFSET		10
+#define THERMAL_TEMP_MASK		0x1ff
+
+/* Thermal Manager Control and Status Register */
+#define PMU_TDC0_SW_RST_MASK		(0x1 << 1)
+#define PMU_TM_DISABLE_OFFS		0
+#define PMU_TM_DISABLE_MASK		(0x1 << PMU_TM_DISABLE_OFFS)
+#define PMU_TDC0_REF_CAL_CNT_OFFS	11
+#define PMU_TDC0_REF_CAL_CNT_MASK	(0x1ff << PMU_TDC0_REF_CAL_CNT_OFFS)
+#define PMU_TDC0_OTF_CAL_MASK		(0x1 << 30)
+#define PMU_TDC0_START_CAL_MASK		(0x1 << 25)
+
+struct armada_thermal_ops;
+
+/* Marvell EBU Thermal Sensor Dev Structure */
+struct armada_thermal_priv {
+	void __iomem *sensor;
+	void __iomem *control;
+	struct armada_thermal_ops *ops;
+};
+
+struct armada_thermal_ops {
+	/* Initialize the sensor */
+	void (*init_sensor)(struct armada_thermal_priv *);
+
+	/* Test for a valid sensor value (optional) */
+	bool (*is_valid)(struct armada_thermal_priv *);
+};
+
+static void armadaxp_init_sensor(struct armada_thermal_priv *priv)
+{
+	unsigned long reg;
+
+	reg =3D readl_relaxed(priv->control);
+	reg |=3D PMU_TDC0_OTF_CAL_MASK;
+	writel(reg, priv->control);
+
+	/* Reference calibration value */
+	reg &=3D ~PMU_TDC0_REF_CAL_CNT_MASK;
+	reg |=3D (0xf1 << PMU_TDC0_REF_CAL_CNT_OFFS);
+	writel(reg, priv->control);
+
+	/* Reset the sensor */
+	reg =3D readl_relaxed(priv->control);
+	writel((reg | PMU_TDC0_SW_RST_MASK), priv->control);
+
+	writel(reg, priv->control);
+
+	/* Enable the sensor */
+	reg =3D readl_relaxed(priv->sensor);
+	reg &=3D ~PMU_TM_DISABLE_MASK;
+	writel(reg, priv->sensor);
+}
+
+static void armada370_init_sensor(struct armada_thermal_priv *priv)
+{
+	unsigned long reg;
+
+	reg =3D readl_relaxed(priv->control);
+	reg |=3D PMU_TDC0_OTF_CAL_MASK;
+	writel(reg, priv->control);
+
+	/* Reference calibration value */
+	reg &=3D ~PMU_TDC0_REF_CAL_CNT_MASK;
+	reg |=3D (0xf1 << PMU_TDC0_REF_CAL_CNT_OFFS);
+	writel(reg, priv->control);
+
+	reg &=3D ~PMU_TDC0_START_CAL_MASK;
+	writel(reg, priv->control);
+
+	mdelay(10);
+}
+
+static bool armada_is_valid(struct armada_thermal_priv *priv)
+{
+	unsigned long reg =3D readl_relaxed(priv->sensor);
+
+	return (reg >> THERMAL_VALID_OFFSET) & THERMAL_VALID_MASK;
+}
+
+static int armada_get_temp(struct thermal_zone_device *thermal,
+			  unsigned long *temp)
+{
+	struct armada_thermal_priv *priv =3D thermal->devdata;
+	unsigned long reg;
+
+	/* Valid check */
+	if (priv->ops->is_valid && !priv->ops->is_valid(priv)) {
+		dev_err(&thermal->device,
+			"Temperature sensor reading not valid\n");
+		return -EIO;
+	}
+
+	reg =3D readl_relaxed(priv->sensor);
+	reg =3D (reg >> THERMAL_TEMP_OFFSET) & THERMAL_TEMP_MASK;
+	*temp =3D (3153000000UL - (10000000UL*reg)) / 13825;
+	return 0;
+}
+
+static struct thermal_zone_device_ops ops =3D {
+	.get_temp =3D armada_get_temp,
+};
+
+static const struct armada_thermal_ops armadaxp_ops =3D {
+	.init_sensor =3D armadaxp_init_sensor,
+};
+
+static const struct armada_thermal_ops armada370_ops =3D {
+	.is_valid =3D armada_is_valid,
+	.init_sensor =3D armada370_init_sensor,
+};
+
+static const struct of_device_id armada_thermal_id_table[] =3D {
+	{
+		.compatible =3D "marvell,armadaxp-thermal",
+		.data       =3D &armadaxp_ops,
+	},
+	{
+		.compatible =3D "marvell,armada370-thermal",
+		.data       =3D &armada370_ops,
+	},
+	{
+		/* sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(of, armada_thermal_id_table);
+
+static int armada_thermal_probe(struct platform_device *pdev)
+{
+	struct thermal_zone_device *thermal;
+	const struct of_device_id *match;
+	struct armada_thermal_priv *priv;
+	struct resource *res;
+
+	match =3D of_match_device(armada_thermal_id_table, &pdev->dev);
+	if (!match)
+		return -ENODEV;
+
+	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get platform resource\n");
+		return -ENODEV;
+	}
+
+	priv->sensor =3D devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->sensor))
+		return PTR_ERR(priv->sensor);
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get platform resource\n");
+		return -ENODEV;
+	}
+
+	priv->control =3D devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->control))
+		return PTR_ERR(priv->control);
+
+	priv->ops =3D (struct armada_thermal_ops *)match->data;
+	priv->ops->init_sensor(priv);
+
+	thermal =3D thermal_zone_device_register("armada_thermal", 0, 0,
+					       priv, &ops, NULL, 0, 0);
+	if (IS_ERR(thermal)) {
+		dev_err(&pdev->dev,
+			"Failed to register thermal zone device\n");
+		return PTR_ERR(thermal);
+	}
+
+	platform_set_drvdata(pdev, thermal);
+
+	return 0;
+}
+
+static int armada_thermal_exit(struct platform_device *pdev)
+{
+	struct thermal_zone_device *armada_thermal =3D
+		platform_get_drvdata(pdev);
+
+	thermal_zone_device_unregister(armada_thermal);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver armada_thermal_driver =3D {
+	.probe =3D armada_thermal_probe,
+	.remove =3D armada_thermal_exit,
+	.driver =3D {
+		.name =3D "armada_thermal",
+		.owner =3D THIS_MODULE,
+		.of_match_table =3D of_match_ptr(armada_thermal_id_table),
+	},
+};
+
+module_platform_driver(armada_thermal_driver);
+
+MODULE_AUTHOR("Ezequiel Garcia <ezequiel.garcia@free-electrons.com>");
+MODULE_DESCRIPTION("Armada 370/XP thermal driver");
+MODULE_LICENSE("GPL v2");
------------------------------------>8---------------------------------=
-------

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
