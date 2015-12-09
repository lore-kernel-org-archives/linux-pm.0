From: Simon Arlott <simon@fire.lp0.eu>
Subject: [PATCH linux-next 2/2] power: bcm6358-power: Add BCM6358 power domain
 controller support
Date: Wed, 9 Dec 2015 22:30:22 +0000
Message-ID: <5668AB7E.4080209@simon.arlott.org.uk>
References: <5668AB4F.7030100@simon.arlott.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from proxima.lp0.eu ([81.2.80.65]:52877 "EHLO proxima.lp0.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422AbbLIWa3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 9 Dec 2015 17:30:29 -0500
In-Reply-To: <5668AB4F.7030100@simon.arlott.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Kevin Cernekee <cernekee@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonas Gorski <jogo@openwrt.org>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>, MIPS Mailing List <linux-mips@linux-mips.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>

The BCM6358 contains power domains controlled with a register. Power
domains are indexed by bits in the register. Power domain bits can be
interleaved with other status bits and clocks in the same register.

Newer SoCs with dedicated power domain registers are active low.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
 MAINTAINERS                   |   1 +
 drivers/power/Kconfig         |  11 +++
 drivers/power/Makefile        |   1 +
 drivers/power/bcm6358-power.c | 198 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 211 insertions(+)
 create mode 100644 drivers/power/bcm6358-power.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0370aba..5546a53 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2391,6 +2391,7 @@ F:	drivers/clk/bcm/clk-bcm6345*
 F:	drivers/irqchip/irq-bcm63*
 F:	drivers/irqchip/irq-bcm7*
 F:	drivers/irqchip/irq-brcmstb*
+F:	drivers/power/bcm6358*
 F:	drivers/reset/bcm/reset-bcm6345*
 F:	include/linux/bcm63xx_wdt.h
 
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 1ddd13c..3d6f842 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -506,3 +506,14 @@ endif # POWER_SUPPLY
 
 source "drivers/power/reset/Kconfig"
 source "drivers/power/avs/Kconfig"
+
+config BCM6358_POWER
+	bool "BCM6358 power domain support"
+	depends on BMIPS_GENERIC && PM && OF
+	select PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS_OF
+	default BMIPS_GENERIC
+	help
+	  Say Y here to enable support for power domains on the BCM6358.
+	  Required to ensure that power is enabled for SoC peripheral
+	  devices, and that power is disabled to unused devices.
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index 0e4eab5..0b72dd2 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_GENERIC_ADC_BATTERY)	+= generic-adc-battery.o
 obj-$(CONFIG_PDA_POWER)		+= pda_power.o
 obj-$(CONFIG_APM_POWER)		+= apm_power.o
 obj-$(CONFIG_AXP20X_POWER)	+= axp20x_usb_power.o
+obj-$(CONFIG_BCM6358_POWER)	+= bcm6358-power.o
 obj-$(CONFIG_MAX8925_POWER)	+= max8925_power.o
 obj-$(CONFIG_WM831X_BACKUP)	+= wm831x_backup.o
 obj-$(CONFIG_WM831X_POWER)	+= wm831x_power.o
