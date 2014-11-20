From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC 2/3] power: mxs_power: add driver for mxs power subsystem
Date: Thu, 20 Nov 2014 20:14:36 +0000
Message-ID: <1416514477-19190-3-git-send-email-stefan.wahren@i2se.com>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:49845 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757939AbaKTUPk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Nov 2014 15:15:40 -0500
In-Reply-To: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This patch adds a minimal driver for the Freescale i.MX23, i.MX28
power subsystem. It's required to trigger the probing of the underlying
drivers like on-chip regulators. Additionally the drivers supports
the configuration of the DC-DC clock frequency to avoid possible
interferences.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/power/Kconfig     |    8 ++
 drivers/power/Makefile    |    1 +
 drivers/power/mxs_power.c |  226 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 235 insertions(+)
 create mode 100644 drivers/power/mxs_power.c

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 0108c2a..8a3eaa4 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -43,6 +43,14 @@ config MAX8925_POWER
 	  Say Y here to enable support for the battery charger in the Maxim
 	  MAX8925 PMIC.

+config MXS_POWER
+	tristate "Freescale MXS power subsystem support"
+	depends on ARCH_MXS
+	help
+	  Say Y here to enable support for the Freescale i.MX23/i.MX28
+	  power subsystem. This is a requirement to get access to on-chip
+	  regulators, battery charger and many more.
+
 config WM831X_BACKUP
 	tristate "WM831X backup battery charger support"
 	depends on MFD_WM831X
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index dfa8942..91c0a62 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_GENERIC_ADC_BATTERY)	+= generic-adc-battery.o
 obj-$(CONFIG_PDA_POWER)		+= pda_power.o
 obj-$(CONFIG_APM_POWER)		+= apm_power.o
 obj-$(CONFIG_MAX8925_POWER)	+= max8925_power.o
+obj-$(CONFIG_MXS_POWER)		+= mxs_power.o
 obj-$(CONFIG_WM831X_BACKUP)	+= wm831x_backup.o
 obj-$(CONFIG_WM831X_POWER)	+= wm831x_power.o
 obj-$(CONFIG_WM8350_POWER)	+= wm8350_power.o
