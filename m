Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202494;
	b=joCUFY61VcMdWuYx/AcCAuyQXWs2I6qfsNAmNScHcO23XNU9w5PcjJE55NwOSWxhEB8R
	 E+oQHU3OywUZo5njAITKJZ8J14tF9A8fO0bVYoWKOPvz2/a6GNyRRQxb/J2umXS/AEEUT
	 IL9AdAboyydhu9BqnbZ/0dXhpjZU1mRB3FY4xzClq0PXQmlr7b2K9Z2fhCjOwZ63X5QSe
	 QKXTvVtz6uMVshP4duOQIttRDVUlukYzHLXCtgSSyQO3fYfC6qReVHUXuDn+ts27/0PB2
	 eGNsYeKjPY772mwh+1tpE2REgsAwdXPWfRz1pOYUVMCgcVIq/hHhzt2B/iVizmIr8zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202494;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=qrL4o0PULdqFfuwcYS3OMeO2yJN8Iu7JXlTfeUe5POg=;
	b=h6EO0/fyxT+Y4a/CVQzt75pVNnox/bmjYaUIH2Iriv/9UDMLijFEn0iqgvi9eTa6qInB
	 Lf3DDFKvDvafHOFSC7CgehzZAmhycn0wYy9OKBMh+n/Q+PY/IXc1YQUa+eJUGMw2SxphP
	 95VKX7x3Y0iXzObTjncrQ1AZVdbejkP3bnByyxB3gARsyfHXfCLrCmUD4iv1EpL1QjHvu
	 D5xQpORu/h5irfCPDoGpUF+pvlLo2vhuHPazgmGozUEgA6530awq2ZX/8u2GyQu7fU1pQ
	 eGTVwnYQbVyIU/H9Y+CfqxdKEpk8iFdgt5oTqk3XI8ffpPPcpGDB2XttQy90p2XzBIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rnLs2+CE;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA06606A6E6
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 19:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBA06606A6E6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rnLs2+CE
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4ac109a8a12so717476f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 11:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795202483; x=1795807283; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qrL4o0PULdqFfuwcYS3OMeO2yJN8Iu7JXlTfeUe5POg=;
        b=rnLs2+CE4dPjrh2cS63O3W8X7Fmhydj3lA4IEyYnwQXSJnu7QhoJOIc++wANPmBAys
         XLOjnYhtycL0b1re/n793G5FpKyL/VX4ksoCFChSHlnh+zuhCoiZIEEOqoumH9LN++XH
         bnkw3AiUD6/oc4QlXmCh+QuF18ZE7e8wSDb4/f+V7E34o58jFP2JbG7BRtbEUjILMMVz
         PUxR3p5yxn61K3nJ4LdtvmKGHtGPkVFX1BM8i/LiBSR2p6YAzCzvRYvwmFJEGVp2R1SW
         lyK9Oj5pRd1zA37fDCFSHL1dmYCGZzT71d0rF8/T8ksySxEmpz8kzAyN4aQ6fFgFEJI4
         bP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202483; x=1795807283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qrL4o0PULdqFfuwcYS3OMeO2yJN8Iu7JXlTfeUe5POg=;
        b=tASr/5bkqWusghPLJTXp8p2shDabi5ygt1aV19NGsQR2BI8//HRM3FcWar6ZXlZDzK
         ZbQ2avskz36ca9wPMzEeayj2k5IxxFjZMtjANkAItPsyOfZ4TsHtJih7sAZT9ysGOvix
         BTajkM48jgU3mvY6xlO8nwH1NFfji9YbI4f3pyG+0WmvqjnZe6qblzRMytUcVoo8xHD3
         vX8TporJySChR4bO1s1h8j3qxxS7shdLu/EZfSSiQwbEDQHt/6sKbB1OJDkXekA0DjDe
         RiNOf92Gclfz4rZBSdRT/mMMPXbyz2oU0R9+Se74ipl+d9ZwxmYLddVs8tXXw1XZE2Ts
         1PJw==
