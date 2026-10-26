Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051120;
	b=zawqvT1lg0hYGAE6M8yu03ruZ+CyHnr4LjOC4V27Ln7nd1FqYDcTUB0gdmSLZQ97SPdM
	 cX7gLvne3QK1BW18pa89hr9GqEPSlYG2v6zMqk7RVPyfPyFgRUN1xbdGaPFWI2DtM3Qjh
	 /qEyIFq9nrzGqdm+szfPvWYAVG2wAYpy3dsq9EFnvRVhHTWzPEoKuRDepheC1782DItjC
	 xLQsmYJwRb+QHHDHmeURjljF4qlctf9/NWLPY1wnx6OyEQZMDl+5EG78/c0SKlFogsb6A
	 CmBLOMSsDZ3zcdviiznWKSkIjvBdGVSkoowsR2d8hqMwyGV+KX+CsX8bJVbbN4snxCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=x03RVkvp2BVkhH7lQ7+Vbovp3CBtCAbe50YhoCsFR7w=;
	b=FeH1bgod7uX0sqk10dAtqkDKF1aElvl65mSVlvOBrMrfP4FgaCsz98glGIK9JHpHp2Wt
	 zdRJ0iJXmfeGFtVC+Dp2MGzNsTGY6+P93omiy9zvAaYZDTTy5s9egLAGYJMfVALNTgsfK
	 1RhxlH2qgsJfdqcEhcsBGo/LWPJhZnmsj/6/dIbDE4dNNRbeqfk+gNnxq50MGT4d7/YJC
	 P67/s46HCyLnzGChhTseUF7RfMjrWZyNo5LvsYBgfkGLpPT9zBm8ZQfPnjG25pl6buWAH
	 jWPN+kaiGtjx8sBYq9le3pdnU3gj0c26iAdE19Yr7U1Gc+LWJLitKugP6vt6t3Rv7PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Xb5+muKp;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9BD60A2604
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 21:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED9BD60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Xb5+muKp
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36681e85e87so1855409eec.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 14:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793051118; x=1793655918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x03RVkvp2BVkhH7lQ7+Vbovp3CBtCAbe50YhoCsFR7w=;
        b=Xb5+muKp/IsAvyvG3v/KdJueDzoS11/5SBskqS5KJonQ5DMH0wKGSazktkiLsrRujl
         FCv6x+NfZ8UH55aqlVEGOn5wm1UYfZzymy8D9Gg0z4mtNqBBMmGyv0v/VVN8TuOu5dzt
         diyhXa8vqrtWXt3uHdxzDhsIWHkBHTAMNzI+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793051118; x=1793655918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x03RVkvp2BVkhH7lQ7+Vbovp3CBtCAbe50YhoCsFR7w=;
        b=QjGkp3SICqnUd1eliYcwAyoYsSpE7qfE2+QVostbcGH1BpZrZZvIiXJmsSM9qau96q
         PfAzsG3AvQW5Nex7vj4uQlclFIQzHepijZ6mRTdtpePXnxMtq8hC3ymt9Yl3K4j/mtLC
         31PtVi3RzKbl9erU1NxR9qB+JDIKAzBmbFlYti1OGm8ZPvCnfxMcxLZQVGuWPb44EG5J
         Ub1dFVpdbNfOKPTzwh4ts1pmwTdMh83GobemNcA4j/q0pOVGLwoH0Aj4vA8Rtpztthj8
         duN1wsjc68lpSzXu3KW2yUo141vtU+0dZx5/GgmY47V5gQr/KFb5nQUk+DUqUoHWz/3n
         E3lA==
X-Forwarded-Encrypted: i=1; AKwUvBwVabeNo6IYz0wF1OAEhryzt6sUhEtaSVMCxqc3mc9quZgQ8vyTKr891dxSGnzRBJZt681hoi2rJA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLXqmTrYjPJkhJ+s24PT4bfY6TYSaqzKE4i83zfczIU+7bh6Hm1
	urv1f+16RDc9epibFpN+QCKD0ZHZ4jq1kHB8vSWHgtHONkzDyq0ggy1WKdEheSaVSg==
X-Gm-Gg: AYBFou1OEBQiNpM+efGGDdA7BSrCaHqeTHiZsipJv3jmLXioVXVXMJO7kb7HPT1cK8s
	AlPLidT8753ZILtzJ9cuQkTSBgiJc7YmaaG8iRPiceRhsXQ8TTTlir3Er2mX+4XzdET3zwxf3Wk
	XNluJ1bLLli2ddCidkPwaORs2vB90njJeyYws1XeACBJgUwDYCr6G8CSsA8sE62hLwAZ4klXRWF
	Zv4K8YurZleu4e0hDdpODS5NRn34fQW/LVcIcfMrhoX/h1gRLSN+Y49YOSL2Q3r7ZlviT8TK0/e
	maZ9vJadJ9WJCL/m2VCW79RE5nRWOIRg4MvFLOGq1/36cafyNNDD1oW1XWCgAlG/uS3ZqFq1UJD
	dY3EG8wlE96JA/1xj9QLaJ0cfaEvxAIomGWCTKh3r8rlFvWOcSRwWkS5/8Ibw1mB5MhrIDFL/Z0
	mlaogxN2Em1ww5GIr45mp+e5o8zNrNTgFWmFScH0CL1tcNpaH4JfBz+6FJ2dKheB/qFzkJlavbs
	/v5X5iZjbq5NOYsB26mya45UKcPP3kQxMaILk0wxEgqmLRAKzgKyxgwIr2g/MSvppVkuPB+Ibqz
	IzZGsZIbVNlip7Bx20w=
X-Received: by 2002:a05:693c:6209:b0:366:83dd:46f3 with SMTP id 5a478bee46e88-369e84596b9mr12859189eec.14.1793051117627;
        Mon, 26 Oct 2026 14:45:17 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:79c5:9cd3:db14:7468])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-369e8daf444sm26943100eec.18.2026.10.26.14.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 14:45:16 -0700 (PDT)
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
Subject: [PATCH 5/9] clk: google: Add CPM clock driver
Date: Mon, 26 Oct 2026 14:43:43 -0700
Message-ID: <20261026144346.5.I82dc05365979021379fe730d6d52792a87ff15ed@changeid>
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

Google Tensor SoCs (used on Pixel phones) manage many resources
(including most clocks) using a Central Power Manager (CPM)
co-processor. We communicate with CPM using mailboxes, abstracted in the
cpm_request_client(), etc., API.

The clock tree is largely not represented fully by this driver, because
CPM hides most of the divider, mux, and parent details, instead
maintaining its own internal table of mappings for divider and mux
values. The one exception is for some of the DPU clocks, where several
clocks and dividers are exposed directly, and the firmware API works on
divider values instead of clock rates. I attempt to represent this
properly with dividers and parents, although I don't have the full
display stack running to verify everything yet.