diff --git a/drivers/power/mxs_power.c b/drivers/power/mxs_power.c
new file mode 100644
index 0000000..6b68064
--- /dev/null
+++ b/drivers/power/mxs_power.c
@@ -0,0 +1,226 @@
+/*
+ * Freescale MXS power subsystem
+ *
+ * Copyright (C) 2014 Stefan Wahren
+ *
+ * Inspired by imx-bootlets
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/types.h>
+
+#define BM_POWER_CTRL_POLARITY_VBUSVALID	(1 << 5)
+#define BM_POWER_CTRL_VBUSVALID_IRQ		(1 << 4)
+#define BM_POWER_CTRL_ENIRQ_VBUS_VALID		(1 << 3)
+
+#define HW_POWER_5VCTRL_OFFSET	0x10
+#define HW_POWER_MISC_OFFSET	0x90
+
+#define BM_POWER_5VCTRL_VBUSVALID_THRESH	(7 << 8)
+#define BM_POWER_5VCTRL_PWDN_5VBRNOUT		(1 << 7)
+#define BM_POWER_5VCTRL_VBUSVALID_5VDETECT	(1 << 4)
+
+#define HW_POWER_5VCTRL_VBUSVALID_THRESH_4_40V	(5 << 8)
+
+#define SHIFT_FREQSEL	4
+
+#define BM_POWER_MISC_FREQSEL			(7 << SHIFT_FREQSEL)
+
+#define HW_POWER_MISC_FREQSEL_20000_KHZ		1
+#define HW_POWER_MISC_FREQSEL_24000_KHZ		2
+#define HW_POWER_MISC_FREQSEL_19200_KHZ		3
+
+#define HW_POWER_MISC_SEL_PLLCLK		(1 << 0)
+
+static int dcdc_pll;
+module_param(dcdc_pll, int, 0);
+MODULE_PARM_DESC(dcdc_pll,
+		 "DC-DC PLL frequency (kHz). Use 19200, 20000 or 24000");
+
+struct mxs_power_data {
+	void __iomem *base_addr;
+	struct power_supply dc;
+};
+
+int get_dcdc_clk_freq(struct mxs_power_data *pdata)
+{
+	void __iomem *base = pdata->base_addr;
+	int ret = -EINVAL;
+	u32 val;
+
+	val = readl(base + HW_POWER_MISC_OFFSET);
+
+	/* XTAL source */
+	if ((val & HW_POWER_MISC_SEL_PLLCLK) == 0)
+		return 24000;
+
+	switch ((val & BM_POWER_MISC_FREQSEL) >> SHIFT_FREQSEL) {
+	case HW_POWER_MISC_FREQSEL_20000_KHZ:
+		ret = 20000;
+		break;
+	case HW_POWER_MISC_FREQSEL_24000_KHZ:
+		ret = 24000;
+		break;
+	case HW_POWER_MISC_FREQSEL_19200_KHZ:
+		ret = 19200;
+		break;
+	}
+
+	return ret;
+}
+
+int set_dcdc_clk_freq(struct mxs_power_data *pdata, int kHz)
+{
+	void __iomem *misc = pdata->base_addr + HW_POWER_MISC_OFFSET;
+	u32 val;
+	int ret = 0;
+
+	val = readl(misc);
+
+	val &= ~BM_POWER_MISC_FREQSEL;
+	val &= ~HW_POWER_MISC_SEL_PLLCLK;
+
+	/* Accept only values recommend by Freescale */
+	switch (kHz) {
+	case 19200:
+		val |= HW_POWER_MISC_FREQSEL_19200_KHZ << SHIFT_FREQSEL;
+		break;
+	case 20000:
+		val |= HW_POWER_MISC_FREQSEL_20000_KHZ << SHIFT_FREQSEL;
+		break;
+	case 24000:
+		val |= HW_POWER_MISC_FREQSEL_24000_KHZ << SHIFT_FREQSEL;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret)
+		return ret;
+
+	/* First program FREQSEL */
+	writel(val, misc);
+
+	/* then set PLL as clk for DC-DC converter */
+	writel(val | HW_POWER_MISC_SEL_PLLCLK, misc);
+
+	return 0;
+}
+
+static enum power_supply_property mxs_power_dc_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+};
+
+static int mxs_power_dc_get_property(struct power_supply *psy,
+				    enum power_supply_property psp,
+				    union power_supply_propval *val)
+{
+	struct mxs_power_data *data = container_of(psy,
+						   struct mxs_power_data, dc);
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = 1;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static const struct of_device_id of_mxs_power_match[] = {
+	{ .compatible = "fsl,imx23-power" },
+	{ .compatible = "fsl,imx28-power" },
+	{ /* end */ }
+};
+MODULE_DEVICE_TABLE(of, of_mxs_power_match);
+
+static int mxs_power_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct resource *res;
+	struct mxs_power_data *data;
+	int ret;
+	int dcdc_clk_freq;
+
+	if (!np) {
+		dev_err(dev, "missing device tree\n");
+		return -EINVAL;
+	}
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (data == NULL)
+		return -ENOMEM;
+
+	data->dc.properties = mxs_power_dc_props;
+	data->dc.num_properties = ARRAY_SIZE(mxs_power_dc_props);
+	data->dc.get_property = mxs_power_dc_get_property;
+	data->dc.name = "dc";
+	data->dc.type = POWER_SUPPLY_TYPE_MAINS;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->base_addr = devm_ioremap_resource(dev, res);
+	if (IS_ERR(data->base_addr))
+		return PTR_ERR(data->base_addr);
+
+	ret = power_supply_register(dev, &data->dc);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, data);
+
+	if (dcdc_pll)
+		set_dcdc_clk_freq(data, dcdc_pll);
+
+	dcdc_clk_freq = get_dcdc_clk_freq(data);
+
+	dev_info(dev, "DCDC clock freq: %d kHz\n", dcdc_clk_freq);
+
+	return of_platform_populate(np, NULL, NULL, dev);
+}
+
+static int mxs_power_remove(struct platform_device *pdev)
+{
+	struct mxs_power_data *data = platform_get_drvdata(pdev);
+
+	of_platform_depopulate(&pdev->dev);
+	power_supply_unregister(&data->dc);
+
+	return 0;
+}
+
+static struct platform_driver mxs_power_driver = {
+	.driver = {
+		.name	= "mxs_power",
+		.owner  = THIS_MODULE,
+		.of_match_table = of_mxs_power_match,
+	},
+	.probe	= mxs_power_probe,
+	.remove = mxs_power_remove,
+};
+
+module_platform_driver(mxs_power_driver);
+
+MODULE_AUTHOR("Stefan Wahren <stefan.wahren@i2se.com>");
+MODULE_DESCRIPTION("Freescale MXS power subsystem");
+MODULE_LICENSE("GPL v2");
--
1.7.9.5

