Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795565194;
	b=MDOZR8EJw53xKJTuTHHzQH9NaAPqwQ/hgJqWg/IMsihk6wPD73gpCF/WmN9k3+1oI9on
	 AEhyeqX6cjLG5ARhUIv18DnOAcAKcxz+BbwJ5cp2oLjhlBUem8+cwLwgqUIQWkRq4yLeJ
	 Zn60IbzWQ0yg0kz7TJ7MM0yVsG8jPVrSl3XnJgnTJzGvm4n65pKv03o6RBQqNBOYL4MLP
	 2ACqnR6OkGHocy2EpAcDn/9wMC9cvnfZneiMONwbgrC+q0RD6jyuqpM6Tgt2kWwR7tEq1
	 k4wm2MK5Yq83MIWoX2c+JCGvmFg6jPGH1EdvDq4XS6BUuJfjx9ibw/6l9OXoHY8HIig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795565194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=43JnkmLbnd5h3/EKldiAk0E/j/UvEn4C3vytWaUkdA8=;
	b=Mciukn8ianGAwhvoIqG3CUvx5hl6MagFUnXtATFKxcv9ydS4f7r7D72au30+3nulRg0p
	 svf6JYqrip/XTRI2gNPh0IEPNHl+JYQx2w4WzevlhB4auXPqsP3Fc6ysi2Mdj7KGLmMal
	 r18I09yYHg4hEAbhdP5q2xTRKOpw+gCJGj8WR5KjFIqTcJ5owqcoIvciwVV5CXGIIYMsY
	 ujhbPXODYtLWHyVVpRIe/ZUaZ8nYiF7uAX3Tk+ghPrGdzYGyCt3LTIz47UC8WZMLbQ34/
	 LZ2DUkHBgic8CLZVM2MK/6hnudwJOZcgnzB2B1SVdh07ZHDwBKPslc8348SkDagncNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="Hdx/FJzN";
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1E2606A681
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 00:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D1E2606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Hdx/FJzN
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1b50a4bd2f3so2332904c88.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 16:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795565193; x=1796169993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=43JnkmLbnd5h3/EKldiAk0E/j/UvEn4C3vytWaUkdA8=;
        b=Hdx/FJzNqVwelwU37ng7a2qKCP1SWhDTBYqRiWbNcOI5KAr+pMcbgxXyXu14/5QLiW
         bPfu+k2Ed/UzDQq2aa+tlIACQ4uwi9eTDKfOTimURlLUuCHJbgzvFZB9WkRngkrPyu1i
         fsn/QxMxGY64naXv8cJVsfln1/VxPyCni/DMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795565193; x=1796169993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=43JnkmLbnd5h3/EKldiAk0E/j/UvEn4C3vytWaUkdA8=;
        b=pWQAaEgBImxVja7TqQDKFw/gXM6iLgtV/lxFfO+wX2a39p0oJDNZy21x9YWe2zmfhH
         hJNKXlOCMGEMbNNuVXR6lFkGxjxuLLqUGMpxGqRQZ71qjCB8RElHlJtCg+6dSytjWQKV
         B++N2Zfq3BKrgrvxtxuPda5aSB6AXnXTIp6Pl49aBLTBqUwgBoDM2xaf+rurddMk9NSl
         GIxEhAc0sAkK2EM9nSdvjarD2Qv17HnWwWuOBUHEJbirOspB5HqECsS7ckQ8Pe0Le55e
         TgIPZW1U3bJEs3cUB1k4M95m6VAaj23ICLRMPSCKYwT051m54rSUwV/rD7rLfqnuZRWO
         6ZnQ==
X-Forwarded-Encrypted: i=1; AL+hErFPxPYwrSjzh2u/+DVtVbcN+wBnCHH28Jl2y96bF8BkzDpNNdpl5bXUav/6JMzytawPAeMuyxIpEQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9V8IV2W2RV7wTWRyAh+KScK7JIHFcl0P6JU8aNm276Kew0nsFz
	wA81uI+leu3XRdsV351bKCgLg6HiPAL2xYZknIT7CGvBeRHaKRc45MpLkcpNps+oaw==
X-Gm-Gg: AZFdTZcTuujg23LnaN1y38wTJ+7wtH0yvZm4zTuGEuA2Qcbs1PhoEm2Y1e9fIKE1lyu
	Q+UabT8OQHm8PAdTCS/JUzkaCFW2DWeaOp1GDSTGA8F7F7uacECXW6HeOuocBB+ELitG5Du+xir
	uLxMAse4vl69PqMnhkbLF8DvUi4qx3bvXaqJWPmxOFUkaXEa5/BLL6Kk/ZkF81nNO2+v3mY+RPH
	EiKOM8oVmQ4zdN6BUiUgjYchY9YFPHhaccXAy9jqaJP0n+2NsrItQHAKHinFkffy5TtqIiBkXMn
	AsVVmZ/waKlIxnasx5yHIxqoksnqO52bgtONIiUyRyhiuGY5VgPDDT/CoPj4nbeS0NeB8GuPp5y
	kFMR8OU5W/YED2ot8ZgwrB8uKA34pyMWygQ1wwsvXDuURD6CflVv9b5HLgP9OoIfTKJMxTEotGt
	tO+iUUENpxK9VIcS/O3DkGTWk5aYhNVETTgBpGKRonOiw264uuI1BjF5Zby945WgBjVWnC/KTV+
	aP6feF4poGtQpgBED3pQnTd/Z2o1OgvTsOSyg8/OX4WJP/bQL3MYKZv26q/gjuwBmSEdT4ZWKlF
	L5Am2m17EfxDl7DKSPnrWgEhGoXPh0pMGO4FhvB094sMVsJtIOas1y+Nq0zYf8f5uG+ZHc2AD9Z
	roGNgVztFyMLsrg==
X-Received: by 2002:a05:7022:ec17:b0:166:862b:9bcc with SMTP id a92af1059eb24-1b55689ad7amr20770592c88.18.1795565192300;
        Tue, 24 Nov 2026 16:06:32 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ea9b:d8a3:ba44:2d0a])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b5567e2bd1sm36588252c88.3.2026.11.24.16.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 16:06:31 -0800 (PST)
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
Subject: [PATCH v2 4/9] clk: google: Add CPM clock driver
Date: Tue, 24 Nov 2026 16:03:38 -0800
Message-ID: <20261124160343.v2.4.I82dc05365979021379fe730d6d52792a87ff15ed@changeid>
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