A few clocks are not managed by CPM, but instead utilize an SMC call for
lower latency. We still represent those within this driver, as they are
part of the same clock hierarchy.

For posterity, I list a summary of changes made relative to the
downstream Pixel driver:

 * CPM clients use the auxiliary_bus, instead of individual platform
   devices (and DT nodes) with phandles to a pseudo-mailbox

 * Instead of device nodes for each clock (and therefore a provider for
   each), we use a per-SoC table of clocks, register them all, and have
   a single clock-cells==2 provider

 * Use devm more heavily

 * Drop ACG (auto-clock gating) and QCH (Q-Channel Mode) custom APIs;
   these are mostly not expected to be used. We only support the
   CLK_GATE feature.

 * Add device objects for clocks that need a power domain, and attach
   per-LPCM power domains to those clock devices. The downstream driver
   had additional device tree properties for "power domains to turn on
   during probe", relying on consumers to manage these domains
   post-probe. I chose instead to simply attach these domains to the
   clocks themselves.

 * Represent hsion-dp0-clk, hsion-dp1-clk, dpu-dp0-pix-clk, and
   dpu-dp1-pix-clk with dividers and parents. In Pixel drivers, the
   display drivers simply memorized a list of clocks and dividers, and
   abused clk_set_rate() to program them individually.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/clk/Kconfig                   |   1 +
 drivers/clk/Makefile                  |   1 +
 drivers/clk/google/Kconfig            |  13 +
 drivers/clk/google/Makefile           |   3 +
 drivers/clk/google/clk-cpm-internal.h |  35 ++
 drivers/clk/google/clk-cpm-lga.c      | 271 ++++++++++++
 drivers/clk/google/clk-cpm.c          | 573 ++++++++++++++++++++++++++
 7 files changed, 897 insertions(+)
 create mode 100644 drivers/clk/google/Kconfig
 create mode 100644 drivers/clk/google/Makefile
 create mode 100644 drivers/clk/google/clk-cpm-internal.h
 create mode 100644 drivers/clk/google/clk-cpm-lga.c
 create mode 100644 drivers/clk/google/clk-cpm.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 37a8e35d4178..23fa8698c54c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -517,6 +517,7 @@ source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/cix/Kconfig"
 source "drivers/clk/davinci/Kconfig"
 source "drivers/clk/eswin/Kconfig"
+source "drivers/clk/google/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
 source "drivers/clk/imgtec/Kconfig"
 source "drivers/clk/imx/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 52d138d4ffc8..0465ae1295b0 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -136,6 +136,7 @@ obj-$(CONFIG_ARCH_BERLIN)		+= berlin/
 obj-y					+= cix/
 obj-$(CONFIG_COMMON_CLK_DAVINCI)	+= davinci/
 obj-$(CONFIG_COMMON_CLK_ESWIN)		+= eswin/
+obj-y					+= google/
 obj-$(CONFIG_COMMON_CLK_HISI)		+= hisilicon/
 obj-y					+= imgtec/
 obj-y					+= imx/
