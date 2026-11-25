Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795565191;
	b=xHhfWahWPCy1Q+R10z3Dpb1l9eEFdjkdspeA6kvmFtH0HDzxThZ3AXOv35Xw4NGq1HzG
	 6KfdAeaSzunYKapmPq2o/8c9a25QSuVg7DbqKtu+SlLhv0xUcCJW5obuGjbZBlmGGMJ5b
	 RY1jDzsEM31SeqoJTNGJPyjlVKWHVcl4MLM2uWOEdEAgDqNMLpEaSS+mha4xjs7Cfe1oh
	 bxNCsuzttAA4oue3UBWP936VWC3yIz0lnXqRmZq41ER+i+50wtl6oeZR27PmFJxqx5Wh8
	 IAbSzBSdlZiInOps0BK4Cc0i94ZM7LCNWX/hcHXskJODAi7yF3YkL6FS1NGRf1ecsEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795565191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hGBzWIQFOFp/BZUWz33FpcX5GbKLCTqrD6aWJ0DeaJ0=;
	b=XO9UC1KZYO7F9fqts6c38H9A4F3SlTlSmYv6B4b79cui6qKkdTHlYqsUlpwR0PDKqrzf
	 4boEsG3AHdXyo4y118vCA02etG0rgjCMBOznMsUbWExskqKTxy4WzQ6TmBA+0Q1tV4V6S
	 2ZLJbnyhlrT6mSRE2eKIv/I+Y9oZQLVdGSWthn3gQZUNmSQmr2jlJVljzAoLSqTlg+Ij+
	 AhpN6WK1mM2hZCabnHo0qMo/tqwZN9bmzuLbIR/R2FyOUnCjhO1sdvu56AKq61W3wiTwR
	 uSXKw5prBCLWLFWhn5U+2dy3nz1wtmvl6uTx8NghBIlV/NAQL/3qel6ZtE/RZBZ2WuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mzP9LK95;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFDD606A683
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 00:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADFDD606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mzP9LK95
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1b546061d58so11537668c88.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 16:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795565190; x=1796169990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hGBzWIQFOFp/BZUWz33FpcX5GbKLCTqrD6aWJ0DeaJ0=;
        b=mzP9LK955F82NH2FwyfX7H8gXcbMjBfS+O5IGvH7FS1j7x5OvXG4tIorrowXcsS1AU
         xSVUseb6gka5OkTiiXPnXVqOs/hLnkYqLSuS9zSriYSA6nyNcO452UkBhBVscexOAlyM
         5vvsdOxU6hrraFIDsXTr9EP2bJY7aX91eO0Og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795565190; x=1796169990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hGBzWIQFOFp/BZUWz33FpcX5GbKLCTqrD6aWJ0DeaJ0=;
        b=LkZUBVXFFRzp4/Ks2unsGz2vcYm2FB/Monpl6gOGxTOacEYbL85LQLse/aKTskYBVA
         7yoxfxbdIfBa+ALSPxr2IdJe8neB2z5PfBKw/aLympRpChA9ALMrpPl1r12+5kUtJiP8
         Oi6f0CNsgIF3s7gV0deuhKyvyf6QZWjzbUqhvMGZhFjhJTWzTrb8jqHwOhZbrcjlUqKJ
         otubPo3rSBj1TEEa4gBlW+48wwHdMSD9OUdt4/FquafkfCfA0NPxBNxkv1E/rJ2pP7Je
         dPDgNfFfbm6L1J0F9CN0xwUEIN2S2w0bqz9s39EY5nDcfunn1NHusaPHjl4wUeC00o3O
         PNyw==
X-Forwarded-Encrypted: i=1; AL+hErFO2l4Sc3TUyBxI45EkexafDjR7TOFojVJiy3OU+NAo95IjKkR7koL/FGwvL4IZRrxFf1LVf4/cvA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8CMmi4c/uIrHOzTUwrJ+ox+7i21/nKNM6j0lGAFO4fL+0ahG7p
	fV7G/zRlyrogk9Y022xvdd48qq5gOwjCrcWVVW2tVOXuNF3fRYqG4F6ZS204pJy+Hg==
X-Gm-Gg: AZFdTZezALl75AJeW6HdlueZojeHkTFY/rCydd0f/zRwxE2gferopg6PxGHpZEaZw2l
	c7sUbN7SsO1D1DIGTK+gHYhRq0jqhGPEWatZjREKJxlOFI+JwREq+kuYKv7HEWoSbJaSdggQ5TR
	5FTTCIOGsJwgr+HhEqhHag18oyMi+PXQdz59Lc9W2p2PgRsG2pEpBjrR8DV8Hynsobt38KDttfP
	MzXdoZxfQKpNi0ih2QB9vEE+vqcuoQbPxME84c16pqXSWcSD3pO76329rpszKpPNzCBO5AWwKVn
	YG/7g+Jt5/ovi0HLWLaZkhLOSzk67NsKb19BIBDD+Eq8EUU4tMw20sSNtbeII+hmEEk1Mc7JGHt
	z/d2H8Ya6t28YhzVmKNJZglZtji1zPmqaDVlUZasfVEgYdPvhjUhRPkDxLl5zB8GNOvb1UQltCI
	utwD03lVynY1i03v6cmol6bWFMlng1wdwRB3iQkTZs1UvxV+k8ISiBWRw9cnSE6Ejbyulk63ozi
	GGJf9H2geoWFWh1mZz78WHU8OXpl+WkTwwrrFGKccv6RCvvJPo7bFkRSx+I2HcWpcMocSOWujG+
	pLdG6PqL2I1bsOniHKchV+R7FG5eViQ90kLFzpPYtkJo5NpNI95yrcWrgBzINWrjzewA
X-Received: by 2002:a05:7022:ea8d:b0:1a7:216d:157c with SMTP id a92af1059eb24-1b556902db6mr16197642c88.34.1795565189374;
        Tue, 24 Nov 2026 16:06:29 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ea9b:d8a3:ba44:2d0a])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b56ef9fd16sm26449446c88.4.2026.11.24.16.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 16:06:28 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Peter Griffin <peter.griffin@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Radu Rendec <radu@rendec.net>,
	=?UTF-8?q?Jakub=20G=C5=82owacki?= <jglow@google.com>,
	linux-clk@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Mariano Marciello <mmarciello@google.com>,
	google-soc@lists.linux.dev,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 3/9] pmdomain: google: Add CPM power-domain driver
