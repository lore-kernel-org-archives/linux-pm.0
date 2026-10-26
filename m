Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051117;
	b=dB8su2YI06D944bGNJbrg4JHihmFIRrDw/AO499UEen8fsx/q0Z/KW6GYkLeLlzJv9XN
	 S82SCjI3SbIAGL50OLQkwlniBeFKLNNMgIBhFa8RE70qea6s61gEfeYYxwe1qnzzRX0CB
	 oGDBcXMRmduY9CVR434ltf55yq18hXxHrMrB3G7BEuu0pi0PgGS/XloOAkIqp9hRJPYs6
	 Nrac53SGHaBRbH+rstFgX7Z1GIaxg2dZud1EIxaqtI60k1tRaHtqprtQc+7mNMG2ePxxm
	 vGP7ORvLte7AcYTQSseGEUVmVfPT8PwdweAY2I8SCnscgEQeqL/wNnNlzewuwQRfmCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051117;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8HHe8fHh/yiT7Fx1i3J5r8F+lWtO95Ns+WYgR64n+Jc=;
	b=pCc+aojJcpa66JKPXlVTkk+5LqySvfdrZav2uZd6Zl1USdAshiXG1qr9N+pOxX3S3YRy
	 AUUGwLIX6KsUX40B+qJS406NE/p7slKttZrgV3WdDp8PQFR50boBdKLq+6C3/vHRZFuzV
	 cxN+9KjdpbvE4C0AWXTrnRcowS5OG6d8MEEM1YmJBM7dcNbTvNoZVe+H/3v805yGj8l/w
	 TO71XCoptG+WCWipqGsdQDJUgvxhVDSSWS3E7JhSOaEqMy+i2NBUN8GTceKGkC55Gd4D7
	 8hIVfCU7SUtgkrjbJbTthujOeKaKP4QGz+I3+oolpiSmjr/RuEtWTn+R2AuuDLkbvwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="oP1zXRs/";
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EF0606A336
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 21:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27EF0606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=oP1zXRs/
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-369f33df08eso3921203eec.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 14:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793051115; x=1793655915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8HHe8fHh/yiT7Fx1i3J5r8F+lWtO95Ns+WYgR64n+Jc=;
        b=oP1zXRs/+XfALqCF/zU1xfM0Wqua+g9IA4i+1ZM3HgniWYSa8KLMj6lf2VZVX4j+w+
         mVF4uOnkuKujlqZRBrJlJ7npxNYKAVWkfdaIz5GYhs9JNEXwlqRo4zTGa0v7n2XPeic7
         Z1/Gg1e/r0fVQujm3Q/iKI5k73AC53VqF+Tm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793051115; x=1793655915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8HHe8fHh/yiT7Fx1i3J5r8F+lWtO95Ns+WYgR64n+Jc=;
        b=EFXDy3RZ32oq5dTYAqaOCe8SJ0HsSVEsG3vPzF9d8o4ehnWlcilbw2P+r/M7xMLHEi
         BynyUyjqlDodo+t10LNnXsjKf8L+SDH8cgOnhiqVxOoM3OZdooBn/RPn5f9j5ND9IZt2
         UtauZHpMNBd1wISrfyU8wLVFmcVux34uTn6cR4lqefPGu2XTYmo9y9vk0VwR9S7C4GDj
         mtvPuFZq/3BsE7Lzd5pQaRYyCu0sS6GsA/ARC9p2Sz9huRzJOouxUxBk6FsT0VjOR/6I
         GGW7dfaQVBSlIySpITPBXDW5R6duUdyt0yqD+5f+AydsVNTw5fkn0EQZajooDgVjuhVN
         7b0w==
X-Forwarded-Encrypted: i=1; AKwUvByYmYTbXNVsUg7ab3u0V9yMuAWdnrXZob8kWnffsevcfokGQkwo/x29lR4xQ0GgR8oo65LmZFWuqQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLIkY940uzSIKYkjWI6DVwnTrnKEn1hlREQke3oV5pNonS+StTi
	2wOBviMoBMtXNLp0EcJwyzaRdM1QzYqdmntOjc197IJXHSt0KXk/jaCxG+dtMQcN4g==
X-Gm-Gg: AYBFou3DOURWRO8odOFZtT/AmBt0iizI9pLk2bmaMbKjzUxdR2QPN7uOEtVp+bUBx6G
	ijbuBK3FW6R5rqQvKG+mh4OatfkeuNL0uM0SnGlA55cryZZPvXx5JWhZVGTwPzUuJ5pWHt2/+Hf
	VVWOQJAuU8yERGgOLww1NgIdoPUEOsXU5X62GGvJUi4Zq714v0II/fwxXKD3a1DcYzYkvgEKHYM
	TCmW0p+RhezxwCME5cDEBN8KPNKxAi2SVhM2VpFZTtVRxUMq/anEujTDHY1TxLTEIxhePcIel9i
	Z4FuyBy3Tb2BaFra6LkuT1Rh8AjWSTYf2jKLO9e2ToeNO9XK59+hVDpTzUPTI8nFWTDkg72Ill6
	QHxczzr2dsHb9srScdEtZcEsiYQLnPa2ciNp4/ZqeAiK4zX8nzjMxk1tXXNZiVc49JSXWY4YOq/
	8p/j3RcvhWr31orkcxxaPv277aeqZnCOI29bEHJ9IEEJIOW/NWRkf1ttHrv4XyWi5vlsw1noXW2
	/fq9bRI0hzY9jtHooUKDepZbcxKplUA20a+LBWx0lP5TfYV1VXFj6Y5Vqp1AhjL4jCYAfh85/uv
	xLOVOoE53eW6Vbo4WxgWJaNFOKxoxqKRm85IZ19v
X-Received: by 2002:a05:7300:4706:b0:369:f05d:6c67 with SMTP id 5a478bee46e88-369f05d6ea9mr9632627eec.12.1793051114716;
        Mon, 26 Oct 2026 14:45:14 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:79c5:9cd3:db14:7468])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-369e8ec864fsm33474769eec.24.2026.10.26.14.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 14:45:14 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Peter Griffin <peter.griffin@linaro.org>,
	devicetree@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	linux-samsung-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Radu Rendec <radu@rendec.net>,
	linux-arm-kernel@lists.infradead.org,
	Mariano Marciello <mmarciello@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-clk@vger.kernel.org,
	=?UTF-8?q?Jakub=20G=C5=82owacki?= <jglow@google.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 4/9] pmdomain: google: Add CPM power-domain driver