diff --git a/drivers/clk/google/Kconfig b/drivers/clk/google/Kconfig
new file mode 100644
index 000000000000..638299829791
--- /dev/null
+++ b/drivers/clk/google/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config GOOGLE_CPM_CLK
+	tristate "Google CPM clock driver"
+	default ARCH_GOOGLE
+	depends on ARCH_GOOGLE || COMPILE_TEST
+	depends on GOOGLE_CPM_MBA
+	help
+	  This driver allows clients to configure Google Tensor SoC LPCM clocks
+	  via CPM using the common clock framework. This covers clocks that are
+	  not supported by PFSM and PSM.
+
+	  If unsure, say N.
diff --git a/drivers/clk/google/Makefile b/drivers/clk/google/Makefile
new file mode 100644
index 000000000000..32fdd5885299
--- /dev/null
+++ b/drivers/clk/google/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_GOOGLE_CPM_CLK) += google-clk-cpm.o
+google-clk-cpm-y := clk-cpm.o clk-cpm-lga.o
diff --git a/drivers/clk/google/clk-cpm-internal.h b/drivers/clk/google/clk-cpm-internal.h
new file mode 100644
index 000000000000..f99c193a6a54
--- /dev/null
+++ b/drivers/clk/google/clk-cpm-internal.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2026 Google LLC
+ */
+
+#ifndef _GOOGLE_CLK_CPM_INTERNAL_H
+#define _GOOGLE_CLK_CPM_INTERNAL_H
+
+#include <linux/types.h>
+
+struct cpm_clk_data {
+	/* LPCM ID the clock belongs to */
+	u32 lpcm_id;
+	/* Index of the clock within the given LPCM */
+	u32 clock_id;
+
+	const char *name;
+	const char *parent_name;
+	bool use_smc;
+	const unsigned long *rates;
+	int nr_rates;
+	const unsigned int *divs;
+	int nr_divs;
+};
+
+struct cpm_clk_soc_data {
+	const struct cpm_clk_data *clks;
+	size_t num_clks;
+	const int *lpcm_to_pd;
+	size_t num_lpcm_to_pd;
+};
+
+extern const struct cpm_clk_soc_data cpm_clk_lga_data;
+
+#endif /* _GOOGLE_CLK_CPM_INTERNAL_H */
diff --git a/drivers/clk/google/clk-cpm-lga.c b/drivers/clk/google/clk-cpm-lga.c
new file mode 100644
index 000000000000..b1a47556cce5
--- /dev/null
+++ b/drivers/clk/google/clk-cpm-lga.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2023-2026 Google LLC
+ */
+
+#include <dt-bindings/clock/google,lga-cpm.h>
+#include <dt-bindings/power/google,lga-cpm.h>
+#include <dt-bindings/soc/google,lga-lpcm.h>
+#include <linux/kernel.h>
+
+#include "clk-cpm-internal.h"
+
+static const unsigned int clk_divs_dp[] = { 1, 2, 4 };
+static const unsigned long clk_rates_dp_osc[] = { 38400000 };
+static const unsigned long clk_rates_dp_pll[] = {
+	12587500,
+	20000000,
+	32500000,
+	37125000,
+	38400000,
+	54000000,
+	67500000,
+	74250000,
+	77000000,
+	96625000,
+	99000000,
+	117295000,
+	118800000,
+	120750000,
+	148500000,
+	159875000,
+	174250000,
+	197500000,
+	261305000,
+	266625000,
+	297000000,
+};
+
+static const unsigned long clk_rates_24576000[] = { 24576000 };
+static const unsigned long clk_rates_38400000_76800000[] = { 38400000, 76800000 };
+static const unsigned long clk_rates_100000000_150000000[] = { 100000000, 150000000 };
+static const unsigned long clk_rates_200000000[] = { 200000000 };
+static const unsigned long clk_rates_288000000[] = { 288000000 };
+static const unsigned long clk_rates_300000000[] = { 300000000 };
+static const unsigned long clk_rates_400000000[] = { 400000000 };
+
+#define CPM_CLK_LGA(domain, id, n, r) \
+	{ .lpcm_id = LGA_LPCM_##domain, .clock_id = id, .name = n, \
+	  .rates = r, .nr_rates = ARRAY_SIZE(r) }
+
+#define CPM_CLK_LGA_DIV(domain, id, n, pname, d, r) \
+	{ .lpcm_id = LGA_LPCM_##domain, .clock_id = id, .name = n, \
+	  .parent_name = pname, .divs = d, .nr_divs = ARRAY_SIZE(d), \
+	  .rates = r, .nr_rates = ARRAY_SIZE(r) }
+
+#define CPM_CLK_LGA_NO_RATES(domain, id, n) \
+	{ .lpcm_id = LGA_LPCM_##domain, .clock_id = id, .name = n }
+
+#define CPM_CLK_LGA_GATE_PARENT(domain, id, n, pname) \
+	{ .lpcm_id = LGA_LPCM_##domain, .clock_id = id, .name = n, .parent_name = pname }
+
+#define CPM_CLK_LGA_SMC(domain, id, n) \
+	{ .lpcm_id = LGA_LPCM_##domain, .clock_id = id, .name = n, .use_smc = true }
+
+static const struct cpm_clk_data cpm_clks_lga[] = {
+	/* GPCM */
+	CPM_CLK_LGA(GPCM, GPCM_HSION_PLL_DP_CLK, "gpcm-hsion-pll-dp-clk", clk_rates_dp_pll),
+	CPM_CLK_LGA_GATE_PARENT(GPCM, GPCM_DPU_PLL_DP_CLK, "gpcm-dpu-pll-dp-clk",
+				"gpcm-hsion-pll-dp-clk"),
+
+	/* CPU */
+	CPM_CLK_LGA_NO_RATES(CPU, CPU_SSWRP_TSS_CLK, "cpu-sswrp-tss-clk"),
+
+	/* LSIO_S */
+	CPM_CLK_LGA(LSIO_S, LSIOS_MCLK0_CLK, "lsios-mclk0-clk", clk_rates_24576000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_MCLK1_CLK, "lsios-mclk1-clk", clk_rates_24576000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_MCLK2_CLK, "lsios-mclk2-clk", clk_rates_24576000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_MCLK3_CLK, "lsios-mclk3-clk", clk_rates_24576000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_MCLK4_CLK, "lsios-mclk4-clk", clk_rates_24576000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_MCLK5_CLK, "lsios-mclk5-clk", clk_rates_24576000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_MCLK6_CLK, "lsios-mclk6-clk", clk_rates_24576000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_MCLK7_CLK, "lsios-mclk7-clk", clk_rates_24576000),
+	CPM_CLK_LGA_NO_RATES(LSIO_S, LSIOS_GPIO_CLK, "lsios-gpio-clk"),
+	CPM_CLK_LGA(LSIO_S, LSIOS_PWM_CLK, "lsios-pwm-clk", clk_rates_24576000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_PWM_CFG_CLK, "lsios-pwm-cfg-clk", clk_rates_300000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI0_CFG_CLK, "lsios-cli0-cfg-clk", clk_rates_300000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI1_CFG_CLK, "lsios-cli1-cfg-clk", clk_rates_300000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI2_CFG_CLK, "lsios-cli2-cfg-clk", clk_rates_300000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI3_CFG_CLK, "lsios-cli3-cfg-clk", clk_rates_300000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI4_CFG_CLK, "lsios-cli4-cfg-clk", clk_rates_300000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI5_CFG_CLK, "lsios-cli5-cfg-clk", clk_rates_300000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI6_CFG_CLK, "lsios-cli6-cfg-clk", clk_rates_300000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI0_SPI_CLK, "lsios-cli0-spi-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI1_SPI_CLK, "lsios-cli1-spi-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI2_SPI_CLK, "lsios-cli2-spi-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI3_SPI_CLK, "lsios-cli3-spi-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI4_SPI_CLK, "lsios-cli4-spi-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI5_SPI_CLK, "lsios-cli5-spi-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI6_SPI_CLK, "lsios-cli6-spi-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI0_I2C_CLK, "lsios-cli0-i2c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI1_I2C_CLK, "lsios-cli1-i2c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI2_I2C_CLK, "lsios-cli2-i2c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI3_I2C_CLK, "lsios-cli3-i2c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI4_I2C_CLK, "lsios-cli4-i2c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI5_I2C_CLK, "lsios-cli5-i2c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI6_I2C_CLK, "lsios-cli6-i2c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI0_UART_CLK, "lsios-cli0-uart-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI1_UART_CLK, "lsios-cli1-uart-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI2_UART_CLK, "lsios-cli2-uart-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI3_UART_CLK, "lsios-cli3-uart-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI4_UART_CLK, "lsios-cli4-uart-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI5_UART_CLK, "lsios-cli5-uart-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI6_UART_CLK, "lsios-cli6-uart-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI0_I3C_CLK, "lsios-cli0-i3c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI1_I3C_CLK, "lsios-cli1-i3c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI2_I3C_CLK, "lsios-cli2-i3c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI3_I3C_CLK, "lsios-cli3-i3c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI4_I3C_CLK, "lsios-cli4-i3c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI5_I3C_CLK, "lsios-cli5-i3c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_S, LSIOS_CLI6_I3C_CLK, "lsios-cli6-i3c-clk", clk_rates_200000000),
+
+	/* HSIO_S */
+	CPM_CLK_LGA_SMC(HSIO_S, HSIOS_GPIO_REF_TCX0_CLK, "hsios-gpio-ref-tcx0-clk"),
+	CPM_CLK_LGA_NO_RATES(HSIO_S, HSIOS_SYS_CLK, "hsios-sys-clk"),
+	CPM_CLK_LGA_NO_RATES(HSIO_S, HSIOS_UFS_CFG_CLK, "hsios-ufs-cfg-clk"),
+	CPM_CLK_LGA_NO_RATES(HSIO_S, HSIOS_PHY_FW_CLK, "hsios-phy-fw-clk"),
+	CPM_CLK_LGA(HSIO_S, HSIOS_MPHY_REF_TCX0_CLK, "hsios-mphy-ref-clk",
+		    clk_rates_38400000_76800000),
+	CPM_CLK_LGA_SMC(HSIO_S, HSIOS_AUX_CLK, "hsios-aux-clk"),
+
+	/* HSIO_N */
+	CPM_CLK_LGA(HSIO_N, HSION_USB_CLK, "hsion-usb-clk", clk_rates_288000000),
+	CPM_CLK_LGA_DIV(HSIO_N, HSION_DP0_CLK, "hsion-dp0-clk",
+			"gpcm-hsion-pll-dp-clk", clk_divs_dp, clk_rates_dp_osc),
+	CPM_CLK_LGA_DIV(HSIO_N, HSION_DP1_CLK, "hsion-dp1-clk",
+			"gpcm-hsion-pll-dp-clk", clk_divs_dp, clk_rates_dp_osc),
+	CPM_CLK_LGA(HSIO_N, HSION_PHY_FW_CLK, "hsion-phy-fw-clk", clk_rates_400000000),
+	CPM_CLK_LGA_NO_RATES(HSIO_N, HSION_PCIE_REF_CLK, "hsion-pcie-ref-clk"),
+	CPM_CLK_LGA_NO_RATES(HSIO_N, HSION_USBDP_SUSPEND_CLK, "hsion-usbdp-suspend-clk"),
+	CPM_CLK_LGA_NO_RATES(HSIO_N, HSION_USBC_NON_STICKY_CLK, "hsion-usbc-non-sticky-clk"),
+	CPM_CLK_LGA_NO_RATES(HSIO_N, HSION_USBC_STICKY_CLK, "hsion-usbc-sticky-clk"),
+	CPM_CLK_LGA_NO_RATES(HSIO_N, HSION_USB_DRD_BUS_CLK, "hsion-usb-drd-bus-clk"),
+	CPM_CLK_LGA_NO_RATES(HSIO_N, HSION_USB_TOP_CSR_CLK, "hsion-usb-top-csr-clk"),
+	CPM_CLK_LGA_NO_RATES(HSIO_N, HSION_U2PHY_APB_CLK, "hsion-u2phy-apb-clk"),
+	CPM_CLK_LGA_NO_RATES(HSIO_N, HSION_USB2_PHY_RESET_CLK, "hsion-usb2-phy-reset-clk"),
+	CPM_CLK_LGA_NO_RATES(HSIO_N, HSION_USB3DP_PHY_RESET_CLK, "hsion-usb3dp-phy-reset-clk"),
+	CPM_CLK_LGA_NO_RATES(HSIO_N, HSION_EBU_CLK, "hsion-ebu-clk"),
+
+	/* LSIO_E */
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI7_CFG_CLK, "lsioe-cli7-cfg-clk", clk_rates_300000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI8_CFG_CLK, "lsioe-cli8-cfg-clk", clk_rates_300000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI9_CFG_CLK, "lsioe-cli9-cfg-clk", clk_rates_300000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI10_CFG_CLK, "lsioe-cli10-cfg-clk", clk_rates_300000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI11_CFG_CLK, "lsioe-cli11-cfg-clk", clk_rates_300000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI12_CFG_CLK, "lsioe-cli12-cfg-clk", clk_rates_300000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI13_CFG_CLK, "lsioe-cli13-cfg-clk", clk_rates_300000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI14_CFG_CLK, "lsioe-cli14-cfg-clk", clk_rates_300000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI7_SPI_CLK, "lsioe-cli7-spi-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI8_SPI_CLK, "lsioe-cli8-spi-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI9_SPI_CLK, "lsioe-cli9-spi-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI10_SPI_CLK, "lsioe-cli10-spi-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI11_SPI_CLK, "lsioe-cli11-spi-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI12_SPI_CLK, "lsioe-cli12-spi-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI13_SPI_CLK, "lsioe-cli13-spi-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI14_SPI_CLK, "lsioe-cli14-spi-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI7_I2C_CLK, "lsioe-cli7-i2c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI8_I2C_CLK, "lsioe-cli8-i2c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI9_I2C_CLK, "lsioe-cli9-i2c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI10_I2C_CLK, "lsioe-cli10-i2c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI11_I2C_CLK, "lsioe-cli11-i2c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI12_I2C_CLK, "lsioe-cli12-i2c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI13_I2C_CLK, "lsioe-cli13-i2c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI14_I2C_CLK, "lsioe-cli14-i2c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI7_UART_CLK, "lsioe-cli7-uart-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI8_UART_CLK, "lsioe-cli8-uart-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI9_UART_CLK, "lsioe-cli9-uart-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI10_UART_CLK, "lsioe-cli10-uart-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI11_UART_CLK, "lsioe-cli11-uart-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI12_UART_CLK, "lsioe-cli12-uart-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI13_UART_CLK, "lsioe-cli13-uart-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI14_UART_CLK, "lsioe-cli14-uart-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI7_I3C_CLK, "lsioe-cli7-i3c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI8_I3C_CLK, "lsioe-cli8-i3c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI9_I3C_CLK, "lsioe-cli9-i3c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI10_I3C_CLK, "lsioe-cli10-i3c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI11_I3C_CLK, "lsioe-cli11-i3c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI12_I3C_CLK, "lsioe-cli12-i3c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI13_I3C_CLK, "lsioe-cli13-i3c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_E, LSIOE_CLI14_I3C_CLK, "lsioe-cli14-i3c-clk", clk_rates_200000000),
+	CPM_CLK_LGA_SMC(LSIO_E, LSIOE_GPIO_CLK, "lsioe-gpio-clk"),
+	CPM_CLK_LGA(LSIO_E, LSIOE_SPMI_CLK, "lsioe-spmi-clk", clk_rates_300000000),
+
+	/* LSIO_N */
+	CPM_CLK_LGA(LSIO_N, LSION_CLI15_CFG_CLK, "lsion-cli15-cfg-clk", clk_rates_300000000),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI16_CFG_CLK, "lsion-cli16-cfg-clk", clk_rates_300000000),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI15_I2C_CLK, "lsion-cli15-i2c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI16_I2C_CLK, "lsion-cli16-i2c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI15_UART_CLK, "lsion-cli15-uart-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI16_UART_CLK, "lsion-cli16-uart-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI15_SPI_CLK, "lsion-cli15-spi-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI16_SPI_CLK, "lsion-cli16-spi-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI15_I3C_CLK, "lsion-cli15-i3c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI16_I3C_CLK, "lsion-cli16-i3c-clk", clk_rates_200000000),
+	CPM_CLK_LGA_NO_RATES(LSIO_N, LSION_GPIO_CLK, "lsion-gpio-clk"),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI_INT0_I2C_CLK, "lsion-cli-int0-i2c-clk", clk_rates_200000000),
+	CPM_CLK_LGA_NO_RATES(LSIO_N, LSION_CLI_INT0_I3C_CLK, "lsion-cli-int0-i3c-clk"),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI_INT0_UART_CLK, "lsion-cli-int0-uart-clk",
+		    clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI_INT0_SPI_CLK, "lsion-cli-int0-spi-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI_INT0_CFG_CLK, "lsion-cli-int0-cfg-clk", clk_rates_300000000),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI_INT1_I2C_CLK, "lsion-cli-int1-i2c-clk", clk_rates_200000000),
+	CPM_CLK_LGA_NO_RATES(LSIO_N, LSION_CLI_INT1_I3C_CLK, "lsion-cli-int1-i3c-clk"),
+	CPM_CLK_LGA_NO_RATES(LSIO_N, LSION_CLI_INT1_UART_CLK, "lsion-cli-int1-uart-clk"),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI_INT1_SPI_CLK, "lsion-cli-int1-spi-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI_INT1_CFG_CLK, "lsion-cli-int1-cfg-clk", clk_rates_300000000),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI_INT2_I2C_CLK, "lsion-cli-int2-i2c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI_INT2_I3C_CLK, "lsion-cli-int2-i3c-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI_INT2_UART_CLK, "lsion-cli-int2-uart-clk",
+		    clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI_INT2_SPI_CLK, "lsion-cli-int2-spi-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI_INT2_CFG_CLK, "lsion-cli-int2-cfg-clk", clk_rates_300000000),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI_INT3_I2C_CLK, "lsion-cli-int3-i2c-clk", clk_rates_200000000),
+	CPM_CLK_LGA_NO_RATES(LSIO_N, LSION_CLI_INT3_I3C_CLK, "lsion-cli-int3-i3c-clk"),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI_INT3_UART_CLK, "lsion-cli-int3-uart-clk",
+		    clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI_INT3_SPI_CLK, "lsion-cli-int3-spi-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI_INT3_CFG_CLK, "lsion-cli-int3-cfg-clk", clk_rates_300000000),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI_INT4_I2C_CLK, "lsion-cli-int4-i2c-clk", clk_rates_200000000),
+	CPM_CLK_LGA_NO_RATES(LSIO_N, LSION_CLI_INT4_I3C_CLK, "lsion-cli-int4-i3c-clk"),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI_INT4_UART_CLK, "lsion-cli-int4-uart-clk",
+		    clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI_INT4_SPI_CLK, "lsion-cli-int4-spi-clk", clk_rates_200000000),
+	CPM_CLK_LGA(LSIO_N, LSION_CLI_INT4_CFG_CLK, "lsion-cli-int4-cfg-clk", clk_rates_300000000),
+
+	/* DPU */
+	CPM_CLK_LGA_DIV(DPU, DPU_DP0_PIX_CLK, "dpu-dp0-pix-clk",
+			"gpcm-dpu-pll-dp-clk", clk_divs_dp, clk_rates_dp_osc),
+	CPM_CLK_LGA_DIV(DPU, DPU_DP1_PIX_CLK, "dpu-dp1-pix-clk",
+			"gpcm-dpu-pll-dp-clk", clk_divs_dp, clk_rates_dp_osc),
+	CPM_CLK_LGA(DPU, DPU_DSI0_PIX_CLK, "dpu-dsi0-pix-clk", clk_rates_100000000_150000000),
+	CPM_CLK_LGA(DPU, DPU_DSI1_PIX_CLK, "dpu-dsi1-pix-clk", clk_rates_100000000_150000000),
+	CPM_CLK_LGA(DPU, DPU_DSI1_PHY_CLK, "dpu-dsi1-phy-clk", clk_rates_300000000),
+};
+
+static const int lga_lpcm_to_pd[] = {
+	[0 ... LGA_LPCM_GSA] = -1,
+	[LGA_LPCM_AOC] = LGA_PD_SSWRP_AOC,
+	[LGA_LPCM_AURORA] = LGA_PD_SSWRP_AURORA,
+	[LGA_LPCM_CODEC_3P] = LGA_PD_SSWRP_CODEC_3P,
+	[LGA_LPCM_DPU] = LGA_PD_SSWRP_DPU,
+	[LGA_LPCM_EH] = LGA_PD_SSWRP_EH,
+	[LGA_LPCM_G2D] = LGA_PD_SSWRP_G2D,
+	[LGA_LPCM_GPDMA] = LGA_PD_SSWRP_GPDMA,
+	[LGA_LPCM_GPU] = LGA_PD_SSWRP_GPU,
+	[LGA_LPCM_GSW] = LGA_PD_SSWRP_GSW,
+	[LGA_LPCM_HSIO_N] = LGA_PD_SSWRP_HSIO_N,
+	[LGA_LPCM_HSIO_S] = LGA_PD_SSWRP_HSIO_S,
+	[LGA_LPCM_ISPBE] = LGA_PD_SSWRP_ISPBE,
+	[LGA_LPCM_ISPFE] = LGA_PD_SSWRP_ISPFE,
+	[LGA_LPCM_LSIO_E] = LGA_PD_SSWRP_LSIO_E,
+	[LGA_LPCM_LSIO_N] = LGA_PD_SSWRP_LSIO_N,
+	[LGA_LPCM_LSIO_S] = LGA_PD_SSWRP_LSIO_S,
+	[LGA_LPCM_TPU] = LGA_PD_SSWRP_TPU,
+};
+
+const struct cpm_clk_soc_data cpm_clk_lga_data = {
+	.clks = cpm_clks_lga,
+	.num_clks = ARRAY_SIZE(cpm_clks_lga),
+	.lpcm_to_pd = lga_lpcm_to_pd,
+	.num_lpcm_to_pd = ARRAY_SIZE(lga_lpcm_to_pd),
+};
diff --git a/drivers/clk/google/clk-cpm.c b/drivers/clk/google/clk-cpm.c
new file mode 100644
index 000000000000..5ab578dbb88e
--- /dev/null
+++ b/drivers/clk/google/clk-cpm.c
@@ -0,0 +1,573 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2023-2026 Google LLC
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/clk-provider.h>
+#include <linux/container_of.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+
+#include <soc/google/goog_cpm_service_ids.h>
+#include <soc/google/google-cpm-mba.h>
+
+#include "clk-cpm-internal.h"
+
+#define MAILBOX_SEND_TIMEOUT_MS			3000
+#define LPCM_CMD_SET_LCM_CLK			0x2
+
+#define OP_ID_BITFIELD				GENMASK(31, 24)
+#define CLOCK_ID_BITFIELD			GENMASK(23, 16)
+#define LPCM_ID_BITFIELD			GENMASK(15, 8)
+#define REQ_ID_BITFIELD				GENMASK(7, 0)
+
+#define PREPARE_OP_ID				0
+#define UNPREPARE_OP_ID				1
+#define IS_ENABLE_OP_ID				2
+#define RECALC_RATE_OP_ID			3
+#define ROUND_RATE_OP_ID			4
+#define SET_RATE_OP_ID				5
+
+/* PREPARE_OP_ID / UNPREPARE_OP_ID */
+#define CLK_GATE				1
+
+#define NO_ERROR				0
+#define ERR_LPCM_NOT_SUPPORTED			(-24)
+#define ERR_LPCM_INVALID_ARGS			(-8)
+#define ERR_LPCM_TIMED_OUT			(-13)
+#define ERR_LPCM_UNAVAILABLE			(-3)
+#define ERR_LPCM_GENERIC			(-1)
+
+#define SIP_SVC_CLK_CONTROL			0x82000702
+
+#define to_goog_cpm_clk(_hw) container_of(_hw, struct goog_cpm_clk, hw)
+
+struct goog_cpm_clk {
+	struct clk_hw hw;
+	struct goog_cpm_clk_dev_data *dev_data;
+	const char *name;
+
+	unsigned int lpcm_id;
+	unsigned int clock_id;
+	const unsigned long *rates;
+	int nr_rates;
+	const unsigned int *divs;
+	int nr_divs;
+	bool use_smc;
+};
+
+struct goog_cpm_clk_dev_data {
+	struct device *dev;
+	struct cpm_client *cpm_client;
+	struct goog_cpm_clk **clks;
+	int num_clks;
+};
+
+static void goog_cpm_clk_pd_dev_release(struct device *dev)
+{
+	kfree(dev);
+}
+
+static void goog_cpm_clk_unregister_pd_dev(void *data)
+{
+	struct device *clk_dev = data;
+
+	pm_runtime_disable(clk_dev);
+	pm_genpd_remove_device(clk_dev);
+	device_unregister(clk_dev);
+}
+
+static void goog_cpm_clk_hw_unregister(void *data)
+{
+	struct clk_hw *hw = data;
+
+	clk_hw_unregister(hw);
+}
+
+static bool goog_cpm_clk_can_adjust_clk_rate(struct goog_cpm_clk *cpm_clk)
+{
+	return cpm_clk->nr_rates > 0 || cpm_clk->nr_divs > 0;
+}
+
+static int goog_cpm_clk_mba_resp_hdl(struct goog_cpm_clk *cpm_clk, int result)
+{
+	struct device *dev = cpm_clk->dev_data->dev;
+	const char *name = cpm_clk->name;
+
+	if (result >= 0)
+		return result; /* .recalc_rate returns clock's frequency instead of err code */
+
+	switch (result) {
+	case ERR_LPCM_NOT_SUPPORTED:
+		dev_err(dev, "%s: the received request_id is invalid\n", name);
+		return -EPROTO;
+	case ERR_LPCM_INVALID_ARGS:
+		dev_err(dev, "%s: invalid lpcm_id or clock_id\n", name);
+		return -EINVAL;
+	case ERR_LPCM_TIMED_OUT:
+		dev_err(dev, "%s: operation timed out\n", name);
+		return -ETIMEDOUT;
+	case ERR_LPCM_GENERIC:
+		dev_err(dev, "%s: internal error occurred\n", name);
+		return -ESERVERFAULT;
+	case ERR_LPCM_UNAVAILABLE:
+		dev_err(dev, "%s: CPM unavailable\n", name);
+		return -ENODATA;
+	default:
+		dev_err(dev, "%s: unknown error response from CPM (%d)\n", name, result);
+		return -EPROTO;
+	}
+}
+
+static int goog_cpm_clk_send_mba_mail(struct goog_cpm_clk *cpm_clk, u8 op_id,
+				      unsigned long *clk_param)
+{
+	struct device *dev = cpm_clk->dev_data->dev;
+	struct cpm_payload resp_msg;
+	struct cpm_payload req_msg = {};
+	struct cpm_request cpm_req = {
+		.msg_type = REQUEST_MSG,
+		.req_msg = &req_msg,
+		.resp_msg = &resp_msg,
+		.dst_id = CPM_COMMON_LPCM_SERVICE,
+		.tout_ms = MAILBOX_SEND_TIMEOUT_MS,
+	};
+	int ret;
+
+	req_msg.payload[0] = FIELD_PREP(REQ_ID_BITFIELD, LPCM_CMD_SET_LCM_CLK) |
+			     FIELD_PREP(LPCM_ID_BITFIELD, cpm_clk->lpcm_id) |
+			     FIELD_PREP(CLOCK_ID_BITFIELD, cpm_clk->clock_id) |
+			     FIELD_PREP(OP_ID_BITFIELD, op_id);
+
+	if (op_id == SET_RATE_OP_ID || op_id == PREPARE_OP_ID ||
+	    op_id == UNPREPARE_OP_ID) {
+		if (!clk_param) {
+			dev_err(dev, "clk_param is NULL for op_id %d\n", op_id);
+			return -EINVAL;
+		}
+		req_msg.payload[1] = *clk_param;
+	}
+
+	dev_dbg(dev, "lpcm_id %d, clock_id %d: send mba mail: [%d, %d, %d]\n",
+		cpm_clk->lpcm_id, cpm_clk->clock_id, req_msg.payload[0],
+		req_msg.payload[1], req_msg.payload[2]);
+
+	ret = cpm_send_message(cpm_clk->dev_data->cpm_client, &cpm_req);
+	if (ret < 0) {
+		dev_err(dev, "lpcm_id %d, clock_id %d: failed to send request to CPM, ret=%d\n",
+			cpm_clk->lpcm_id, cpm_clk->clock_id, ret);
+		return ret;
+	}
+
+	dev_dbg(dev, "got resp from %u, data %d.\n", cpm_req.dst_id,
+		resp_msg.payload[0]);
+	return goog_cpm_clk_mba_resp_hdl(cpm_clk, resp_msg.payload[0]);
+}
+
+static int goog_cpm_clk_send_mbox_msg_set_gate(struct goog_cpm_clk *cpm_clk,
+					       bool enable)
+{
+	int op_id = enable ? PREPARE_OP_ID : UNPREPARE_OP_ID;
+	unsigned long param = CLK_GATE;
+
+	return goog_cpm_clk_send_mba_mail(cpm_clk, op_id, &param);
+}
+
+static int goog_cpm_clk_send_mbox_msg_set_rate(struct goog_cpm_clk *cpm_clk,
+					       unsigned long rate)
+{
+	return goog_cpm_clk_send_mba_mail(cpm_clk, SET_RATE_OP_ID, &rate);
+}
+
+static int goog_cpm_clk_send_mbox_msg_recalc_rate(struct goog_cpm_clk *cpm_clk)
+{
+	return goog_cpm_clk_send_mba_mail(cpm_clk, RECALC_RATE_OP_ID, NULL);
+}
+
+static int goog_cpm_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long parent_rate)
+{
+	struct goog_cpm_clk *cpm_clk = to_goog_cpm_clk(hw);
+	unsigned long param = rate;
+
+	for (int i = 0; i < cpm_clk->nr_divs; i++) {
+		if (parent_rate / cpm_clk->divs[i] == rate) {
+			param = cpm_clk->divs[i];
+			break;
+		}
+	}
+
+	for (int i = 0; i < cpm_clk->nr_rates; i++) {
+		if (cpm_clk->rates[i] == rate) {
+			param = rate;
+			break;
+		}
+	}
+
+	dev_dbg(cpm_clk->dev_data->dev,
+		"%s: lpcm_id %d, clock_id %d: set rate %lu (param %lu)\n",
+		cpm_clk->name, cpm_clk->lpcm_id, cpm_clk->clock_id, rate, param);
+	return goog_cpm_clk_send_mbox_msg_set_rate(cpm_clk, param);
+}
+
+static unsigned long goog_cpm_clk_recalc_rate(struct clk_hw *hw,
+					      unsigned long parent_rate)
+{
+	struct goog_cpm_clk *cpm_clk = to_goog_cpm_clk(hw);
+	int ret;
+
+	dev_dbg(cpm_clk->dev_data->dev, "%s: lpcm_id %d, clock_id %d: get rate\n",
+		cpm_clk->name, cpm_clk->lpcm_id, cpm_clk->clock_id);
+	ret = goog_cpm_clk_send_mbox_msg_recalc_rate(cpm_clk);
+	if (ret < 0)
+		return 0;
+
+	for (int i = 0; i < cpm_clk->nr_divs; i++) {
+		if (ret == cpm_clk->divs[i])
+			return parent_rate / ret;
+	}
+
+	return ret;
+}
+
+static int goog_cpm_clk_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
+{
+	struct goog_cpm_clk *cpm_clk = to_goog_cpm_clk(hw);
+	unsigned long best_rate = ULONG_MAX;
+	unsigned long max_rate = 0;
+
+	dev_dbg(cpm_clk->dev_data->dev, "%s: lpcm_id %d, clock_id %d: determine rate for %lu\n",
+		cpm_clk->name, cpm_clk->lpcm_id, cpm_clk->clock_id, req->rate);
+
+	for (int i = 0; i < cpm_clk->nr_rates; i++) {
+		unsigned long rate = cpm_clk->rates[i];
+
+		if (rate >= req->rate && rate < best_rate)
+			best_rate = rate;
+		if (rate > max_rate)
+			max_rate = rate;
+	}
+
+	for (int i = 0; i < cpm_clk->nr_divs; i++) {
+		unsigned long rate = req->best_parent_rate / cpm_clk->divs[i];
+
+		if (rate >= req->rate && rate < best_rate)
+			best_rate = rate;
+		if (rate > max_rate)
+			max_rate = rate;
+	}
+
+	if (best_rate != ULONG_MAX) {
+		req->rate = best_rate;
+		return 0;
+	}
+	if (max_rate > 0) {
+		req->rate = max_rate;
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static inline int lpcm_smc(struct clk_hw *hw, bool enable)
+{
+	struct goog_cpm_clk *cpm_clk = to_goog_cpm_clk(hw);
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(SIP_SVC_CLK_CONTROL, cpm_clk->lpcm_id, cpm_clk->clock_id,
+		      enable, 0, 0, 0, 0, &res);
+
+	WARN_ON(res.a0);
+	if ((unsigned long)res.a1) {
+		dev_err(cpm_clk->dev_data->dev,
+			"Failed LPCM SMC: %d clk_id: %d, enable: %d res.a1: %lu\n",
+			cpm_clk->lpcm_id, cpm_clk->clock_id, enable, res.a1);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int goog_cpm_clk_prepare(struct clk_hw *hw)
+{
+	struct goog_cpm_clk *cpm_clk = to_goog_cpm_clk(hw);
+
+	dev_dbg(cpm_clk->dev_data->dev, "%s: lpcm_id %d, clock_id %d: enable\n",
+		cpm_clk->name, cpm_clk->lpcm_id, cpm_clk->clock_id);
+
+	return goog_cpm_clk_send_mbox_msg_set_gate(cpm_clk, true);
+}
+
+static void goog_cpm_clk_unprepare(struct clk_hw *hw)
+{
+	struct goog_cpm_clk *cpm_clk = to_goog_cpm_clk(hw);
+
+	dev_dbg(cpm_clk->dev_data->dev, "%s: lpcm_id %d, clock_id %d: disable\n",
+		cpm_clk->name, cpm_clk->lpcm_id, cpm_clk->clock_id);
+
+	goog_cpm_clk_send_mbox_msg_set_gate(cpm_clk, false);
+}
+
+static int goog_cpm_clk_smc_enable(struct clk_hw *hw)
+{
+	struct goog_cpm_clk *cpm_clk = to_goog_cpm_clk(hw);
+
+	dev_dbg(cpm_clk->dev_data->dev, "%s: lpcm_id %d, clock_id %d: enable\n",
+		cpm_clk->name, cpm_clk->lpcm_id, cpm_clk->clock_id);
+
+	return lpcm_smc(hw, true);
+}
+
+static void goog_cpm_clk_smc_disable(struct clk_hw *hw)
+{
+	struct goog_cpm_clk *cpm_clk = to_goog_cpm_clk(hw);
+
+	dev_dbg(cpm_clk->dev_data->dev, "%s: lpcm_id %d, clock_id %d: disable\n",
+		cpm_clk->name, cpm_clk->lpcm_id, cpm_clk->clock_id);
+
+	lpcm_smc(hw, false);
+}
+
+static const struct clk_ops goog_cpm_mutable_rate_clk_ops = {
+	.set_rate = goog_cpm_clk_set_rate,
+	.recalc_rate = goog_cpm_clk_recalc_rate,
+	.determine_rate = goog_cpm_clk_determine_rate,
+	.prepare = goog_cpm_clk_prepare,
+	.unprepare = goog_cpm_clk_unprepare,
+};
+
+static const struct clk_ops goog_cpm_gate_clk_ops = {
+	.prepare = goog_cpm_clk_prepare,
+	.unprepare = goog_cpm_clk_unprepare,
+};
+
+static const struct clk_ops goog_cpm_gate_smc_clk_ops = {
+	.enable = goog_cpm_clk_smc_enable,
+	.disable = goog_cpm_clk_smc_disable,
+};
+
+static struct device *goog_cpm_clk_attach_pd(struct device *dev, const char *name,
+					     int pd_id)
+{
+	struct of_phandle_args genpdspec = {
+		.np = dev->of_node,
+		.args_count = 1,
+		.args[0] = pd_id,
+	};
+	struct device *clk_dev;
+	int err;
+
+	/*
+	 * No need for a new device if there's no domain to attach. Just reuse
+	 * the controller device.
+	 */
+	if (pd_id < 0)
+		return dev;
+
+	clk_dev = kzalloc_obj(*clk_dev, GFP_KERNEL);
+	if (!clk_dev)
+		return ERR_PTR(-ENOMEM);
+
+	device_initialize(clk_dev);
+	clk_dev->parent = dev;
+	clk_dev->release = goog_cpm_clk_pd_dev_release;
+	dev_set_name(clk_dev, "%s:%s", dev_name(dev), name);
+
+	err = device_add(clk_dev);
+	if (err) {
+		put_device(clk_dev);
+		return ERR_PTR(err);
+	}
+
+	err = of_genpd_add_device(&genpdspec, clk_dev);
+	if (err) {
+		device_unregister(clk_dev);
+		if (err == -ENOENT)
+			err = -EPROBE_DEFER;
+		return ERR_PTR(dev_err_probe(dev, err,
+					     "failed to attach %s to power domain %d\n",
+					     name, pd_id));
+	}
+
+	pm_runtime_enable(clk_dev);
+
+	err = devm_add_action_or_reset(dev, goog_cpm_clk_unregister_pd_dev, clk_dev);
+	if (err)
+		return ERR_PTR(err);
+
+	return clk_dev;
+}
+
+static struct goog_cpm_clk *
+goog_cpm_clk_register_clk(struct device *dev,
+			  const struct cpm_clk_data *clk_data,
+			  const struct cpm_clk_soc_data *soc_data,
+			  struct goog_cpm_clk_dev_data *dev_data)
+{
+	struct goog_cpm_clk *cpm_clk;
+	struct clk_init_data init = {};
+	const char *name = clk_data->name;
+	struct device *clk_dev;
+	int pd_id = -1;
+	int err;
+
+	cpm_clk = devm_kzalloc(dev, sizeof(*cpm_clk), GFP_KERNEL);
+	if (!cpm_clk)
+		return ERR_PTR(-ENOMEM);
+
+	cpm_clk->name = name;
+	cpm_clk->lpcm_id = clk_data->lpcm_id;
+	cpm_clk->clock_id = clk_data->clock_id;
+	cpm_clk->use_smc = clk_data->use_smc;
+	cpm_clk->rates = clk_data->rates;
+	cpm_clk->nr_rates = clk_data->nr_rates;
+	cpm_clk->divs = clk_data->divs;
+	cpm_clk->nr_divs = clk_data->nr_divs;
+	cpm_clk->dev_data = dev_data;
+
+	if (soc_data->lpcm_to_pd && clk_data->lpcm_id < soc_data->num_lpcm_to_pd)
+		pd_id = soc_data->lpcm_to_pd[clk_data->lpcm_id];
+
+	clk_dev = goog_cpm_clk_attach_pd(dev, name, pd_id);
+	if (IS_ERR(clk_dev))
+		return ERR_CAST(clk_dev);
+
+	init.name = name;
+	init.flags = CLK_GET_RATE_NOCACHE;
+	if (clk_data->parent_name) {
+		init.parent_names = &clk_data->parent_name;
+		init.num_parents = 1;
+	}
+	if (goog_cpm_clk_can_adjust_clk_rate(cpm_clk))
+		init.ops = &goog_cpm_mutable_rate_clk_ops;
+	else if (cpm_clk->use_smc)
+		init.ops = &goog_cpm_gate_smc_clk_ops;
+	else
+		init.ops = &goog_cpm_gate_clk_ops;
+	cpm_clk->hw.init = &init;
+
+	err = clk_hw_register(clk_dev, &cpm_clk->hw);
+	if (err) {
+		dev_err(dev, "%s: failed to register clk hw: %d\n", name, err);
+		return ERR_PTR(err);
+	}
+
+	/*
+	 * Attach teardown to the controller dev (not clk_dev) so the clock is
+	 * unregistered with driver teardown, not with (late) device cleanup.
+	 */
+	err = devm_add_action_or_reset(dev, goog_cpm_clk_hw_unregister, &cpm_clk->hw);
+	if (err)
+		return ERR_PTR(err);
+
+	return cpm_clk;
+}
+
+static struct clk_hw *
+goog_cpm_clk_of_xlate(struct of_phandle_args *clkspec, void *data)
+{
+	struct goog_cpm_clk_dev_data *dev_data = data;
+	u32 lpcm_id, clock_id;
+	int i;
+
+	if (clkspec->args_count != 2)
+		return ERR_PTR(-EINVAL);
+
+	lpcm_id = clkspec->args[0];
+	clock_id = clkspec->args[1];
+
+	for (i = 0; i < dev_data->num_clks; i++) {
+		if (dev_data->clks[i]->lpcm_id == lpcm_id &&
+		    dev_data->clks[i]->clock_id == clock_id)
+			return &dev_data->clks[i]->hw;
+	}
+
+	return ERR_PTR(-ENOENT);
+}
+
+static const struct of_device_id cpm_clk_of_match[] = {
+	{ .compatible = "google,lga-cpm", .data = &cpm_clk_lga_data },
+	{ }
+};
+
+static int goog_cpm_clk_controller_probe(struct auxiliary_device *auxdev,
+					 const struct auxiliary_device_id *id)
+{
+	struct device *dev = &auxdev->dev;
+	struct device_node *node = dev->of_node;
+	struct goog_cpm_clk_dev_data *dev_data;
+	const struct of_device_id *match;
+	const struct cpm_clk_soc_data *soc_data;
+	int ret, i;
+
+	if (!node) {
+		dev_err(dev, "No device tree node associated with device\n");
+		return -ENODEV;
+	}
+
+	match = of_match_node(cpm_clk_of_match, node);
+	if (!match) {
+		dev_err(dev, "unsupported CPM compatible\n");
+		return -ENODEV;
+	}
+	soc_data = match->data;
+
+	dev_data = devm_kzalloc(dev, sizeof(*dev_data), GFP_KERNEL);
+	if (!dev_data)
+		return -ENOMEM;
+
+	dev_data->dev = dev;
+
+	dev_data->cpm_client = devm_cpm_request_client(dev, 0, NULL, NULL);
+	if (IS_ERR(dev_data->cpm_client))
+		return dev_err_probe(dev, PTR_ERR(dev_data->cpm_client),
+				     "Failed to request cpm client\n");
+
+	dev_data->num_clks = soc_data->num_clks;
+	dev_data->clks = devm_kcalloc(dev, dev_data->num_clks,
+				      sizeof(*dev_data->clks), GFP_KERNEL);
+	if (!dev_data->clks)
+		return -ENOMEM;
+
+	auxiliary_set_drvdata(auxdev, dev_data);
+
+	for (i = 0; i < dev_data->num_clks; i++) {
+		struct goog_cpm_clk *cpm_clk;
+
+		cpm_clk = goog_cpm_clk_register_clk(dev, &soc_data->clks[i], soc_data, dev_data);
+		if (IS_ERR(cpm_clk))
+			return PTR_ERR(cpm_clk);
+
+		dev_data->clks[i] = cpm_clk;
+	}
+
+	ret = devm_of_clk_add_hw_provider(dev, goog_cpm_clk_of_xlate, dev_data);
+	if (ret) {
+		dev_err(dev, "failed to add clock provider: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct auxiliary_device_id goog_cpm_clk_id_table[] = {
+	{ .name = "google_cpm_mba.clk" },
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, goog_cpm_clk_id_table);
+
+static struct auxiliary_driver goog_cpm_clk_driver = {
+	.probe = goog_cpm_clk_controller_probe,
+	.name = "google-clk-cpm",
+	.id_table = goog_cpm_clk_id_table,
+};
+
+module_auxiliary_driver(goog_cpm_clk_driver);
+
+MODULE_DESCRIPTION("Google CPM Clock Driver");
+MODULE_LICENSE("GPL");
-- 
2.56.0.307.g5fe7bd680c-goog

