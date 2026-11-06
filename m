Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793953645;
	b=AdqDOSC5w7ZDywH/+a2n7vXTcd5smFAo0D3Aue+m7UTIiob16gtaF77rD97EF5RpSf5/
	 slgAfPiOG2ik0EskkhbQ9Ng/ZJ5uy3axeLJdfU2ax1WURUjWbeNmroa2RFj0krhZ8MjmP
	 jO8VvJF/kRp3zgyHQZh+zK/iyM/RyvxkeW39b9Uun1MrSf7upj5PmfKY8QYqn3/lkH+rc
	 OySVHnVPbIFdkbsHGwJ+/f8lcQgNFNdQF7F89QcPA6xjMu2SsY6E64zB8v/WHu7M19Xxu
	 ck6r+uq0iSMyFAoQ5rtdBt9atjPeCKZcgpCxTrVd/7WUbaIqu8ndIXY6hLZb5cLxFCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953645;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Cp94Ekg2JFEGNzlkt0FRCQQnyLlqYCH0OTnsTXRuj/0=;
	b=iYUZTMMQV47JQNrHUW/27L29SfNg0X1FNq7wqxwzbBU+vExJZSwZCdV+Y64e1H6CButw
	 o/k4aHUFrFn5nftwaclXAk/uH87IPlctZ3U+8GPnusO3jMek2JPj+c+mq5ubcWGKdI42v
	 6k4ePWMNepqwVi1K8RMwQVOrh5kpOVt4wda15f9hSk6zEeqVf57Xnv6BDZ1iJV/4JLETK
	 5uRfi0wYJsQBcUg6xh79q+wp6RaexAXM+W+8Co6TeJwCFR1BlpLZHVCctnDqXOJtXa3Ww
	 PKbFZQ7pGeSgKYmIv/Tl1WUnsL2ZxEY1pEt5HsWuyFleVDK/sqwvI36CGIPQlg14taA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HzCXOVXD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1084F606A339;
	Fri,  6 Nov 2026 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HzCXOVXD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2431F008A2;
	Fri,  6 Nov 2026 08:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793953644;
	bh=Cp94Ekg2JFEGNzlkt0FRCQQnyLlqYCH0OTnsTXRuj/0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HzCXOVXDmJJCK4EjDPYFwNrNz16pjF4n5+BouFr5PBw3EKXgI0UVT98YkhoH2/Mq4
	 0gl7rjzAE5xyOyxCISaX2H2iROn7YqVZJBRHqkGvw5iTaabUAfxUwWvRPG6ntDw+xI
	 whJ4B0hakaN2lM+HWpf/kMUNBSImOVqOUJR5wdKVwJNwOeyTwwUTn4c4DFgUBxKfUZ
	 OCvoBHpzEtzoopG8vbU5140w3MVqG1SVKzn9zK/TlAopCKPsG41ll9Cg0za2d5bazW
	 CWnwKM0Vy5dyVXv25xFOMQVmAEb0fcyQ/EiEdZZg6juPTm4ehl8GcRcFVoBbrQq9SI
	 ICFwlpd0kNnSg==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 06 Nov 2026 09:26:48 +0100
Subject: [PATCH v3 5/7] reset: Add BCMBCA block resets through the PMB
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
Message-Id: <20261106-xg6846b-bcmbca-xrdp-reset-v3-5-d6adeb71afc9@kernel.org>
References: <20261106-xg6846b-bcmbca-xrdp-reset-v3-0-d6adeb71afc9@kernel.org>
In-Reply-To: <20261106-xg6846b-bcmbca-xrdp-reset-v3-0-d6adeb71afc9@kernel.org>
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

Power domain consumers must enable their domains before requesting a
reset. Zone transitions belong to the PMB power domain subdriver.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 MAINTAINERS                      |   1 +
 drivers/reset/Kconfig            |  13 +++
 drivers/reset/Makefile           |   1 +
 drivers/reset/reset-bcmbca-pmb.c | 243 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 258 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6702e9c447ae..1b7247b8c717 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5455,6 +5455,7 @@ F:	Documentation/devicetree/bindings/reset/brcm,bcm6846-pmb-reset.yaml
 F:	Documentation/devicetree/bindings/soc/bcm/brcm,bcm6846-pmb.yaml
 F:	drivers/mfd/bcmbca_pmc3_pmb.c
 F:	drivers/pmdomain/bcm/bcmbca-pmb.c
+F:	drivers/reset/reset-bcmbca-pmb.c
 F:	include/dt-bindings/clock/brcm,bcm6846-pmb.h
 F:	include/dt-bindings/power/brcm,bcm6846-pmb.h
 F:	include/dt-bindings/reset/brcm,bcm6846-pmb.h
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index eda9c698a95f..56f7aee6cf1f 100644
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
+	  Reset BCMBCA blocks through the Processor Monitor Bus (PMB) of
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
index 000000000000..e8e079c9ccb5
--- /dev/null
+++ b/drivers/reset/reset-bcmbca-pmb.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * BCMBCA block resets through the Processor Monitor Bus (PMB) of the
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
+struct bcmbca_pmb_reset;
+
+struct bcmbca_pmb_reset_group {
+	const char *name;
+	int (*reset)(struct bcmbca_pmb_reset *rst,
+		     const struct bcmbca_pmb_reset_group *group);
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
+static int bcmbca_pmb_reset_sequence(struct bcmbca_pmb_reset *rst,
+				     const struct bcmbca_pmb_reset_group *group);
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
+		.reset = bcmbca_pmb_reset_sequence,
+		.blocks = bcm6846_xrdp_resets,
+		.num_blocks = ARRAY_SIZE(bcm6846_xrdp_resets),
+		.assert_hold_us = 10,
+	},
+	[BCM6846_RESET_PVTMON] = {
+		.name = "PVTMON",
+		.reset = bcmbca_pmb_reset_sequence,
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
+	const struct bcmbca_pmb_reset_group *group;
+
+	if (id >= rst->variant->num_groups)
+		return -EINVAL;
+	group = &rst->variant->groups[id];
+	if (!group->reset)
+		return -EINVAL;
+
+	guard(mutex)(&rst->lock);
+	return group->reset(rst, group);
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
+	rst->rcdev.of_reset_n_cells = 1;
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
2.56.0

