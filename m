Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795379581;
	b=3AM3awFIG5S8/DeI5eVhMsXQYIvEYSFOnlPgeEZ+xeo/sJiye5KYVG2z7mFlmkURsC2a
	 duS6erTG2oIcRs/cUoD2RJPxr/BFUhtLyuU4EPwWE8ebHEVz1C+dATi4RWLkE5ev/6f+5
	 Fk22pEH5talPezKk3vPPmFH1/GJhjmbINj+cfbK0vlB2RjOAk1mVC6nO/r1IMTqLr1bre
	 zIzEiqN7F/EfToQ6U8Nbtr5fIb0tWhGfEq7MWEYl3HDtRfBqziZez12MDpwyOtGdPUgxr
	 j7tDccfsDnnrD/Gs2Bc44/DaJbWwekqFSvxmjT1iHKG76Qsj07kXdxrSmIxkiZ7rSNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795379581;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=IT3uhrPADx9D4Srqz/Zu9EO3T+JRAK83LQQrhjQqwfA=;
	b=X6/xlR+HCrf3xop5KIbKLzOR7Jm/RnSIt1BrDNM8RpN0O72f9XX9o+mPpe4xf9KMKe49
	 kxYSGK+xR+HTJIAiZU555HYePRk+RUG7xMUqVErv6kKnxzTEPLI6A2URChtfWeSvJsDW7
	 Dh0TiwcCvKTDSmd8hemGX4vNBCs2wppYr+MLiJmkK4JgYA41ek6FvcsoK4J7YgXRp5OkE
	 R328M/nH5AGP1WjqcJEz8KXjarM9257tEJ74PQNazip3gZezHklUCa33geq1iwp4eTbI9
	 awwuoaOvIH9WsyHf+XBOSv9MMwEa8kyhvuOV9LiJsFZlU1WD5LcNJ4EJ86JGgDdrUPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RthWLvdh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A092606A320;
	Sun, 22 Nov 2026 20:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RthWLvdh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A287F1F000E1;
	Sun, 22 Nov 2026 20:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795379581;
	bh=IT3uhrPADx9D4Srqz/Zu9EO3T+JRAK83LQQrhjQqwfA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RthWLvdho+9S+/rxudDhN9AiC7SQazvm0xfejlHwEkrtww7S0dfXAPO+5OvpFRxrl
	 xxOZbBqV+wfMDo+Iz6lIq6Iqpp7zsABoP+iT/+hYCMsBt1Uv/181G4LPOFA5VohIrm
	 KTLQmH4Z/3r6c6n2/191EWkye1KVzSAEaVZe6/GMV0QF3mH6KJDMGUJmBF9eP1SLQv
	 dSOw4NJZDqDVlw7coFsEkRe4OwQ/hn8mI+hQs7P4MahstncjLmtYoGmaD/sRafPEqq
	 8aySV695WyFLqr+47RCAKZS4U3PE3eAXGSsI213oA8vt5dGoRb/4hf6pkNX+9QmQj1
	 6jAZZdoPBKKqw==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 22 Nov 2026 21:32:29 +0100
Subject: [PATCH v6 4/6] reset: Add BCMBCA block resets through the PMB
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261122-xg6846b-bcmbca-xrdp-reset-v6-4-bf2104a25095@kernel.org>
References: <20261122-xg6846b-bcmbca-xrdp-reset-v6-0-bf2104a25095@kernel.org>
In-Reply-To: <20261122-xg6846b-bcmbca-xrdp-reset-v6-0-bf2104a25095@kernel.org>
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

Implement the BCM6846 XRDP reset group through the shared PMB regmap.
Assert all blocks before releasing any of them, preserving the vendor
reset masks and ordering. Provide the independent PVTMON acquisition
reset as well. Serialize complete sequences and hold blocks in reset
on failure.

Consumers must enable their power domains before triggering a reset
pulse (i.e. the cycle of asserting/deasserting reset).

Suppress bind attributes: it's not good to be able to unbind the
reset driver for the SoC manually.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
I kept the suppress_bind_attributes around: it looks dangerous to
be able to unbind the reset driver.
---
 MAINTAINERS                      |   1 +
 drivers/reset/Kconfig            |  13 +++
 drivers/reset/Makefile           |   1 +
 drivers/reset/reset-bcmbca-pmb.c | 227 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 242 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cfe64722a708..1d92b70c4465 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5450,6 +5450,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml
 F:	drivers/mfd/bcmbca_pmc3_pmb.c
 F:	drivers/pmdomain/bcm/bcmbca-pmb.c
