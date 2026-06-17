Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7BA2DAFBB;
	Wed, 17 Jun 2026 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781723868; cv=none; b=Kveaq43cwUbZDBaHzyLK62CWEHBQSjXZXNP4R884LZsDkVfSXocfreDZnakTC1mtGdt10m3xT4OY7IjpzfDBig3nVyF+bIJ4Q/EZVcPJIDljWBynNZwhYIM+QZwATu1R85ZeHhwtKqDECPt11G5HXWcFH6fzECu+7CG/tdmNtN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781723868; c=relaxed/simple;
	bh=i2HsCLJ+C5F9yQFGwmk9Kz6swxRcC9JXrseoDw1U6q8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l9Jwl91VwPFoMLUv8aYqShFbBe1FpVEKRf2k7NXurO6n9g+1XnNAbxmkCQ1T70AuCrLUBCZrhWAIP45FEHQ1ZlxwqI0YXvbTnHPCPTJbm8K+IiJF/70rgGcoKQO3xYoqHto2/HHllWbEOfSsb/YeDEKthYibRo5OOcQjvtOuPNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=TXqND+3J; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="TXqND+3J"
Received: by mail.gandi.net (Postfix) with ESMTPSA id CA8C91FCF3;
	Wed, 17 Jun 2026 19:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1781723858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/k7+g9zMNKdPsh6vw6H14wzVFIu9apA78DEjV9MySI=;
	b=TXqND+3JXQ9JpBIrlUkrJVoidlEmBQyn7XuoT8pC67lxIYUYb5dvtNqMHu9okgPhYv/JaY
	pCFP/2ZgsF9ushgQ19J8MFooSnLxRkz+uzN6sz4MWVXuzcBNNwSXiFIFhk2wSgEING+D4a
	kyzoOblVmOX11l2N8BXU0cvQGnAaimjKkJ7hUWQii+2frg/TLalNbOalU/M5FHjM+y4Z7F
	N658T3KJqGCkLYQ+AFYF8spao8Qn7ic1MWyUN1NYnmyAHEBK/jjt8H9oO74l7AY2B2ZU8u
	f7G+znwtw429m3qy+5ebwTFqGRfZZ9DI2fPLkCwx/noa32fcrlCNR0GE4U+EKw==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Wed, 17 Jun 2026 21:17:15 +0200
Subject: [PATCH v3 1/2] power: reset: add MCF5441x RCM power-on reason
 driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-coldfire-rcm-power-on-reason-v3-1-1a7c7b6b14e7@yoseli.org>
References: <20260617-coldfire-rcm-power-on-reason-v3-0-1a7c7b6b14e7@yoseli.org>
In-Reply-To: <20260617-coldfire-rcm-power-on-reason-v3-0-1a7c7b6b14e7@yoseli.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, 
 Sebastian Reichel <sre@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781723856; l=7274;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=i2HsCLJ+C5F9yQFGwmk9Kz6swxRcC9JXrseoDw1U6q8=;
 b=sNNoFhfvBkD+DJpCYISWCLCCaRXH7OrLIVK0ZeA5AL6pQkj33j1ZoqqfIW45FEIxpGDe5LJ+G
 PonoEN2HpySBjCkKdnaxKHKaynH3YsQqeJkqyAjSvNopwqPoWKDJ35q
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGGen1Aoh+3Xbqx0LsZbbSCz2aEJthWcpe63xc9fiELMZSNbfcy0ERPyYIPeQ9uk4trfHDqLOHjsP8LswY+yVaUj+JNuXDHZ40gv6l2zUiGZJVhDPMzjC4UxDH+imOB3MwsaNQBMvsxrxJnA5R1OpZYtt3a5GuQwSpvObNJZPOL0ckLh405340td3Ut2N6Ii5b7sxAiTwH85EuOgWyFucQV3FO07ZixgE7o2i7EirLtDs6RkQZr6bgRwmv0Y5nzUSy4k4HNKLq+yemOSieB8EiXeiPZyKjqUNEEcHFYmincN3jT79+TgfSRyA4Fcfo7ad5AOtGdzqUqkV3hiABnwJP2OKkG2HPkdsX7nN7gjFbdd6UFv5AjptauOXpkK2LZMXyoTRj7RH8F/Q4GH35811cQ8qGFP7e1eRMmoelSvsnaMsZzN8vaxLBe+lRXotlj/Cq929IcK2yNCoPx7g3hJnU6lPTSyN4OXzY0idPTIMbhYo61Iz8WQ+z6Bp020mqypodz9mxWonwk/agyRr4F2zuv1G+AvCo8mzrUaA2nl8QV37qMnVe0xJkf65YjDYRswBATQHS3s9B+X81uoCNEqzMDWmbDendxrbKWkmaTv2xa0IVNc7oUqGDYeZVSxtbG5S9Pcoh0K0LsiOVio0/Nb9CSTNg94efnoksAVBArygWExw