Google Tensor SoCs (used on Pixel phones) manage many resources
(including most clocks) using a Central Power Manager (CPM)
co-processor. We communicate with CPM using mailboxes, abstracted in the
devm_cpm_get_handle(), etc., API.

== Clock topology ==

The clock topology is not represented by this driver, because
CPM hides most of the divider, mux, and parent details, instead
maintaining its own internal table of mappings for divider and mux
values.

== No .set_rate() ==

Many clocks can report their rate, and the firmware also supports a
SET_RATE operation. However, the firmware protocol does not enumerate
which rates are supported, nor does it actually support the alleged
ROUND_RATE operation found in its API definition. This makes it
difficult to support .set_rate() without memorizing the rate table (as
done in downstream drivers).

Fortunately, we don't need .set_rate() for the vast majority of CPM
clocks, as they only support a single rate. For now, we omit
.set_rate(), and leave configurable clocks for later.

This leaves a few follow-up items:

 - Clocks not running at their expected rates: while many clocks
   allegedly support only a single rate, some do not appear to
   initialize at that rate by default. Such clocks may be utilized at a
   lower rate, or else may need additional improvements on the firmware
   side. Affected clocks:

     CLK_HSIO_N_PHY_FW (USB PHY firmware)

     CLK_LSIO_S_MCLK* (I2C camera sensor)

 - Configurable clocks: it appears this is only necessary for DP.

== SMC ==

A few clocks are not managed by CPM, but instead utilize an SMC call for
lower latency. We still represent those within this driver, as they are
part of the same clock hierarchy.

== Downstream notes ==