X-Forwarded-Encrypted: i=1; AL+hErH2eKFbly+bsAnx9tjbF3qWHzGELM7Iy+U3nfH9zdkqELe57nLZoHtlX7c9R0iz3IZAuXK4G0mWLQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/P1aKWJ8nzX5MrWBt/ISyC5A/0vXFXX7l5dZALX0dPewHqfO4i
	JR6Jcc200ia9878eLKjJKjRSkDm4QXV1B2oV0RbgtncDWbfLsRTzpeXC
X-Gm-Gg: AZFdTZdCQEMf9a4gTgzALgqXn+RHDyRQyoQe6J56QrZTZbWCyzYGV4gPHl7HFiGphna
	mocK/xwAx8vt8LNwGLKb0y9FBS37clbGk0t8aYD4+iV+eoVc6hoCoPWJLSO02KYaUfRXg3vEme6
	p2X2Sz0Jpv9GeKCM6vavDCfkL7cD6mO8vf55rojjYt7Txz19BdNwY/15rI2vxRhpgslTMokscga
	U8/Ido+IqVulETfb75Y3EVnpTI2l8uUT0xVmCPtkCAjkJJcp1GyC5+RHJRQjzmIqnVU/w21L5AY
	RRjdoQab2d2dpdhF+u3sc3c+5Q21C/CDe/jnBXdyrrxeYFDJTH9g7r+cJlYBOF9l60NyZFVsmMX
	rAKXSCJigUG5jFi6443ZQ/bcdCpcsZ5yTPf3GzcwbnYAnTXWHI7FZ0pp6Hgzw8GHvX+nz9q8KwL
	qbGB5LTUlEN1i59X85XhAB9Rhd5Gx8144dbKGIn5hmuNEbZbFL6wksrIhijH+FnhCCNjoHEQn44
	l7xPqTDBRwyT9Db/tRM+Lia3whCP+8EJMCXORukvGA/vxg40gGHYUmIcb5PN2Z+8CBl/Jj+MGJR
	3xXRnSP8ogMLiMzdql5uAHTYIIjOFgOfunyj9YzU
X-Received: by 2002:a5d:5e8f:0:b0:48f:bf71:2ad9 with SMTP id ffacd0b85a97d-4abb400bcb1mr8820356f8f.41.1795202483117;
        Fri, 20 Nov 2026 11:21:23 -0800 (PST)