Add a driver that decodes the Reset Status Register (RSR) of the
Freescale ColdFire MCF5441x Reset Controller Module at probe time
and exposes the cause via the power_on_reason sysfs ABI.

The RSR can latch several cause bits simultaneously (Reference
Manual chapter 12.3.2); the driver picks one cause per a priority
that favours the most explanatory diagnostic.

The register layout is described in the driver so it can be built
with COMPILE_TEST on any architecture.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 MAINTAINERS                         |   6 ++
 drivers/power/reset/Kconfig         |  12 ++++
 drivers/power/reset/Makefile        |   1 +
 drivers/power/reset/mcf-rcm-reset.c | 126 ++++++++++++++++++++++++++++++++++++
 4 files changed, 145 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e035a3be797c..a82adb6fa40f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10196,6 +10196,12 @@ S:	Maintained
 F:	drivers/mmc/host/sdhci-esdhc-mcf.c
 F:	include/linux/platform_data/mmc-esdhc-mcf.h
 
+FREESCALE COLDFIRE M5441X RCM POWER-ON REASON DRIVER
+M:	Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
+L:	linux-m68k@lists.linux-m68k.org
+S:	Maintained
+F:	drivers/power/reset/mcf-rcm-reset.c
+
 FREESCALE DIU FRAMEBUFFER DRIVER
 M:	Timur Tabi <timur@kernel.org>
 L:	linux-fbdev@vger.kernel.org
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 124afb99febe..bce996bbef28 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -128,6 +128,18 @@ config POWER_RESET_LINKSTATION
 
 	  Say Y here if you have a Buffalo LinkStation LS421D/E.
 
+config POWER_RESET_MCF_RCM
+	tristate "Freescale ColdFire RCM power-on reason driver"
+	depends on M5441x || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This driver exposes the cause of the last reset on Freescale
+	  ColdFire 5441x SoCs through the standard power_on_reason sysfs
+	  ABI. It reads the Reset Status Register (RSR) of the Reset
+	  Controller Module once at probe time and reports a normalised
+	  string (regular power-up, reset button action, software reset
+	  or unknown reason).
+
 config POWER_RESET_MACSMC
 	tristate "Apple SMC reset/power-off driver"
 	depends on MFD_MACSMC
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index d7ae97241a83..e31cab4ba78e 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
 obj-$(CONFIG_POWER_RESET_GPIO_RESTART) += gpio-restart.o
 obj-$(CONFIG_POWER_RESET_HISI) += hisi-reboot.o
 obj-$(CONFIG_POWER_RESET_LINKSTATION) += linkstation-poweroff.o
+obj-$(CONFIG_POWER_RESET_MCF_RCM) += mcf-rcm-reset.o
 obj-$(CONFIG_POWER_RESET_MACSMC) += macsmc-reboot.o
 obj-$(CONFIG_POWER_RESET_MSM) += msm-poweroff.o
 obj-$(CONFIG_POWER_RESET_MT6323) += mt6323-poweroff.o