For posterity, I list a summary of changes made relative to the
downstream Pixel driver:

 * CPM clients use the auxiliary_bus, instead of individual platform
   devices (and DT nodes) with phandles to a pseudo-mailbox

 * Instead of device nodes for each clock (and therefore a provider for
   each), we use a per-SoC table of clocks, register them all, and have
   a single clock-cells==1 provider

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

 * Drop all rate tables. Do not support .set_rate() for now.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Simplify clock driver, to avoid memorizing rate tables and clock
   topology that is owned by the remote CPM firmware
 * Rename symbols from goog_cpm_clk* to cpm_clk*
 * Moved shared protocol details to CPM driver
 * Drop all rate/divider tables, and avoid representing clock topology
   in driver -- it's owned by the remote firmware
 * Don't support .set_rate(); this lacks full support for the DP
   clocks, while everything else the kernel just uses as-is.
 * Flatten the of_cells to use just 1 cell, and perform the
   ID-to-firmware mapping in driver-contained tables

 drivers/clk/Kconfig                   |   1 +
 drivers/clk/Makefile                  |   1 +
 drivers/clk/google/Kconfig            |  13 +
 drivers/clk/google/Makefile           |   3 +
 drivers/clk/google/clk-cpm-internal.h |  35 +++
 drivers/clk/google/clk-cpm-lga.c      | 223 +++++++++++++++
 drivers/clk/google/clk-cpm-lga.h      | 194 +++++++++++++
 drivers/clk/google/clk-cpm.c          | 385 ++++++++++++++++++++++++++
 8 files changed, 855 insertions(+)
 create mode 100644 drivers/clk/google/Kconfig
 create mode 100644 drivers/clk/google/Makefile
 create mode 100644 drivers/clk/google/clk-cpm-internal.h
 create mode 100644 drivers/clk/google/clk-cpm-lga.c
 create mode 100644 drivers/clk/google/clk-cpm-lga.h
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
index 000000000000..e1680df4df7d
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
+	bool use_smc;
+};
+
+struct cpm_clk_pd_map {
+	u32 lpcm_id;
+	u32 pd_id;
+};
+
+struct cpm_clk_soc_data {
+	const struct cpm_clk_data *clks;
+	size_t num_clks;
+	const struct cpm_clk_pd_map *pd_map;
+	size_t num_pd_map;
+};
+
+extern const struct cpm_clk_soc_data cpm_clk_lga_data;
+
+#endif /* _GOOGLE_CLK_CPM_INTERNAL_H */
diff --git a/drivers/clk/google/clk-cpm-lga.c b/drivers/clk/google/clk-cpm-lga.c
new file mode 100644
index 000000000000..f5f3ee97504e
--- /dev/null
+++ b/drivers/clk/google/clk-cpm-lga.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2023-2026 Google LLC
+ */
+
+#include <dt-bindings/clock/google,lga-cpm.h>
+#include <dt-bindings/power/google,lga-cpm.h>
+#include <linux/array_size.h>
+#include <soc/google/lga-lpcm-ids.h>
+
+#include "clk-cpm-internal.h"
+#include "clk-cpm-lga.h"
+
+#define CPM_CLK_LGA(domain, id, n)				\
+	[id] = {						\
+		.lpcm_id = LPCM_##domain,			\
+		.clock_id = LPCM_##id,				\
+		.name = n,					\
+	}
+
+#define CPM_CLK_LGA_SMC(domain, id, n)				\
+	[id] = {						\
+		.lpcm_id = LPCM_##domain,			\
+		.clock_id = LPCM_##id,				\
+		.name = n,					\
+		.use_smc = true,				\
+	}
+
+static const struct cpm_clk_data cpm_clks_lga[] = {
+	/* CPU */
+	CPM_CLK_LGA(CPU, CLK_CPU_SSWRP_TSS, "cpu-sswrp-tss-clk"),
+
+	/* DPU */
+	CPM_CLK_LGA(DPU, CLK_DPU_DP0_PIX, "dpu-dp0-pix-clk"),
+	CPM_CLK_LGA(DPU, CLK_DPU_DP1_PIX, "dpu-dp1-pix-clk"),
+	CPM_CLK_LGA(DPU, CLK_DPU_DSI0_PIX, "dpu-dsi0-pix-clk"),
+	CPM_CLK_LGA(DPU, CLK_DPU_DSI1_PIX, "dpu-dsi1-pix-clk"),
+	CPM_CLK_LGA(DPU, CLK_DPU_DSI1_PHY, "dpu-dsi1-phy-clk"),
+
+	/* GPCM */
+	CPM_CLK_LGA(GPCM, CLK_GPCM_DPU_PLL_DP, "gpcm-dpu-pll-dp-clk"),
+	CPM_CLK_LGA(GPCM, CLK_GPCM_HSIO_N_PLL_DP, "gpcm-hsio-n-pll-dp-clk"),
+
+	/* HSIO_N */
+	CPM_CLK_LGA(HSIO_N, CLK_HSIO_N_USB, "hsio-n-usb-clk"),
+	CPM_CLK_LGA(HSIO_N, CLK_HSIO_N_DP0, "hsio-n-dp0-clk"),
+	CPM_CLK_LGA(HSIO_N, CLK_HSIO_N_DP1, "hsio-n-dp1-clk"),
+	CPM_CLK_LGA(HSIO_N, CLK_HSIO_N_PHY_FW, "hsio-n-phy-fw-clk"),
+	CPM_CLK_LGA(HSIO_N, CLK_HSIO_N_USBDP_SUSPEND, "hsio-n-usbdp-suspend-clk"),
+	CPM_CLK_LGA(HSIO_N, CLK_HSIO_N_USBC_NON_STICKY, "hsio-n-usbc-non-sticky-clk"),
+	CPM_CLK_LGA(HSIO_N, CLK_HSIO_N_USBC_STICKY, "hsio-n-usbc-sticky-clk"),
+	CPM_CLK_LGA(HSIO_N, CLK_HSIO_N_USB_DRD_BUS, "hsio-n-usb-drd-bus-clk"),
+	CPM_CLK_LGA(HSIO_N, CLK_HSIO_N_USB_TOP_CSR, "hsio-n-usb-top-csr-clk"),
+	CPM_CLK_LGA(HSIO_N, CLK_HSIO_N_U2PHY_APB, "hsio-n-u2phy-apb-clk"),
+	CPM_CLK_LGA(HSIO_N, CLK_HSIO_N_USB2_PHY_RESET, "hsio-n-usb2-phy-reset-clk"),
+	CPM_CLK_LGA(HSIO_N, CLK_HSIO_N_USB3DP_PHY_RESET, "hsio-n-usb3dp-phy-reset-clk"),
+	CPM_CLK_LGA(HSIO_N, CLK_HSIO_N_EBU, "hsio-n-ebu-clk"),
+
+	/* HSIO_S */
+	CPM_CLK_LGA_SMC(HSIO_S, CLK_HSIO_S_GPIO_REF_TCX0, "hsio-s-gpio-ref-tcx0-clk"),
+	CPM_CLK_LGA(HSIO_S, CLK_HSIO_S_SYS, "hsio-s-sys-clk"),
+	CPM_CLK_LGA(HSIO_S, CLK_HSIO_S_UFS_CFG, "hsio-s-ufs-cfg-clk"),
+	CPM_CLK_LGA(HSIO_S, CLK_HSIO_S_PHY_FW, "hsio-s-phy-fw-clk"),
+	CPM_CLK_LGA(HSIO_S, CLK_HSIO_S_MPHY_REF_TCX0, "hsio-s-mphy-ref-clk"),
+	CPM_CLK_LGA_SMC(HSIO_S, CLK_HSIO_S_AUX, "hsio-s-aux-clk"),
+
+	/* LSIO_E */
+	CPM_CLK_LGA_SMC(LSIO_E, CLK_LSIO_E_GPIO, "lsio-e-gpio-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_SPMI, "lsio-e-spmi-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI7_CFG, "lsio-e-cli7-cfg-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI8_CFG, "lsio-e-cli8-cfg-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI9_CFG, "lsio-e-cli9-cfg-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI10_CFG, "lsio-e-cli10-cfg-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI11_CFG, "lsio-e-cli11-cfg-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI12_CFG, "lsio-e-cli12-cfg-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI13_CFG, "lsio-e-cli13-cfg-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI14_CFG, "lsio-e-cli14-cfg-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI7_SPI, "lsio-e-cli7-spi-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI8_SPI, "lsio-e-cli8-spi-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI9_SPI, "lsio-e-cli9-spi-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI10_SPI, "lsio-e-cli10-spi-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI11_SPI, "lsio-e-cli11-spi-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI12_SPI, "lsio-e-cli12-spi-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI13_SPI, "lsio-e-cli13-spi-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI14_SPI, "lsio-e-cli14-spi-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI7_I2C, "lsio-e-cli7-i2c-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI8_I2C, "lsio-e-cli8-i2c-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI9_I2C, "lsio-e-cli9-i2c-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI10_I2C, "lsio-e-cli10-i2c-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI11_I2C, "lsio-e-cli11-i2c-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI12_I2C, "lsio-e-cli12-i2c-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI13_I2C, "lsio-e-cli13-i2c-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI14_I2C, "lsio-e-cli14-i2c-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI7_UART, "lsio-e-cli7-uart-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI8_UART, "lsio-e-cli8-uart-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI9_UART, "lsio-e-cli9-uart-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI10_UART, "lsio-e-cli10-uart-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI11_UART, "lsio-e-cli11-uart-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI12_UART, "lsio-e-cli12-uart-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI13_UART, "lsio-e-cli13-uart-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI14_UART, "lsio-e-cli14-uart-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI7_I3C, "lsio-e-cli7-i3c-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI8_I3C, "lsio-e-cli8-i3c-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI9_I3C, "lsio-e-cli9-i3c-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI10_I3C, "lsio-e-cli10-i3c-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI11_I3C, "lsio-e-cli11-i3c-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI12_I3C, "lsio-e-cli12-i3c-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI13_I3C, "lsio-e-cli13-i3c-clk"),
+	CPM_CLK_LGA(LSIO_E, CLK_LSIO_E_CLI14_I3C, "lsio-e-cli14-i3c-clk"),
+
+	/* LSIO_N */
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_GPIO, "lsio-n-gpio-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI15_CFG, "lsio-n-cli15-cfg-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI16_CFG, "lsio-n-cli16-cfg-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI15_I2C, "lsio-n-cli15-i2c-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI16_I2C, "lsio-n-cli16-i2c-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI15_UART, "lsio-n-cli15-uart-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI16_UART, "lsio-n-cli16-uart-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI15_SPI, "lsio-n-cli15-spi-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI16_SPI, "lsio-n-cli16-spi-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI15_I3C, "lsio-n-cli15-i3c-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI16_I3C, "lsio-n-cli16-i3c-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI_INT0_I2C, "lsio-n-cli-int0-i2c-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI_INT0_I3C, "lsio-n-cli-int0-i3c-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI_INT0_UART, "lsio-n-cli-int0-uart-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI_INT0_SPI, "lsio-n-cli-int0-spi-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI_INT0_CFG, "lsio-n-cli-int0-cfg-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI_INT1_I2C, "lsio-n-cli-int1-i2c-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI_INT1_I3C, "lsio-n-cli-int1-i3c-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI_INT1_UART, "lsio-n-cli-int1-uart-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI_INT1_SPI, "lsio-n-cli-int1-spi-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI_INT1_CFG, "lsio-n-cli-int1-cfg-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI_INT2_I2C, "lsio-n-cli-int2-i2c-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI_INT2_I3C, "lsio-n-cli-int2-i3c-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI_INT2_UART, "lsio-n-cli-int2-uart-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI_INT2_SPI, "lsio-n-cli-int2-spi-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI_INT2_CFG, "lsio-n-cli-int2-cfg-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI_INT3_I2C, "lsio-n-cli-int3-i2c-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI_INT3_I3C, "lsio-n-cli-int3-i3c-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI_INT3_UART, "lsio-n-cli-int3-uart-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI_INT3_SPI, "lsio-n-cli-int3-spi-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI_INT3_CFG, "lsio-n-cli-int3-cfg-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI_INT4_I2C, "lsio-n-cli-int4-i2c-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI_INT4_I3C, "lsio-n-cli-int4-i3c-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI_INT4_UART, "lsio-n-cli-int4-uart-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI_INT4_SPI, "lsio-n-cli-int4-spi-clk"),
+	CPM_CLK_LGA(LSIO_N, CLK_LSIO_N_CLI_INT4_CFG, "lsio-n-cli-int4-cfg-clk"),
+
+	/* LSIO_S */
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_GPIO, "lsio-s-gpio-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_MCLK0, "lsio-s-mclk0-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_MCLK1, "lsio-s-mclk1-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_MCLK2, "lsio-s-mclk2-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_MCLK3, "lsio-s-mclk3-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_MCLK4, "lsio-s-mclk4-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_MCLK5, "lsio-s-mclk5-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_MCLK6, "lsio-s-mclk6-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_MCLK7, "lsio-s-mclk7-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_PWM, "lsio-s-pwm-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_PWM_CFG, "lsio-s-pwm-cfg-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI0_CFG, "lsio-s-cli0-cfg-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI1_CFG, "lsio-s-cli1-cfg-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI2_CFG, "lsio-s-cli2-cfg-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI3_CFG, "lsio-s-cli3-cfg-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI4_CFG, "lsio-s-cli4-cfg-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI5_CFG, "lsio-s-cli5-cfg-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI6_CFG, "lsio-s-cli6-cfg-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI0_SPI, "lsio-s-cli0-spi-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI1_SPI, "lsio-s-cli1-spi-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI2_SPI, "lsio-s-cli2-spi-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI3_SPI, "lsio-s-cli3-spi-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI4_SPI, "lsio-s-cli4-spi-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI5_SPI, "lsio-s-cli5-spi-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI6_SPI, "lsio-s-cli6-spi-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI0_I2C, "lsio-s-cli0-i2c-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI1_I2C, "lsio-s-cli1-i2c-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI2_I2C, "lsio-s-cli2-i2c-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI3_I2C, "lsio-s-cli3-i2c-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI4_I2C, "lsio-s-cli4-i2c-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI5_I2C, "lsio-s-cli5-i2c-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI6_I2C, "lsio-s-cli6-i2c-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI0_UART, "lsio-s-cli0-uart-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI1_UART, "lsio-s-cli1-uart-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI2_UART, "lsio-s-cli2-uart-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI3_UART, "lsio-s-cli3-uart-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI4_UART, "lsio-s-cli4-uart-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI5_UART, "lsio-s-cli5-uart-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI6_UART, "lsio-s-cli6-uart-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI0_I3C, "lsio-s-cli0-i3c-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI1_I3C, "lsio-s-cli1-i3c-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI2_I3C, "lsio-s-cli2-i3c-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI3_I3C, "lsio-s-cli3-i3c-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI4_I3C, "lsio-s-cli4-i3c-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI5_I3C, "lsio-s-cli5-i3c-clk"),
+	CPM_CLK_LGA(LSIO_S, CLK_LSIO_S_CLI6_I3C, "lsio-s-cli6-i3c-clk"),
+};
+
+static const struct cpm_clk_pd_map lga_pd_map[] = {
+	{ .lpcm_id = LPCM_AOC, .pd_id = PD_SSWRP_AOC },
+	{ .lpcm_id = LPCM_AURORA, .pd_id = PD_SSWRP_AURORA },
+	{ .lpcm_id = LPCM_CODEC_3P, .pd_id = PD_SSWRP_CODEC_3P },
+	{ .lpcm_id = LPCM_DPU, .pd_id = PD_SSWRP_DPU },
+	{ .lpcm_id = LPCM_EH, .pd_id = PD_SSWRP_EH },
+	{ .lpcm_id = LPCM_G2D, .pd_id = PD_SSWRP_G2D },
+	{ .lpcm_id = LPCM_GPDMA, .pd_id = PD_SSWRP_GPDMA },
+	{ .lpcm_id = LPCM_GPU, .pd_id = PD_SSWRP_GPU },
+	{ .lpcm_id = LPCM_GSW, .pd_id = PD_SSWRP_GSW },
+	{ .lpcm_id = LPCM_HSIO_N, .pd_id = PD_SSWRP_HSIO_N },
+	{ .lpcm_id = LPCM_HSIO_S, .pd_id = PD_SSWRP_HSIO_S },
+	{ .lpcm_id = LPCM_ISPBE, .pd_id = PD_SSWRP_ISPBE },
+	{ .lpcm_id = LPCM_ISPFE, .pd_id = PD_SSWRP_ISPFE },
+	{ .lpcm_id = LPCM_LSIO_E, .pd_id = PD_SSWRP_LSIO_E },
+	{ .lpcm_id = LPCM_LSIO_N, .pd_id = PD_SSWRP_LSIO_N },
+	{ .lpcm_id = LPCM_LSIO_S, .pd_id = PD_SSWRP_LSIO_S },
+	{ .lpcm_id = LPCM_TPU, .pd_id = PD_SSWRP_TPU },
+};
+
+const struct cpm_clk_soc_data cpm_clk_lga_data = {
+	.clks = cpm_clks_lga,
+	.num_clks = ARRAY_SIZE(cpm_clks_lga),
+	.pd_map = lga_pd_map,
+	.num_pd_map = ARRAY_SIZE(lga_pd_map),
+};
diff --git a/drivers/clk/google/clk-cpm-lga.h b/drivers/clk/google/clk-cpm-lga.h
new file mode 100644
index 000000000000..ea3e4fa32575
--- /dev/null
+++ b/drivers/clk/google/clk-cpm-lga.h
@@ -0,0 +1,194 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2023-2026 Google LLC
+ */
+
+#ifndef _GOOGLE_CLK_CPM_LGA_H
+#define _GOOGLE_CLK_CPM_LGA_H
+
+/*
+ * LPCM clock IDs of each SSWRP
+ */
+
+#define LPCM_CLK_LSIO_S_GPIO			0
+#define LPCM_CLK_LSIO_S_MCLK0			1
+#define LPCM_CLK_LSIO_S_PWM			2
+#define LPCM_CLK_LSIO_S_PWM_CFG			3
+#define LPCM_CLK_LSIO_S_CLI0_CFG		4
+#define LPCM_CLK_LSIO_S_CLI1_CFG		5
+#define LPCM_CLK_LSIO_S_CLI2_CFG		6
+#define LPCM_CLK_LSIO_S_CLI3_CFG		7
+#define LPCM_CLK_LSIO_S_CLI4_CFG		8
+#define LPCM_CLK_LSIO_S_CLI5_CFG		9
+#define LPCM_CLK_LSIO_S_CLI6_CFG		10
+#define LPCM_CLK_LSIO_S_CLI0_SPI		11
+#define LPCM_CLK_LSIO_S_CLI1_SPI		12
+#define LPCM_CLK_LSIO_S_CLI2_SPI		13
+#define LPCM_CLK_LSIO_S_CLI3_SPI		14
+#define LPCM_CLK_LSIO_S_CLI4_SPI		15
+#define LPCM_CLK_LSIO_S_CLI5_SPI		16
+#define LPCM_CLK_LSIO_S_CLI6_SPI		17
+#define LPCM_CLK_LSIO_S_CLI0_I2C		18
+#define LPCM_CLK_LSIO_S_CLI1_I2C		19
+#define LPCM_CLK_LSIO_S_CLI2_I2C		20
+#define LPCM_CLK_LSIO_S_CLI3_I2C		21
+#define LPCM_CLK_LSIO_S_CLI4_I2C		22
+#define LPCM_CLK_LSIO_S_CLI5_I2C		23
+#define LPCM_CLK_LSIO_S_CLI6_I2C		24
+#define LPCM_CLK_LSIO_S_CLI0_UART		25
+#define LPCM_CLK_LSIO_S_CLI1_UART		26
+#define LPCM_CLK_LSIO_S_CLI2_UART		27
+#define LPCM_CLK_LSIO_S_CLI3_UART		28
+#define LPCM_CLK_LSIO_S_CLI4_UART		29
+#define LPCM_CLK_LSIO_S_CLI5_UART		30
+#define LPCM_CLK_LSIO_S_CLI6_UART		31
+#define LPCM_CLK_LSIO_S_CLI0_I3C		32
+#define LPCM_CLK_LSIO_S_CLI1_I3C		33
+#define LPCM_CLK_LSIO_S_CLI2_I3C		34
+#define LPCM_CLK_LSIO_S_CLI3_I3C		35
+#define LPCM_CLK_LSIO_S_CLI4_I3C		36
+#define LPCM_CLK_LSIO_S_CLI5_I3C		37
+#define LPCM_CLK_LSIO_S_CLI6_I3C		38
+#define LPCM_CLK_LSIO_S_MCLK1			39
+#define LPCM_CLK_LSIO_S_MCLK2			40
+#define LPCM_CLK_LSIO_S_MCLK3			41
+#define LPCM_CLK_LSIO_S_MCLK4			42
+#define LPCM_CLK_LSIO_S_MCLK5			43
+#define LPCM_CLK_LSIO_S_MCLK6			44
+#define LPCM_CLK_LSIO_S_MCLK7			45
+
+#define LPCM_CLK_LSIO_N_GPIO			0
+#define LPCM_CLK_LSIO_N_CLI_INT0_I2C		1
+#define LPCM_CLK_LSIO_N_CLI_INT0_I3C		2
+#define LPCM_CLK_LSIO_N_CLI_INT0_UART		3
+#define LPCM_CLK_LSIO_N_CLI_INT0_SPI		4
+#define LPCM_CLK_LSIO_N_CLI_INT0_CFG		5
+#define LPCM_CLK_LSIO_N_CLI_INT1_I2C		6
+#define LPCM_CLK_LSIO_N_CLI_INT1_I3C		7
+#define LPCM_CLK_LSIO_N_CLI_INT1_UART		8
+#define LPCM_CLK_LSIO_N_CLI_INT1_SPI		9
+#define LPCM_CLK_LSIO_N_CLI_INT1_CFG		10
+#define LPCM_CLK_LSIO_N_CLI_INT2_I2C		11
+#define LPCM_CLK_LSIO_N_CLI_INT2_I3C		12
+#define LPCM_CLK_LSIO_N_CLI_INT2_UART		13
+#define LPCM_CLK_LSIO_N_CLI_INT2_SPI		14
+#define LPCM_CLK_LSIO_N_CLI_INT2_CFG		15
+#define LPCM_CLK_LSIO_N_CLI_INT3_I2C		16
+#define LPCM_CLK_LSIO_N_CLI_INT3_I3C		17
+#define LPCM_CLK_LSIO_N_CLI_INT3_UART		18
+#define LPCM_CLK_LSIO_N_CLI_INT3_SPI		19
+#define LPCM_CLK_LSIO_N_CLI_INT3_CFG		20
+#define LPCM_CLK_LSIO_N_CLI_INT4_I2C		21
+#define LPCM_CLK_LSIO_N_CLI_INT4_I3C		22
+#define LPCM_CLK_LSIO_N_CLI_INT4_UART		23
+#define LPCM_CLK_LSIO_N_CLI_INT4_SPI		24
+#define LPCM_CLK_LSIO_N_CLI_INT4_CFG		25
+#define LPCM_CLK_LSIO_N_CLI15_CFG		26
+#define LPCM_CLK_LSIO_N_CLI16_CFG		27
+#define LPCM_CLK_LSIO_N_CLI15_I2C		28
+#define LPCM_CLK_LSIO_N_CLI16_I2C		29
+#define LPCM_CLK_LSIO_N_CLI15_SPI		30
+#define LPCM_CLK_LSIO_N_CLI16_SPI		31
+#define LPCM_CLK_LSIO_N_CLI15_UART		32
+#define LPCM_CLK_LSIO_N_CLI16_UART		33
+#define LPCM_CLK_LSIO_N_CLI15_I3C		34
+#define LPCM_CLK_LSIO_N_CLI16_I3C		35
+
+#define LPCM_CLK_LSIO_E_GPIO			0
+#define LPCM_CLK_LSIO_E_CLI7_CFG		1
+#define LPCM_CLK_LSIO_E_CLI8_CFG		2
+#define LPCM_CLK_LSIO_E_CLI9_CFG		3
+#define LPCM_CLK_LSIO_E_CLI10_CFG		4
+#define LPCM_CLK_LSIO_E_CLI11_CFG		5
+#define LPCM_CLK_LSIO_E_CLI12_CFG		6
+#define LPCM_CLK_LSIO_E_CLI13_CFG		7
+#define LPCM_CLK_LSIO_E_CLI14_CFG		8
+#define LPCM_CLK_LSIO_E_CLI7_SPI		9
+#define LPCM_CLK_LSIO_E_CLI8_SPI		10
+#define LPCM_CLK_LSIO_E_CLI9_SPI		11
+#define LPCM_CLK_LSIO_E_CLI10_SPI		12
+#define LPCM_CLK_LSIO_E_CLI11_SPI		13
+#define LPCM_CLK_LSIO_E_CLI12_SPI		14
+#define LPCM_CLK_LSIO_E_CLI13_SPI		15
+#define LPCM_CLK_LSIO_E_CLI14_SPI		16
+#define LPCM_CLK_LSIO_E_CLI7_I2C		17
+#define LPCM_CLK_LSIO_E_CLI8_I2C		18
+#define LPCM_CLK_LSIO_E_CLI9_I2C		19
+#define LPCM_CLK_LSIO_E_CLI10_I2C		20
+#define LPCM_CLK_LSIO_E_CLI11_I2C		21
+#define LPCM_CLK_LSIO_E_CLI12_I2C		22
+#define LPCM_CLK_LSIO_E_CLI13_I2C		23
+#define LPCM_CLK_LSIO_E_CLI14_I2C		24
+#define LPCM_CLK_LSIO_E_CLI7_UART		25
+#define LPCM_CLK_LSIO_E_CLI8_UART		26
+#define LPCM_CLK_LSIO_E_CLI9_UART		27
+#define LPCM_CLK_LSIO_E_CLI10_UART		28
+#define LPCM_CLK_LSIO_E_CLI11_UART		29
+#define LPCM_CLK_LSIO_E_CLI12_UART		30
+#define LPCM_CLK_LSIO_E_CLI13_UART		31
+#define LPCM_CLK_LSIO_E_CLI14_UART		32
+#define LPCM_CLK_LSIO_E_SPMI			33
+#define LPCM_CLK_LSIO_E_CLI7_I3C		34
+#define LPCM_CLK_LSIO_E_CLI8_I3C		35
+#define LPCM_CLK_LSIO_E_CLI9_I3C		36
+#define LPCM_CLK_LSIO_E_CLI10_I3C		37
+#define LPCM_CLK_LSIO_E_CLI11_I3C		38
+#define LPCM_CLK_LSIO_E_CLI12_I3C		39
+#define LPCM_CLK_LSIO_E_CLI13_I3C		40
+#define LPCM_CLK_LSIO_E_CLI14_I3C		41
+
+#define LPCM_CLK_HSIO_S_MPHY_REF_OSC		0
+#define LPCM_CLK_HSIO_S_MPHY_REF_TCX0		1
+#define LPCM_CLK_HSIO_S_GPIO_REF_OSC		2
+#define LPCM_CLK_HSIO_S_GPIO_REF_TCX0		3
+#define LPCM_CLK_HSIO_S_HCLK			4
+#define LPCM_CLK_HSIO_S_SYS			5
+#define LPCM_CLK_HSIO_S_T			6
+#define LPCM_CLK_HSIO_S_LP_T			7
+#define LPCM_CLK_HSIO_S_MPHY_CFG		8
+#define LPCM_CLK_HSIO_S_UFS_CFG			9
+#define LPCM_CLK_HSIO_S_PHY_FW			10
+#define LPCM_CLK_HSIO_S_PCIE_REF		11
+#define LPCM_CLK_HSIO_S_UFS_RESET		12
+#define LPCM_CLK_HSIO_S_UFS_LP_RESET		13
+#define LPCM_CLK_HSIO_S_UFS_ARESET		14
+#define LPCM_CLK_HSIO_S_UFS_PHY_RESET		15
+#define LPCM_CLK_HSIO_S_AUX			16
+
+#define LPCM_CLK_HSIO_N_USB			0
+#define LPCM_CLK_HSIO_N_DP0			1
+#define LPCM_CLK_HSIO_N_DP1			2
+#define LPCM_CLK_HSIO_N_PHY_FW			3
+#define LPCM_CLK_HSIO_N_PCIE_REF		4
+#define LPCM_CLK_HSIO_N_U2PHY_REF		5
+#define LPCM_CLK_HSIO_N_USBDP_SUSPEND		6
+#define LPCM_CLK_HSIO_N_USBC_NON_STICKY		7
+#define LPCM_CLK_HSIO_N_USBC_STICKY		8
+#define LPCM_CLK_HSIO_N_USB_DRD_BUS		9
+#define LPCM_CLK_HSIO_N_CSR			10
+#define LPCM_CLK_HSIO_N_USB_TOP_CSR		11
+#define LPCM_CLK_HSIO_N_DP_PCLK			12
+#define LPCM_CLK_HSIO_N_DP_CFG			13
+#define LPCM_CLK_HSIO_N_U2PHY_APB		14
+#define LPCM_CLK_HSIO_N_DP_VCC			15
+#define LPCM_CLK_HSIO_N_U3PHY_REF		16
+#define LPCM_CLK_HSIO_N_USB2_PHY_RESET		17
+#define LPCM_CLK_HSIO_N_USB3DP_PHY_RESET	18
+#define LPCM_CLK_HSIO_N_EBU			19
+
+#define LPCM_CLK_DPU_DP0_PIX			0
+#define LPCM_CLK_DPU_DP1_PIX			1
+#define LPCM_CLK_DPU_DSI0_PIX			2
+#define LPCM_CLK_DPU_DSI1_PIX			3
+#define LPCM_CLK_DPU_DSI1_PHY			4
+#define LPCM_CLK_DPU_FE0			5
+#define LPCM_CLK_DPU_FE1			6
+#define LPCM_CLK_DPU_BE				7
+#define LPCM_CLK_DPU_AON			8
+
+#define LPCM_CLK_GPCM_DPU_PLL_DP		0
+#define LPCM_CLK_GPCM_HSIO_N_PLL_DP		1
+
+#define LPCM_CLK_CPU_SSWRP_TSS			1
+
+#endif /* _GOOGLE_CLK_CPM_LGA_H */
diff --git a/drivers/clk/google/clk-cpm.c b/drivers/clk/google/clk-cpm.c
new file mode 100644
index 000000000000..9f3c3ea6ec56
--- /dev/null
+++ b/drivers/clk/google/clk-cpm.c
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2023-2026 Google LLC
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/bug.h>
+#include <linux/clk-provider.h>
+#include <linux/container_of.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/gfp_types.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/overflow.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include <soc/google/google-cpm-mba.h>
+
+#include "clk-cpm-internal.h"
+
+#define PREPARE_OP_ID				0
+#define UNPREPARE_OP_ID				1
+#define IS_ENABLE_OP_ID				2
+#define RECALC_RATE_OP_ID			3
+#define ROUND_RATE_OP_ID			4 /* Not implemented */
+#define SET_RATE_OP_ID				5
+
+/* PREPARE_OP_ID / UNPREPARE_OP_ID */
+#define CLK_GATE				1
+
+#define SIP_SVC_CLK_CONTROL			0x82000702
+
+#define to_cpm_clk(_hw) container_of(_hw, struct cpm_clk, hw)
+
+struct cpm_clk {
+	struct clk_hw hw;
+	struct cpm_clk_dev_data *dev_data;
+	const char *name;
+
+	unsigned int lpcm_id;
+	unsigned int clock_id;
+	bool use_smc;
+};
+
+struct cpm_clk_dev_data {
+	struct device *dev;
+	struct cpm_handle *cpm;
+};
+
+static void cpm_clk_pd_dev_release(struct device *dev)
+{
+	kfree(dev);
+}
+
+static void cpm_clk_unregister_pd_dev(void *data)
+{
+	struct device *clk_dev = data;
+
+	pm_runtime_disable(clk_dev);
+	pm_genpd_remove_device(clk_dev);
+	device_unregister(clk_dev);
+}
+
+static void cpm_clk_hw_unregister(void *data)
+{
+	struct clk_hw *hw = data;
+
+	clk_hw_unregister(hw);
+}
+
+static int cpm_clk_send_mbox_msg_set_gate(struct cpm_clk *cpm_clk, bool enable)
+{
+	const struct cpm_lpcm_message msg = {
+		.cmd = LPCM_CMD_SET_LCM_CLK,
+		.opcode = enable ? PREPARE_OP_ID : UNPREPARE_OP_ID,
+		.lpcm_id = cpm_clk->lpcm_id,
+		.obj_id = cpm_clk->clock_id,
+		.payload = CLK_GATE,
+	};
+
+	return cpm_send_lpcm_message(cpm_clk->dev_data->cpm, &msg);
+}
+
+static unsigned long cpm_clk_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct cpm_clk *cpm_clk = to_cpm_clk(hw);
+	const struct cpm_lpcm_message msg = {
+		.cmd = LPCM_CMD_SET_LCM_CLK,
+		.opcode = RECALC_RATE_OP_ID,
+		.lpcm_id = cpm_clk->lpcm_id,
+		.obj_id = cpm_clk->clock_id,
+	};
+	int ret;
+
+	dev_dbg(cpm_clk->dev_data->dev, "%s: lpcm_id %d, clock_id %d: get rate\n",
+		cpm_clk->name, cpm_clk->lpcm_id, cpm_clk->clock_id);
+	ret = cpm_send_lpcm_message(cpm_clk->dev_data->cpm, &msg);
+	if (ret < 0)
+		return 0;
+
+	return ret;
+}
+
+static inline int lpcm_smc(struct clk_hw *hw, bool enable)
+{
+	struct cpm_clk *cpm_clk = to_cpm_clk(hw);
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
+static int cpm_clk_prepare(struct clk_hw *hw)
+{
+	struct cpm_clk *cpm_clk = to_cpm_clk(hw);
+
+	dev_dbg(cpm_clk->dev_data->dev, "%s: lpcm_id %d, clock_id %d: enable\n",
+		cpm_clk->name, cpm_clk->lpcm_id, cpm_clk->clock_id);
+
+	return cpm_clk_send_mbox_msg_set_gate(cpm_clk, true);
+}
+
+static void cpm_clk_unprepare(struct clk_hw *hw)
+{
+	struct cpm_clk *cpm_clk = to_cpm_clk(hw);
+
+	dev_dbg(cpm_clk->dev_data->dev, "%s: lpcm_id %d, clock_id %d: disable\n",
+		cpm_clk->name, cpm_clk->lpcm_id, cpm_clk->clock_id);
+
+	cpm_clk_send_mbox_msg_set_gate(cpm_clk, false);
+}
+
+static int cpm_clk_smc_enable(struct clk_hw *hw)
+{
+	struct cpm_clk *cpm_clk = to_cpm_clk(hw);
+
+	dev_dbg(cpm_clk->dev_data->dev, "%s: lpcm_id %d, clock_id %d: enable\n",
+		cpm_clk->name, cpm_clk->lpcm_id, cpm_clk->clock_id);
+
+	return lpcm_smc(hw, true);
+}
+
+static void cpm_clk_smc_disable(struct clk_hw *hw)
+{
+	struct cpm_clk *cpm_clk = to_cpm_clk(hw);
+
+	dev_dbg(cpm_clk->dev_data->dev, "%s: lpcm_id %d, clock_id %d: disable\n",
+		cpm_clk->name, cpm_clk->lpcm_id, cpm_clk->clock_id);
+
+	lpcm_smc(hw, false);
+}
+
+static const struct clk_ops cpm_clk_ops = {
+	.recalc_rate = cpm_clk_recalc_rate,
+	.prepare = cpm_clk_prepare,
+	.unprepare = cpm_clk_unprepare,
+};
+
+static const struct clk_ops cpm_gate_smc_clk_ops = {
+	.enable = cpm_clk_smc_enable,
+	.disable = cpm_clk_smc_disable,
+};
+
+static struct device *cpm_clk_attach_pd(struct device *dev, const char *name,
+					int pd_id)
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
+	clk_dev->release = cpm_clk_pd_dev_release;
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
+	err = devm_add_action_or_reset(dev, cpm_clk_unregister_pd_dev, clk_dev);
+	if (err)
+		return ERR_PTR(err);
+
+	return clk_dev;
+}
+
+static int cpm_clk_lookup_pd(const struct cpm_clk_soc_data *soc_data,
+			     u32 lpcm_id)
+{
+	size_t i;
+
+	for (i = 0; i < soc_data->num_pd_map; i++) {
+		if (soc_data->pd_map[i].lpcm_id == lpcm_id)
+			return soc_data->pd_map[i].pd_id;
+	}
+
+	return -1;
+}
+
+static struct cpm_clk *
+cpm_clk_register_clk(struct device *dev,
+		     const struct cpm_clk_data *clk_data,
+		     const struct cpm_clk_soc_data *soc_data,
+		     struct cpm_clk_dev_data *dev_data)
+{
+	struct cpm_clk *cpm_clk;
+	struct clk_init_data init = {};
+	const char *name = clk_data->name;
+	struct device *clk_dev;
+	int pd_id;
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
+	cpm_clk->dev_data = dev_data;
+
+	pd_id = cpm_clk_lookup_pd(soc_data, clk_data->lpcm_id);
+	clk_dev = cpm_clk_attach_pd(dev, name, pd_id);
+	if (IS_ERR(clk_dev))
+		return ERR_CAST(clk_dev);
+
+	init.name = name;
+	init.flags = CLK_GET_RATE_NOCACHE;
+	if (cpm_clk->use_smc)
+		init.ops = &cpm_gate_smc_clk_ops;
+	else
+		init.ops = &cpm_clk_ops;
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
+	err = devm_add_action_or_reset(dev, cpm_clk_hw_unregister, &cpm_clk->hw);
+	if (err)
+		return ERR_PTR(err);
+
+	return cpm_clk;
+}
+
+static const struct of_device_id cpm_clk_of_match[] __maybe_unused = {
+	{ .compatible = "google,lga-cpm", .data = &cpm_clk_lga_data },
+	{ }
+};
+
+static int cpm_clk_controller_probe(struct auxiliary_device *auxdev,
+				    const struct auxiliary_device_id *id)
+{
+	struct device *dev = &auxdev->dev;
+	struct device_node *node = dev->of_node;
+	struct cpm_clk_dev_data *dev_data;
+	struct clk_hw_onecell_data *hw_data;
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
+	dev_data->cpm = devm_cpm_get_handle(dev);
+	if (IS_ERR(dev_data->cpm))
+		return dev_err_probe(dev, PTR_ERR(dev_data->cpm),
+				     "Failed to get CPM handle\n");
+
+	hw_data = devm_kzalloc(dev, struct_size(hw_data, hws, soc_data->num_clks),
+			       GFP_KERNEL);
+	if (!hw_data)
+		return -ENOMEM;
+
+	hw_data->num = soc_data->num_clks;
+
+	for (i = 0; i < soc_data->num_clks; i++) {
+		struct cpm_clk *cpm_clk;
+
+		if (!soc_data->clks[i].name) {
+			hw_data->hws[i] = ERR_PTR(-ENOENT);
+			continue;
+		}
+
+		cpm_clk = cpm_clk_register_clk(dev, &soc_data->clks[i], soc_data, dev_data);
+		if (IS_ERR(cpm_clk))
+			return PTR_ERR(cpm_clk);
+
+		hw_data->hws[i] = &cpm_clk->hw;
+	}
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, hw_data);
+	if (ret) {
+		dev_err(dev, "failed to add clock provider: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct auxiliary_device_id cpm_clk_id_table[] = {
+	{ .name = "google_cpm_mba.clk" },
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, cpm_clk_id_table);
+
+static struct auxiliary_driver cpm_clk_driver = {
+	.probe = cpm_clk_controller_probe,
+	.name = "google-clk-cpm",
+	.id_table = cpm_clk_id_table,
+};
+module_auxiliary_driver(cpm_clk_driver);
+
+MODULE_DESCRIPTION("Google CPM Clock Driver");
+MODULE_LICENSE("GPL");
-- 
2.56.1.831.g720f3f5937-goog

