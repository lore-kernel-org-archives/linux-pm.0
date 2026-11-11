Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394874;
	b=3i7eL68w9btIdoOJpyT41gxskiZcaxq6pVvV1w2WDhnbULmhhXl4B3uB1HZPgXJAlE5T
	 vExwwOWraPIgdBY2eI/eZT1WMGdCIMeSh/WdGVfznzowHJ0sqQKaNk6UDT7m72sUGRLb1
	 z8/iKepZxpl8PrZ3w32sw+5uD7Eg+mlfGyj5jTu8RBpeSGpCsz4tXJeLEg0dupHKIJ4FP
	 shh0Ua39pFwbJ/gasEH3fNtyXDmWzsH186P/pBMIPD2Ipa8WMTBgq5uB7xaJd3E+bm3cB
	 EBODcJYJxFYh1CZ4oAEuc98ZgWgRfnPjarRMGlqoh9SeCO5XX/uKQRfOW6xaWmlAYVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394874;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=A/+wx61uRYhCnoT+kwJpeTxEoUHYoUFHUOua9VvIOkg=;
	b=H7YjNIu+eRwbjoR8h7y/50Pcy9UYcCYyl8dLLfS/I/OqoD2SZL6qyYgZUs+ktCNGmIO+
	 tkB210tvjqVQRpWCrRMsJHftmkR95EufXtBBx2TzLfJnrgsM1Ct87m3E+2TrBLztVhA+u
	 AZml5ezkiZ7B3pZy1JmZW9urAd+HxyuQHP8n26OPZhXR3cvzwrgPjdbePaqtvs5Ks2IED
	 FEhTaSx2swjAqrRRFOi96+/n4RdEjCMeurTCyLRgg9Q14LvU0TVFC/xk0Q1QS0zLSCdNZ
	 RNyCA+NCnJXxi8zFY74/DQFSF2/rgncr2IKHYEUAaRBG/AYpmw1SxBGP/Vj/MEjgt5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GFruyEy6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF07B606A31C;
	Wed, 11 Nov 2026 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GFruyEy6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CAF1F00A06;
	Wed, 11 Nov 2026 11:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794394874;
	bh=A/+wx61uRYhCnoT+kwJpeTxEoUHYoUFHUOua9VvIOkg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GFruyEy6O9KEACdt198iMWHI+OxBgH7bsDRukZ884bLw540/BSkPfvlrKkiQ1S7Wz
	 KcraXjiLHMkzYKWg4LhraPjktM8/lGFt/G9vP5WhT4As3SIV+37YiS2SWlowSWkhS0
	 pUvdn/2sBX8Mjwlj/KLWRxjpKervQsb1akhZPL+9z3VCtJ/os8wOBxCyDnOcgkVDwC
	 D+5bslr31ttW8cBpQE8dUpc6MpHPr2d8dMo+A+HCqmgdez/1DaKRUipy0HLuL56BkU
	 jUYZM6bkBeZxPjefgmhqT4HwhNkRBNZGJeqviEFqiIR6HpA6fzNxGSdqfnEJoTX/2Q
	 sX7q9iHxcYc/w==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 11 Nov 2026 12:00:45 +0100
Subject: [PATCH v4 4/7] pmdomain: bcm: Add BCMBCA PMB power domains
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-xg6846b-bcmbca-xrdp-reset-v4-4-17035a5e8ad2@kernel.org>
References: <20261111-xg6846b-bcmbca-xrdp-reset-v4-0-17035a5e8ad2@kernel.org>
In-Reply-To: <20261111-xg6846b-bcmbca-xrdp-reset-v4-0-17035a5e8ad2@kernel.org>
To: Linus Walleij <linusw@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 William Zhang <william.zhang@broadcom.com>, 
 Anand Gore <anand.gore@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
 Ulf Hansson <ulfh@kernel.org>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: mfd@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.16.0

Implement BCM6846 BPCM power domains.

Group XRDP, its three Runner cores and WAN in vendor xrdp_pmb[] order,
so consumers can power the complete packet engine before resetting it.

Also expose peripheral, memory, USB and PCIe domains. Keep the peripheral
and memory domains always on; exclude CPU and PLL blocks with different
register layouts.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 MAINTAINERS                       |   1 +
 drivers/pmdomain/bcm/Kconfig      |  10 ++
 drivers/pmdomain/bcm/Makefile     |   1 +
 drivers/pmdomain/bcm/bcmbca-pmb.c | 279 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 291 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9c9ef7eddb10..6702e9c447ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5454,6 +5454,7 @@ F:	Documentation/devicetree/bindings/power/brcm,bcm6846-pmb-power.yaml
 F:	Documentation/devicetree/bindings/reset/brcm,bcm6846-pmb-reset.yaml
 F:	Documentation/devicetree/bindings/soc/bcm/brcm,bcm6846-pmb.yaml
 F:	drivers/mfd/bcmbca_pmc3_pmb.c
