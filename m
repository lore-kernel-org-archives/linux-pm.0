Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A7D3C73DD;
	Tue,  2 Jun 2026 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392128; cv=none; b=quPxb/PPVRVZcYBio8gPzhjDhaHwRRL+2m47JffgRZtjOOkSLWpGEGaIRNkB96IfrT9N/MPd2MDBK6pfPI59GLAEpuRqZZ+iT09scS217ci6jRmk4SuePFIjJjG3KQG9PPxlIykIebPsHPXqgvwmVtj8O2gJ5o1PEsFqpD8CgzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392128; c=relaxed/simple;
	bh=1Uek1t1vYr5g4/ogLTnuD7M4z7yaydx6lVfOr/W3Rso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SBLSdfHIYUcegb7VYNy0nb/PrnwvX4CPY9jFWt3o2aXz3agrcxsivuppc85ZKXY3IDFD82yn9fNGVkvGDtmT/x3UqR2IIoHeeZmiW5BzY4KVhh3DrxeIT44h/64IHNzqk9w2no6Sx5OwgM8iIGcWETQNLXaJXbe3azDNEhi/ijw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=KCBFSzDj; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="KCBFSzDj"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0097D3EBF7;
	Tue,  2 Jun 2026 09:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1780392118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4VhRzNc+mCdb8kmhy8C1Cme3KDLdpBCiBHqNIi8Dsc=;
	b=KCBFSzDjq90WPR/ZdOLg32fhv3QSbJe//AJ/c62UqO6DOXxFpih8JVVhmfVFB7B3ebMi7J
	UI4AEybiY3vr9xPmjwroelinH5rgYvlzQWOzijJH91kD9jCkC4L4tXIQLA4rbXodaTJ8yV
	XXOM1lSOd+q6obFrmopE7QA6KOwvAqpgtKwJadZYrfZdfjHR1tTj4/b4SrONWKvqeZvbOe
	ez4cb1JoEsS99A1i3clc9fzyOIqssNkeAOZ7q2bgCea/lCMmMW1JfqWTOEhiYkQAck/26g
	tdbKYgE7p2P/RJ6djEULgMR44WiYblgF427Jxys6nK7YZiXYZe6tdokU1X+2ow==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Tue, 02 Jun 2026 11:21:22 +0200
Subject: [PATCH 2/3] power: reset: add MCF5441x RCM power-on reason driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-coldfire-rcm-power-on-reason-v1-2-fbc3eab0c016@yoseli.org>
References: <20260602-coldfire-rcm-power-on-reason-v1-0-fbc3eab0c016@yoseli.org>
In-Reply-To: <20260602-coldfire-rcm-power-on-reason-v1-0-fbc3eab0c016@yoseli.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, 
 Sebastian Reichel <sre@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780392115; l=6377;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=1Uek1t1vYr5g4/ogLTnuD7M4z7yaydx6lVfOr/W3Rso=;
 b=HDclsfclivd7CnNaFDxF/mq9DacC6uWxnpP6AQAc0c5L6UL0DnQHwUUEpO4TkdvK2XGlclPOV
 mOA+NB7gNDDBUzwGVL5c+V+gLvgYoFUVGQc8Q3RdEb9ibeuaCbZAR4p
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org
X-GND-Score: -100
X-GND-Cause: dmFkZTGZnDm+qP+IIE8q7fl0ylzs7vW7XFxPlmP9Riz87oMhwGzvZZIRYplOiORTbDN4OXFi+K8S2y2wJ8ELCaUF0EYbuKfNpj66kov/TBETXf91nZVoCTSEd5oiOHPUy0ZWxAVHyVHYvFebNY7AvzJ3lwSgiyYVHRb3qBly/HEuWT3b0eg/9zAdM6HpyoKevIj6OrQ2Vd9YNKpuoNFww5O3G3J2pO+gQsOqZ+sx23SLGeri912Jce4X53gaqVGP0yw+/XcvDwx/KK9V/NlfOeLQ9vLhwxat1T0K1eM8xFbdboKRCu6vrqJtqumZptPM87DF74+OnKHNzc5wncqIWGB4RswGA0EnYHPB9wcRaJSC7KxoFTE4de8v9KYwIx0icnkYnr3Q0zh6bItHvqurpInaUEhA7njKSYWnbtEEEe401nJSoWs8s+uktsRKyMDapBsKeTVG7XUyAl1f2HYs7hUQn+DpShpCQvtrN4Q3oHmFN/bhAwaFO42WHBF1EnQ+EHbZs2JA6LcO9U7uL6eo2OsOuqQId8edkPTROTJ3gBmpovwVIVWGquhCIAHbNcVdr/9lOs/VvYQbZ3O07tFvxX4FqFz0HYJM248njOESzOHJIxX9W9nz4ZK9I9yRwyO9s3aBe+ewdNe0ZYRMvqg87cfuhvjW1c+ijJZyL0eGCXQ2gs6sdA
X-GND-State: clean

Add a driver that decodes the Reset Status Register (RSR) of the
Freescale ColdFire MCF5441x Reset Controller Module at probe time
and exposes the cause via the power_on_reason sysfs ABI.

The RSR can latch several cause bits simultaneously (Reference
Manual chapter 12.3.2); the driver picks one cause per a priority
that favours the most explanatory diagnostic.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 MAINTAINERS                         |   6 ++
 drivers/power/reset/Kconfig         |  12 ++++
 drivers/power/reset/Makefile        |   1 +
 drivers/power/reset/mcf-rcm-reset.c | 109 ++++++++++++++++++++++++++++++++++++
 4 files changed, 128 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 461a3eed6129..1109bff23ec1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10195,6 +10195,12 @@ S:	Maintained
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
index 124afb99febe..003638f652fa 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -128,6 +128,18 @@ config POWER_RESET_LINKSTATION
 
 	  Say Y here if you have a Buffalo LinkStation LS421D/E.
 
+config POWER_RESET_MCF_RCM
+	tristate "Freescale ColdFire RCM power-on reason driver"
+	depends on M5441x
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
index 000000000000..666ae1455be1
--- /dev/null
+++ b/drivers/power/reset/mcf-rcm-reset.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Freescale ColdFire MCF5441x RCM power-on reason driver
+ *
+ * Copyright (C) 2026 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/power/power_on_reason.h>
+
+#include <asm/m5441xsim.h>
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
+static struct platform_driver mcf_rcm_driver = {
+	.probe = mcf_rcm_probe,
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
+MODULE_ALIAS("platform:mcf-rcm-reset");

-- 
2.39.5

