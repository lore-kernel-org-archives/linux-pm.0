From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH-V2 2/5] thermal: bcm2835: add thermal driver for bcm2835 soc
Date: Fri, 13 May 2016 13:13:03 +0000
Message-ID: <1463145186-12906-3-git-send-email-kernel@martin.sperl.org>
References: <1463145186-12906-1-git-send-email-kernel@martin.sperl.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463145186-12906-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Add basic thermal driver for bcm2835 SOC.

This driver currently relies on the firmware setting up the
tsense HW block and does not set it up itself.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

ChangeLog:
 V1 -> V2: added specific settings depending on compatiblity
	   added trip point based on register
	   setting up ctrl-register if HW is not enabled by firmware
	     as per recommendation of Eric (untested)
	   check that clock frequency is in range
	     (1.9 - 5MHz - as per comment in clk-bcm2835.c)
---
 drivers/thermal/Kconfig               |   5 +
 drivers/thermal/Makefile              |   1 +
 drivers/thermal/bcm/Kconfig           |   4 +
 drivers/thermal/bcm/Makefile          |   1 +
 drivers/thermal/bcm/bcm2835_thermal.c | 326 ++++++++++++++++++++++++++++++++++
 5 files changed, 337 insertions(+)
 create mode 100644 drivers/thermal/bcm/Kconfig
 create mode 100644 drivers/thermal/bcm/Makefile
 create mode 100644 drivers/thermal/bcm/bcm2835_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 3c3dc4a..5b63d45 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -383,6 +383,11 @@ config MTK_THERMAL
 	  Enable this option if you want to have support for thermal management
 	  controller present in Mediatek SoCs
 
+menu "Broadcom thermal drivers"
+depends on ARCH_BCM || COMPILE_TEST
+source "drivers/thermal/bcm/Kconfig"
+endmenu
+
 menu "Texas Instruments thermal drivers"
 depends on ARCH_HAS_BANDGAP || COMPILE_TEST
 depends on HAS_IOMEM
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 8e9cbc3..6df1aa3 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -49,3 +49,4 @@ obj-$(CONFIG_ST_THERMAL)	+= st/
 obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra_soctherm.o
 obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
 obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