+F:	drivers/pmdomain/bcm/bcmbca-pmb.c
 F:	include/dt-bindings/clock/brcm,bcm6846-pmb.h
 F:	include/dt-bindings/power/brcm,bcm6846-pmb.h
 F:	include/dt-bindings/reset/brcm,bcm6846-pmb.h
diff --git a/drivers/pmdomain/bcm/Kconfig b/drivers/pmdomain/bcm/Kconfig
index b28c9f6d256b..fb0c2baea156 100644
--- a/drivers/pmdomain/bcm/Kconfig
+++ b/drivers/pmdomain/bcm/Kconfig
@@ -31,6 +31,16 @@ config BCM_PMB
 	  This enables support for the Broadcom's PMB (Power Management Bus) that
 	  is used for disabling and enabling SoC devices.
 
+config BCMBCA_PMB_POWER
+	bool "Broadcom BCMBCA PMB power domains"
+	depends on MFD_BCMBCA_PMB
+	depends on PM
+	default MFD_BCMBCA_PMB
+	select PM_GENERIC_DOMAINS
+	help
+	  Provide power domains for BCM6846 blocks through the shared PMC3
+	  Power Management Bus regmap, including the XRDP packet processor.
+
 config BCM63XX_POWER
 	bool "BCM63xx power domain driver"
 	depends on BMIPS_GENERIC || (COMPILE_TEST && OF)
diff --git a/drivers/pmdomain/bcm/Makefile b/drivers/pmdomain/bcm/Makefile
index 6bfbe4e4db13..ed8a1d3d4c10 100644
--- a/drivers/pmdomain/bcm/Makefile
+++ b/drivers/pmdomain/bcm/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_BCM_PMB)			+= bcm-pmb.o
 obj-$(CONFIG_BCM2835_POWER)		+= bcm2835-power.o
 obj-$(CONFIG_BCM63XX_POWER)		+= bcm63xx-power.o
 obj-$(CONFIG_RASPBERRYPI_POWER)		+= raspberrypi-power.o