Date: Tue, 24 Nov 2026 16:03:37 -0800
Message-ID: <20261124160343.v2.3.I42273470eab028b2ae2e128d338783b5bdcb4e55@changeid>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261125000349.3385325-1-briannorris@chromium.org>
References: <20261125000349.3385325-1-briannorris@chromium.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Central Power Manager (CPM) is a co-processor on the Google Tensor
SoCs, as used on Pixel phones. Among other features, CPM manages most of
the power domains on these SoCs. We talk to the CPM over a pair of
mailboxes, and we hide many of these details beneath a
cpm_send_message() API.

Tensor SoCs consist of various regions called Subsystem Wrappers
(SSWRP). SSWRPs and their sub-domains can be powered on and off by
interfacing with the Local Power and Clock Manager (LPCM) associated
with each SSWRP. Thus, the power-domain mapping tends to consist of a
"LPCM ID" (the SSWRP) and a "subdomain ID", although the mappings are
complicated enough we simply expose a single "power domain ID" in the
device tree binding, and figure out the rest of the details by per-SoC
tables.

Most of the complexity in this driver is in the hardware tables, and the
mappings between domains.

Because it may be useful both for reviewers familiar with the downstream
Linux support for these devices, or for future developers looking at
adapting/improving/adding further features later on, it's worth noting
some major deviations from the downstream drivers:

 * Use auxiliary_bus. The whole CPM-interface structure was reworked for
   upstream Linux, so rather than a bunch of DT nodes and platform
   devices, most/all CPM services are simply instantiated as auxiliary
   devices from the CPM driver, and share the same CPM DT node.

 * As a corollary to the DT restructuring: we eliminate the use of
   per-domain DT nodes. Downstream DTs would describe each power domain
   as its own node (with #power-domain-cells = <0>), and a variety of
   custom DT properties ("irq-safe", "always-on"). These are all encoded
   in the driver's per-SoC tables instead, and devices simply use a
   single cell (power domain ID) to refer to which domain they use.

 * Use devm more heavily

 * Drop 'no-auto-resume' feature. This was a Pixel optimization to avoid
   excessive power-on latency during system resume. It required unsound
   overrides to basic genpd functionality. I assume it should be
   replaced by more aggressive use of direct-complete eventually.

 * Drop CPM_LGA_LSIO_S_CLI_GPIO_IRQ_SAFE_ID,
   CPM_LGA_LSIO_N_CLI_GPIO_IRQ_SAFE_ID, and
   CPM_LGA_LSIO_E_CLI_GPIO_IRQ_SAFE_ID. They were not actually used
   downstream.

 * Drop debugfs test helpers

 * Replace a downstream "GENPD_FLAG_ALWAYS_ON" (but only during system
   suspend) feature with simply applying GENPD_FLAG_ACTIVE_WAKEUP to the
   SSWRP_AOC domain. This domain is for an "Always On Compute" subsystem
   on the SoC, but it also can be powered off temporarily for reset or
   similar. Any drivers for this component should simply manage its
   wakeup status properly, to ensure it stays "on" in the appropriate
   system suspend states.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Move pmdomain per-SoC info from .h to .c file
 * Remove custom pmdomain debugfs 'state' (get/set on/off) file
 * Restructure pmdomain SoC tables for simplicity and readability
 * adapt to cpm_* interface changes (devm_cpm_register_rx_callback(),
   ...)

 drivers/pmdomain/Kconfig                  |   1 +
 drivers/pmdomain/Makefile                 |   1 +
 drivers/pmdomain/google/Kconfig           |  14 +
 drivers/pmdomain/google/Makefile          |   3 +
 drivers/pmdomain/google/cpm-power-lga.c   | 365 +++++++++++++++++
 drivers/pmdomain/google/cpm-power-trace.h |  80 ++++
 drivers/pmdomain/google/cpm-power.c       | 458 ++++++++++++++++++++++
 drivers/pmdomain/google/cpm-power.h       |  42 ++
 8 files changed, 964 insertions(+)
 create mode 100644 drivers/pmdomain/google/Kconfig
 create mode 100644 drivers/pmdomain/google/Makefile
 create mode 100644 drivers/pmdomain/google/cpm-power-lga.c
 create mode 100644 drivers/pmdomain/google/cpm-power-trace.h
 create mode 100644 drivers/pmdomain/google/cpm-power.c
 create mode 100644 drivers/pmdomain/google/cpm-power.h

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 5341dff669be..aeda621411df 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -6,6 +6,7 @@ source "drivers/pmdomain/amlogic/Kconfig"
 source "drivers/pmdomain/apple/Kconfig"
 source "drivers/pmdomain/arm/Kconfig"
 source "drivers/pmdomain/bcm/Kconfig"
+source "drivers/pmdomain/google/Kconfig"
 source "drivers/pmdomain/imx/Kconfig"
 source "drivers/pmdomain/marvell/Kconfig"
 source "drivers/pmdomain/mediatek/Kconfig"
diff --git a/drivers/pmdomain/Makefile b/drivers/pmdomain/Makefile
index d7aee13ae571..608555ba5990 100644
--- a/drivers/pmdomain/Makefile
+++ b/drivers/pmdomain/Makefile
@@ -4,6 +4,7 @@ obj-y					+= amlogic/
 obj-y					+= apple/
 obj-y					+= arm/
 obj-y					+= bcm/
+obj-y					+= google/
 obj-y					+= imx/
 obj-y					+= marvell/
 obj-y					+= mediatek/
diff --git a/drivers/pmdomain/google/Kconfig b/drivers/pmdomain/google/Kconfig
new file mode 100644
index 000000000000..e2a9bf0a7c82
--- /dev/null
+++ b/drivers/pmdomain/google/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config GOOGLE_CPM_POWER
+	tristate "Google Tensor CPM power controller driver"
+	depends on ARCH_GOOGLE || COMPILE_TEST
+	depends on GOOGLE_CPM_MBA
+	select PM_GENERIC_DOMAINS
+	default ARCH_GOOGLE
+	help
+	  This driver allows clients to power on/off power domains on Google
+	  Tensor SoCs via the generic power domain framework. It uses SMC or
+	  CPM mailbox array to request toggling the power domains.
+
+	  Say Y or M here to support CPM power domains.
diff --git a/drivers/pmdomain/google/Makefile b/drivers/pmdomain/google/Makefile
new file mode 100644
index 000000000000..5e6a0530122d
--- /dev/null
+++ b/drivers/pmdomain/google/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_GOOGLE_CPM_POWER) += google-cpm-power.o
+google-cpm-power-y := cpm-power.o cpm-power-lga.o
diff --git a/drivers/pmdomain/google/cpm-power-lga.c b/drivers/pmdomain/google/cpm-power-lga.c
new file mode 100644
index 000000000000..7aff28ec1685
--- /dev/null
+++ b/drivers/pmdomain/google/cpm-power-lga.c
@@ -0,0 +1,365 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2023-2026 Google LLC
+ */
+
+#include <dt-bindings/power/google,lga-cpm.h>
+#include <linux/array_size.h>
+#include <linux/pm_domain.h>
+
+#include "cpm-power.h"
+
+/* SSWRP IDs for the LPB service */
+enum lpb_sswrp_id {
+	LPB_ID_AOC,
+	LPB_ID_AURORA,
+	LPB_ID_CODEC_3P,
+	LPB_ID_CPU,
+	LPB_ID_CPUACC,
+	LPB_ID_DPU,
+	LPB_ID_EH,
+	LPB_ID_FABHBW,
+	LPB_ID_FABMED,
+	LPB_ID_FABRT,
+	LPB_ID_FABSTBY,
+	LPB_ID_FABSYSS,
+	LPB_ID_G2D,
+	LPB_ID_GMC0,
+	LPB_ID_GMC1,
+	LPB_ID_GMC2,
+	LPB_ID_GMC3,
+	LPB_ID_GPCA,
+	LPB_ID_GPCM,
+	LPB_ID_GPDMA,
+	LPB_ID_GPU,
+	LPB_ID_GSA,
+	LPB_ID_GSW,
+	LPB_ID_HSIO_N,
+	LPB_ID_HSIO_S,
+	LPB_ID_INF_TCU,
+	LPB_ID_ISPBE,
+	LPB_ID_ISPFE,
+	LPB_ID_LSIO_E,
+	LPB_ID_LSIO_N,
+	LPB_ID_LSIO_S,
+	LPB_ID_MEMSS,
+	LPB_ID_TPU,
+};
+
+/* Subdomain IDs */
+/* HSIO_N */
+#define SUB_HSIO_N_USB			0
+#define SUB_HSIO_N_PCIE			1
+#define SUB_HSIO_N_EBU			2
+#define SUB_HSIO_N_EBU_CORE		3
+#define SUB_HSIO_N_DP			4
+#define SUB_HSIO_N_USB_PSW		5
+
+/* HSIO_S */
+#define SUB_HSIO_S_UFS			0
+#define SUB_HSIO_S_PCIE			1
+#define SUB_HSIO_S_SD			2
+#define SUB_HSIO_S_UFS_PREP		3
+
+/* LSIO_{E,S,N} */
+#define SUB_LSIO_CLI_GPIO		0
+
+/* DPU */
+#define SUB_DPU_FE0			0
+#define SUB_DPU_FE1			1
+#define SUB_DPU_DSI0			2
+#define SUB_DPU_DSI1			3
+#define SUB_DPU_DP			4
+
+/* ISPFE */
+#define SUB_ISPFE_TOP			0
+#define SUB_ISPFE_PIPE			1
+#define SUB_ISPFE_CSIS			2
+
+/* G2D */
+#define SUB_G2D_CORE			0
+
+/* AOC */
+#define SUB_AOC_CORE			0
+
+#define LPCM_GENPD_SSWRP_DPU			0
+#define LPCM_GENPD_SSWRP_HSIO_S			1
+#define LPCM_GENPD_SSWRP_HSIO_N			2
+#define LPCM_GENPD_SSWRP_LSIO_S			3
+#define LPCM_GENPD_SSWRP_LSIO_N			4
+#define LPCM_GENPD_SSWRP_LSIO_E			5
+#define LPCM_GENPD_SSWRP_G2D			6
+#define LPCM_GENPD_SSWRP_GPDMA			7
+#define LPCM_GENPD_SSWRP_ISPFE			8
+#define LPCM_GENPD_SSWRP_AOC			9
+
+static const struct cpm_power_domain_desc lga_pm_domains[] = {
+	[PD_SSWRP_AOC] = {
+		.name = "sswrp-aoc-pd",
+		.type = CPM_PD_LPB,
+		.lpb_id = LPB_ID_AOC,
+		.flags = GENPD_FLAG_ACTIVE_WAKEUP,
+		.on_at_init = true,
+	},
+	[PD_AOC_CORE] = {
+		.name = "aoc-core-pd",
+		.type = CPM_PD_LPCM,
+		.lpcm_id = LPCM_GENPD_SSWRP_AOC,
+		.subdomain_id = SUB_AOC_CORE,
+		.on_at_init = true,
+		.parent_id = PD_SSWRP_AOC,
+	},
+	[PD_SSWRP_AURORA] = {
+		.name = "sswrp-aurora-pd",
+		.type = CPM_PD_LPB,
+		.lpb_id = LPB_ID_AURORA,
+	},
+	[PD_SSWRP_CODEC_3P] = {
+		.name = "sswrp-codec-3p-pd",
+		.type = CPM_PD_LPB,
+		.lpb_id = LPB_ID_CODEC_3P,
+	},
+	[PD_DPU_DP] = {
+		.name = "dpu-dp-pd",
+		.type = CPM_PD_LPCM,
+		.lpcm_id = LPCM_GENPD_SSWRP_DPU,
+		.subdomain_id = SUB_DPU_DP,
+		.parent_id = PD_SSWRP_DPU,
+	},
+	[PD_SSWRP_DPU] = {
+		.name = "sswrp-dpu-pd",
+		.type = CPM_PD_LPB,
+		.lpb_id = LPB_ID_DPU,
+	},
+	[PD_DPU_FE0] = {
+		.name = "dpu-fe0-pd",
+		.type = CPM_PD_LPCM,
+		.lpcm_id = LPCM_GENPD_SSWRP_DPU,
+		.subdomain_id = SUB_DPU_FE0,
+		.parent_id = PD_DPU_DSI0,
+	},
+	[PD_DPU_FE1] = {
+		.name = "dpu-fe1-pd",
+		.type = CPM_PD_LPCM,
+		.lpcm_id = LPCM_GENPD_SSWRP_DPU,
+		.subdomain_id = SUB_DPU_FE1,
+		.parent_id = PD_DPU_FE0,
+	},
+	[PD_DPU_DSI0] = {
+		.name = "dpu-dsi0-pd",
+		.type = CPM_PD_LPCM,
+		.lpcm_id = LPCM_GENPD_SSWRP_DPU,
+		.subdomain_id = SUB_DPU_DSI0,
+		.parent_id = PD_SSWRP_DPU,
+	},
+	[PD_DPU_DSI1] = {
+		.name = "dpu-dsi1-pd",
+		.type = CPM_PD_LPCM,
+		.lpcm_id = LPCM_GENPD_SSWRP_DPU,
+		.subdomain_id = SUB_DPU_DSI1,
+		.parent_id = PD_SSWRP_DPU,
+	},
+	[PD_SSWRP_EH] = {
+		.name = "sswrp-eh-pd",
+		.type = CPM_PD_LPB,
+		.lpb_id = LPB_ID_EH,
+	},
+	[PD_SSWRP_G2D] = {
+		.name = "sswrp-g2d-pd",
+		.type = CPM_PD_LPB,
+		.lpb_id = LPB_ID_G2D,
+	},
+	[PD_G2D_CORE] = {
+		.name = "g2d-core-pd",
+		.type = CPM_PD_LPCM,
+		.lpcm_id = LPCM_GENPD_SSWRP_G2D,
+		.subdomain_id = SUB_G2D_CORE,
+		.parent_id = PD_SSWRP_G2D,
+	},
+	[PD_SSWRP_GPDMA] = {
+		.name = "sswrp-gpdma-pd",
+		.type = CPM_PD_LPB,
+		.lpb_id = LPB_ID_GPDMA,
+		.on_at_init = true,
+	},
+	[PD_SSWRP_GPU] = {
+		.name = "sswrp-gpu-pd",
+		.type = CPM_PD_LPB,
+		.lpb_id = LPB_ID_GPU,
+	},
+	[PD_SSWRP_GSW] = {
+		.name = "sswrp-gsw-pd",
+		.type = CPM_PD_LPB,
+		.lpb_id = LPB_ID_GSW,
+	},
+	[PD_SSWRP_HSIO_N] = {
+		.name = "sswrp-hsio-n-pd",
+		.type = CPM_PD_LPB,
+		.lpb_id = LPB_ID_HSIO_N,
+		.on_at_init = true,
+	},
+	[PD_HSIO_N_USB] = {
+		.name = "hsio-n-usb-pd",
+		.type = CPM_PD_LPCM,
+		.lpcm_id = LPCM_GENPD_SSWRP_HSIO_N,
+		.subdomain_id = SUB_HSIO_N_USB,
+		.flags = GENPD_FLAG_ACTIVE_WAKEUP,
+		.on_at_init = true,
+		.parent_id = PD_SSWRP_HSIO_N,
+	},
+	[PD_HSIO_N_USB_PSW] = {
+		.name = "hsio-n-usb-psw-pd",
+		.type = CPM_PD_LPCM,
+		.lpcm_id = LPCM_GENPD_SSWRP_HSIO_N,
+		.subdomain_id = SUB_HSIO_N_USB_PSW,
+		.flags = GENPD_FLAG_ACTIVE_WAKEUP,
+		.on_at_init = true,
+		.parent_id = PD_HSIO_N_USB,
+	},
+	[PD_HSIO_N_PCIE] = {
+		.name = "hsio-n-pcie-pd",
+		.type = CPM_PD_LPCM,
+		.lpcm_id = LPCM_GENPD_SSWRP_HSIO_N,
+		.subdomain_id = SUB_HSIO_N_PCIE,
+		.flags = GENPD_FLAG_ACTIVE_WAKEUP,
+		.parent_id = PD_SSWRP_HSIO_N,
+	},
+	[PD_HSIO_N_DP] = {
+		.name = "hsio-n-dp-pd",
+		.type = CPM_PD_LPCM,
+		.lpcm_id = LPCM_GENPD_SSWRP_HSIO_N,
+		.subdomain_id = SUB_HSIO_N_DP,
+		.parent_id = PD_HSIO_N_USB_PSW,
+	},
+	[PD_HSIO_N_EBU] = {
+		.name = "hsio-n-ebu-pd",
+		.type = CPM_PD_LPCM,
+		.lpcm_id = LPCM_GENPD_SSWRP_HSIO_N,
+		.subdomain_id = SUB_HSIO_N_EBU,
+		.parent_id = PD_HSIO_N_USB,
+	},
+	[PD_HSIO_N_EBU_CORE] = {
+		.name = "hsio-n-ebu-core-pd",
+		.type = CPM_PD_LPCM,
+		.lpcm_id = LPCM_GENPD_SSWRP_HSIO_N,
+		.subdomain_id = SUB_HSIO_N_EBU_CORE,
+		.parent_id = PD_HSIO_N_EBU,
+	},
+	[PD_SSWRP_HSIO_S] = {
+		.name = "sswrp-hsio-s-pd",
+		.type = CPM_PD_LPB,
+		.lpb_id = LPB_ID_HSIO_S,
+		.flags = GENPD_FLAG_RPM_ALWAYS_ON,
+		.on_at_init = true,
+	},
+	[PD_HSIO_S_UFS_PREP] = {
+		.name = "hsio-s-ufs-prep-pd",
+		.type = CPM_PD_LPCM,
+		.lpcm_id = LPCM_GENPD_SSWRP_HSIO_S,
+		.subdomain_id = SUB_HSIO_S_UFS_PREP,
+		.on_at_init = true,
+		.parent_id = PD_SSWRP_HSIO_S,
+	},
+	[PD_HSIO_S_UFS] = {
+		.name = "hsio-s-ufs-pd",
+		.type = CPM_PD_LPCM,
+		.lpcm_id = LPCM_GENPD_SSWRP_HSIO_S,
+		.subdomain_id = SUB_HSIO_S_UFS,
+		.flags = GENPD_FLAG_RPM_ALWAYS_ON,
+		.on_at_init = true,
+		.parent_id = PD_HSIO_S_UFS_PREP,
+	},
+	[PD_HSIO_S_PCIE] = {
+		.name = "hsio-s-pcie-pd",
+		.type = CPM_PD_LPCM,
+		.lpcm_id = LPCM_GENPD_SSWRP_HSIO_S,
+		.subdomain_id = SUB_HSIO_S_PCIE,
+		.parent_id = PD_SSWRP_HSIO_S,
+	},
+	[PD_HSIO_S_SD] = {
+		.name = "hsio-s-sd-pd",
+		.type = CPM_PD_LPCM,
+		.lpcm_id = LPCM_GENPD_SSWRP_HSIO_S,
+		.subdomain_id = SUB_HSIO_S_SD,
+		.parent_id = PD_HSIO_S_UFS,
+	},
+	[PD_SSWRP_ISPBE] = {
+		.name = "sswrp-ispbe-pd",
+		.type = CPM_PD_LPB,
+		.lpb_id = LPB_ID_ISPBE,
+	},
+	[PD_SSWRP_ISPFE] = {
+		.name = "sswrp-ispfe-pd",
+		.type = CPM_PD_LPB,
+		.lpb_id = LPB_ID_ISPFE,
+	},
+	[PD_ISPFE_PIPE] = {
+		.name = "ispfe-pipe-pd",
+		.type = CPM_PD_LPCM,
+		.lpcm_id = LPCM_GENPD_SSWRP_ISPFE,
+		.subdomain_id = SUB_ISPFE_PIPE,
+		.parent_id = PD_SSWRP_ISPFE,
+	},
+	[PD_ISPFE_CSIS] = {
+		.name = "ispfe-csis-pd",
+		.type = CPM_PD_LPCM,
+		.lpcm_id = LPCM_GENPD_SSWRP_ISPFE,
+		.subdomain_id = SUB_ISPFE_CSIS,
+		.parent_id = PD_SSWRP_ISPFE,
+	},
+	[PD_SSWRP_LSIO_E] = {
+		.name = "sswrp-lsio-e-pd",
+		.type = CPM_PD_LPB,
+		.lpb_id = LPB_ID_LSIO_E,
+		.flags = GENPD_FLAG_RPM_ALWAYS_ON,
+		.on_at_init = true,
+	},
+	[PD_LSIO_E_CLI_GPIO] = {
+		.name = "lsio-e-cli-gpio-pd",
+		.type = CPM_PD_SMC,
+		.smc_id = LPB_ID_LSIO_E,
+		.subdomain_id = SUB_LSIO_CLI_GPIO,
+		.flags = GENPD_FLAG_RPM_ALWAYS_ON,
+		.on_at_init = true,
+		.parent_id = PD_SSWRP_LSIO_E,
+	},
+	[PD_SSWRP_LSIO_N] = {
+		.name = "sswrp-lsio-n-pd",
+		.type = CPM_PD_LPB,
+		.lpb_id = LPB_ID_LSIO_N,
+		.on_at_init = true,
+	},
+	[PD_LSIO_N_CLI_GPIO] = {
+		.name = "lsio-n-cli-gpio-pd",
+		.type = CPM_PD_LPCM,
+		.lpcm_id = LPCM_GENPD_SSWRP_LSIO_N,
+		.subdomain_id = SUB_LSIO_CLI_GPIO,
+		.on_at_init = true,
+		.parent_id = PD_SSWRP_LSIO_N,
+	},
+	[PD_SSWRP_LSIO_S] = {
+		.name = "sswrp-lsio-s-pd",
+		.type = CPM_PD_LPB,
+		.lpb_id = LPB_ID_LSIO_S,
+		.on_at_init = true,
+	},
+	[PD_LSIO_S_CLI_GPIO] = {
+		.name = "lsio-s-cli-gpio-pd",
+		.type = CPM_PD_LPCM,
+		.lpcm_id = LPCM_GENPD_SSWRP_LSIO_S,
+		.subdomain_id = SUB_LSIO_CLI_GPIO,
+		.on_at_init = true,
+		.parent_id = PD_SSWRP_LSIO_S,
+	},
+	[PD_SSWRP_TPU] = {
+		.name = "sswrp-tpu-pd",
+		.type = CPM_PD_LPB,
+		.lpb_id = LPB_ID_TPU,
+		.flags = GENPD_FLAG_ACTIVE_WAKEUP,
+	},
+};
+
+const struct cpm_power_desc lga_cpm_power_desc = {
+	.domains = lga_pm_domains,
+	.num_domains = ARRAY_SIZE(lga_pm_domains),
+};
diff --git a/drivers/pmdomain/google/cpm-power-trace.h b/drivers/pmdomain/google/cpm-power-trace.h
new file mode 100644
index 000000000000..0c5e3c47b304
--- /dev/null
+++ b/drivers/pmdomain/google/cpm-power-trace.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2023-2026 Google LLC
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM cpm_power
+
+#if !defined(_TRACE_CPM_POWER_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_CPM_POWER_TRACE_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(cpm_power_send_mail_events,
+	TP_PROTO(struct cpm_power_domain *pd, bool on),
+	TP_ARGS(pd, on),
+	TP_STRUCT__entry(
+		__string(name, pd->name)
+		__field(unsigned char, sswrp_id)
+		__field(unsigned char, subdomain_id)
+		__field(bool, on)
+	),
+	TP_fast_assign(
+		__assign_str(name);
+		__entry->sswrp_id = (pd->type == CPM_PD_LPB) ? pd->lpb_id : pd->lpcm_id;
+		__entry->subdomain_id = pd->subdomain_id;
+		__entry->on = on;
+	),
+	TP_printk("\t%#04x.%02x:%s\ten:%d",
+		  __entry->sswrp_id, __entry->subdomain_id,
+		  __get_str(name), __entry->on)
+);
+DEFINE_EVENT(cpm_power_send_mail_events, send_mail_lpb,
+	TP_PROTO(struct cpm_power_domain *pd, bool on),
+	TP_ARGS(pd, on)
+);
+DEFINE_EVENT(cpm_power_send_mail_events, send_mail_lpcm,
+	TP_PROTO(struct cpm_power_domain *pd, bool on),
+	TP_ARGS(pd, on)
+);
+
+DECLARE_EVENT_CLASS(cpm_power_mail_result_events,
+	TP_PROTO(struct cpm_power_domain *pd, bool on, int result),
+	TP_ARGS(pd, on, result),
+	TP_STRUCT__entry(
+		__string(name, pd->name)
+		__field(unsigned char, sswrp_id)
+		__field(unsigned char, subdomain_id)
+		__field(bool, on)
+		__field(int, result)
+	),
+	TP_fast_assign(
+		__assign_str(name);
+		__entry->sswrp_id = (pd->type == CPM_PD_LPB) ? pd->lpb_id : pd->lpcm_id;
+		__entry->subdomain_id = pd->subdomain_id;
+		__entry->on = on;
+		__entry->result = result;
+	),
+	TP_printk("\t%#04x.%02x:%s\ten:%d (res:%d)",
+		  __entry->sswrp_id, __entry->subdomain_id,
+		  __get_str(name), __entry->on, __entry->result)
+);
+DEFINE_EVENT(cpm_power_mail_result_events, recv_result_lpb,
+	TP_PROTO(struct cpm_power_domain *pd, bool on, int result),
+	TP_ARGS(pd, on, result)
+);
+DEFINE_EVENT(cpm_power_mail_result_events, recv_result_lpcm,
+	TP_PROTO(struct cpm_power_domain *pd, bool on, int result),
+	TP_ARGS(pd, on, result)
+);
+
+#endif /* _TRACE_CPM_POWER_TRACE_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../drivers/pmdomain/google
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE cpm-power-trace
+
+#include <trace/define_trace.h>
diff --git a/drivers/pmdomain/google/cpm-power.c b/drivers/pmdomain/google/cpm-power.c
new file mode 100644
index 000000000000..e93013188aa2
--- /dev/null
+++ b/drivers/pmdomain/google/cpm-power.c
@@ -0,0 +1,458 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2023-2026 Google LLC
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/atomic.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/bug.h>
+#include <linux/completion.h>
+#include <linux/container_of.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/gfp_types.h>
+#include <linux/jiffies.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pm_domain.h>
+#include <linux/string_choices.h>
+#include <linux/types.h>
+#include <soc/google/cpm-service-ids.h>
+#include <soc/google/google-cpm-mba.h>
+
+#include "cpm-power.h"
+
+struct cpm_power_controller;
+
+struct cpm_power_domain {
+	struct cpm_power_controller *controller;
+	struct generic_pm_domain genpd;
+	const char *name;
+	enum cpm_pd_type type;
+	int id;
+	/* Firmware SSWRP ID used by CPM / EL3 depending on @type */
+	union {
+		int lpb_id;
+		int lpcm_id;
+		int smc_id;
+	};
+	int subdomain_id;
+	int parent_id;
+	atomic_t state;
+	struct completion cpm_resp_done;
+};
+
+struct cpm_power_controller {
+	struct device *dev;
+	struct cpm_handle *cpm;
+	struct cpm_power_domain *pds;
+	u32 pd_count;
+	struct genpd_onecell_data pd_data;
+};
+
+#define CREATE_TRACE_POINTS
+#include "cpm-power-trace.h"
+
+#define SIP_SVC_PD_CONTROL	0x82000701
+
+#define CPM_MBX_RECV_TIMEOUT_MS	3000
+
+/*
+ * LPB service command response status codes.
+ */
+enum lpb_service_cmd_status {
+	LPB_SERVICE_CMD_SUCCESS = 0xf,
+	LPB_SERVICE_CMD_FAIL,
+	LPB_SERVICE_PWRDN_STARTED,
+	LPB_SERVICE_PWRUP_STARTED,
+	LPB_SERVICE_NO_EFFECT,
+};
+
+static inline struct cpm_power_domain *to_power_domain(struct generic_pm_domain *d)
+{
+	return container_of(d, struct cpm_power_domain, genpd);
+}
+
+/*
+ * This callback is triggered when CPM signals the transition has finished.
+ */
+static void cpm_power_rx_callback(const struct cpm_payload *msg, void *priv)
+{
+	struct cpm_power_controller *pc = priv;
+	struct device *dev = pc->dev;
+	struct cpm_power_domain *pd = NULL;
+	u32 resource_sid = msg->payload[0];
+	int i;
+
+	dev_dbg(dev, "rx callback msg %d %d %d\n", msg->payload[0],
+		msg->payload[1], msg->payload[2]);
+
+	for (i = 0; i < pc->pd_count; i++) {
+		/* For MBA/LPB service */
+		if (pc->pds[i].type == CPM_PD_LPB &&
+		    pc->pds[i].lpb_id == resource_sid) {
+			pd = &pc->pds[i];
+			break;
+		}
+	}
+	if (!pd) {
+		dev_err(dev, "cannot find corresponding power domain for ID: %d\n",
+			resource_sid);
+		return;
+	}
+
+	dev_dbg(dev, "%s: power transition completed\n", pd->name);
+	complete(&pd->cpm_resp_done);
+}
+
+static int send_lpb_request(struct cpm_power_domain *pd, bool on)
+{
+	struct device *dev = pd->controller->dev;
+	const struct cpm_lpb_message msg = {
+		.cmd = LPB_CMD_SSWRP_STATE_SET,
+		.sswrp_id = pd->lpb_id,
+		.data = on,
+	};
+	int ret;
+
+	dev_dbg(dev, "%s: power %s: sswrp_id = %d\n", pd->name, str_on_off(on),
+		pd->lpb_id);
+
+	reinit_completion(&pd->cpm_resp_done);
+
+	trace_send_mail_lpb(pd, on);
+	ret = cpm_send_lpb_message(pd->controller->cpm, &msg);
+	if (ret < 0)
+		return ret;
+
+	switch (ret) {
+	case LPB_SERVICE_CMD_SUCCESS:
+		/* Command requires no asynchronous processing -- we are done */
+		ret = 0;
+		break;
+	case LPB_SERVICE_PWRUP_STARTED:
+	case LPB_SERVICE_PWRDN_STARTED:
+		/*
+		 * We have received the first response for power on/off.  The
+		 * final result will be received asynchronously.
+		 */
+		if (!wait_for_completion_timeout(&pd->cpm_resp_done,
+						 msecs_to_jiffies(CPM_MBX_RECV_TIMEOUT_MS))) {
+			dev_err(dev, "%s: power %s: wait for CPM response timeout\n",
+				pd->name, str_on_off(on));
+			ret = -ETIMEDOUT;
+			break;
+		}
+		ret = 0;
+		break;
+	case LPB_SERVICE_CMD_FAIL:
+	default:
+		/* Command got through but the result was failure */
+		dev_err(dev, "%s: power %s: CPM LPB services returned fail, err=%d\n",
+			pd->name, str_on_off(on), ret);
+		ret = -EPROTO;
+		break;
+	}
+
+	trace_recv_result_lpb(pd, on, ret);
+
+	return ret;
+}
+
+static int send_lpcm_request(struct cpm_power_domain *pd, bool on)
+{
+	struct device *dev = pd->controller->dev;
+	const struct cpm_lpcm_message msg = {
+		.cmd = LPCM_CMD_SET_GEN_PD,
+		.opcode = on,
+		.lpcm_id = pd->lpcm_id,
+		.obj_id = pd->subdomain_id,
+	};
+	int ret;
+
+	dev_dbg(dev, "%s: power %s: lpcm_id = %d\n", pd->name, str_on_off(on),
+		pd->lpcm_id);
+
+	trace_send_mail_lpcm(pd, on);
+	ret = cpm_send_lpcm_message(pd->controller->cpm, &msg);
+	trace_recv_result_lpcm(pd, on, ret);
+
+	return ret;
+}
+
+static inline int lpcm_smc(struct cpm_power_domain *pd, bool on)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(SIP_SVC_PD_CONTROL, pd->smc_id,
+		      pd->subdomain_id, on, 0, 0, 0, 0, &res);
+
+	WARN_ON(res.a0);
+	if ((unsigned long)res.a1) {
+		dev_err(pd->controller->dev, "Failed SMC call sswrp:%d sub-domain:%d, res.a1:%lu\n",
+			pd->smc_id, pd->subdomain_id, res.a1);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int cpm_set_power_state(struct generic_pm_domain *domain, bool on)
+{
+	struct cpm_power_domain *pd = to_power_domain(domain);
+	int ret;
+
+	switch (pd->type) {
+	case CPM_PD_LPB:
+		ret = send_lpb_request(pd, on);
+		break;
+	case CPM_PD_LPCM:
+		ret = send_lpcm_request(pd, on);
+		break;
+	case CPM_PD_SMC:
+		ret = lpcm_smc(pd, on);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!ret)
+		atomic_set(&pd->state, on);
+
+	return ret;
+}
+
+static int cpm_power_on(struct generic_pm_domain *domain)
+{
+	return cpm_set_power_state(domain, true);
+}
+
+static int cpm_power_off(struct generic_pm_domain *domain)
+{
+	return cpm_set_power_state(domain, false);
+}
+
+static int cpm_power_apply_desc(struct cpm_power_domain *pd,
+				const struct cpm_power_domain_desc *domain)
+{
+	struct device *dev = pd->controller->dev;
+
+	if (domain->on_at_init)
+		atomic_set(&pd->state, true);
+
+	pd->genpd.flags |= domain->flags;
+
+	/* If we want it "always on", it must already be on. */
+	if (pd->genpd.flags & GENPD_FLAG_ALWAYS_ON) {
+		if (!atomic_read(&pd->state)) {
+			dev_err(dev, "%s: always-on PM domain is not on\n",
+				pd->name);
+			return -EINVAL;
+		}
+	}
+
+	/* If we want it "RPM always on", it must already be on. */
+	if (pd->genpd.flags & GENPD_FLAG_RPM_ALWAYS_ON) {
+		if (!atomic_read(&pd->state)) {
+			dev_err(dev, "%s: rpm-always-on PM domain is not on\n",
+				pd->name);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static struct cpm_power_domain *cpm_find_pd_by_id(struct cpm_power_controller *pc, int id)
+{
+	if (id >= 0 && id < pc->pd_count)
+		return &pc->pds[id];
+	return NULL;
+}
+
+static void cpm_genpd_remove_action(void *data)
+{
+	struct generic_pm_domain *genpd = data;
+
+	pm_genpd_remove(genpd);
+}
+
+static void cpm_genpd_remove_subdomain_action(void *data)
+{
+	struct cpm_power_domain *pd = data;
+	struct cpm_power_domain *parent_pd = cpm_find_pd_by_id(pd->controller, pd->parent_id);
+
+	pm_genpd_remove_subdomain(&parent_pd->genpd, &pd->genpd);
+}
+
+static const struct of_device_id cpm_power_of_match[] __maybe_unused = {
+	{ .compatible = "google,lga-cpm", .data = &lga_cpm_power_desc },
+	{},
+};
+
+static int cpm_power_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_id *id)
+{
+	struct device *dev = &auxdev->dev;
+	struct cpm_power_controller *controller;
+	const struct of_device_id *match;
+	const struct cpm_power_desc *desc;
+	int ret, i, pd_count;
+
+	match = of_match_node(cpm_power_of_match, dev->of_node);
+	if (!match) {
+		dev_err(dev, "unsupported CPM compatible\n");
+		return -ENODEV;
+	}
+	desc = match->data;
+
+	controller = devm_kzalloc(dev, sizeof(*controller), GFP_KERNEL);
+	if (!controller)
+		return -ENOMEM;
+
+	controller->dev = dev;
+
+	auxiliary_set_drvdata(auxdev, controller);
+
+	pd_count = desc->num_domains;
+	controller->pds = devm_kcalloc(dev, pd_count, sizeof(*controller->pds), GFP_KERNEL);
+	if (!controller->pds)
+		return -ENOMEM;
+	controller->pd_count = pd_count;
+
+	controller->pd_data.domains =
+		devm_kcalloc(dev, pd_count, sizeof(*controller->pd_data.domains),
+			     GFP_KERNEL);
+	if (!controller->pd_data.domains)
+		return -ENOMEM;
+	controller->pd_data.num_domains = pd_count;
+
+	for (i = 0; i < pd_count; i++) {
+		const struct cpm_power_domain_desc *domain = &desc->domains[i];
+		struct cpm_power_domain *pd = &controller->pds[i];
+
+		pd->type = domain->type;
+		atomic_set(&pd->state, false);
+		pd->name = domain->name;
+		pd->controller = controller;
+		pd->genpd.name = domain->name;
+		pd->genpd.power_on = cpm_power_on;
+		pd->genpd.power_off = cpm_power_off;
+		pd->id = i;
+		pd->subdomain_id = domain->subdomain_id;
+		pd->parent_id = domain->parent_id;
+
+		switch (pd->type) {
+		case CPM_PD_LPB:
+			pd->lpb_id = domain->lpb_id;
+			break;
+		case CPM_PD_LPCM:
+			pd->lpcm_id = domain->lpcm_id;
+			break;
+		case CPM_PD_SMC:
+			pd->smc_id = domain->smc_id;
+			break;
+		default:
+			dev_err(dev, "%s: invalid power domain type %d\n",
+				pd->name, pd->type);
+			return -EINVAL;
+		}
+
+		init_completion(&pd->cpm_resp_done);
+
+		ret = cpm_power_apply_desc(pd, domain);
+		if (ret) {
+			dev_err(dev, "%s: failed to parse attributes\n",
+				pd->name);
+			return ret;
+		}
+	}
+
+	controller->cpm = devm_cpm_get_handle(dev);
+	if (IS_ERR(controller->cpm))
+		return dev_err_probe(dev, PTR_ERR(controller->cpm),
+				     "failed to get CPM handle\n");
+
+	ret = devm_cpm_register_rx_callback(dev, controller->cpm,
+					    APC_COMMON_SERVICE_ID_POWER_CONTROLLER,
+					    cpm_power_rx_callback, controller);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register CPM RX callback\n");
+
+	/* First, register all domains. */
+	for (i = 0; i < pd_count; i++) {
+		struct cpm_power_domain *pd = &controller->pds[i];
+
+		ret = pm_genpd_init(&pd->genpd, NULL, !atomic_read(&pd->state));
+		if (ret) {
+			dev_err(dev, "%s: failed to init power domain\n",
+				pd->name);
+			return ret;
+		}
+
+		ret = devm_add_action_or_reset(dev, cpm_genpd_remove_action, &pd->genpd);
+		if (ret)
+			return ret;
+
+		controller->pd_data.domains[i] = &pd->genpd;
+	}
+
+	/* Next, link subdomains to their parents. */
+	for (i = 0; i < pd_count; i++) {
+		struct cpm_power_domain *pd = &controller->pds[i];
+		struct cpm_power_domain *parent_pd;
+
+		/* LPB is only used for top-level domains. */
+		if (pd->type == CPM_PD_LPB)
+			continue;
+
+		parent_pd = cpm_find_pd_by_id(controller, pd->parent_id);
+		if (!parent_pd) {
+			dev_err(dev, "failed to find parent for %s\n", pd->name);
+			return -EINVAL;
+		}
+		ret = pm_genpd_add_subdomain(&parent_pd->genpd, &pd->genpd);
+		if (ret) {
+			dev_err(dev, "failed to add subdomain %s to %s: %d\n",
+				pd->name, parent_pd->name, ret);
+			return ret;
+		}
+		ret = devm_add_action_or_reset(dev, cpm_genpd_remove_subdomain_action, pd);
+		if (ret)
+			return ret;
+	}
+
+	ret = of_genpd_add_provider_onecell(dev->of_node, &controller->pd_data);
+	if (ret) {
+		dev_err(dev, "failed to add genpd provider: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void cpm_power_remove(struct auxiliary_device *auxdev)
+{
+	of_genpd_del_provider(auxdev->dev.of_node);
+}
+
+static const struct auxiliary_device_id cpm_power_id_table[] = {
+	{ .name = "google_cpm_mba.power-controller" },
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, cpm_power_id_table);
+
+static struct auxiliary_driver cpm_power_driver = {
+	.probe = cpm_power_probe,
+	.remove = cpm_power_remove,
+	.name = "cpm-power-controller",
+	.id_table = cpm_power_id_table,
+};
+module_auxiliary_driver(cpm_power_driver);
+
+MODULE_DESCRIPTION("Google Tensor CPM power controller driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/pmdomain/google/cpm-power.h b/drivers/pmdomain/google/cpm-power.h
new file mode 100644
index 000000000000..2453a8c52fc0
--- /dev/null
+++ b/drivers/pmdomain/google/cpm-power.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2023-2026 Google LLC
+ */
+
+#ifndef _GOOGLE_CPM_POWER_H
+#define _GOOGLE_CPM_POWER_H
+
+#include <linux/types.h>
+
+enum cpm_pd_type {
+	CPM_PD_LPB = 1,
+	CPM_PD_LPCM,
+	CPM_PD_SMC,
+};
+
+struct cpm_power_domain_desc {
+	const char *name;
+	enum cpm_pd_type type;
+	union {
+		int lpb_id;	/* SSWRP ID for LPB service */
+		int lpcm_id;	/* SSWRP ID for LPCM service */
+		int smc_id;	/* SSWRP ID for SMC */
+	};
+	/* Subdomain ID (ignored for CPM_PD_LPB). */
+	int subdomain_id;
+	/* GENPD_FLAG_* to apply. */
+	u32 flags;
+	/* Signifies that the power domain is already on at boot time. */
+	bool on_at_init;
+	/* Parent domain ID (ignored for CPM_PD_LPB). */
+	int parent_id;
+};
+
+struct cpm_power_desc {
+	const struct cpm_power_domain_desc *domains;
+	size_t num_domains;
+};
+
+extern const struct cpm_power_desc lga_cpm_power_desc;
+
+#endif /* _GOOGLE_CPM_POWER_H */
-- 
2.56.1.831.g720f3f5937-goog