diff --git a/drivers/power/bcm6358-power.c b/drivers/power/bcm6358-power.c
new file mode 100644
index 0000000..f4654d7
--- /dev/null
+++ b/drivers/power/bcm6358-power.c
@@ -0,0 +1,198 @@
+/*
+ * Copyright 2015 Simon Arlott
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
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/pm_domain.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+
+#define BITS 32
+
+struct bcm6358_power;
+
+struct bcm6358_power_dev {
+	struct generic_pm_domain genpd;
+	struct bcm6358_power *power;
+	u32 bit;
+};
+
+struct bcm6358_power {
+	struct regmap *map;
+	u32 offset;
+	bool active_low;
+
+	struct bcm6358_power_dev dev[BITS];
+	struct genpd_onecell_data genpd_data;
+	struct generic_pm_domain *genpd[BITS];
+};
+
+static int bcm6358_power_get_state(struct bcm6358_power_dev *pmd,
+	bool *is_on)
+{
+	struct bcm6358_power *power = pmd->power;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(power->map, power->offset, &val);
+	if (ret) {
+		*is_on = false;
+		return ret;
+	}
+
+	if (power->active_low)
+		*is_on = !(val & pmd->bit);
+	else
+		*is_on = (val & pmd->bit);
+	return 0;
+}
+
+static int bcm6358_power_set_state(struct bcm6358_power_dev *pmd,
+	bool on)
+{
+	struct bcm6358_power *power = pmd->power;
+	u32 val;
+
+	if (power->active_low)
+		val = on ? 0 : pmd->bit;
+	else
+		val = on ? pmd->bit : 0;
+
+	return regmap_update_bits(power->map, power->offset, pmd->bit, val);
+}
+
+static int bcm6358_power_power_on(struct generic_pm_domain *genpd)
+{
+	struct bcm6358_power_dev *pmd = container_of(genpd,
+		struct bcm6358_power_dev, genpd);
+
+	return bcm6358_power_set_state(pmd, true);
+}
+
+static int bcm6358_power_power_off(struct generic_pm_domain *genpd)
+{
+	struct bcm6358_power_dev *pmd = container_of(genpd,
+		struct bcm6358_power_dev, genpd);
+
+	return bcm6358_power_set_state(pmd, false);
+}
+
+static int __init bcm6358_power_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct bcm6358_power *power;
+	unsigned int pmdomains = 0;
+	int ret, i;
+
+	power = devm_kzalloc(dev, sizeof(*power), GFP_KERNEL);
+	if (!power)
+		return -ENOMEM;
+
+	power->map = syscon_regmap_lookup_by_phandle(np, "regmap");
+	if (IS_ERR(power->map)) {
+		ret = PTR_ERR(power->map);
+		dev_err(dev, "failed to get regmap: %d\n", ret);
+		return ret;
+	}
+
+	if (of_property_read_u32(np, "offset", &power->offset)) {
+		dev_err(dev, "missing register offset\n");
+		return -EINVAL;
+	}
+
+	power->active_low = of_property_read_bool(np, "active-low");
+
+	power->genpd_data.domains = power->genpd;
+	power->genpd_data.num_domains = BITS;
+
+	/* power->genpd_data is sparse, indexed by bit,
+	 * maximum pm domains checked using i
+	 */
+	for (i = 0; i < power->genpd_data.num_domains; i++) {
+		struct bcm6358_power_dev *pmd = &power->dev[i];
+		u32 bit;
+		bool is_on;
+
+		if (of_property_read_u32_index(np, "power-domain-indices",
+				i, &bit))
+			goto out;
+
+		if (of_property_read_string_index(np, "power-domain-names",
+				i, &pmd->genpd.name))
+			goto out;
+
+		if (bit >= power->genpd_data.num_domains) {
+			dev_err(dev,
+				"power domain bit %u out of range\n", bit);
+			continue;
+		}
+
+		if (power->genpd[bit]) {
+			dev_err(dev,
+				"power domain bit %u already exists\n", bit);
+			continue;
+		}
+
+		pmd->power = power;
+		pmd->bit = BIT(bit);
+
+		ret = bcm6358_power_get_state(pmd, &is_on);
+		if (ret)
+			dev_warn(dev, "unable to get current state for %s\n",
+				pmd->genpd.name);
+
+		pmd->genpd.power_on = bcm6358_power_power_on;
+		pmd->genpd.power_off = bcm6358_power_power_off;
+
+		pm_genpd_init(&pmd->genpd, NULL, !is_on);
+		power->genpd[bit] = &pmd->genpd;
+		pmdomains++;
+	}
+
+out:
+	if (!pmdomains)
+		return -ENODEV;
+
+	ret = of_genpd_add_provider_onecell(np, &power->genpd_data);
+	if (ret) {
+		dev_err(dev, "failed to register genpd driver: %d\n", ret);
+		return ret;
+	}
+
+	dev_info(dev, "registered %u power domains\n", pmdomains);
+	return 0;
+}
+
+static const struct of_device_id bcm6358_power_ids[] __initconst = {
+	{ .compatible = "brcm,bcm6358-power-controller" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bcm6358_power_ids);
+
+static struct platform_driver bcm6358_power_driver __refdata = {
+	.probe  = bcm6358_power_probe,
+	.driver = {
+		.name = "bcm6358-power-controller",
+	.of_match_table = bcm6358_power_ids,
+	},
+};
+
+module_platform_driver(bcm6358_power_driver);
+
+MODULE_DESCRIPTION("BCM6358 Power domain controller driver");
+MODULE_AUTHOR("Simon Arlott");
+MODULE_LICENSE("GPL");
-- 
2.1.4

-- 
Simon Arlott