Received: from [192.168.0.2] ([197.250.160.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f204sm8405703f8f.21.2026.11.20.11.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:21:22 -0800 (PST)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Fri, 20 Nov 2026 22:20:52 +0300
Subject: [PATCH 3/6] pmdomain: zte: Add a zx297520v3 power domain driver
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
Message-Id: <20261120-zx29usb-v1-3-b0433258e51b@gmail.com>
References: <20261120-zx29usb-v1-0-b0433258e51b@gmail.com>
In-Reply-To: <20261120-zx29usb-v1-0-b0433258e51b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Lee Jones <lee@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Agustin Santiago Isasmendi <isasmendi.agus@gmail.com>, 
 Navid Ghahremani <ghahramani.navid@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev, 
 linux-pm@vger.kernel.org, linux-phy@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12340;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=VfvWHYxi8vxHqRxg9s/54zdayLBUu8LY5SmupIpw68k=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBrAJ2Wj2mjRcJ86eSiAk+9gbxi78e0958ZSB/bB
 sOwfk3XSJGJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCawCdlhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiJSJQ/9G2A1qfjkRgEgWSLvjqNuwV6AiYVbdcb
 OnExHEAkvQ+C7cGpw8bpL7WKovivZZeIfX/ZWHLqnlFsE5pPXW+HWfGZSmxKgZ5N8DNGSioOvBe
 F2i/BWh0EbgZSHWMf3LKUQZyxnUU0hf8pIEsl1iDBHLLgsvggEUisvVbrmCewSheK0D4mn3kZC1
 b23jEXZPgjxLL+QXTNyddZD+ScwpFUqEPh6kzSMMuF1cgXmY4pKAK7Vep3XTl4skhtDckjyISJV
 EOTlD/3rAkdgwUY4TQ7GkQU0BsQ1McUAmB/bMPYbQC2GIOEoiAFxJTsaPjBVhFD9wi7jgKv2e16
 LpWyyjHF8MicAFnYmxiM2y3GQT+CRRPXFe8V8MCXQeqxqhxJ0MQMTqTKozSJA9cA1dxm3Hh6rth
 mBTuvOub4Ytsy17W8IeqZodC99cDpLHtWKtg2AiTr3MeqUbmdIMiI2G1lKY51DOdiZmCSK6CTA4
 EUapb4VqiaEgeaXHEruOmOhbpqsNM7lstdTwOekSiHeaG4ln4naujpm98BnkzQtZbMO+9/jVqkq
 bG+fd+EPTqjcaZ1EAdXlxE2X1v6j3hqXLBkMbC3zJBX6Tqg4kpZ6BN/ziFPAWoKkulMVr+mliwW
 tvXIN/xKcAtvJ49xs/5+iHiHRTIiUVRI1TbI4E7vziqaTmbnSwWU=
X-Developer-Key: i=stefandoesinger@gmail.com; a=openpgp;
 fpr=4F9C2C8728019633893EBBB98CB81F9A72BBA155

This controller has bits for USB, HSIC, EDCP (a cryptographic engine)
and GSM. Not all of them work the way one might expect (see comments in
the code), but they are there and can be set.

Signed-off-by: Stefan Dösinger <stefandoesinger@gmail.com>

---

For now this driver can only enable and disable the USB controller. I
expect more LTE related power switches will be added later, but I don't
want to commit to how I expose GSM and EDCP in the bindings just yet.
---
 MAINTAINERS                                 |   1 +
 drivers/pmdomain/Kconfig                    |   1 +
 drivers/pmdomain/Makefile                   |   1 +
 drivers/pmdomain/zte/Kconfig                |  15 ++
 drivers/pmdomain/zte/Makefile               |   2 +
 drivers/pmdomain/zte/zx297520v3-pm-domain.c | 286 ++++++++++++++++++++++++++++
 6 files changed, 306 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ab8797b8d0a5..e394e0044f1f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4038,6 +4038,7 @@ F:	arch/arm/boot/dts/zte/
 F:	arch/arm/mach-zte/
 F:	drivers/clk/zte/
 F:	drivers/mfd/zte-zx297520v3-crm.c
+F:	drivers/pmdomain/zte/
 F:	include/dt-bindings/clock/zte,zx297520v3-clk.h
 F:	include/dt-bindings/phy/zte,zx297520v3-topcrm.h
 F:	include/dt-bindings/reset/zte,zx297520v3-reset.h
diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 5341dff669be..d5050c22f064 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -21,5 +21,6 @@ source "drivers/pmdomain/tegra/Kconfig"
 source "drivers/pmdomain/thead/Kconfig"
 source "drivers/pmdomain/ti/Kconfig"
 source "drivers/pmdomain/xilinx/Kconfig"
+source "drivers/pmdomain/zte/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/Makefile b/drivers/pmdomain/Makefile
index d7aee13ae571..cc3cc7b3d1c2 100644
--- a/drivers/pmdomain/Makefile
+++ b/drivers/pmdomain/Makefile
@@ -19,4 +19,5 @@ obj-y					+= tegra/
 obj-y					+= thead/
 obj-y					+= ti/
 obj-y					+= xilinx/
+obj-y					+= zte/
 obj-y					+= core.o governor.o
diff --git a/drivers/pmdomain/zte/Kconfig b/drivers/pmdomain/zte/Kconfig
new file mode 100644
index 000000000000..cc329d085e5a
--- /dev/null
+++ b/drivers/pmdomain/zte/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config ZTE_ZX297520V3_PM_DOMAIN
+	tristate "ZTE zx297520v3 pm domain"
+	depends on HAS_IOMEM
+	depends on PM
+	depends on MFD_ZTE_ZX297520V3_CRM || COMPILE_TEST
+	default SOC_ZX297520V3
+	select PM_GENERIC_DOMAINS
+	select MFD_SYSCON
+	help
+	  Say y to enable the power domain driver for ZTE zx297520v3 boards.
+	  This driver is necessary to enable the USB hardware found on this
+	  board. Say y or m if you are building a kernel for a zx297520v3 based
+	  device and plan to use its USB capabilities.
diff --git a/drivers/pmdomain/zte/Makefile b/drivers/pmdomain/zte/Makefile
new file mode 100644
index 000000000000..8a4185f48ff3
--- /dev/null
+++ b/drivers/pmdomain/zte/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_ZTE_ZX297520V3_PM_DOMAIN)	+= zx297520v3-pm-domain.o
diff --git a/drivers/pmdomain/zte/zx297520v3-pm-domain.c b/drivers/pmdomain/zte/zx297520v3-pm-domain.c
new file mode 100644
index 000000000000..3df4cd5f1b22
--- /dev/null
+++ b/drivers/pmdomain/zte/zx297520v3-pm-domain.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Stefan Dösinger
+ *
+ * This driver controls power domain registers found on the ZTE zx297520v3 board. The USB and GSM
+ * controllers are controlled from here.
+ */
+
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/regmap.h>
+
+static const struct {
+	const char *name;
+	u32 reg;
+	u32 mask;
+} power_domains[] = {
+	/* ZTE's kernel defines the following power controls in 0x10c-0x114:
+	 *
+	 * Name			Bit
+	 * GSM_RAM		0
+	 * GSM_DSP		1
+	 * EDCP			4
+	 * USB_CTRL		8
+	 * USB_HSIC		9
+	 *
+	 * But the names are wrong/misleading.
+	 *
+	 * For USB, bit 9 appears to control both HSIC and USB, except for the isolation register,
+	 * where setting either bit 8 or bit 9 zeroes both of their address space. So we expose
+	 * one power domain that controls both bits.
+	 *
+	 * Bit 1 isolates and resets the mmio area from 0xf4000000-0xf7000000. The device behind it
+	 * is an Infineon PMB887x GSM controller derivate. The power bit doesn't appear to turn it
+	 * off, and it remains unset by the stock firmware. The reset works and the driver for this
+	 * hardware needs to assert and deassert it to wake it up on boot. The isolation bit 1
+	 * works, but only once the GSM hardware is properly booted - if the GSM chip doesn't
+	 * respond, and isolation is enabled, attempts to access this area nevertheless stall the
+	 * bus.
+	 *
+	 * Bit 0 controls the TeakLite DSP on the PMB887x.
+	 *
+	 * The functionality of bit 4 is not understood yet. The "EDCP" hardware seems to be a
+	 * cryptographic engine implementing PDCP and some hash functions.
+	 */
+
+	{"usb",		0x10c,		BIT(8) | BIT(9)},
+
+	/* There is a separate set of registers in 0x180 - 0x188 that accepts 4 bits (0, 1, 6, 7)
+	 * and is controlled by the cpko.ko blob in the same way as 0x10c-0x114 is controlled by
+	 * the USB driver: LTE on: Set *0x188=0xc3 and the others to 0. LTE off: Set 0x188 to 0 and
+	 * the others to 0xc3. It is therefore likely that up to 4 more devices can be powered on
+	 * and off in these registers.
+	 */
+};
+
+struct zx29_pm_domain {
+	struct generic_pm_domain	gpd;
+	struct regmap			*map;
+	unsigned int			domain;
+};
+
+#define REG_RST		0x0
+#define REG_ISO		0x4
+#define REG_PWR		0x8
+
+static inline struct zx29_pm_domain *to_zte_pm_domain(struct generic_pm_domain *domain)
+{
+	return container_of(domain, struct zx29_pm_domain, gpd);
+}
+
+static int zx29_pd_on(struct generic_pm_domain *domain)
+{
+	const struct zx29_pm_domain *zx29_pd = to_zte_pm_domain(domain);
+	u32 mask = power_domains[zx29_pd->domain].mask;
+	u32 reg = power_domains[zx29_pd->domain].reg;
+	int res;
+
+	dev_dbg(&domain->dev, "Power on\n");
+
+	res = regmap_set_bits(zx29_pd->map, reg + REG_PWR, mask);
+	if (res)
+		goto error;
+
+	/* The 10 microsecond delay is from ZTE's dwc2 USB driver integration */
+	udelay(10);
+
+	res = regmap_clear_bits(zx29_pd->map, reg + REG_RST, mask);
+	if (res)
+		goto error;
+
+	udelay(10);
+
+	res = regmap_clear_bits(zx29_pd->map, reg + REG_ISO, mask);
+	if (res)
+		goto error;
+
+	return 0;
+
+error:
+	/* Power the device off and isolate it from the bus (reads from an unpowered, unisolated
+	 * device can stall the CPU), but don't forcefully reset it.
+	 */
+	dev_err(&domain->dev, "%s: Power on failed: %d\n", domain->name, res);
+	regmap_set_bits(zx29_pd->map, reg + REG_ISO, mask);
+	regmap_clear_bits(zx29_pd->map, reg + REG_PWR, mask);
+	return res;
+}
+
+static int zx29_pd_off(struct generic_pm_domain *domain)
+{
+	const struct zx29_pm_domain *zx29_pd = to_zte_pm_domain(domain);
+	u32 mask = power_domains[zx29_pd->domain].mask;
+	u32 reg = power_domains[zx29_pd->domain].reg;
+	int res;
+
+	dev_dbg(&domain->dev, "Power off\n");
+
+	/* If isolation fails, abort. The device should still be operational as far as the pmdomain
+	 * settings are concerned. If isolation failed, asserting reset or powering it down leaves
+	 * the mmio space in a dangerous state: Attempting to access it will stall the CPU forever.
+	 *
+	 * If later steps fail, consider the device off. It won't work without removing isolation.
+	 */
+	res = regmap_set_bits(zx29_pd->map, reg + REG_ISO, mask);
+	if (res) {
+		dev_err(&domain->dev, "Bus isolation failed: %d\n", res);
+		return res;
+	}
+
+	res = regmap_set_bits(zx29_pd->map, reg + REG_RST, mask);
+	if (res)
+		dev_err(&domain->dev, "Device reset failed: %d\n", res);
+
+	res = regmap_clear_bits(zx29_pd->map, reg + REG_PWR, mask);
+	if (res)
+		dev_err(&domain->dev, "Power off failed: %d\n", res);
+
+	return 0;
+}
+
+static int zx29_pd_attach_dev(struct generic_pm_domain *domain, struct device *dev)
+{
+	/* The DT link to the consumer targets the (MFD) parent, which doesn't prevent unbinding the
+	 * this driver or removing the module. Either would leave the consumer with a dangling
+	 * reference.
+	 */
+	if (!device_link_add(dev, &domain->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int zx29_pd_is_on(const struct zx29_pm_domain *zx29_pd)
+{
+	u32 mask = power_domains[zx29_pd->domain].mask;
+	u32 reg = power_domains[zx29_pd->domain].reg;
+	int res;
+	unsigned int val;
+
+	/* To consider a domain on, PWR must be set and RST and ISO cleared */
+	res = regmap_test_bits(zx29_pd->map, reg + REG_PWR, mask);
+	if (res < 0)
+		return res;
+	if (!res)
+		return 0;
+
+	res = regmap_read(zx29_pd->map, reg + REG_ISO, &val);
+	if (res < 0)
+		return res;
+	if (val & mask)
+		return 0;
+
+	res = regmap_read(zx29_pd->map, reg + REG_RST, &val);
+	if (res < 0)
+		return res;
+	if (val & mask)
+		return 0;
+
+	return 1;
+}
+
+static void zx29_pd_release_provider(void *data)
+{
+	struct device_node *of_node = data;
+
+	of_genpd_del_provider(of_node);
+}
+
+static void zx29_pd_remove_domain(void *data)
+{
+	struct generic_pm_domain *genpd = data;
+
+	pm_genpd_remove(genpd);
+}
+
+static int zx29_pd_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *of_node = dev->parent->of_node;
+	struct genpd_onecell_data *zx29_pd_data;
+	struct generic_pm_domain **domains;
+	struct zx29_pm_domain *zx29_pd;
+	struct regmap *map;
+	unsigned int i;
+	int res;
+
+	map = device_node_to_regmap(of_node);
+	if (IS_ERR(map))
+		return dev_err_probe(dev, PTR_ERR(map), "Cannot get parent syscon regmap\n");
+
+	zx29_pd = devm_kcalloc(dev, ARRAY_SIZE(power_domains), sizeof(*zx29_pd), GFP_KERNEL);
+	if (!zx29_pd)
+		return -ENOMEM;
+
+	domains = devm_kcalloc(dev, ARRAY_SIZE(power_domains), sizeof(*domains), GFP_KERNEL);
+	if (!domains)
+		return -ENOMEM;
+
+	zx29_pd_data = devm_kzalloc(dev, sizeof(*zx29_pd_data), GFP_KERNEL);
+	if (!zx29_pd_data)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(power_domains); i++) {
+		zx29_pd[i].gpd.name = power_domains[i].name;
+		zx29_pd[i].gpd.power_off = zx29_pd_off;
+		zx29_pd[i].gpd.power_on = zx29_pd_on;
+		zx29_pd[i].gpd.attach_dev = zx29_pd_attach_dev;
+
+		zx29_pd[i].map = map;
+		zx29_pd[i].domain = i;
+
+		domains[i] = &zx29_pd[i].gpd;
+
+		res = zx29_pd_is_on(&zx29_pd[i]);
+		if (res < 0)
+			return dev_err_probe(dev, res, "failed to read initial pmdomain state\n");
+
+		dev_dbg(dev, "%s: %s\n", power_domains[i].name, res ? "on" : "off");
+
+		res = pm_genpd_init(&zx29_pd[i].gpd, NULL, !res);
+		if (res)
+			return dev_err_probe(dev, res, "failed to init power domain\n");
+		res = devm_add_action_or_reset(dev, zx29_pd_remove_domain, &zx29_pd[i].gpd);
+		if (res)
+			return dev_err_probe(dev, res, "failed to add pm_genpd release callback\n");
+	}
+
+	zx29_pd_data->domains = domains;
+	zx29_pd_data->num_domains = ARRAY_SIZE(power_domains);
+
+	res = of_genpd_add_provider_onecell(of_node, zx29_pd_data);
+	if (res)
+		return dev_err_probe(dev, res, "Cannot register power domains\n");
+
+	device_link_add(dev, dev->parent, DL_FLAG_AUTOREMOVE_CONSUMER);
+
+	dev_dbg(dev, "zx297520v3 power domain initialized.\n");
+
+	return devm_add_action_or_reset(dev, zx29_pd_release_provider, of_node);
+}
+
+static const struct platform_device_id pmdomain_zx297520v3_ids[] = {
+	{
+		.name = "zx297520v3-socsys-power",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, pmdomain_zx297520v3_ids);
+
+static struct platform_driver zx297520_pd = {
+	.probe = zx29_pd_probe,
+	.driver = {
+		.name = "zx297520v3-power-domain",
+	},
+	.id_table = pmdomain_zx297520v3_ids,
+};
+module_platform_driver(zx297520_pd);
+
+MODULE_AUTHOR("Stefan Dösinger <stefandoesinger@gmail.com>");
+MODULE_DESCRIPTION("ZTE zx297520v3 power domain driver");
+MODULE_LICENSE("GPL");

-- 
2.56.1