Date: Mon, 26 Oct 2026 14:43:42 -0700
Message-ID: <20261026144346.4.I42273470eab028b2ae2e128d338783b5bdcb4e55@changeid>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261026214359.3122870-1-briannorris@chromium.org>
References: <20261026214359.3122870-1-briannorris@chromium.org>
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

 * Make our debugfs file readable (downstream has read/write operations,
   but leaves it mode 0220)

 * Replace a downstream "GENPD_FLAG_ALWAYS_ON" (but only during system
   suspend) feature with simply applying GENPD_FLAG_ACTIVE_WAKEUP to the
   SSWRP_AOC domain. This domain is for an "Always On Compute" subsystem
   on the SoC, but it also can be powered off temporarily for reset or
   similar. Any drivers for this component should simply manage its
   wakeup status properly, to ensure it stays "on" in the appropriate
   system suspend states.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/pmdomain/Kconfig                  |   1 +
 drivers/pmdomain/Makefile                 |   1 +
 drivers/pmdomain/google/Kconfig           |  14 +
 drivers/pmdomain/google/Makefile          |   2 +
 drivers/pmdomain/google/cpm-power-lga.h   | 467 ++++++++++++++++
 drivers/pmdomain/google/cpm-power-trace.h |  80 +++
 drivers/pmdomain/google/cpm-power.c       | 637 ++++++++++++++++++++++
 drivers/pmdomain/google/lpb_service.h     | 200 +++++++
 8 files changed, 1402 insertions(+)
 create mode 100644 drivers/pmdomain/google/Kconfig
 create mode 100644 drivers/pmdomain/google/Makefile
 create mode 100644 drivers/pmdomain/google/cpm-power-lga.h
 create mode 100644 drivers/pmdomain/google/cpm-power-trace.h
 create mode 100644 drivers/pmdomain/google/cpm-power.c
 create mode 100644 drivers/pmdomain/google/lpb_service.h

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
index 000000000000..34ea111208df
--- /dev/null
+++ b/drivers/pmdomain/google/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_GOOGLE_CPM_POWER) += cpm-power.o
diff --git a/drivers/pmdomain/google/cpm-power-lga.h b/drivers/pmdomain/google/cpm-power-lga.h
new file mode 100644
index 000000000000..fc006aeb5cfe
--- /dev/null
+++ b/drivers/pmdomain/google/cpm-power-lga.h
@@ -0,0 +1,467 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2023-2026 Google LLC
+ */
+#ifndef _CPM_POWER_LGA_H
+#define _CPM_POWER_LGA_H
+
+#include <dt-bindings/power/google,lga-cpm.h>
+#include <linux/kernel.h>
+#include <linux/pm_domain.h>
+#include <linux/types.h>
+
+#include "lpb_service.h"
+
+#define NOT_SUPPORTED				-1
+
+/* CPM Mapping Definitions */
+enum cpm_lga_sswrp_id {
+	CPM_LGA_SSWRP_AOC_ID,
+	CPM_LGA_SSWRP_AURORA_ID,
+	CPM_LGA_SSWRP_CODEC_3P_ID,
+	CPM_LGA_SSWRP_CPU_ID,
+	CPM_LGA_SSWRP_CPUACC_ID,
+	CPM_LGA_SSWRP_DPU_ID,
+	CPM_LGA_SSWRP_EH_ID,
+	CPM_LGA_SSWRP_FABHBW_ID,
+	CPM_LGA_SSWRP_FABMED_ID,
+	CPM_LGA_SSWRP_FABRT_ID,
+	CPM_LGA_SSWRP_FABSTBY_ID,
+	CPM_LGA_SSWRP_FABSYSS_ID,
+	CPM_LGA_SSWRP_G2D_ID,
+	CPM_LGA_SSWRP_GMC0_ID,
+	CPM_LGA_SSWRP_GMC1_ID,
+	CPM_LGA_SSWRP_GMC2_ID,
+	CPM_LGA_SSWRP_GMC3_ID,
+	CPM_LGA_SSWRP_GPCA_ID,
+	CPM_LGA_SSWRP_GPCM_ID,
+	CPM_LGA_SSWRP_GPDMA_ID,
+	CPM_LGA_SSWRP_GPU_ID,
+	CPM_LGA_SSWRP_GSA_ID,
+	CPM_LGA_SSWRP_GSW_ID,
+	CPM_LGA_SSWRP_HSIO_N_ID,
+	CPM_LGA_SSWRP_HSIO_S_ID,
+	CPM_LGA_SSWRP_INF_TCU_ID,
+	CPM_LGA_SSWRP_ISPBE_ID,
+	CPM_LGA_SSWRP_ISPFE_ID,
+	CPM_LGA_SSWRP_LSIO_E_ID,
+	CPM_LGA_SSWRP_LSIO_N_ID,
+	CPM_LGA_SSWRP_LSIO_S_ID,
+	CPM_LGA_SSWRP_MEMSS_ID,
+	CPM_LGA_SSWRP_TPU_ID,
+	CPM_LGA_SSWRP_COUNT,
+};
+
+#define CPM_LGA_GPU_CORE_LOGIC_ID		0
+
+#define CPM_LGA_HSIO_N_USB_ID			0
+#define CPM_LGA_HSIO_N_PCIE_ID			1
+#define CPM_LGA_HSIO_N_EBU_ID			2
+#define CPM_LGA_HSIO_N_EBU_CORE_ID		3
+#define CPM_LGA_HSIO_N_DP_ID			4
+#define CPM_LGA_HSIO_N_USB_PSW_ID		5
+
+#define CPM_LGA_HSIO_S_UFS_ID			0
+#define CPM_LGA_HSIO_S_PCIE_ID			1
+#define CPM_LGA_HSIO_S_SD_ID			2
+#define CPM_HSIO_S_UFS_PREP_ID			3
+
+#define CPM_LGA_LSIO_CLI_GPIO_ID		0
+
+#define CPM_LGA_DPU_FE0_ID			0
+#define CPM_LGA_DPU_FE1_ID			1
+#define CPM_LGA_DPU_DSI0_ID			2
+#define CPM_LGA_DPU_DSI1_ID			3
+#define CPM_LGA_DPU_DP_ID			4
+
+#define CPM_LGA_ISPFE_TOP_ID			0
+#define CPM_LGA_ISPFE_PIPE_ID			1
+#define CPM_LGA_ISPFE_CSIS_ID			2
+#define CPM_LGA_ISPBE_TOP_ID			0
+
+#define CPM_LGA_GSW_MAIN_ID			0
+
+#define CPM_LGA_G2D_CORE_ID			0
+
+#define CPM_LGA_C3P_CORE_ID			0
+
+#define CPM_LGA_GPDMA_ID			0
+
+#define CPM_LGA_INF_TCU_ID			0
+
+#define CPM_LGA_AOC_CORE_ID			0
+
+struct cpm_power_domain_desc {
+	const char *name;
+	int sswrp_id;
+	int subdomain_id;
+	/* GENPD_FLAG_* to apply. */
+	u32 flags;
+	/* Signifies that the power domain is already on at boot time. */
+	bool on_at_init;
+	/* Control the power domain via SMC calls instead of CPM requests. */
+	bool use_smc;
+	/* Use NOT_SUPPORTED for top-level (SSWRP) domains. */
+	int parent_id;
+};
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
+static const int lga_sswrp_to_lpb[CPM_LGA_SSWRP_COUNT] = {
+	[CPM_LGA_SSWRP_AOC_ID]			= LPB_SERVICE_AOC_ID,
+	[CPM_LGA_SSWRP_AURORA_ID]		= LPB_SERVICE_AURORA_ID,
+	[CPM_LGA_SSWRP_CODEC_3P_ID]		= LPB_SERVICE_CODEC_3P_ID,
+	[CPM_LGA_SSWRP_CPU_ID]			= LPB_SERVICE_CPU_ID,
+	[CPM_LGA_SSWRP_CPUACC_ID]		= LPB_SERVICE_CPUACC_ID,
+	[CPM_LGA_SSWRP_DPU_ID]			= LPB_SERVICE_DPU_ID,
+	[CPM_LGA_SSWRP_EH_ID]			= LPB_SERVICE_EH_ID,
+	[CPM_LGA_SSWRP_FABHBW_ID]		= LPB_SERVICE_FABHBW_ID,
+	[CPM_LGA_SSWRP_FABMED_ID]		= LPB_SERVICE_FABMED_ID,
+	[CPM_LGA_SSWRP_FABRT_ID]		= LPB_SERVICE_FABRT_ID,
+	[CPM_LGA_SSWRP_FABSTBY_ID]		= LPB_SERVICE_FABSTBY_ID,
+	[CPM_LGA_SSWRP_FABSYSS_ID]		= LPB_SERVICE_FABSYSS_ID,
+	[CPM_LGA_SSWRP_G2D_ID]			= LPB_SERVICE_G2D_ID,
+	[CPM_LGA_SSWRP_GMC0_ID]			= LPB_SERVICE_GMC0_ID,
+	[CPM_LGA_SSWRP_GMC1_ID]			= LPB_SERVICE_GMC1_ID,
+	[CPM_LGA_SSWRP_GMC2_ID]			= LPB_SERVICE_GMC2_ID,
+	[CPM_LGA_SSWRP_GMC3_ID]			= LPB_SERVICE_GMC3_ID,
+	[CPM_LGA_SSWRP_GPCA_ID]			= LPB_SERVICE_GPCA_ID,
+	[CPM_LGA_SSWRP_GPCM_ID]			= LPB_SERVICE_GPCM_ID,
+	[CPM_LGA_SSWRP_GPDMA_ID]		= LPB_SERVICE_GPDMA_ID,
+	[CPM_LGA_SSWRP_GPU_ID]			= LPB_SERVICE_GPU_ID,
+	[CPM_LGA_SSWRP_GSA_ID]			= LPB_SERVICE_GSA_ID,
+	[CPM_LGA_SSWRP_GSW_ID]			= LPB_SERVICE_GSW_ID,
+	[CPM_LGA_SSWRP_HSIO_N_ID]		= LPB_SERVICE_HSIO_N_ID,
+	[CPM_LGA_SSWRP_HSIO_S_ID]		= LPB_SERVICE_HSIO_S_ID,
+	[CPM_LGA_SSWRP_INF_TCU_ID]		= LPB_SERVICE_INF_TCU_ID,
+	[CPM_LGA_SSWRP_ISPBE_ID]		= LPB_SERVICE_ISPBE_ID,
+	[CPM_LGA_SSWRP_ISPFE_ID]		= LPB_SERVICE_ISPFE_ID,
+	[CPM_LGA_SSWRP_LSIO_E_ID]		= LPB_SERVICE_LSIO_E_ID,
+	[CPM_LGA_SSWRP_LSIO_N_ID]		= LPB_SERVICE_LSIO_N_ID,
+	[CPM_LGA_SSWRP_LSIO_S_ID]		= LPB_SERVICE_LSIO_S_ID,
+	[CPM_LGA_SSWRP_MEMSS_ID]		= LPB_SERVICE_MEMSS_ID,
+	[CPM_LGA_SSWRP_TPU_ID]			= LPB_SERVICE_TPU_ID,
+};
+
+static const int lga_sswrp_to_lpcm[CPM_LGA_SSWRP_COUNT] = {
+	[CPM_LGA_SSWRP_AOC_ID]			= LPCM_GENPD_SSWRP_AOC,
+	[CPM_LGA_SSWRP_AURORA_ID]		= NOT_SUPPORTED,
+	[CPM_LGA_SSWRP_CODEC_3P_ID]		= NOT_SUPPORTED,
+	[CPM_LGA_SSWRP_CPU_ID]			= NOT_SUPPORTED,
+	[CPM_LGA_SSWRP_CPUACC_ID]		= NOT_SUPPORTED,
+	[CPM_LGA_SSWRP_DPU_ID]			= LPCM_GENPD_SSWRP_DPU,
+	[CPM_LGA_SSWRP_EH_ID]			= NOT_SUPPORTED,
+	[CPM_LGA_SSWRP_FABHBW_ID]		= NOT_SUPPORTED,
+	[CPM_LGA_SSWRP_FABMED_ID]		= NOT_SUPPORTED,
+	[CPM_LGA_SSWRP_FABRT_ID]		= NOT_SUPPORTED,
+	[CPM_LGA_SSWRP_FABSTBY_ID]		= NOT_SUPPORTED,
+	[CPM_LGA_SSWRP_FABSYSS_ID]		= NOT_SUPPORTED,
+	[CPM_LGA_SSWRP_G2D_ID]			= LPCM_GENPD_SSWRP_G2D,
+	[CPM_LGA_SSWRP_GMC0_ID]			= NOT_SUPPORTED,
+	[CPM_LGA_SSWRP_GMC1_ID]			= NOT_SUPPORTED,
+	[CPM_LGA_SSWRP_GMC2_ID]			= NOT_SUPPORTED,
+	[CPM_LGA_SSWRP_GMC3_ID]			= NOT_SUPPORTED,
+	[CPM_LGA_SSWRP_GPCA_ID]			= NOT_SUPPORTED,
+	[CPM_LGA_SSWRP_GPCM_ID]			= NOT_SUPPORTED,
+	[CPM_LGA_SSWRP_GPDMA_ID]		= LPCM_GENPD_SSWRP_GPDMA,
+	[CPM_LGA_SSWRP_GPU_ID]			= NOT_SUPPORTED,
+	[CPM_LGA_SSWRP_GSA_ID]			= NOT_SUPPORTED,
+	[CPM_LGA_SSWRP_GSW_ID]			= NOT_SUPPORTED,
+	[CPM_LGA_SSWRP_HSIO_N_ID]		= LPCM_GENPD_SSWRP_HSIO_N,
+	[CPM_LGA_SSWRP_HSIO_S_ID]		= LPCM_GENPD_SSWRP_HSIO_S,
+	[CPM_LGA_SSWRP_INF_TCU_ID]		= NOT_SUPPORTED,
+	[CPM_LGA_SSWRP_ISPBE_ID]		= NOT_SUPPORTED,
+	[CPM_LGA_SSWRP_ISPFE_ID]		= LPCM_GENPD_SSWRP_ISPFE,
+	[CPM_LGA_SSWRP_LSIO_E_ID]		= LPCM_GENPD_SSWRP_LSIO_E,
+	[CPM_LGA_SSWRP_LSIO_N_ID]		= LPCM_GENPD_SSWRP_LSIO_N,
+	[CPM_LGA_SSWRP_LSIO_S_ID]		= LPCM_GENPD_SSWRP_LSIO_S,
+	[CPM_LGA_SSWRP_MEMSS_ID]		= NOT_SUPPORTED,
+	[CPM_LGA_SSWRP_TPU_ID]			= NOT_SUPPORTED,
+};
+
+static const struct cpm_power_domain_desc lga_pm_domains[] = {
+	[LGA_PD_SSWRP_AOC] = {
+		.name = "sswrp-aoc-pd",
+		.sswrp_id = CPM_LGA_SSWRP_AOC_ID,
+		.subdomain_id = NOT_SUPPORTED,
+		.flags = GENPD_FLAG_ACTIVE_WAKEUP,
+		.on_at_init = true,
+		.parent_id = NOT_SUPPORTED,
+	},
+	[LGA_PD_AOC_CORE] = {
+		.name = "aoc-core-pd",
+		.sswrp_id = CPM_LGA_SSWRP_AOC_ID,
+		.subdomain_id = CPM_LGA_AOC_CORE_ID,
+		.on_at_init = true,
+		.parent_id = LGA_PD_SSWRP_AOC,
+	},
+	[LGA_PD_SSWRP_AURORA] = {
+		.name = "sswrp-aurora-pd",
+		.sswrp_id = CPM_LGA_SSWRP_AURORA_ID,
+		.subdomain_id = NOT_SUPPORTED,
+		.parent_id = NOT_SUPPORTED,
+	},
+	[LGA_PD_SSWRP_CODEC_3P] = {
+		.name = "sswrp-codec-3p-pd",
+		.sswrp_id = CPM_LGA_SSWRP_CODEC_3P_ID,
+		.subdomain_id = NOT_SUPPORTED,
+		.parent_id = NOT_SUPPORTED,
+	},
+	[LGA_PD_DPU_DP] = {
+		.name = "dpu-dp-pd",
+		.sswrp_id = CPM_LGA_SSWRP_DPU_ID,
+		.subdomain_id = CPM_LGA_DPU_DP_ID,
+		.parent_id = LGA_PD_SSWRP_DPU,
+	},
+	[LGA_PD_SSWRP_DPU] = {
+		.name = "sswrp-dpu-pd",
+		.sswrp_id = CPM_LGA_SSWRP_DPU_ID,
+		.subdomain_id = NOT_SUPPORTED,
+		.parent_id = NOT_SUPPORTED,
+	},
+	[LGA_PD_DPU_FE0] = {
+		.name = "dpu-fe0-pd",
+		.sswrp_id = CPM_LGA_SSWRP_DPU_ID,
+		.subdomain_id = CPM_LGA_DPU_FE0_ID,
+		.parent_id = LGA_PD_DPU_DSI0,
+	},
+	[LGA_PD_DPU_FE1] = {
+		.name = "dpu-fe1-pd",
+		.sswrp_id = CPM_LGA_SSWRP_DPU_ID,
+		.subdomain_id = CPM_LGA_DPU_FE1_ID,
+		.parent_id = LGA_PD_DPU_FE0,
+	},
+	[LGA_PD_DPU_DSI0] = {
+		.name = "dpu-dsi0-pd",
+		.sswrp_id = CPM_LGA_SSWRP_DPU_ID,
+		.subdomain_id = CPM_LGA_DPU_DSI0_ID,
+		.parent_id = LGA_PD_SSWRP_DPU,
+	},
+	[LGA_PD_DPU_DSI1] = {
+		.name = "dpu-dsi1-pd",
+		.sswrp_id = CPM_LGA_SSWRP_DPU_ID,
+		.subdomain_id = CPM_LGA_DPU_DSI1_ID,
+		.parent_id = LGA_PD_SSWRP_DPU,
+	},
+	[LGA_PD_SSWRP_EH] = {
+		.name = "sswrp-eh-pd",
+		.sswrp_id = CPM_LGA_SSWRP_EH_ID,
+		.subdomain_id = NOT_SUPPORTED,
+		.parent_id = NOT_SUPPORTED,
+	},
+	[LGA_PD_SSWRP_G2D] = {
+		.name = "sswrp-g2d-pd",
+		.sswrp_id = CPM_LGA_SSWRP_G2D_ID,
+		.subdomain_id = NOT_SUPPORTED,
+		.parent_id = NOT_SUPPORTED,
+	},
+	[LGA_PD_G2D_CORE] = {
+		.name = "g2d-core-pd",
+		.sswrp_id = CPM_LGA_SSWRP_G2D_ID,
+		.subdomain_id = CPM_LGA_G2D_CORE_ID,
+		.parent_id = LGA_PD_SSWRP_G2D,
+	},
+	[LGA_PD_SSWRP_GPDMA] = {
+		.name = "sswrp-gpdma-pd",
+		.sswrp_id = CPM_LGA_SSWRP_GPDMA_ID,
+		.subdomain_id = NOT_SUPPORTED,
+		.on_at_init = true,
+		.parent_id = NOT_SUPPORTED,
+	},
+	[LGA_PD_SSWRP_GPU] = {
+		.name = "sswrp-gpu-pd",
+		.sswrp_id = CPM_LGA_SSWRP_GPU_ID,
+		.subdomain_id = NOT_SUPPORTED,
+		.parent_id = NOT_SUPPORTED,
+	},
+	[LGA_PD_SSWRP_GSW] = {
+		.name = "sswrp-gsw-pd",
+		.sswrp_id = CPM_LGA_SSWRP_GSW_ID,
+		.subdomain_id = NOT_SUPPORTED,
+		.parent_id = NOT_SUPPORTED,
+	},
+	[LGA_PD_SSWRP_HSIO_N] = {
+		.name = "sswrp-hsio-n-pd",
+		.sswrp_id = CPM_LGA_SSWRP_HSIO_N_ID,
+		.subdomain_id = NOT_SUPPORTED,
+		.on_at_init = true,
+		.parent_id = NOT_SUPPORTED,
+	},
+	[LGA_PD_HSIO_N_USB] = {
+		.name = "hsio-n-usb-pd",
+		.sswrp_id = CPM_LGA_SSWRP_HSIO_N_ID,
+		.subdomain_id = CPM_LGA_HSIO_N_USB_ID,
+		.flags = GENPD_FLAG_ACTIVE_WAKEUP,
+		.on_at_init = true,
+		.parent_id = LGA_PD_SSWRP_HSIO_N,
+	},
+	[LGA_PD_HSIO_N_USB_PSW] = {
+		.name = "hsio-n-usb-psw-pd",
+		.sswrp_id = CPM_LGA_SSWRP_HSIO_N_ID,
+		.subdomain_id = CPM_LGA_HSIO_N_USB_PSW_ID,
+		.flags = GENPD_FLAG_ACTIVE_WAKEUP,
+		.on_at_init = true,
+		.parent_id = LGA_PD_HSIO_N_USB,
+	},
+	[LGA_PD_HSIO_N_PCIE] = {
+		.name = "hsio-n-pcie-pd",
+		.sswrp_id = CPM_LGA_SSWRP_HSIO_N_ID,
+		.subdomain_id = CPM_LGA_HSIO_N_PCIE_ID,
+		.flags = GENPD_FLAG_ACTIVE_WAKEUP,
+		.parent_id = LGA_PD_SSWRP_HSIO_N,
+	},
+	[LGA_PD_HSIO_N_DP] = {
+		.name = "hsio-n-dp-pd",
+		.sswrp_id = CPM_LGA_SSWRP_HSIO_N_ID,
+		.subdomain_id = CPM_LGA_HSIO_N_DP_ID,
+		.parent_id = LGA_PD_HSIO_N_USB_PSW,
+	},
+	[LGA_PD_HSIO_N_EBU] = {
+		.name = "hsio-n-ebu-pd",
+		.sswrp_id = CPM_LGA_SSWRP_HSIO_N_ID,
+		.subdomain_id = CPM_LGA_HSIO_N_EBU_ID,
+		.parent_id = LGA_PD_HSIO_N_USB,
+	},
+	[LGA_PD_HSIO_N_EBU_CORE] = {
+		.name = "hsio-n-ebu-core-pd",
+		.sswrp_id = CPM_LGA_SSWRP_HSIO_N_ID,
+		.subdomain_id = CPM_LGA_HSIO_N_EBU_CORE_ID,
+		.parent_id = LGA_PD_HSIO_N_EBU,
+	},
+	[LGA_PD_SSWRP_HSIO_S] = {
+		.name = "sswrp-hsio-s-pd",
+		.sswrp_id = CPM_LGA_SSWRP_HSIO_S_ID,
+		.subdomain_id = NOT_SUPPORTED,
+		.flags = GENPD_FLAG_RPM_ALWAYS_ON,
+		.on_at_init = true,
+		.parent_id = NOT_SUPPORTED,
+	},
+	[LGA_PD_HSIO_S_UFS_PREP] = {
+		.name = "hsio-s-ufs-prep-pd",
+		.sswrp_id = CPM_LGA_SSWRP_HSIO_S_ID,
+		.subdomain_id = CPM_HSIO_S_UFS_PREP_ID,
+		.on_at_init = true,
+		.parent_id = LGA_PD_SSWRP_HSIO_S,
+	},
+	[LGA_PD_HSIO_S_UFS] = {
+		.name = "hsio-s-ufs-pd",
+		.sswrp_id = CPM_LGA_SSWRP_HSIO_S_ID,
+		.subdomain_id = CPM_LGA_HSIO_S_UFS_ID,
+		.flags = GENPD_FLAG_RPM_ALWAYS_ON,
+		.on_at_init = true,
+		.parent_id = LGA_PD_HSIO_S_UFS_PREP,
+	},
+	[LGA_PD_HSIO_S_PCIE] = {
+		.name = "hsio-s-pcie-pd",
+		.sswrp_id = CPM_LGA_SSWRP_HSIO_S_ID,
+		.subdomain_id = CPM_LGA_HSIO_S_PCIE_ID,
+		.parent_id = LGA_PD_SSWRP_HSIO_S,
+	},
+	[LGA_PD_HSIO_S_SD] = {
+		.name = "hsio-s-sd-pd",
+		.sswrp_id = CPM_LGA_SSWRP_HSIO_S_ID,
+		.subdomain_id = CPM_LGA_HSIO_S_SD_ID,
+		.parent_id = LGA_PD_HSIO_S_UFS,
+	},
+	[LGA_PD_SSWRP_ISPBE] = {
+		.name = "sswrp-ispbe-pd",
+		.sswrp_id = CPM_LGA_SSWRP_ISPBE_ID,
+		.subdomain_id = NOT_SUPPORTED,
+		.parent_id = NOT_SUPPORTED,
+	},
+	[LGA_PD_SSWRP_ISPFE] = {
+		.name = "sswrp-ispfe-pd",
+		.sswrp_id = CPM_LGA_SSWRP_ISPFE_ID,
+		.subdomain_id = NOT_SUPPORTED,
+		.parent_id = NOT_SUPPORTED,
+	},
+	[LGA_PD_ISPFE_PIPE] = {
+		.name = "ispfe-pipe-pd",
+		.sswrp_id = CPM_LGA_SSWRP_ISPFE_ID,
+		.subdomain_id = CPM_LGA_ISPFE_PIPE_ID,
+		.parent_id = LGA_PD_SSWRP_ISPFE,
+	},
+	[LGA_PD_ISPFE_CSIS] = {
+		.name = "ispfe-csis-pd",
+		.sswrp_id = CPM_LGA_SSWRP_ISPFE_ID,
+		.subdomain_id = CPM_LGA_ISPFE_CSIS_ID,
+		.parent_id = LGA_PD_SSWRP_ISPFE,
+	},
+	[LGA_PD_SSWRP_LSIO_E] = {
+		.name = "sswrp-lsio-e-pd",
+		.sswrp_id = CPM_LGA_SSWRP_LSIO_E_ID,
+		.subdomain_id = NOT_SUPPORTED,
+		.flags = GENPD_FLAG_RPM_ALWAYS_ON,
+		.on_at_init = true,
+		.parent_id = NOT_SUPPORTED,
+	},
+	[LGA_PD_LSIO_E_CLI_GPIO] = {
+		.name = "lsio-e-cli-gpio-pd",
+		.sswrp_id = CPM_LGA_SSWRP_LSIO_E_ID,
+		.subdomain_id = CPM_LGA_LSIO_CLI_GPIO_ID,
+		.flags = GENPD_FLAG_RPM_ALWAYS_ON,
+		.on_at_init = true,
+		.use_smc = true,
+		.parent_id = LGA_PD_SSWRP_LSIO_E,
+	},
+	[LGA_PD_SSWRP_LSIO_N] = {
+		.name = "sswrp-lsio-n-pd",
+		.sswrp_id = CPM_LGA_SSWRP_LSIO_N_ID,
+		.subdomain_id = NOT_SUPPORTED,
+		.on_at_init = true,
+		.parent_id = NOT_SUPPORTED,
+	},
+	[LGA_PD_LSIO_N_CLI_GPIO] = {
+		.name = "lsio-n-cli-gpio-pd",
+		.sswrp_id = CPM_LGA_SSWRP_LSIO_N_ID,
+		.subdomain_id = CPM_LGA_LSIO_CLI_GPIO_ID,
+		.on_at_init = true,
+		.parent_id = LGA_PD_SSWRP_LSIO_N,
+	},
+	[LGA_PD_SSWRP_LSIO_S] = {
+		.name = "sswrp-lsio-s-pd",
+		.sswrp_id = CPM_LGA_SSWRP_LSIO_S_ID,
+		.subdomain_id = NOT_SUPPORTED,
+		.on_at_init = true,
+		.parent_id = NOT_SUPPORTED,
+	},
+	[LGA_PD_LSIO_S_CLI_GPIO] = {
+		.name = "lsio-s-cli-gpio-pd",
+		.sswrp_id = CPM_LGA_SSWRP_LSIO_S_ID,
+		.subdomain_id = CPM_LGA_LSIO_CLI_GPIO_ID,
+		.on_at_init = true,
+		.parent_id = LGA_PD_SSWRP_LSIO_S,
+	},
+	[LGA_PD_SSWRP_TPU] = {
+		.name = "sswrp-tpu-pd",
+		.sswrp_id = CPM_LGA_SSWRP_TPU_ID,
+		.subdomain_id = NOT_SUPPORTED,
+		.flags = GENPD_FLAG_ACTIVE_WAKEUP,
+		.parent_id = NOT_SUPPORTED,
+	},
+};
+
+struct cpm_power_desc {
+	const int *sswrp_to_lpb_ids;
+	const int *sswrp_to_lpcm_ids;
+	const struct cpm_power_domain_desc *domains;
+	size_t num_domains;
+};
+
+static const struct cpm_power_desc lga_cpm_power_desc = {
+	.sswrp_to_lpb_ids = lga_sswrp_to_lpb,
+	.sswrp_to_lpcm_ids = lga_sswrp_to_lpcm,
+	.domains = lga_pm_domains,
+	.num_domains = ARRAY_SIZE(lga_pm_domains),
+};
+
+#endif /* _CPM_POWER_LGA_H */
diff --git a/drivers/pmdomain/google/cpm-power-trace.h b/drivers/pmdomain/google/cpm-power-trace.h
new file mode 100644
index 000000000000..14c4c3c8e7d8
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
+		__entry->sswrp_id = pd->sswrp_id;
+		__entry->subdomain_id = pd->cpm_lpcm_subdomain_id;
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
+		__entry->sswrp_id = pd->sswrp_id;
+		__entry->subdomain_id = pd->cpm_lpcm_subdomain_id;
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
index 000000000000..6dc7a61e30ab
--- /dev/null
+++ b/drivers/pmdomain/google/cpm-power.c
@@ -0,0 +1,637 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2023-2026 Google LLC
+ */
+
+#include <dt-bindings/power/google,lga-cpm.h>
+#include <linux/arm-smccc.h>
+#include <linux/atomic.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/bitfield.h>
+#include <linux/completion.h>
+#include <linux/container_of.h>
+#include <linux/debugfs.h>
+#include <linux/dev_printk.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm_domain.h>
+#include <soc/google/goog_cpm_service_ids.h>
+#include <soc/google/google-cpm-mba.h>
+
+#include "lpb_service.h"
+
+enum power_state {
+	PD_STATE_OFF = 0,
+	PD_STATE_ON = 1,
+	PD_STATE_COUNT,
+};
+
+struct cpm_power_controller;
+
+struct cpm_power_domain {
+	struct cpm_power_controller *controller;
+	struct generic_pm_domain genpd;
+	const char *name;
+	bool is_top_pd;
+	bool use_smc;
+	int id;
+	int sswrp_id;
+	int subdomain_id;
+	int parent_id;
+	atomic_t state;
+	struct completion cpm_resp_done;
+	/*
+	 * SSWRP ID that CPM uses internally has a different value depending on
+	 * |is_top_pd|:
+	 * - for top power domain, it is cpm_lpb_sswrp_id.
+	 * - for sub power domain, it is cpm_lpcm_sswrp_id.
+	 */
+	union {
+		int cpm_lpcm_sswrp_id;
+		int cpm_lpb_sswrp_id;
+	};
+	int cpm_lpcm_subdomain_id;
+};
+
+struct cpm_power_controller {
+	struct device *dev;
+	struct cpm_client *client;
+	struct dentry *debugfs_root;
+	struct cpm_power_domain *pds;
+	u32 pd_count;
+	struct genpd_onecell_data pd_data;
+};
+
+#define CREATE_TRACE_POINTS
+#include "cpm-power-trace.h"
+
+#include "cpm-power-lga.h"
+
+#define LPCM_CMD_SET_GEN_PD	1
+#define POWER_ON_BITFIELD	GENMASK(31, 24)
+#define PD_ID_BITFIELD		GENMASK(23, 16)
+#define SSWRP_ID_BITFIELD	GENMASK(15, 8)
+#define REQ_ID_BITFIELD		GENMASK(7, 0)
+
+#define NO_ERROR		0
+#define LPB_STATUS_ON		3
+#define LPB_STATUS_OFF		0
+#define LPB_EVENT_ON		0
+#define LPB_EVENT_OFF		1
+#define CPM_COMMON_PROT_NO_ERR	15
+
+#define SIP_SVC_PD_CONTROL	0x82000701
+
+#define ON_OFF_STR(x)		((x) ? "power_on" : "power_off")
+
+#define CPM_MBX_SEND_TIMEOUT_MS	3000
+#define CPM_MBX_RECV_TIMEOUT_MS	3000
+
+static inline struct cpm_power_domain *to_power_domain(struct generic_pm_domain *d)
+{
+	return container_of(d, struct cpm_power_domain, genpd);
+}
+
+/*
+ * This callback is triggered when CPM signals the transition has finished.
+ */
+static void cpm_power_rx_callback(u32 context, const struct cpm_payload *msg, void *priv)
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
+		/* For MBA service */
+		if (pc->pds[i].is_top_pd &&
+		    pc->pds[i].cpm_lpb_sswrp_id == resource_sid) {
+			pd = &pc->pds[i];
+			break;
+		}
+	}
+	if (!pd) {
+		dev_err(dev,
+			"cannot find corresponding power domain for ID: %d\n",
+			resource_sid);
+		return;
+	}
+
+	dev_dbg(dev, "%s: power transition completed\n", pd->name);
+	complete(&pd->cpm_resp_done);
+}
+
+static int send_lpb_request(struct cpm_power_domain *pd, enum power_state state)
+{
+	struct device *dev = pd->controller->dev;
+	struct cpm_payload resp_msg;
+	struct cpm_payload req_msg = {};
+	struct cpm_request cpm_req = {
+		.msg_type = REQUEST_MSG,
+		.req_msg = &req_msg,
+		.resp_msg = &resp_msg,
+		.dst_id = CPM_COMMON_LPB_SERVICE,
+		.tout_ms = CPM_MBX_SEND_TIMEOUT_MS,
+	};
+	int ret;
+
+	dev_dbg(dev, "%s: %s: sswrp_id = %d\n", pd->name, ON_OFF_STR(state),
+		pd->cpm_lpb_sswrp_id);
+
+	req_msg.payload[0] = LPB_CMD_SSWRP_STATE_SET;
+	req_msg.payload[1] = pd->cpm_lpb_sswrp_id;
+	req_msg.payload[2] = state;
+
+	reinit_completion(&pd->cpm_resp_done);
+
+	trace_send_mail_lpb(pd, state);
+	ret = cpm_send_message(pd->controller->client, &cpm_req);
+
+	if (ret < 0) {
+		dev_err(dev, "%s: %s: send lpb message failed ret (%d)\n",
+			pd->name, ON_OFF_STR(state), ret);
+
+		return ret;
+	}
+
+	dev_dbg(dev, "%s: %s: lpb response msg %d %d %d\n", pd->name,
+		ON_OFF_STR(state), resp_msg.payload[0], resp_msg.payload[1],
+		resp_msg.payload[2]);
+
+	if (resp_msg.payload[0] != CPM_COMMON_PROT_NO_ERR) {
+		/* We failed completely no additional message is waiting */
+		dev_err(dev, "%s: %s: CPM LPB service failed with err=%d\n",
+			pd->name, ON_OFF_STR(state), resp_msg.payload[0]);
+
+		return -EPROTO;
+	}
+
+	switch (resp_msg.payload[1]) {
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
+
+		ret = wait_for_completion_timeout(&pd->cpm_resp_done,
+						  msecs_to_jiffies(CPM_MBX_RECV_TIMEOUT_MS));
+		if (ret == 0) {
+			dev_err(dev, "%s: %s: wait for CPM response timeout\n",
+				pd->name, ON_OFF_STR(state));
+			ret = -ETIMEDOUT;
+			break;
+		}
+		ret = 0;
+		break;
+	case LPB_SERVICE_CMD_FAIL:
+	default:
+		/* Command got through but the result was failure */
+		dev_err(dev, "%s: %s: CPM LPB services returned fail, err=%d\n",
+			pd->name, ON_OFF_STR(state), resp_msg.payload[1]);
+		ret = -EPROTO;
+		break;
+	}
+
+	trace_recv_result_lpb(pd, state, ret);
+
+	return ret;
+}
+
+static int request_lpb_vote_status(struct generic_pm_domain *genpd)
+{
+	struct cpm_power_domain *pd = to_power_domain(genpd);
+	struct device *dev = pd->controller->dev;
+	struct cpm_payload resp_msg;
+	struct cpm_payload req_msg = {};
+	struct cpm_request cpm_req = {
+		.msg_type = REQUEST_MSG,
+		.req_msg = &req_msg,
+		.resp_msg = &resp_msg,
+		.dst_id = CPM_COMMON_LPB_SERVICE,
+		.tout_ms = CPM_MBX_SEND_TIMEOUT_MS,
+	};
+	int ret;
+
+	if (!pd->is_top_pd) {
+		dev_warn(dev, "%s: Only SSWRP vote status is supported\n",
+			 pd->name);
+		return -EINVAL;
+	}
+
+	req_msg.payload[0] = LPB_CMD_SSWRP_STATE_GET;
+	req_msg.payload[1] = pd->cpm_lpb_sswrp_id;
+
+	ret = cpm_send_message(pd->controller->client, &cpm_req);
+	if (ret < 0) {
+		dev_err(dev, "%s: failed to get SSWRP state, MBA err: %d\n",
+			pd->name, ret);
+		return ret;
+	}
+
+	return resp_msg.payload[1] == LPB_STATUS_ON ? PD_STATE_ON :
+						      PD_STATE_OFF;
+}
+
+static int send_lpcm_request(struct cpm_power_domain *pd, enum power_state state)
+{
+	struct device *dev = pd->controller->dev;
+	struct cpm_payload resp_msg;
+	struct cpm_payload req_msg = {};
+	struct cpm_request cpm_req = {
+		.msg_type = REQUEST_MSG,
+		.req_msg = &req_msg,
+		.resp_msg = &resp_msg,
+		.dst_id = CPM_COMMON_LPCM_SERVICE,
+		.tout_ms = CPM_MBX_SEND_TIMEOUT_MS,
+	};
+	int ret;
+
+	if (pd->cpm_lpcm_sswrp_id == NOT_SUPPORTED) {
+		dev_err(dev,
+			"%s: %s: ID %d is not supported by LPCM service\n",
+			pd->name, ON_OFF_STR(state), pd->sswrp_id);
+		return -EPROTONOSUPPORT;
+	}
+
+	dev_dbg(dev, "%s: %s: lpcm_id = %d\n", pd->name, ON_OFF_STR(state),
+		pd->cpm_lpcm_sswrp_id);
+	req_msg.payload[0] =
+		FIELD_PREP(REQ_ID_BITFIELD, LPCM_CMD_SET_GEN_PD) |
+		FIELD_PREP(SSWRP_ID_BITFIELD, pd->cpm_lpcm_sswrp_id) |
+		FIELD_PREP(PD_ID_BITFIELD, pd->cpm_lpcm_subdomain_id) |
+		FIELD_PREP(POWER_ON_BITFIELD, state);
+
+	trace_send_mail_lpcm(pd, state);
+	ret = cpm_send_message(pd->controller->client, &cpm_req);
+	trace_recv_result_lpcm(pd, state, resp_msg.payload[0]);
+
+	if (ret < 0) {
+		dev_err(dev, "%s: %s: send lpcm message failed ret (%d)\n",
+			pd->name, ON_OFF_STR(state), ret);
+
+		return ret;
+	}
+
+	dev_dbg(dev, "%s: %s: got resp from %u, data %u %u %u\n", pd->name,
+		ON_OFF_STR(state), cpm_req.dst_id, resp_msg.payload[0],
+		resp_msg.payload[1], resp_msg.payload[2]);
+
+	switch (resp_msg.payload[0]) {
+	case NO_ERROR:
+		dev_dbg(dev, "%s: %s: lpcm service success\n", pd->name,
+			ON_OFF_STR(state));
+		ret = 0;
+		break;
+	default:
+		dev_err(dev, "%s: %s: unknown error code %d\n", pd->name,
+			ON_OFF_STR(state), resp_msg.payload[0]);
+		ret = -EPROTO;
+		break;
+	}
+
+	return ret;
+}
+
+static inline int lpcm_smc(struct cpm_power_domain *pd, enum power_state state)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(SIP_SVC_PD_CONTROL, pd->sswrp_id,
+		      pd->cpm_lpcm_subdomain_id, state, 0, 0, 0, 0, &res);
+
+	WARN_ON(res.a0);
+	if ((unsigned long)res.a1) {
+		dev_err(pd->controller->dev, "Failed SMC call sswrp:%d sub-domain:%d, res.a1:%lu\n",
+			pd->sswrp_id, pd->cpm_lpcm_subdomain_id, res.a1);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int cpm_set_power_state(struct generic_pm_domain *domain, enum power_state state)
+{
+	int ret;
+	struct cpm_power_domain *pd = to_power_domain(domain);
+
+	if (state >= PD_STATE_COUNT || state < 0)
+		return -EINVAL;
+
+	if (pd->use_smc)
+		ret = lpcm_smc(pd, state);
+	else if (pd->is_top_pd)
+		ret = send_lpb_request(pd, state);
+	else
+		ret = send_lpcm_request(pd, state);
+
+	if (!ret)
+		atomic_set(&pd->state, state);
+
+	return ret;
+}
+
+static int cpm_power_on(struct generic_pm_domain *domain)
+{
+	return cpm_set_power_state(domain, PD_STATE_ON);
+}
+
+static int cpm_power_off(struct generic_pm_domain *domain)
+{
+	return cpm_set_power_state(domain, PD_STATE_OFF);
+}
+
+static int cpm_power_apply_desc(struct cpm_power_domain *pd,
+				const struct cpm_power_domain_desc *domain)
+{
+	struct device *dev = pd->controller->dev;
+
+	if (domain->on_at_init)
+		atomic_set(&pd->state, PD_STATE_ON);
+
+	pd->use_smc = domain->use_smc;
+	pd->genpd.flags |= domain->flags;
+
+	/* If we want it "always on", it must already be on. */
+	if (pd->genpd.flags & GENPD_FLAG_ALWAYS_ON) {
+		if (atomic_read(&pd->state) == PD_STATE_OFF) {
+			dev_err(dev, "%s: always-on PM domain is not on\n",
+				pd->name);
+			return -EINVAL;
+		}
+	}
+
+	/* If we want it "RPM always on", it must already be on. */
+	if (pd->genpd.flags & GENPD_FLAG_RPM_ALWAYS_ON) {
+		if (atomic_read(&pd->state) == PD_STATE_OFF) {
+			dev_err(dev, "%s: rpm-always-on PM domain is not on\n",
+				pd->name);
+			return -EINVAL;
+		}
+	}
+
+	if (pd->genpd.flags & GENPD_FLAG_IRQ_SAFE) {
+		if (pd->genpd.flags & GENPD_FLAG_RPM_ALWAYS_ON) {
+			dev_err(dev, "%s: rpm-always-on and irq-safe both set\n",
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
+/*
+ * This flag can be dangerous because it allows power on/off a power domain
+ * without changing reference count in genpd core. This can lead to an
+ * inconsistent state where genpd core thinks the domain is ON while it is
+ * actually OFF and vice versa. Only define this flag for testing purposes.
+ */
+static int cpm_power_debugfs_state_set(void *domain, u64 val)
+{
+	struct generic_pm_domain *genpd = domain;
+	int ret = 0;
+
+	dev_dbg(&genpd->dev, "%s\n", ON_OFF_STR(val));
+
+	mutex_lock(&genpd->mlock);
+	if (val)
+		ret = cpm_power_on(genpd);
+	else
+		ret = cpm_power_off(genpd);
+	mutex_unlock(&genpd->mlock);
+
+	return ret;
+}
+
+static int cpm_power_debugfs_state_get(void *domain, u64 *val)
+{
+	struct generic_pm_domain *genpd = domain;
+	int ret;
+
+	ret = request_lpb_vote_status(genpd);
+	if (ret < 0)
+		return ret;
+
+	*val = ret;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(cpm_power_debugfs_state_fops,
+			 cpm_power_debugfs_state_get,
+			 cpm_power_debugfs_state_set, "%llu\n");
+
+static void cpm_power_debugfs_init(struct cpm_power_controller *controller)
+{
+	controller->debugfs_root = debugfs_create_dir("cpm-power", NULL);
+
+	for (int i = 0; i < controller->pd_count; ++i) {
+		struct cpm_power_domain *pd = &controller->pds[i];
+		struct dentry *d =
+			debugfs_create_dir(pd->genpd.name,
+					   controller->debugfs_root);
+
+		debugfs_create_file("state", 0660, d, &pd->genpd,
+				    &cpm_power_debugfs_state_fops);
+	}
+}
+
+static void cpm_power_debugfs_remove(struct cpm_power_controller *controller)
+{
+	debugfs_remove_recursive(controller->debugfs_root);
+}
+
+static int cpm_power_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_id *id)
+{
+	struct device *dev = &auxdev->dev;
+	struct cpm_power_controller *controller;
+	const struct cpm_power_desc *desc;
+	int ret, i, pd_count;
+
+	controller = devm_kzalloc(dev, sizeof(*controller), GFP_KERNEL);
+	if (!controller)
+		return -ENOMEM;
+
+	controller->dev = dev;
+
+	auxiliary_set_drvdata(auxdev, controller);
+
+	desc = (const struct cpm_power_desc *)id->driver_data;
+	if (!desc)
+		return -EINVAL;
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
+		pd->sswrp_id = domain->sswrp_id;
+		pd->is_top_pd = (domain->subdomain_id == NOT_SUPPORTED);
+		atomic_set(&pd->state, PD_STATE_OFF);
+		pd->name = domain->name;
+		pd->controller = controller;
+		pd->genpd.name = domain->name;
+		pd->genpd.power_on = cpm_power_on;
+		pd->genpd.power_off = cpm_power_off;
+		pd->id = i;
+		pd->subdomain_id = domain->subdomain_id;
+		pd->parent_id = domain->parent_id;
+
+		pd->cpm_lpcm_subdomain_id = domain->subdomain_id;
+
+		if (pd->is_top_pd && desc->sswrp_to_lpb_ids)
+			pd->cpm_lpb_sswrp_id =
+				desc->sswrp_to_lpb_ids[pd->sswrp_id];
+		else if (desc->sswrp_to_lpcm_ids)
+			pd->cpm_lpcm_sswrp_id =
+				desc->sswrp_to_lpcm_ids[pd->sswrp_id];
+		else
+			return -EINVAL;
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
+	controller->client =
+		devm_cpm_request_client(dev,
+					APC_COMMON_SERVICE_ID_POWER_CONTROLLER,
+					cpm_power_rx_callback,
+					controller);
+	if (IS_ERR(controller->client))
+		return dev_err_probe(dev, PTR_ERR(controller->client),
+				     "failed to request mailbox channel\n");
+
+	/* First, register all domains. */
+	for (i = 0; i < pd_count; i++) {
+		struct cpm_power_domain *pd = &controller->pds[i];
+
+		ret = pm_genpd_init(&pd->genpd, NULL,
+				    atomic_read(&pd->state) == PD_STATE_OFF);
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
+		if (pd->parent_id == NOT_SUPPORTED)
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
+	cpm_power_debugfs_init(controller);
+
+	return 0;
+}
+
+static void cpm_power_remove(struct auxiliary_device *auxdev)
+{
+	struct cpm_power_controller *controller = auxiliary_get_drvdata(auxdev);
+	struct device *dev = &auxdev->dev;
+	struct device_node *np = dev->of_node;
+
+	cpm_power_debugfs_remove(controller);
+
+	of_genpd_del_provider(np);
+}
+
+static const struct auxiliary_device_id cpm_power_id_table[] = {
+	{
+		.name = "google_cpm_mba.power-controller",
+		.driver_data = (kernel_ulong_t)&lga_cpm_power_desc,
+	},
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
+
+module_auxiliary_driver(cpm_power_driver);
+
+MODULE_DESCRIPTION("Google Tensor CPM power controller driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/pmdomain/google/lpb_service.h b/drivers/pmdomain/google/lpb_service.h
new file mode 100644
index 000000000000..4b84e2b8a5a8
--- /dev/null
+++ b/drivers/pmdomain/google/lpb_service.h
@@ -0,0 +1,200 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2023-2026 Google LLC
+ */
+#ifndef _GOOGLE_LPB_SERVICE_H
+#define _GOOGLE_LPB_SERVICE_H
+
+/* Contains definitions needed to use the LPB mailbox service */
+
+/*
+ * SERVICE_ID: CPM_COMMON_LPB_SERVICE
+ *
+ * Disabled for production
+ * CLI to test LPB
+ *
+ * CMD: LPB_CMD_DEBUG_SET, LPB_CMD_SSWRP_STATE_SET
+ * Queue Mode:
+ * Word 0: Queue mode header
+ * Word 1: Cmd: LPB_CMD_DEBUG_SET | LPB_CMD_SSWRP_STATE_SET
+ *  bit [ 31 - 0 ]
+ *      | cmd    |
+ * Word 2: LPB SERVICE SSWRP ID
+ *  bit [ 31 - 0 ]
+ *      | SERVICE SSWRP ID |
+ * Word 3: Set on or off (1 is on, anything else is off)
+ *  bit [ 31 - 0 ]
+ *      | state  |
+ *
+ * Response:
+ * Word 0: Queue mode header
+ * Word 1: CPM_COMMON_PROT_NO_ERR on success, else error
+ *  bit [ 31 - 0                 ]
+ *      | cpm_common_mba_error_t |
+ * Word 2:
+ *  bit [ 31 - 0                   ]
+ *      | lpb_service_cmd_status_t |
+ * Word 3: LPB Service ID that was changed
+ *  bit [ 31 - 0           ]
+ *      | Service SSWRP ID |
+ *
+ * Polling Mode:
+ * Word 0: Header and data (1 to set on, 0 to set off)
+ *         cmd: LPB_CMD_DEBUG_SET | LPB_CMD_SSWRP_STATE_SET
+ *  bit [ 31 - 16             | 15-0 ]
+ *      | polling mode header | cmd  |
+ * Word 1: LPB SERVICE SSWRP ID
+ *  bit [ 31 - 0 ]
+ *      | SERVICE SSWRP ID |
+ * Word 2: state (1 on, 0 off)
+ *  bit [ 31 - 0 ]
+ *      | state  |
+ *
+ * Response:
+ * Word 0: Header
+ *  bit [ 31 - 16             | 15 - 0 ]
+ *      | polling mode header | unused |
+ * Word 1: CPM_COMMON_PROT_NO_ERR on success, else error
+ *  bit [ 31 - 0                 ]
+ *      | cpm_common_mba_error_t |
+ * Word 2:
+ *  bit [ 31 - 0                   ]
+ *      | lpb_service_cmd_status_t |
+ * Word 3: LPB Service ID that was changed
+ *  bit [ 31 - 0           ]
+ *      | Service SSWRP ID |
+ *
+ * CMD: LPB_CMD_DEBUG_SET, LPB_CMD_SSWRP_STATE_SET
+ *
+ * CMD: LPB_CMD_SSWRP_STATE_GET
+ * Queue Mode: Not supported at this time
+ * Polling Mode:
+ * Word 0: Header and data (1 to set on, 0 to set off)
+ *         cmd: LPB_CMD_SSWRP_STATE_GET
+ *  bit [ 31 - 16             | 15-0 ]
+ *      | polling mode header | cmd  |
+ * Word 1: LPB SERVICE SSWRP ID
+ *  bit [ 31 - 0           ]
+ *      | SERVICE SSWRP ID |
+ *
+ * Response:
+ * Word 0: Header
+ *  bit [ 31 - 16             | 15 - 0 ]
+ *      | polling mode header | unused |
+ * Word 1: lpb_service_state_t (LPB_SERVICE_STATE_ON | LPB_SERVICE_STATE_OFF)
+ *  bit [ 31 - 0              ]
+ *      | lpb_service_state_t |
+ *
+ * CMD: LPB_CMD_SSWRP_STATE_GET
+ *
+ * CMD: LPB_CMD_REQ_DRAM_STATE
+ * Polling Mode:
+ * Word 0: Header and data (1 to set on, 0 to set off)
+ *         cmd: LPB_CMD_REQ_DRAM_STATE
+ *  bit [ 31 - 16             | 15-0 ]
+ *      | polling mode header | cmd  |
+ * Word 1: state (1 on, all else off)
+ *  bit [ 31 - 0 ]
+ *      | state  |
+ *
+ * Response:
+ * Word 0: Header
+ *  bit [ 31 - 16             | 15 - 0 ]
+ *      | polling mode header | unused |
+ * Word 1: Error code (CPM_COMMON_PROT_NO_ERR for success, else an error code)
+ *  bit [ 31 - 0     ]
+ *      | error code |
+ *
+ * CMD: LPB_CMD_REQ_DRAM_STATE
+ *
+ * CMD: LPB_CMD_GET_DRAM_STATE
+ * Polling Mode:
+ * Word 0: Header and data (1 to set on, 0 to set off)
+ *         cmd: LPB_CMD_GET_DRAM_STATE
+ *  bit [ 31 - 16             | 15-0 ]
+ *      | polling mode header | cmd  |
+ *
+ * Response:
+ * Word 0: Header
+ *  bit [ 31 - 16             | 15 - 0 ]
+ *      | polling mode header | unused |
+ * Word 1: 0 for OFF, 1 for ON, else CPM_COMMON_PROT_GENERIC_ERR
+ *  bit [ 31 - 0     ]
+ *      | state |
+ *
+ * CMD: LPB_CMD_GET_DRAM_STATE
+ *
+ * SERVICE_ID: CPM_COMMON_LPB_SERVICE
+ */
+
+/*
+ * Add all LPB specific definitions here.
+ * Note: CPM, BMSM, and GDMC are not on this list, as they don't have an LPB
+ * sequencer
+ */
+
+/* LGA */
+enum lpb_service_sswrp_id {
+	LPB_SERVICE_AOC_ID,
+	LPB_SERVICE_AURORA_ID,
+	LPB_SERVICE_CODEC_3P_ID,
+	LPB_SERVICE_CPU_ID,
+	LPB_SERVICE_CPUACC_ID,
+	LPB_SERVICE_DPU_ID,
+	LPB_SERVICE_EH_ID,
+	LPB_SERVICE_FABHBW_ID,
+	LPB_SERVICE_FABMED_ID,
+	LPB_SERVICE_FABRT_ID,
+	LPB_SERVICE_FABSTBY_ID,
+	LPB_SERVICE_FABSYSS_ID,
+	LPB_SERVICE_G2D_ID,
+	LPB_SERVICE_GMC0_ID,
+	LPB_SERVICE_GMC1_ID,
+	LPB_SERVICE_GMC2_ID,
+	LPB_SERVICE_GMC3_ID,
+	LPB_SERVICE_GPCA_ID,
+	LPB_SERVICE_GPCM_ID,
+	LPB_SERVICE_GPDMA_ID,
+	LPB_SERVICE_GPU_ID,
+	LPB_SERVICE_GSA_ID,
+	LPB_SERVICE_GSW_ID,
+	LPB_SERVICE_HSIO_N_ID,
+	LPB_SERVICE_HSIO_S_ID,
+	LPB_SERVICE_INF_TCU_ID,
+	LPB_SERVICE_ISPBE_ID,
+	LPB_SERVICE_ISPFE_ID,
+	LPB_SERVICE_LSIO_E_ID,
+	LPB_SERVICE_LSIO_N_ID,
+	LPB_SERVICE_LSIO_S_ID,
+	LPB_SERVICE_MEMSS_ID,
+	LPB_SERVICE_TPU_ID,
+	LPB_SERVICE_NUM_SSWRPS,
+};
+
+/*
+ * Used to indicate what has just happened as a result of the below commands.
+ * Can be a generic success/error, or something more meaningful.
+ */
+
+enum lpb_service_cmd_status {
+	LPB_SERVICE_CMD_SUCCESS = 0xf,
+	LPB_SERVICE_CMD_FAIL,
+	LPB_SERVICE_PWRDN_STARTED,
+	LPB_SERVICE_PWRUP_STARTED,
+	LPB_SERVICE_NO_EFFECT,
+};
+
+enum lpb_service_state {
+	LPB_SERVICE_STATE_OFF = 0x1,
+	LPB_SERVICE_STATE_ON,
+};
+
+#define LPB_SVC_MSG_SIZE			(4)
+#define LPB_CMD_DEBUG_SET			(1)
+#define LPB_CMD_SSWRP_STATE_SET			(2)
+#define LPB_CMD_SSWRP_STATE_GET			(3)
+#define LPB_CMD_REQUEST_COMPUTE_SSWRP_OFF	(4)
+#define LPB_CMD_REQ_DRAM_STATE			(5)
+#define LPB_CMD_GET_DRAM_STATE			(6)
+
+#endif /* _GOOGLE_LPB_SERVICE_H */
-- 
2.56.0.307.g5fe7bd680c-goog