+F:	drivers/reset/reset-bcmbca-pmb.c
 F:	include/dt-bindings/clock/brcm,bcm6846-pmb.h
 F:	include/dt-bindings/power/brcm,bcm6846-pmb.h
 F:	include/dt-bindings/reset/brcm,bcm6846-pmb.h
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index eda9c698a95f..7371aead0b17 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -49,6 +49,19 @@ config RESET_BCM6345
 	help
 	  This enables the reset controller driver for BCM6345 SoCs.
 
+config RESET_BCMBCA_PMB
+	tristate "Broadcom BCMBCA PMB reset controller"
+	depends on ARCH_BCMBCA || COMPILE_TEST
+	depends on OF && HAS_IOMEM
+	depends on MFD_BCMBCA_PMB
+	select REGMAP
+	default MFD_BCMBCA_PMB
+	help
+	  Reset BCMBCA blocks through the Power Management Bus (PMB) of
+	  the third generation Power Management Controller (PMC3).
+
+	  The module will be called reset-bcmbca-pmb.
+
 config RESET_BERLIN
 	tristate "Berlin Reset Driver"
 	depends on ARCH_BERLIN || COMPILE_TEST
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 489fafd6bbe3..26c8a73f774f 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_RESET_ASPEED) += reset-aspeed.o
 obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
 obj-$(CONFIG_RESET_AXS10X) += reset-axs10x.o
 obj-$(CONFIG_RESET_BCM6345) += reset-bcm6345.o
+obj-$(CONFIG_RESET_BCMBCA_PMB) += reset-bcmbca-pmb.o
 obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
 obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
 obj-$(CONFIG_RESET_BRCMSTB_RESCAL) += reset-brcmstb-rescal.o