+obj-y				+= bcm/
diff --git a/drivers/thermal/bcm/Kconfig b/drivers/thermal/bcm/Kconfig
new file mode 100644
index 0000000..62245ae
--- /dev/null
+++ b/drivers/thermal/bcm/Kconfig
@@ -0,0 +1,4 @@
+config BCM2835_THERMAL
+       tristate "Thermal sensors on bcm2835 SoC"
+       help
+         Support for thermal sensors on Broadcom bcm2835 SoCs.
diff --git a/drivers/thermal/bcm/Makefile b/drivers/thermal/bcm/Makefile
new file mode 100644
index 0000000..13456d2
--- /dev/null
+++ b/drivers/thermal/bcm/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_BCM2835_THERMAL)		:= bcm2835_thermal.o
diff --git a/drivers/thermal/bcm/bcm2835_thermal.c b/drivers/thermal/bcm/bcm2835_thermal.c
new file mode 100644
index 0000000..73138cb
--- /dev/null
+++ b/drivers/thermal/bcm/bcm2835_thermal.c
@@ -0,0 +1,326 @@
+/*
+ * Driver for Broadcom BCM2835 soc temperature sensor
+ *
+ * Copyright (C) 2015 Martin Sperl
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+#define BCM2835_TS_TSENSCTL			0x00
+#define BCM2835_TS_TSENSSTAT			0x04
+
+#define BCM2835_TS_TSENSCTL_PRWDW		BIT(0)
+#define BCM2835_TS_TSENSCTL_RSTB		BIT(1)
+#define BCM2835_TS_TSENSCTL_CTRL_BITS		3
+#define BCM2835_TS_TSENSCTL_CTRL_SHIFT		2
+#define BCM2835_TS_TSENSCTL_CTRL_MASK		    \
+	GENMASK(BCM2835_TS_TSENSCTL_CTRL_BITS +     \
+		BCM2835_TS_TSENSCTL_CTRL_SHIFT - 1, \
+		BCM2835_TS_TSENSCTL_CTRL_SHIFT)
+#define BCM2835_TS_TSENSCTL_CTRL_DEFAULT	1
+#define BCM2835_TS_TSENSCTL_EN_INT		BIT(5)
+#define BCM2835_TS_TSENSCTL_DIRECT		BIT(6)
+#define BCM2835_TS_TSENSCTL_CLR_INT		BIT(7)
+#define BCM2835_TS_TSENSCTL_THOLD_SHIFT		8
+#define BCM2835_TS_TSENSCTL_THOLD_BITS		10
+#define BCM2835_TS_TSENSCTL_THOLD_MASK		     \
+	GENMASK(BCM2835_TS_TSENSCTL_THOLD_BITS +     \
+		BCM2835_TS_TSENSCTL_THOLD_SHIFT - 1, \
+		BCM2835_TS_TSENSCTL_THOLD_SHIFT)
+#define BCM2835_TS_TSENSCTL_RSTDELAY_SHIFT	18
+#define BCM2835_TS_TSENSCTL_RSTDELAY_BITS	8
+#define BCM2835_TS_TSENSCTL_RSTDELAY_DEFAULT	14
+#define BCM2835_TS_TSENSCTL_REGULEN		BIT(26)
+
+#define BCM2835_TS_TSENSSTAT_DATA_BITS		10
+#define BCM2835_TS_TSENSSTAT_DATA_SHIFT		0
+#define BCM2835_TS_TSENSSTAT_DATA_MASK		     \
+	GENMASK(BCM2835_TS_TSENSSTAT_DATA_BITS +     \
+		BCM2835_TS_TSENSSTAT_DATA_SHIFT - 1, \
+		BCM2835_TS_TSENSSTAT_DATA_SHIFT)
+#define BCM2835_TS_TSENSSTAT_VALID		BIT(10)
+#define BCM2835_TS_TSENSSTAT_INTERRUPT		BIT(11)
+
+struct bcm2835_thermal_info {
+	int offset;
+	int slope;
+	int trip_temp;
+};
+
+struct bcm2835_thermal_data {
+	const struct bcm2835_thermal_info *info;
+	void __iomem *regs;
+	struct clk *clk;
+	struct dentry *debugfsdir;
+};
+
+static int bcm2835_thermal_adc2temp(
+	const struct bcm2835_thermal_info *info, u32 adc)
+{
+	return info->offset + (adc * info->slope);
+}
+
+static int bcm2835_thermal_temp2adc(
+	const struct bcm2835_thermal_info *info, int temp)
+{
+	temp -= info->offset;
+	temp /= info->slope;
+
+	if (temp < 0)
+		temp = 0;
+	if (temp >= BIT(BCM2835_TS_TSENSSTAT_DATA_BITS))
+		temp = BIT(BCM2835_TS_TSENSSTAT_DATA_BITS) - 1;
+
+	return temp;
+}
+
+static int bcm2835_thermal_get_trip_type(
+	struct thermal_zone_device *tz, int trip,
+	enum thermal_trip_type *type)
+{
+	*type = THERMAL_TRIP_CRITICAL;
+	return 0;
+}
+
+static int bcm2835_thermal_get_trip_temp(
+	struct thermal_zone_device *tz, int trip, int *temp)
+{
+	struct bcm2835_thermal_data *data = tz->devdata;
+	u32 val = readl(data->regs + BCM2835_TS_TSENSCTL);
+
+	/* get the THOLD bits */
+	val &= BCM2835_TS_TSENSCTL_THOLD_MASK;
+	val >>= BCM2835_TS_TSENSCTL_THOLD_SHIFT;
+
+	/* if it is zero then use the info value */
+	if (val)
+		*temp = bcm2835_thermal_adc2temp(data->info, val);
+	else
+		*temp = data->info->trip_temp;
+
+	return 0;
+}
+
+static int bcm2835_thermal_get_temp(struct thermal_zone_device *tz,
+				    int *temp)
+{
+	struct bcm2835_thermal_data *data = tz->devdata;
+	u32 val = readl(data->regs + BCM2835_TS_TSENSSTAT);
+
+	if (!(val & BCM2835_TS_TSENSSTAT_VALID))
+		return -EIO;
+
+	/* mask the relevant bits */
+	val &= BCM2835_TS_TSENSSTAT_DATA_MASK;
+
+	*temp = bcm2835_thermal_adc2temp(data->info, val);
+
+	return 0;
+}
+
+static const struct debugfs_reg32 bcm2835_thermal_regs[] = {
+	{
+		.name = "ctl",
+		.offset = 0
+	},
+	{
+		.name = "stat",
+		.offset = 4
+	}
+};
+
+static void bcm2835_thermal_debugfs(struct platform_device *pdev)
+{
+	struct thermal_zone_device *tz = platform_get_drvdata(pdev);
+	struct bcm2835_thermal_data *data = tz->devdata;
+	struct debugfs_regset32 *regset;
+
+	data->debugfsdir = debugfs_create_dir("bcm2835_thermal", NULL);
+	if (!data->debugfsdir)
+		return;
+
+	regset = devm_kzalloc(&pdev->dev, sizeof(*regset), GFP_KERNEL);
+	if (!regset)
+		return;
+
+	regset->regs = bcm2835_thermal_regs;
+	regset->nregs = ARRAY_SIZE(bcm2835_thermal_regs);
+	regset->base = data->regs;
+
+	debugfs_create_regset32("regset", S_IRUGO,
+				data->debugfsdir, regset);
+}
+
+static struct thermal_zone_device_ops bcm2835_thermal_ops  = {
+	.get_temp = bcm2835_thermal_get_temp,
+	.get_trip_temp = bcm2835_thermal_get_trip_temp,
+	.get_trip_type = bcm2835_thermal_get_trip_type,
+};
+
+static const struct of_device_id bcm2835_thermal_of_match_table[];
+static int bcm2835_thermal_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	struct thermal_zone_device *tz;
+	struct bcm2835_thermal_data *data;
+	struct resource *res;
+	int err;
+	u32 val;
+	unsigned long rate;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	match = of_match_device(bcm2835_thermal_of_match_table,
+				&pdev->dev);
+	if (!match)
+		return -EINVAL;
+	data->info = match->data;
+
+	/* get registers */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(data->regs)) {
+		err = PTR_ERR(data->regs);
+		dev_err(&pdev->dev, "Could not get registers: %d\n", err);
+		return err;
+	}
+
+	/* get clock */
+	data->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(data->clk)) {
+		err = PTR_ERR(data->clk);
+		if (err != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Could not get clk: %d\n", err);
+		return err;
+	}
+
+	/* set up registers if not already done by the fw */
+	val = readl(data->regs + BCM2835_TS_TSENSCTL);
+	if (!(val & BCM2835_TS_TSENSCTL_RSTB)) {
+		/* the basic required flags */
+		val = (BCM2835_TS_TSENSCTL_CTRL_DEFAULT <<
+		       BCM2835_TS_TSENSCTL_CTRL_SHIFT) |
+		      BCM2835_TS_TSENSCTL_REGULEN;
+
+		/* reset delay */
+		val |= (BCM2835_TS_TSENSCTL_RSTDELAY_DEFAULT <<
+			BCM2835_TS_TSENSCTL_RSTDELAY_SHIFT);
+
+		/*  trip_adc value from info */
+		val |= bcm2835_thermal_temp2adc(data->info,
+						data->info->trip_temp) <<
+			BCM2835_TS_TSENSCTL_THOLD_SHIFT;
+
+		/* write the value back to the register as 2 steps */
+		writel(val, data->regs + BCM2835_TS_TSENSCTL);
+		val |= BCM2835_TS_TSENSCTL_RSTB;
+		writel(val, data->regs + BCM2835_TS_TSENSCTL);
+	}
+
+	/* enable clock and check rate */
+	clk_prepare_enable(data->clk);
+	rate = clk_get_rate(data->clk);
+	if ((rate < 1920000) || (rate > 5000000)) {
+		dev_warn(&pdev->dev,
+			 "Clock %pCn is running at %pCr Hz, which is outside the recommended range of 1.9 to 5.0 MHz\n",
+			 data->clk, data->clk);
+	}
+
+	/* register it */
+	tz = thermal_zone_device_register("bcm2835_thermal",
+					  1, 0, data,
+					  &bcm2835_thermal_ops,
+					  NULL, 0, 0);
+	if (IS_ERR(tz)) {
+		clk_disable_unprepare(data->clk);
+		err = PTR_ERR(tz);
+		dev_err(&pdev->dev,
+			"Failed to register the thermal device: %d\n",
+			err);
+		return err;
+	}
+
+	platform_set_drvdata(pdev, tz);
+
+	bcm2835_thermal_debugfs(pdev);
+
+	return 0;
+}
+
+static int bcm2835_thermal_remove(struct platform_device *pdev)
+{
+	struct thermal_zone_device *tz = platform_get_drvdata(pdev);
+	struct bcm2835_thermal_data *data = tz->devdata;
+
+	debugfs_remove_recursive(data->debugfsdir);
+	thermal_zone_device_unregister(tz);
+
+	return 0;
+}
+
+static const struct of_device_id bcm2835_thermal_of_match_table[] = {
+	{
+		.compatible = "brcm,bcm2835-thermal",
+		.data = &(struct bcm2835_thermal_info) {
+			.offset = 407000,
+			.slope = -538,
+			.trip_temp = 80000
+		}
+	},
+	{
+		.compatible = "brcm,bcm2836-thermal",
+		.data = &(struct bcm2835_thermal_info) {
+			.offset = 407000,
+			.slope = -538,
+			.trip_temp = 80000
+		}
+	},
+	{
+		.compatible = "brcm,bcm2837-thermal",
+		.data = &(struct bcm2835_thermal_info) {
+			/* the bcm2837 needs adjustment of +5C */
+			.offset = 407000 + 5000,
+			.slope = -538,
+			.trip_temp = 80000
+		}
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, bcm2835_thermal_of_match_table);
+
+static struct platform_driver bcm2835_thermal_driver = {
+	.probe = bcm2835_thermal_probe,
+	.remove = bcm2835_thermal_remove,
+	.driver = {
+		.name = "bcm2835_thermal",
+		.of_match_table = bcm2835_thermal_of_match_table,
+	},
+};
+module_platform_driver(bcm2835_thermal_driver);
+
+MODULE_AUTHOR("Martin Sperl");
+MODULE_DESCRIPTION("Thermal driver for bcm2835 chip");
+MODULE_LICENSE("GPL");
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
