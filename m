From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 2/7] power: mxs_power: add driver for mxs power subsystem
Date: Sun, 22 Mar 2015 00:29:58 +0000
Message-ID: <1426984203-9133-3-git-send-email-stefan.wahren@i2se.com>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: shawn.guo@linaro.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, broonie@kernel.org, lgirdwood@gmail.com, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, robh+dt@kernel.org, galak@codeaurora.org
Cc: fabio.estevam@freescale.com, marex@denx.de, devicetree@vger.kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, Stefan Wahren <stefan.wahren@i2se.com>, kernel@pengutronix.de, sebastien.szymanski@armadeus.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This patch adds a minimal driver for the Freescale i.MX23, i.MX28
power subsystem. It's required to trigger the probing of the underlying
drivers like on-chip regulators.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/power/Kconfig     |    8 +++
 drivers/power/Makefile    |    1 +
 drivers/power/mxs_power.c |  146 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 155 insertions(+)
 create mode 100644 drivers/power/mxs_power.c

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 4091fb0..b689017 100644
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
index b7b0181..8edcad7 100644
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
index 0000000..f3428d3
--- /dev/null
+++ b/drivers/power/mxs_power.c
@@ -0,0 +1,146 @@
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
+#define HW_POWER_CTRL_CLR	0x08
+
+#define BM_POWER_CTRL_POLARITY_VBUSVALID	BIT(5)
+#define BM_POWER_CTRL_VBUSVALID_IRQ		BIT(4)
+#define BM_POWER_CTRL_ENIRQ_VBUS_VALID		BIT(3)
+
+#define HW_POWER_5VCTRL_OFFSET	0x10
+
+#define BM_POWER_5VCTRL_VBUSVALID_THRESH	(7 << 8)
+#define BM_POWER_5VCTRL_PWDN_5VBRNOUT		BIT(7)
+#define BM_POWER_5VCTRL_ENABLE_LINREG_ILIMIT	BIT(6)
+#define BM_POWER_5VCTRL_VBUSVALID_5VDETECT	BIT(4)
+
+#define HW_POWER_5VCTRL_VBUSVALID_THRESH_4_40V	(5 << 8)
+
+struct mxs_power_data {
+	void __iomem *base_addr;
+	struct power_supply *ac;
+};
+
+static enum power_supply_property mxs_power_ac_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+};
+
+static int mxs_power_ac_get_property(struct power_supply *psy,
+				     enum power_supply_property psp,
+				     union power_supply_propval *val)
+{
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
+static const struct power_supply_desc ac_desc = {
+	.properties	= mxs_power_ac_props,
+	.num_properties	= ARRAY_SIZE(mxs_power_ac_props),
+	.get_property	= mxs_power_ac_get_property,
+	.name		= "ac",
+	.type		= POWER_SUPPLY_TYPE_MAINS,
+};
+
+static int mxs_power_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct resource *res;
+	struct mxs_power_data *data;
+	struct power_supply_config psy_cfg = {};
+	void __iomem *v5ctrl_addr;
+
+	if (!np) {
+		dev_err(dev, "missing device tree\n");
+		return -EINVAL;
+	}
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->base_addr = devm_ioremap_resource(dev, res);
+	if (IS_ERR(data->base_addr))
+		return PTR_ERR(data->base_addr);
+
+	psy_cfg.drv_data = data;
+
+	data->ac = power_supply_register(dev, &ac_desc, &psy_cfg);
+	if (IS_ERR(data->ac))
+		return PTR_ERR(data->ac);
+
+	platform_set_drvdata(pdev, data);
+
+	v5ctrl_addr = data->base_addr + HW_POWER_5VCTRL_OFFSET;
+
+	/* Make sure the current limit of the linregs are disabled. */
+	writel(BM_POWER_5VCTRL_ENABLE_LINREG_ILIMIT,
+	       v5ctrl_addr + HW_POWER_CTRL_CLR);
+
+	return of_platform_populate(np, NULL, NULL, dev);
+}
+
+static int mxs_power_remove(struct platform_device *pdev)
+{
+	struct mxs_power_data *data = platform_get_drvdata(pdev);
+
+	power_supply_unregister(data->ac);
+
+	return 0;
+}
+
+static struct platform_driver mxs_power_driver = {
+	.driver = {
+		.name	= "mxs_power",
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