diff --git a/drivers/reset/reset-bcmbca-pmb.c b/drivers/reset/reset-bcmbca-pmb.c
new file mode 100644
index 000000000000..80159b92de88
--- /dev/null
+++ b/drivers/reset/reset-bcmbca-pmb.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * BCMBCA block resets through the Power Management Bus (PMB) of the
+ * third generation Power Management Controller (PMC3).
+ */
+
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/mfd/bcmbca-pmb.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+#include <linux/string_choices.h>
+
+#include <dt-bindings/reset/brcm,bcm6846-pmb.h>
+
+struct bcmbca_pmb_reset_block {
+	u8 bus;
+	u8 device;
+	u16 offset; /* PMB word offset of the reset register. */
+	u32 mask;
+	u32 assert_value;
+	u32 deassert_value;
+};
+
+struct bcmbca_pmb_reset_group {
+	const char *name;
+	const struct bcmbca_pmb_reset_block *blocks;
+	unsigned int num_blocks;
+	/* Minimum reset assertion hold time in microseconds. */
+	unsigned int assert_hold_us;
+};
+
+struct bcmbca_pmb_reset_variant {
+	const struct bcmbca_pmb_reset_group *groups;
+	unsigned int num_groups;
+};
+
+struct bcmbca_pmb_reset {
+	struct reset_controller_dev rcdev;
+	const struct bcmbca_pmb_reset_variant *variant;
+	struct regmap *regmap;
+	/* Serialize complete reset pulses and failure cleanup. */
+	struct mutex lock;
+};
+
+static const struct bcmbca_pmb_reset_block bcm6846_xrdp_resets[] = {
+	{
+		.bus = 1,
+		.device = 12,
+		.offset = 5,
+		.mask = GENMASK(27, 0),
+		/* Keep bits 0–2 deasserted. */
+		.assert_value = GENMASK(2, 0),
+		.deassert_value = GENMASK(27, 0),
+	},
+	{
+		.bus = 1,
+		.device = 14,
+		.offset = 5,
+		.mask = GENMASK(27, 0),
+		.deassert_value = GENMASK(27, 0),
+	},
+	{
+		.bus = 1,
+		.device = 15,
+		.offset = 5,
+		.mask = GENMASK(27, 0),
+		.deassert_value = GENMASK(27, 0),
+	},
+	{
+		.bus = 1,
+		.device = 16,
+		.offset = 5,
+		.mask = GENMASK(27, 0),
+		.deassert_value = GENMASK(27, 0),
+	},
+};
+
+/* Analog acquisition reset, independent of clock and power configuration. */
+static const struct bcmbca_pmb_reset_block bcm6846_pvtmon_reset = {
+	.bus = 1,
+	.device = 6,
+	.offset = 17,
+	.mask = BIT(0),
+	.deassert_value = BIT(0),
+};
+
+static const struct bcmbca_pmb_reset_group bcm6846_pmb_reset_groups[] = {
+	[BCM6846_RESET_XRDP] = {
+		.name = "XRDP",
+		.blocks = bcm6846_xrdp_resets,
+		.num_blocks = ARRAY_SIZE(bcm6846_xrdp_resets),
+		.assert_hold_us = 10,
+	},
+	[BCM6846_RESET_PVTMON] = {
+		.name = "PVTMON",
+		.blocks = &bcm6846_pvtmon_reset,
+		.num_blocks = 1,
+		.assert_hold_us = 1000,
+	},
+};
+
+static const struct bcmbca_pmb_reset_variant bcm6846_pmb_variant = {
+	.groups = bcm6846_pmb_reset_groups,
+	.num_groups = ARRAY_SIZE(bcm6846_pmb_reset_groups),
+};
+
+/* Best effort: never restart a partially reset group. */
+static void bcmbca_pmb_reset_cleanup(struct bcmbca_pmb_reset *rst,
+				     const struct bcmbca_pmb_reset_group *group)
+{
+	const struct bcmbca_pmb_reset_block *block;
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < group->num_blocks; i++) {
+		block = &group->blocks[i];
+		ret = regmap_update_bits(rst->regmap,
+					 BCMBCA_PMB_REG(block->bus, block->device, block->offset),
+					 block->mask, block->assert_value);
+		if (ret)
+			dev_err(rst->rcdev.dev,
+				"failed to hold PMB bus %u device %u in reset: %d\n",
+				block->bus, block->device, ret);
+	}
+}
+
+static int bcmbca_pmb_reset_sequence(struct bcmbca_pmb_reset *rst,
+				     const struct bcmbca_pmb_reset_group *group)
+{
+	const struct bcmbca_pmb_reset_block *block;
+	enum {
+		PASS_ASSERT,
+		PASS_DEASSERT,
+	} pass;
+	unsigned int i;
+	int ret;
+
+	if (!group->num_blocks)
+		return -EINVAL;
+
+	/* Assert every block before releasing any of them. */
+	for (pass = PASS_ASSERT; pass <= PASS_DEASSERT; pass++) {
+		for (i = 0; i < group->num_blocks; i++) {
+			block = &group->blocks[i];
+			ret = regmap_update_bits(rst->regmap,
+						 BCMBCA_PMB_REG(block->bus, block->device,
+								block->offset), block->mask,
+						 pass == PASS_DEASSERT ? block->deassert_value :
+						 block->assert_value);
+			if (ret)
+				goto cleanup;
+		}
+		if (pass == PASS_ASSERT && group->assert_hold_us)
+			usleep_range(group->assert_hold_us, group->assert_hold_us * 2);
+	}
+cleanup:
+	if (ret) {
+		dev_err(rst->rcdev.dev, "%s %s failed at PMB bus %u device %u: %d\n",
+			group->name, str_assert_deassert(pass == PASS_ASSERT),
+			block->bus, block->device, ret);
+		bcmbca_pmb_reset_cleanup(rst, group);
+	}
+	return ret;
+}
+
+static int bcmbca_pmb_reset(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct bcmbca_pmb_reset *rst = container_of(rcdev, struct bcmbca_pmb_reset, rcdev);
+	const struct bcmbca_pmb_reset_group *group = &rst->variant->groups[id];
+
+	guard(mutex)(&rst->lock);
+	return bcmbca_pmb_reset_sequence(rst, group);
+}
+
+static const struct reset_control_ops bcmbca_pmb_reset_ops = {
+	.reset = bcmbca_pmb_reset,
+};
+
+static int bcmbca_pmb_reset_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap = dev_get_regmap(dev->parent, NULL);
+	struct bcmbca_pmb_reset *rst;
+
+	if (!regmap)
+		return -ENODEV;
+
+	rst = devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
+	if (!rst)
+		return -ENOMEM;
+	rst->variant = device_get_match_data(dev);
+	if (!rst->variant)
+		return -ENODEV;
+	rst->regmap = regmap;
+	mutex_init(&rst->lock);
+	rst->rcdev.owner = THIS_MODULE;
+	rst->rcdev.dev = dev;
+	rst->rcdev.ops = &bcmbca_pmb_reset_ops;
+	rst->rcdev.of_node = dev->of_node;
+	rst->rcdev.nr_resets = rst->variant->num_groups;
+	return devm_reset_controller_register(dev, &rst->rcdev);
+}
+
+static const struct of_device_id bcmbca_pmb_reset_of_match[] = {
+	{ .compatible = "brcm,bcm6846-pmb-reset", .data = &bcm6846_pmb_variant },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bcmbca_pmb_reset_of_match);
+
+static struct platform_driver bcmbca_pmb_reset_driver = {
+	.probe = bcmbca_pmb_reset_probe,
+	.driver = {
+		.name = "brcm-pmb-reset",
+		.of_match_table = bcmbca_pmb_reset_of_match,
+		.suppress_bind_attrs = true,
+	},
+};
+module_platform_driver(bcmbca_pmb_reset_driver);
+
+MODULE_DESCRIPTION("Broadcom BCMBCA PMB reset controller");
+MODULE_LICENSE("GPL");

-- 
2.56.1

