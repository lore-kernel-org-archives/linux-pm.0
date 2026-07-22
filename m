Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC05F368D4D;
	Wed, 22 Jul 2026 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709576; cv=none; b=lgpnuxT6NjHo6jrBHyxRz2hVW7rjsOayvvxwFszEFpRGuhWmZqmLby5mD1giIaOLXxt29Ea0WDI8se6qo0IM9VLlFCJVjwhe4Evizoz3nMU87Dh7Hh5bMhiLOxnBgnMhHIvtV+zLZU5vLpuUMBKD/+2TYZmKEF5vlpNuVIDM5+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709576; c=relaxed/simple;
	bh=rcQeDo5UoMmhlm0sZIB41JjoS+2snFmUVnAn3/eGTz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g2MTumMJ33BeyPXNomNE2Xtpmp/a0kb06hAxFPtv+StOF2S4j1qICf0WHVztL3e12Ysm3uFotg+zVHzwPrbSkiaM5FXyrLc3NbOyxyq4XoOB3ZZAcfhE802UDpUH60T6KzPueRA++0yy6c0qxGYPYH9G3HcpdYBenXYxBUi91cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gwihkad8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gwihkad8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 941B4C2BCFD;
	Wed, 22 Jul 2026 08:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784709576;
	bh=rcQeDo5UoMmhlm0sZIB41JjoS+2snFmUVnAn3/eGTz0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Gwihkad8V3uKxA0Tqtj4E6G7FNqhVjguejzl1oIRI+6Vw/T1Bq1vty42OoKjoJ3fd
	 /ZiMYjzJfKuuu+1r48A/9jox+/zGIFg1X9rPkRsXhqmkRQM+TZN3GsR2L8TAy1zh6/
	 4mtYk+nIRWzQk4TNcsHiI7LBApYq6cNzkv1NoYYvhe1ovLny1buAcUUa+3l7UHKpeW
	 iHWsS5aPZ4FoFoJ9HeY0HD68bx1EvKnO8vB2W6Umzm8NfX6RF8MdGedRrPIfqmokLU
	 B6ur0qlflskfRWdW23KZRFNwc8LcccP0LntmUVOFj2RWd0DocLMZGES+c64TTwdHCM
	 CRUuSy0DCN3wg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F95BC4453A;
	Wed, 22 Jul 2026 08:39:36 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 22 Jul 2026 08:39:32 +0000
Subject: [PATCH 2/3] pmdomain: amlogic: Add support for A9 power domains
 controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-a9-pm-v1-2-1fe20a44bf2d@amlogic.com>
References: <20260722-a9-pm-v1-0-1fe20a44bf2d@amlogic.com>
In-Reply-To: <20260722-a9-pm-v1-0-1fe20a44bf2d@amlogic.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784709572; l=3797;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=aA+XjaI8J4Dk36k0e6tePHR7OYdh6T5F5939mIxU5ck=;
 b=2XyApDwRB19STwV3fcrFyt6Uej1ZasA9HEWcQrSNgX7BV4hbGtLXf2iYQ9wr8vzRKDFMxbum2
 5AHuduN6EErCuFYXumBll49nsmWVSLloPwCVVq0Gp27E1IHfud8X2WD
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add support for the A9 power controller, whose registers are
in the secure domain and should be accessed via SMC.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 drivers/pmdomain/amlogic/meson-secure-pwrc.c | 69 ++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/pmdomain/amlogic/meson-secure-pwrc.c b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
index 1d2f371d2d7f..133549956efa 100644
--- a/drivers/pmdomain/amlogic/meson-secure-pwrc.c
+++ b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
@@ -16,6 +16,7 @@
 #include <dt-bindings/power/amlogic,t7-pwrc.h>
 #include <dt-bindings/power/amlogic,a4-pwrc.h>
 #include <dt-bindings/power/amlogic,a5-pwrc.h>
+#include <dt-bindings/power/amlogic,a9-pwrc.h>
 #include <dt-bindings/power/amlogic,s6-pwrc.h>
 #include <dt-bindings/power/amlogic,s7-pwrc.h>
 #include <dt-bindings/power/amlogic,s7d-pwrc.h>
@@ -175,6 +176,65 @@ static const struct meson_secure_pwrc_domain_desc a5_pwrc_domains[] = {
 	SEC_PD(A5_DSPA,		0),
 };
 