diff --git a/drivers/power/reset/mcf-rcm-reset.c b/drivers/power/reset/mcf-rcm-reset.c
new file mode 100644
index 000000000000..18f11c05a868
--- /dev/null
+++ b/drivers/power/reset/mcf-rcm-reset.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Freescale ColdFire MCF5441x RCM power-on reason driver
+ *
+ * Copyright (C) 2026 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
+ */
+
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/power/power_on_reason.h>
+
+/*
+ * Reset Status Register (RSR) layout, MCF54418 Reference Manual chapter
+ * 12.3.2. The register is 8-bit read-only and latches the cause (or
+ * causes) of the most recent reset until the next one occurs.
+ */
+#define MCF_RSR_SOFT		0x20	/* Last reset caused by software */
+#define MCF_RSR_LOC		0x10	/* Last reset caused by PLL loss of clock */
+#define MCF_RSR_POR		0x08	/* Last reset caused by power-on */
+#define MCF_RSR_EXT		0x04	/* Last reset caused by external pin */
+#define MCF_RSR_WDRCORE		0x02	/* Last reset caused by core watchdog */
+#define MCF_RSR_LOL		0x01	/* Last reset caused by PLL loss of lock */
+
+#define MCF_RSR_KNOWN_CAUSES	(MCF_RSR_POR | MCF_RSR_EXT | MCF_RSR_WDRCORE | \
+				 MCF_RSR_LOC | MCF_RSR_LOL | MCF_RSR_SOFT)
+
+struct mcf_rcm {
+	const char *reason;
+};
+
+/*
+ * Decode RSR into a power_on_reason string.
+ *
+ * The MCF5441x Reset Status Register can latch several cause bits at the
+ * same time (Reference Manual chapter 12.3.2: "one or more status bits
+ * may be set at the same time"). A power-on, for example, also resets
+ * the PLL and may co-flag LOC and LOL during the boot sequence. The
+ * power_on_reason ABI carries a single string, so this routine picks
+ * one cause; the chosen priority surfaces the most explanatory one for
+ * diagnostics:
+ *
+ *   POR              cold boot dominates any spurious co-flagged cause
+ *   EXT              operator action via the RESET pin
+ *   WDRCORE          core watchdog timeout, a fault to investigate
+ *   LOC, LOL         PLL clock or lock failure, hardware fault
+ *   SOFT             explicit software-requested reset
+ */
+static const char *mcf_rcm_decode(u8 rsr)
+{
+	if (rsr & MCF_RSR_POR)
+		return POWER_ON_REASON_REGULAR;
+	if (rsr & MCF_RSR_EXT)
+		return POWER_ON_REASON_RST_BTN;
+	if (rsr & MCF_RSR_WDRCORE)
+		return POWER_ON_REASON_WATCHDOG;
+	if (rsr & (MCF_RSR_LOC | MCF_RSR_LOL))
+		return POWER_ON_REASON_CPU_CLK_FAIL;
+	if (rsr & MCF_RSR_SOFT)
+		return POWER_ON_REASON_SOFTWARE;
+	return POWER_ON_REASON_UNKNOWN;
+}
+
+static ssize_t power_on_reason_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct mcf_rcm *rcm = platform_get_drvdata(to_platform_device(dev));
+
+	return sysfs_emit(buf, "%s\n", rcm->reason);
+}
+static DEVICE_ATTR_RO(power_on_reason);
+
+static struct attribute *mcf_rcm_attrs[] = {
+	&dev_attr_power_on_reason.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(mcf_rcm);
+
+static int mcf_rcm_probe(struct platform_device *pdev)
+{
+	struct mcf_rcm *rcm;
+	void __iomem *base;
+	u8 rsr;
+
+	rcm = devm_kzalloc(&pdev->dev, sizeof(*rcm), GFP_KERNEL);
+	if (!rcm)
+		return -ENOMEM;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	rsr = readb_relaxed(base);
+	rcm->reason = mcf_rcm_decode(rsr);
+
+	platform_set_drvdata(pdev, rcm);
+
+	if (!(rsr & MCF_RSR_KNOWN_CAUSES))
+		dev_warn(&pdev->dev, "Unknown reset cause (RSR=0x%02x)\n", rsr);
+	else
+		dev_info(&pdev->dev, "Starting after %s (RSR=0x%02x)\n",
+			 rcm->reason, rsr);
+
+	return 0;
+}
+
+static const struct platform_device_id mcf_rcm_id[] = {
+	{ "mcf-rcm-reset" },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, mcf_rcm_id);
+
+static struct platform_driver mcf_rcm_driver = {
+	.probe = mcf_rcm_probe,
+	.id_table = mcf_rcm_id,
+	.driver = {
+		.name = "mcf-rcm-reset",
+		.dev_groups = mcf_rcm_groups,
+	},
+};
+module_platform_driver(mcf_rcm_driver);
+
+MODULE_AUTHOR("Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>");
+MODULE_DESCRIPTION("Freescale ColdFire RCM power-on reason driver");
+MODULE_LICENSE("GPL");

-- 
2.39.5