+obj-$(CONFIG_BCMBCA_PMB_POWER)		+= bcmbca-pmb.o
diff --git a/drivers/pmdomain/bcm/bcmbca-pmb.c b/drivers/pmdomain/bcm/bcmbca-pmb.c
new file mode 100644
index 000000000000..9a631b7b0360
--- /dev/null
+++ b/drivers/pmdomain/bcm/bcmbca-pmb.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Broadcom BCM6846 BPCM power zones, accessed through the PMC3 PMB regmap. */
+
+#include <linux/bits.h>
+#include <linux/mfd/bcmbca-pmb.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/power/brcm,bcm6846-pmb.h>
+
+/* BCM6846 BPCM zone control, in PMB words, with eight words per zone. */
+#define BCM6846_ZONE_CONTROL(zone)	(32 + (zone) * 8)
+#define BCM6846_ZONE_DPG_EN		BIT(8)
+#define BCM6846_ZONE_POWER_DOWN		BIT(9)
+#define BCM6846_ZONE_POWER_UP		BIT(10)
+#define BCM6846_ZONE_MEM_POWER		BIT(11)
+#define BCM6846_ZONE_RESET		BIT(12)
+#define BCM6846_ZONE_POWER_OFF		BIT(25)
+#define BCM6846_ZONE_POWER_ON		BIT(26)
+
+struct bcmbca_pmb_power_block {
+	u8 bus;
+	u8 device;
+	u8 zones;
+};
+
+struct bcmbca_pmb_power_data {
+	const char *name;
+	const struct bcmbca_pmb_power_block *blocks;
+	unsigned int num_blocks;
+	unsigned int flags;
+};
+
+struct bcmbca_pmb_power_domain {
+	struct generic_pm_domain genpd;
+	struct device *dev;
+	struct regmap *regmap;
+	const struct bcmbca_pmb_power_data *data;
+};
+
+static const struct bcmbca_pmb_power_block bcm6846_periph[] = { { 0, 0, 4 } };
+static const struct bcmbca_pmb_power_block bcm6846_memc[] = { { 1, 8, 1 } };
+static const struct bcmbca_pmb_power_block bcm6846_usb20[] = { { 1, 10, 4 } };
+static const struct bcmbca_pmb_power_block bcm6846_pcie0[] = { { 0, 18, 1 } };
+static const struct bcmbca_pmb_power_block bcm6846_pcie1[] = { { 0, 19, 1 } };
+
+/* Power up XRDP, three Runners, then WAN. */
+static const struct bcmbca_pmb_power_block bcm6846_xrdp[] = {
+	{ 1, 12, 3 }, { 1, 14, 1 }, { 1, 15, 1 }, { 1, 16, 1 }, { 1, 11, 3 },
+};
+
+static const struct bcmbca_pmb_power_data bcm6846_domains[] = {
+	[BCM6846_PD_PERIPH] = {
+		.name = "periph",
+		.blocks = bcm6846_periph,
+		.num_blocks = ARRAY_SIZE(bcm6846_periph),
+		.flags = GENPD_FLAG_ALWAYS_ON,
+	},
+	[BCM6846_PD_MEMC] = {
+		.name = "memc",
+		.blocks = bcm6846_memc,
+		.num_blocks = ARRAY_SIZE(bcm6846_memc),
+		.flags = GENPD_FLAG_ALWAYS_ON,
+	},
+	[BCM6846_PD_USB20] = {
+		.name = "usb20",
+		.blocks = bcm6846_usb20,
+		.num_blocks = ARRAY_SIZE(bcm6846_usb20),
+	},
+	[BCM6846_PD_XRDP] = {
+		.name = "xrdp",
+		.blocks = bcm6846_xrdp,
+		.num_blocks = ARRAY_SIZE(bcm6846_xrdp),
+	},
+	[BCM6846_PD_PCIE0] = {
+		.name = "pcie0",
+		.blocks = bcm6846_pcie0,
+		.num_blocks = ARRAY_SIZE(bcm6846_pcie0),
+	},
+	[BCM6846_PD_PCIE1] = {
+		.name = "pcie1",
+		.blocks = bcm6846_pcie1,
+		.num_blocks = ARRAY_SIZE(bcm6846_pcie1),
+	},
+};
+
+static unsigned int bcmbca_pmb_zone_reg(const struct bcmbca_pmb_power_block *block,
+					unsigned int zone)
+{
+	return BCMBCA_PMB_REG(block->bus, block->device, BCM6846_ZONE_CONTROL(zone));
+}
+
+static int bcmbca_pmb_zone_off(struct bcmbca_pmb_power_domain *pd,
+			       const struct bcmbca_pmb_power_block *block, unsigned int zone)
+{
+	unsigned int reg = bcmbca_pmb_zone_reg(block, zone);
+	unsigned int value;
+	int ret;
+
+	/* Request power-down and cancel power-up. */
+	ret = regmap_write_bits(pd->regmap, reg,
+				BCM6846_ZONE_POWER_DOWN | BCM6846_ZONE_POWER_UP,
+				BCM6846_ZONE_POWER_DOWN);
+	if (ret)
+		return ret;
+
+	return regmap_read_poll_timeout(pd->regmap, reg, value,
+					value & BCM6846_ZONE_POWER_OFF, 10, 10000);
+}
+
+static int bcmbca_pmb_power_on(struct generic_pm_domain *genpd)
+{
+	struct bcmbca_pmb_power_domain *pd = container_of(genpd, typeof(*pd), genpd);
+	const struct bcmbca_pmb_power_data *data = pd->data;
+	/* One bit per zone, tracking only zones changed by this attempt. */
+	u32 changed[ARRAY_SIZE(bcm6846_xrdp)] = {};
+	const struct bcmbca_pmb_power_block *block;
+	unsigned int i, zone, reg, value, mask;
+	int ret;
+
+	for (i = 0; i < data->num_blocks; i++) {
+		block = &data->blocks[i];
+		for (zone = 0; zone < block->zones; zone++) {
+			reg = bcmbca_pmb_zone_reg(block, zone);
+			ret = regmap_read(pd->regmap, reg, &value);
+			if (ret)
+				goto rollback;
+			if ((value & BCM6846_ZONE_POWER_ON) &&
+			    !(value & BCM6846_ZONE_POWER_DOWN))
+				continue;
+
+			changed[i] |= BIT(zone);
+			/* Enable dynamic gating, memory power control and block reset. */
+			mask = BCM6846_ZONE_POWER_DOWN | BCM6846_ZONE_DPG_EN |
+			       BCM6846_ZONE_POWER_UP | BCM6846_ZONE_MEM_POWER |
+			       BCM6846_ZONE_RESET;
+			ret = regmap_write_bits(pd->regmap, reg, mask,
+						mask & ~BCM6846_ZONE_POWER_DOWN);
+			if (ret)
+				goto rollback;
+			ret = regmap_read_poll_timeout(pd->regmap, reg, value,
+						       value & BCM6846_ZONE_POWER_ON, 10, 10000);
+			if (ret)
+				goto rollback;
+		}
+	}
+	return 0;
+
+rollback:
+	dev_err(pd->dev, "%s power-up failed at bus %u device %u zone %u: %d\n",
+		data->name, block->bus, block->device, zone, ret);
+	/* Preserve zones left powered by firmware or an earlier attempt. */
+	for (i = data->num_blocks; i-- > 0;) {
+		block = &data->blocks[i];
+		for (zone = block->zones; zone-- > 0;)
+			if ((changed[i] & BIT(zone)) && bcmbca_pmb_zone_off(pd, block, zone))
+				dev_err(pd->dev, "%s power-up rollback failed\n", data->name);
+	}
+	return ret;
+}
+
+static int bcmbca_pmb_power_off(struct generic_pm_domain *genpd)
+{
+	struct bcmbca_pmb_power_domain *pd = container_of(genpd, typeof(*pd), genpd);
+	const struct bcmbca_pmb_power_data *data = pd->data;
+	unsigned int i;
+	int ret;
+
+	/* Powering down zone zero powers down the whole block. */
+	for (i = data->num_blocks; i-- > 0;) {
+		ret = bcmbca_pmb_zone_off(pd, &data->blocks[i], 0);
+		if (ret) {
+			/* genpd keeps the domain logically on when power-off fails. */
+			if (bcmbca_pmb_power_on(genpd))
+				dev_err(pd->dev, "%s power-off recovery failed\n", data->name);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static int bcmbca_pmb_power_is_off(struct bcmbca_pmb_power_domain *pd, bool *off)
+{
+	const struct bcmbca_pmb_power_data *data = pd->data;
+	unsigned int i, zone, value;
+	int ret;
+
+	*off = false;
+	for (i = 0; i < data->num_blocks; i++) {
+		for (zone = 0; zone < data->blocks[i].zones; zone++) {
+			ret = regmap_read(pd->regmap, bcmbca_pmb_zone_reg(&data->blocks[i], zone),
+					  &value);
+			if (ret)
+				return ret;
+			if (!(value & BCM6846_ZONE_POWER_ON) || (value & BCM6846_ZONE_POWER_DOWN))
+				*off = true;
+		}
+	}
+	return 0;
+}
+
+static int bcmbca_pmb_power_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap = dev_get_regmap(dev->parent, NULL);
+	struct bcmbca_pmb_power_domain *domains;
+	struct genpd_onecell_data *onecell;
+	unsigned int i;
+	bool off;
+	int ret;
+
+	if (!regmap)
+		return -ENODEV;
+
+	onecell = devm_kzalloc(dev, sizeof(*onecell), GFP_KERNEL);
+	if (!onecell)
+		return -ENOMEM;
+	onecell->num_domains = ARRAY_SIZE(bcm6846_domains);
+	onecell->domains = devm_kcalloc(dev, onecell->num_domains,
+					sizeof(*onecell->domains), GFP_KERNEL);
+	domains = devm_kcalloc(dev, onecell->num_domains, sizeof(*domains), GFP_KERNEL);
+	if (!onecell->domains || !domains)
+		return -ENOMEM;
+
+	for (i = 0; i < onecell->num_domains; i++) {
+		struct bcmbca_pmb_power_domain *pd = &domains[i];
+
+		pd->dev = dev;
+		pd->regmap = regmap;
+		pd->data = &bcm6846_domains[i];
+		pd->genpd.name = pd->data->name;
+		pd->genpd.flags = pd->data->flags;
+		pd->genpd.power_on = bcmbca_pmb_power_on;
+		pd->genpd.power_off = bcmbca_pmb_power_off;
+		ret = bcmbca_pmb_power_is_off(pd, &off);
+		if (ret)
+			goto remove_domains;
+		/* Always-on domains must be fully powered before genpd initialization. */
+		if (off && (pd->data->flags & GENPD_FLAG_ALWAYS_ON)) {
+			ret = bcmbca_pmb_power_on(&pd->genpd);
+			if (ret)
+				goto remove_domains;
+			off = false;
+		}
+		ret = pm_genpd_init(&pd->genpd, NULL, off);
+		if (ret)
+			goto remove_domains;
+		onecell->domains[i] = &pd->genpd;
+	}
+	ret = of_genpd_add_provider_onecell(dev->of_node, onecell);
+	if (!ret)
+		return 0;
+
+remove_domains:
+	while (i-- > 0)
+		pm_genpd_remove(onecell->domains[i]);
+	return dev_err_probe(dev, ret, "failed to register PMB power domains\n");
+}
+
+static const struct of_device_id bcmbca_pmb_power_of_match[] = {
+	{ .compatible = "brcm,bcm6846-pmb-power" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bcmbca_pmb_power_of_match);
+
+static struct platform_driver bcmbca_pmb_power_driver = {
+	.probe = bcmbca_pmb_power_probe,
+	.driver = {
+		.name = "bcmbca-pmb-power",
+		.of_match_table = bcmbca_pmb_power_of_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver(bcmbca_pmb_power_driver);
+
+MODULE_DESCRIPTION("Broadcom BCMBCA PMB power domains");
+MODULE_LICENSE("GPL");

-- 
2.56.0