+static const struct meson_secure_pwrc_domain_desc a9_pwrc_domains[] = {
+	SEC_PD(A9_DSPA,		0),
+	SEC_PD(A9_U3HSG_U3,	0),
+	SEC_PD(A9_DP,		0),
+	SEC_PD(A9_DOS_HCODEC,	0),
+	SEC_PD(A9_TAHOE,	0),
+	SEC_PD(A9_DOS_HEVC,	0),
+	SEC_PD(A9_U2H,		0),
+	SEC_PD(A9_U3DRD_B,	0),
+	SEC_PD(A9_VPU_HDMI,	0),
+	SEC_PD(A9_U2DRD,	0),
+	SEC_PD(A9_U3DRD_A,	0),
+	SEC_PD(A9_SD_EMMC_C,	0),
+	SEC_PD(A9_GE2D,		0),
+	SEC_PD(A9_AMFC,		0),
+	SEC_PD(A9_EDPTX,	0),
+	SEC_PD(A9_OPP,		0),
+	SEC_PD(A9_VICP,		0),
+	SEC_PD(A9_SD_EMMC_A,	0),
+	SEC_PD(A9_SD_EMMC_B,	0),
+	SEC_PD(A9_ETH,		0),
+	SEC_PD(A9_PCIE_A,	0),
+	SEC_PD(A9_PCIE_B,	0),
+	SEC_PD(A9_NNA_4T,	0),
+	SEC_PD(A9_HDMIRX,	0),
+	SEC_PD(A9_CVE,		0),
+	SEC_PD(A9_ISP,		0),
+	SEC_PD(A9_ETH_1G,	0),
+	SEC_PD(A9_U3HSG_HSG,	0),
+	SEC_PD(A9_U3DPPHY_U3,	0),
+	SEC_PD(A9_U3DPPHY_DP,	0),
+	SEC_PD(A9_PCIE3PHY,	0),
+	SEC_PD(A9_U3HSG_PCIE2,	0),
+	SEC_PD(A9_MALI_TOP,	0),
+	SEC_PD(A9_AO_SED,	0),
+	SEC_PD(A9_AO_IR,	0),
+	/* UART_B is for console log, and should be always on */
+	SEC_PD(A9_AO_UART_B,	GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(A9_AO_UART_C,	0),
+	SEC_PD(A9_AO_UART_D,	0),
+	SEC_PD(A9_AO_SPISG,	0),
+	SEC_PD(A9_AO_UART_E,	0),
+	SEC_PD(A9_AO_CEC,	0),
+	/* SRAMA is used as ATF runtime memory, and should be always on */
+	SEC_PD(A9_EE_SRAMA,	GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(A9_AUDIO,	0),
+	/* DMC0 is for DDR PHY ana/dig and DMC, and should be always on */
+	SEC_PD(A9_DMC0,		GENPD_FLAG_ALWAYS_ON),
+	/*GIC needs to be used consistently, and should be always on */
+	SEC_PD(A9_GIC,		GENPD_FLAG_ALWAYS_ON),
+	/* DDRPHY is for DDR Work, and should be always on */
+	SEC_PD(A9_DDRPHY,	GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(A9_AUCPU,	0),
+	SEC_PD(A9_DSI0,		0),
+	SEC_PD(A9_DSI1,		0),
+	SEC_PD(A9_CAN0,		0),
+	SEC_PD(A9_CAN1,		0),
+};
+
 static const struct meson_secure_pwrc_domain_desc c3_pwrc_domains[] = {
 	SEC_PD(C3_NNA,		0),
 	SEC_PD(C3_AUDIO,	0),
@@ -425,6 +485,11 @@ static const struct meson_secure_pwrc_domain_data amlogic_secure_a5_pwrc_data =
 	.count = ARRAY_SIZE(a5_pwrc_domains),
 };
 
+static const struct meson_secure_pwrc_domain_data amlogic_secure_a9_pwrc_data = {
+	.domains = a9_pwrc_domains,
+	.count = ARRAY_SIZE(a9_pwrc_domains),
+};
+
 static const struct meson_secure_pwrc_domain_data amlogic_secure_c3_pwrc_data = {
 	.domains = c3_pwrc_domains,
 	.count = ARRAY_SIZE(c3_pwrc_domains),
@@ -468,6 +533,10 @@ static const struct of_device_id meson_secure_pwrc_match_table[] = {
 		.compatible = "amlogic,a5-pwrc",
 		.data = &amlogic_secure_a5_pwrc_data,
 	},
+	{
+		.compatible = "amlogic,a9-pwrc",
+		.data = &amlogic_secure_a9_pwrc_data,
+	},
 	{
 		.compatible = "amlogic,c3-pwrc",
 		.data = &amlogic_secure_c3_pwrc_data,

-- 
2.52.0


