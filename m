Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907AE36C9D0;
	Sun,  7 Jun 2026 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780822223; cv=none; b=ZTjiHDBGmVhwvhrer0uWdOwu83A5qFWwTCFXeYg/sD5cVQ2oicqTA7w7I6f0HQhMr0WsTks07qe5tetOePJjPcEDdSmGf7I7qWDNuF2AQbPeIz/2+VvN2wMYhKb9AaXQb0pEoizTEyKQ2nuwQPRnG+dgCUQTTLLR8WC50jgQS+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780822223; c=relaxed/simple;
	bh=gUeJPt4wa+X19kBRX2INzHwAP4HUW5hrNAe6NujEUyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a44yM1awbcANd9dGaG06PoHcCAT08VWRQnSp/fimTj2wKrtMfw/9P4TBkY6tRr5cNLG4hy5p3yoqTOCNICt0Di7B2Ei2YtTKKYA6VPrPHCl9bqjcC3JkEX7on2APxkNeM6aWnz7IbmU7+v201WR3PpxoXBE0qxBBuA/vx/uFGQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=dFfvNazm; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="dFfvNazm"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 748DE3EBD2;
	Sun,  7 Jun 2026 08:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1780822214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TykClniNvh2ivjjob+1T1w+oZ7+He2Bbxyt6cZe6aVk=;
	b=dFfvNazmEQITniEkrtIqHEtyEEog+uWh1UFS0evhZjFDpfPoTiT05VSWVfg+HWfDE5LLET
	/nY7hrjCFPgvl3AaYSgjdLRM+2LXyWkkOTFFAsekhB5wMiITn4kzRIFmpJ72sMZHmyihMO
	yCAZhlEu9MNUHkhPYsQWXxxVicthMqMvTgojwrRQ8PJfbAU+Hiu6nZnSgGAbX9scwP2CZM
	dPJoxrO7u0zSrHWEHwi6W5FEcwOoKO9DmujA+sNBSggIEZTZCqby2odJZV7jbA5ilYU89l
	5AwWn1qyEZByh0LBqvVfEMoMQHWGB8vPOiuVrjPS/Vqhg3YXltUCSuedK442sg==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Sun, 07 Jun 2026 10:49:53 +0200
Subject: [PATCH v2 1/2] power: reset: add MCF5441x RCM power-on reason
 driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-coldfire-rcm-power-on-reason-v2-1-d0039d8a91e8@yoseli.org>
References: <20260607-coldfire-rcm-power-on-reason-v2-0-d0039d8a91e8@yoseli.org>
In-Reply-To: <20260607-coldfire-rcm-power-on-reason-v2-0-d0039d8a91e8@yoseli.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, 
 Sebastian Reichel <sre@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780822212; l=7277;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=gUeJPt4wa+X19kBRX2INzHwAP4HUW5hrNAe6NujEUyw=;
 b=31EVJ+lFP/6qBgI8A0ePW8pDrOOcN00Wrfh+kzYYMTp2nvjgCwhzmDIqhjwUUPSE4HlhhXTnR
 0Rj5KDZFZv6DcfxKtjB4a5U7rintqOjKUPGVY5EwjIYwD9b32JbwHJz
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org
X-GND-Cause: dmFkZTGhtrL9Cb7uXPcR0LTL1O368UyEJSwtX/Zu71dpZyZpj0jlt0XceXpcFcjR2zJ4LSptuE61jCNBVz5vpVF6q9/uRYXOBTbSFRtDdfGAEgahic3rCbEDR1mcuLfTqiO+ZdvWIUWmT9QN0SkA6Sky2pMCuzw/DY8Ab5DGRafQNI1lm87TIzjbmrt4xF99IpmlvLBnMqXrBmqxTUNlKCqUEELExWWXE0KOyOuqntunZ8UoaH6witT72ayGvDh77v+Iy06CqDcucZxphIM8eyja6H8N5aoJASQ3Mr4M5hYSFAa000052AQoIm7jSFwWbzyxtqtXH8Pa5gRdXDDxXfc6JV63REsHkwGxBnvBebBEpbgN63LzaXKSD4zuxN9MeByOXJW+KnWK5s7+bpzr/AG9xjh77B9avBg40y9xvOdQEm1oWOaEBOi5qHMUzvHOc1uD51jLU4ftmL6L+qF5D8OliTAY0M5ojsphohpLTSCdt58P/0o1zx9Jo0JH3lmcN/wELW75+pPg2sKjt5j3QZDuZMg4Bc5PeMkfnQgXm2vDCnT+pDH3S3ozzFVnTYCRXHWqpAlr0SbiQvtVEoZ2ayrtHMQ3iM4r8WP5Hc6aQMl0q3oNeOMT+MOoUK+b4EOtEWYldhl6hgVbeLPzblCvU06Ns83vzkRRpJZxBBM1UPJ6P5cySQ
X-GND-State: clean
X-GND-Score: -100

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
index 000000000000..a3164bdcdfb3
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
+	{ "mcf-rcm-reset", 0 },
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

