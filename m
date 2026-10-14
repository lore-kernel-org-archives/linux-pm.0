Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702494E5320;
	Wed, 14 Oct 2026 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980555; cv=none; b=suQedAY7CgnUQwo4xoWX034lBWfPxML/6dIDfwtgs7YrpWMaUvX7WNWidT9ELhUNtks0tZxl0+AsJ/F8aZfv3kUCBOBene+VLJdGhzEzPGUagztY/T//dJnshz75beFd/SmBfekuw2PSvWQnTvv0tcNNRHRN4IWb6CLU/QlVrKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980555; c=relaxed/simple;
	bh=xUlGlPmvoXaOTfxTyR8uSHUjKGmSeb3hWG6r6zKSTBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NVZv/LzpNuMxUuVdRMJpIkZku65ltnEIuRekIzcwmb2X3W4H4Fn1bLwT1eRX0ZiJHqIIEUrp9fUf7dzIg/XCuu8E8o0Efl7yS+ZCyayISu9Dc+fZkG2Fjz5PVOWwzJxq5vji2c7EpGY1h8ylZtE2U2dTuQKY0uiQ1p6s3XdjhdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIBWTCMS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIBWTCMS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFB01F000FF;
	Wed, 14 Oct 2026 12:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791980551;
	bh=nGFVUAOyXfmmOoBh4jNazx0vrALZul4VlBLgErDaxxk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XIBWTCMST9eSZUIIzLIrEdhjNRKE/ltSdMKto5mWsvK0DON9cxxDls/Mj4qCo/tls
	 Uq7Kx2vWZhsSgJPZi3ccsbChTWB0fVsBsCjgV7Dvr3gThazTPCcd+dtZEz9w4YZaCl
	 v2TlcJcmBbIkmNPUJRYHIz/DQB2nAd6c8y5V3NRPmTnAEkFvrh99Zox/inDJbgpuGn
	 XjGp0wTe8leOc0mfu7sRMCDKwGEjILgFnkMRYxhU31/KMI7WTMmXQiv84PViTGPX2w
	 y4zxBIggv7nO56ECbugasv1+L5c08931wrSPAOh1xYko0VC+zOUZwVhq3SLZu6W0bd
	 UsU7zLq03JrPQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 14 Oct 2026 14:19:14 +0200
Subject: [PATCH DNM RFC 14/16] clk: qcom: Enable clk-dvfs on SM8650
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-topic-qc_clk_dvfs-v1-14-3041b788e9f7@oss.qualcomm.com>
References: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
In-Reply-To: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mike Tipton <mike.tipton@oss.qualcomm.com>, 
 Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791980431; l=92186;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=rB0q3k0RbmEdVm9Hx70Z5qJ2Mahan4qbpaXdX2DgPbU=;
 b=ujVGIP2T58bJI0NUbSqea0m+LqucQz2F7G3puFkKcMTEwLoCvjLPUfnMOMWbCDg2CXqNTzUod
 D8+Dc3QvizyCfu3xKCpvfXqt+dV4pjPGsn3Nv7BY/5x5BpVgHmgYKDb
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Make use of the clock-dvfs infrastructure and fill in the power
requirements for SM8650's clocks to ensure the hardware can operate in
accordance with the specification.

Assisted-by: LLM
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
This commit is a DNM since some of the affected drivers are shared
between multiple platforms, this will be properly reworked if we agree
on merging the clk-DVFS infra.
---
 drivers/clk/qcom/camcc-sm8650.c             | 282 ++++++++++++++++++++++++
 drivers/clk/qcom/dispcc-sm8550.c            | 328 ++++++++++++++++++++++++----
 drivers/clk/qcom/gcc-sm8650.c               | 261 ++++++++++++++++++++++
 drivers/clk/qcom/gpucc-sm8650.c             | 101 ++++++++-
 drivers/clk/qcom/videocc-sm8550.c           | 135 ++++++++++--
 include/dt-bindings/clock/qcom,sm8650-gcc.h |   2 +
 6 files changed, 1041 insertions(+), 68 deletions(-)

diff --git a/drivers/clk/qcom/camcc-sm8650.c b/drivers/clk/qcom/camcc-sm8650.c
index 3aad816ed233..188649368564 100644
--- a/drivers/clk/qcom/camcc-sm8650.c
+++ b/drivers/clk/qcom/camcc-sm8650.c
@@ -6,12 +6,15 @@
 #include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,sm8650-camcc.h>
+#include <dt-bindings/power/qcom,rpmhpd.h>
 
 #include "clk-alpha-pll.h"
 #include "clk-branch.h"
+#include "clk-dvfs.h"
 #include "clk-rcg.h"
 #include "clk-regmap.h"
 #include "common.h"
@@ -46,6 +49,110 @@ enum {
 	P_SLEEP_CLK,
 };
 
+/*
+ * Downstream uses CRM/CESTA for PLL3-7/10 and the CAMNOC AXI RT, CPHY RX,
+ * CSID, IFE0-2 and SFE0-2 RCGs. Until upstream supports that path, manage
+ * their rail requirements through clock-owned DVFS.
+ */
+enum {
+	DT_PMDOMAIN_MMCX,
+	DT_PMDOMAIN_MXC,
+	DT_PMDOMAIN_MX,
+};
+
+static const struct qcom_clk_dvfs_data cam_cc_pll0_dvfs = {
+	.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_MXC },
+	.num_pd_indices = 1,
+	.rates = (const struct qcom_clk_dvfs_rate[]) {
+		{ 615000000, RPMH_REGULATOR_LEVEL_LOW_SVS_D1 },
+		{ 1100000000, RPMH_REGULATOR_LEVEL_SVS },
+		{ 1600000000, RPMH_REGULATOR_LEVEL_SVS_L1 },
+		{ 2000000000, RPMH_REGULATOR_LEVEL_NOM },
+		{ 2100000000, RPMH_REGULATOR_LEVEL_TURBO_L1 },
+	},
+	.num_rates = 5,
+};
+
+static const struct qcom_clk_dvfs_data cam_cc_camnoc_axi_rt_clk_src_dvfs = {
+	.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_MMCX, DT_PMDOMAIN_MXC },
+	.num_pd_indices = 2,
+	.rates = (const struct qcom_clk_dvfs_rate[]) {
+		{ 300000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+		{ 400000000, RPMH_REGULATOR_LEVEL_SVS },
+	},
+	.num_rates = 2,
+};
+
+static const struct qcom_clk_dvfs_data cam_cc_cci_0_clk_src_dvfs = {
+	.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_MMCX },
+	.num_pd_indices = 1,
+	.rates = (const struct qcom_clk_dvfs_rate[]) {
+		{ 37500000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+	},
+	.num_rates = 1,
+};
+
+static const struct qcom_clk_dvfs_data cam_cc_cphy_rx_clk_src_dvfs = {
+	.pd_indices = (const unsigned int[]) {
+		DT_PMDOMAIN_MMCX, DT_PMDOMAIN_MX, DT_PMDOMAIN_MXC,
+	},
+	.num_pd_indices = 3,
+	.rates = (const struct qcom_clk_dvfs_rate[]) {
+		{ 400000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+		{ 480000000, RPMH_REGULATOR_LEVEL_SVS },
+	},
+	.num_rates = 2,
+};
+
+static const struct qcom_clk_dvfs_data cam_cc_csi0phytimer_clk_src_dvfs = {
+	.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_MXC },
+	.num_pd_indices = 1,
+	.rates = (const struct qcom_clk_dvfs_rate[]) {
+		{ 400000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+	},
+	.num_rates = 1,
+};
+
+static const struct qcom_clk_dvfs_data cam_cc_csi2phytimer_clk_src_dvfs = {
+	.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_MX },
+	.num_pd_indices = 1,
+	.rates = (const struct qcom_clk_dvfs_rate[]) {
+		{ 400000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+	},
+	.num_rates = 1,
+};
+
+static const struct qcom_clk_dvfs_data cam_cc_ife_0_clk_src_dvfs = {
+	.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_MMCX, DT_PMDOMAIN_MXC },
+	.num_pd_indices = 2,
+	.rates = (const struct qcom_clk_dvfs_rate[]) {
+		{ 466000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+		{ 594000000, RPMH_REGULATOR_LEVEL_SVS },
+		{ 675000000, RPMH_REGULATOR_LEVEL_SVS_L1 },
+		{ 785000000, RPMH_REGULATOR_LEVEL_NOM },
+	},
+	.num_rates = 4,
+};
+
+static const struct qcom_clk_dvfs_data cam_cc_ife_lite_clk_src_dvfs = {
+	.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_MMCX, DT_PMDOMAIN_MXC },
+	.num_pd_indices = 2,
+	.rates = (const struct qcom_clk_dvfs_rate[]) {
+		{ 400000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+		{ 480000000, RPMH_REGULATOR_LEVEL_SVS },
+	},
+	.num_rates = 2,
+};
+
+static const struct qcom_clk_dvfs_data cam_cc_mclk0_clk_src_dvfs = {
+	.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_MX },
+	.num_pd_indices = 1,
+	.rates = (const struct qcom_clk_dvfs_rate[]) {
+		{ 68571429, RPMH_REGULATOR_LEVEL_LOW_SVS },
+	},
+	.num_rates = 1,
+};
+
 static const struct pll_vco lucid_ole_vco[] = {
 	{ 249600000, 2300000000, 0 },
 };
@@ -75,6 +182,7 @@ static struct clk_alpha_pll cam_cc_pll0 = {
 	.num_vco = ARRAY_SIZE(lucid_ole_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &cam_cc_pll0_dvfs,
 		.hw.init = &(const struct clk_init_data) {
 			.name = "cam_cc_pll0",
 			.parent_data = &(const struct clk_parent_data) {
@@ -153,6 +261,7 @@ static struct clk_alpha_pll cam_cc_pll1 = {
 	.num_vco = ARRAY_SIZE(lucid_ole_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &cam_cc_pll0_dvfs,
 		.hw.init = &(const struct clk_init_data) {
 			.name = "cam_cc_pll1",
 			.parent_data = &(const struct clk_parent_data) {
@@ -204,6 +313,16 @@ static struct clk_alpha_pll cam_cc_pll2 = {
 	.num_vco = ARRAY_SIZE(rivian_ole_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_RIVIAN_EVO],
 	.clkr = {
+		.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+			.pd_indices = (const unsigned int[]) {
+				DT_PMDOMAIN_MX,
+			},
+			.num_pd_indices = 1,
+			.rates = (const struct qcom_clk_dvfs_rate[]) {
+				{ 1285000000, RPMH_REGULATOR_LEVEL_SVS },
+			},
+			.num_rates = 1,
+		},
 		.hw.init = &(const struct clk_init_data) {
 			.name = "cam_cc_pll2",
 			.parent_data = &(const struct clk_parent_data) {
@@ -236,6 +355,7 @@ static struct clk_alpha_pll cam_cc_pll3 = {
 	.num_vco = ARRAY_SIZE(lucid_ole_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &cam_cc_pll0_dvfs,
 		.hw.init = &(const struct clk_init_data) {
 			.name = "cam_cc_pll3",
 			.parent_data = &(const struct clk_parent_data) {
@@ -291,6 +411,7 @@ static struct clk_alpha_pll cam_cc_pll4 = {
 	.num_vco = ARRAY_SIZE(lucid_ole_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &cam_cc_pll0_dvfs,
 		.hw.init = &(const struct clk_init_data) {
 			.name = "cam_cc_pll4",
 			.parent_data = &(const struct clk_parent_data) {
@@ -346,6 +467,7 @@ static struct clk_alpha_pll cam_cc_pll5 = {
 	.num_vco = ARRAY_SIZE(lucid_ole_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &cam_cc_pll0_dvfs,
 		.hw.init = &(const struct clk_init_data) {
 			.name = "cam_cc_pll5",
 			.parent_data = &(const struct clk_parent_data) {
@@ -401,6 +523,7 @@ static struct clk_alpha_pll cam_cc_pll6 = {
 	.num_vco = ARRAY_SIZE(lucid_ole_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &cam_cc_pll0_dvfs,
 		.hw.init = &(const struct clk_init_data) {
 			.name = "cam_cc_pll6",
 			.parent_data = &(const struct clk_parent_data) {
@@ -456,6 +579,7 @@ static struct clk_alpha_pll cam_cc_pll7 = {
 	.num_vco = ARRAY_SIZE(lucid_ole_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &cam_cc_pll0_dvfs,
 		.hw.init = &(const struct clk_init_data) {
 			.name = "cam_cc_pll7",
 			.parent_data = &(const struct clk_parent_data) {
@@ -511,6 +635,7 @@ static struct clk_alpha_pll cam_cc_pll8 = {
 	.num_vco = ARRAY_SIZE(lucid_ole_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &cam_cc_pll0_dvfs,
 		.hw.init = &(const struct clk_init_data) {
 			.name = "cam_cc_pll8",
 			.parent_data = &(const struct clk_parent_data) {
@@ -566,6 +691,7 @@ static struct clk_alpha_pll cam_cc_pll9 = {
 	.num_vco = ARRAY_SIZE(lucid_ole_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &cam_cc_pll0_dvfs,
 		.hw.init = &(const struct clk_init_data) {
 			.name = "cam_cc_pll9",
 			.parent_data = &(const struct clk_parent_data) {
@@ -644,6 +770,7 @@ static struct clk_alpha_pll cam_cc_pll10 = {
 	.num_vco = ARRAY_SIZE(lucid_ole_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &cam_cc_pll0_dvfs,
 		.hw.init = &(const struct clk_init_data) {
 			.name = "cam_cc_pll10",
 			.parent_data = &(const struct clk_parent_data) {
@@ -819,6 +946,20 @@ static struct clk_rcg2 cam_cc_bps_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_2,
 	.freq_tbl = ftbl_cam_cc_bps_clk_src,
+	.clkr.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+		.pd_indices = (const unsigned int[]) {
+			DT_PMDOMAIN_MMCX,
+			DT_PMDOMAIN_MXC,
+		},
+		.num_pd_indices = 2,
+		.rates = (const struct qcom_clk_dvfs_rate[]) {
+			{ 200000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+			{ 400000000, RPMH_REGULATOR_LEVEL_SVS },
+			{ 480000000, RPMH_REGULATOR_LEVEL_SVS_L1 },
+			{ 785000000, RPMH_REGULATOR_LEVEL_NOM },
+		},
+		.num_rates = 4,
+	},
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_bps_clk_src",
 		.parent_data = cam_cc_parent_data_2,
@@ -840,6 +981,7 @@ static struct clk_rcg2 cam_cc_camnoc_axi_rt_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_camnoc_axi_rt_clk_src,
+	.clkr.dvfs_data = &cam_cc_camnoc_axi_rt_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_camnoc_axi_rt_clk_src",
 		.parent_data = cam_cc_parent_data_0,
@@ -861,6 +1003,7 @@ static struct clk_rcg2 cam_cc_cci_0_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_cci_0_clk_src,
+	.clkr.dvfs_data = &cam_cc_cci_0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_cci_0_clk_src",
 		.parent_data = cam_cc_parent_data_0,
@@ -876,6 +1019,7 @@ static struct clk_rcg2 cam_cc_cci_1_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_cci_0_clk_src,
+	.clkr.dvfs_data = &cam_cc_cci_0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_cci_1_clk_src",
 		.parent_data = cam_cc_parent_data_0,
@@ -891,6 +1035,7 @@ static struct clk_rcg2 cam_cc_cci_2_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_cci_0_clk_src,
+	.clkr.dvfs_data = &cam_cc_cci_0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_cci_2_clk_src",
 		.parent_data = cam_cc_parent_data_0,
@@ -913,6 +1058,7 @@ static struct clk_rcg2 cam_cc_cphy_rx_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_cphy_rx_clk_src,
+	.clkr.dvfs_data = &cam_cc_cphy_rx_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_cphy_rx_clk_src",
 		.parent_data = cam_cc_parent_data_0,
@@ -936,6 +1082,19 @@ static struct clk_rcg2 cam_cc_cre_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_cre_clk_src,
+	.clkr.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+		.pd_indices = (const unsigned int[]) {
+			DT_PMDOMAIN_MMCX,
+		},
+		.num_pd_indices = 1,
+		.rates = (const struct qcom_clk_dvfs_rate[]) {
+			{ 200000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+			{ 400000000, RPMH_REGULATOR_LEVEL_SVS },
+			{ 480000000, RPMH_REGULATOR_LEVEL_SVS_L1 },
+			{ 600000000, RPMH_REGULATOR_LEVEL_NOM },
+		},
+		.num_rates = 4,
+	},
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_cre_clk_src",
 		.parent_data = cam_cc_parent_data_0,
@@ -957,6 +1116,7 @@ static struct clk_rcg2 cam_cc_csi0phytimer_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_csi0phytimer_clk_src,
+	.clkr.dvfs_data = &cam_cc_csi0phytimer_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_csi0phytimer_clk_src",
 		.parent_data = cam_cc_parent_data_0,
@@ -972,6 +1132,7 @@ static struct clk_rcg2 cam_cc_csi1phytimer_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_csi0phytimer_clk_src,
+	.clkr.dvfs_data = &cam_cc_csi0phytimer_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_csi1phytimer_clk_src",
 		.parent_data = cam_cc_parent_data_0,
@@ -987,6 +1148,7 @@ static struct clk_rcg2 cam_cc_csi2phytimer_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_csi0phytimer_clk_src,
+	.clkr.dvfs_data = &cam_cc_csi2phytimer_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_csi2phytimer_clk_src",
 		.parent_data = cam_cc_parent_data_0,
@@ -1002,6 +1164,7 @@ static struct clk_rcg2 cam_cc_csi3phytimer_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_csi0phytimer_clk_src,
+	.clkr.dvfs_data = &cam_cc_csi0phytimer_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_csi3phytimer_clk_src",
 		.parent_data = cam_cc_parent_data_0,
@@ -1017,6 +1180,7 @@ static struct clk_rcg2 cam_cc_csi4phytimer_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_csi0phytimer_clk_src,
+	.clkr.dvfs_data = &cam_cc_csi2phytimer_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_csi4phytimer_clk_src",
 		.parent_data = cam_cc_parent_data_0,
@@ -1032,6 +1196,7 @@ static struct clk_rcg2 cam_cc_csi5phytimer_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_csi0phytimer_clk_src,
+	.clkr.dvfs_data = &cam_cc_csi0phytimer_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_csi5phytimer_clk_src",
 		.parent_data = cam_cc_parent_data_0,
@@ -1047,6 +1212,7 @@ static struct clk_rcg2 cam_cc_csi6phytimer_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_csi0phytimer_clk_src,
+	.clkr.dvfs_data = &cam_cc_csi0phytimer_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_csi6phytimer_clk_src",
 		.parent_data = cam_cc_parent_data_0,
@@ -1062,6 +1228,7 @@ static struct clk_rcg2 cam_cc_csi7phytimer_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_csi0phytimer_clk_src,
+	.clkr.dvfs_data = &cam_cc_csi0phytimer_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_csi7phytimer_clk_src",
 		.parent_data = cam_cc_parent_data_0,
@@ -1083,6 +1250,7 @@ static struct clk_rcg2 cam_cc_csid_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_csid_clk_src,
+	.clkr.dvfs_data = &cam_cc_ife_lite_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_csid_clk_src",
 		.parent_data = cam_cc_parent_data_0,
@@ -1105,6 +1273,18 @@ static struct clk_rcg2 cam_cc_fast_ahb_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_fast_ahb_clk_src,
+	.clkr.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+		.pd_indices = (const unsigned int[]) {
+			DT_PMDOMAIN_MMCX,
+			DT_PMDOMAIN_MXC,
+		},
+		.num_pd_indices = 2,
+		.rates = (const struct qcom_clk_dvfs_rate[]) {
+			{ 300000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+			{ 400000000, RPMH_REGULATOR_LEVEL_NOM },
+		},
+		.num_rates = 2,
+	},
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_fast_ahb_clk_src",
 		.parent_data = cam_cc_parent_data_0,
@@ -1128,6 +1308,19 @@ static struct clk_rcg2 cam_cc_icp_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_icp_clk_src,
+	.clkr.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+		.pd_indices = (const unsigned int[]) {
+			DT_PMDOMAIN_MMCX,
+			DT_PMDOMAIN_MXC,
+		},
+		.num_pd_indices = 2,
+		.rates = (const struct qcom_clk_dvfs_rate[]) {
+			{ 400000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+			{ 480000000, RPMH_REGULATOR_LEVEL_SVS },
+			{ 600000000, RPMH_REGULATOR_LEVEL_SVS_L1 },
+		},
+		.num_rates = 3,
+	},
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_icp_clk_src",
 		.parent_data = cam_cc_parent_data_0,
@@ -1152,6 +1345,7 @@ static struct clk_rcg2 cam_cc_ife_0_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_3,
 	.freq_tbl = ftbl_cam_cc_ife_0_clk_src,
+	.clkr.dvfs_data = &cam_cc_ife_0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_ife_0_clk_src",
 		.parent_data = cam_cc_parent_data_3,
@@ -1176,6 +1370,7 @@ static struct clk_rcg2 cam_cc_ife_1_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_4,
 	.freq_tbl = ftbl_cam_cc_ife_1_clk_src,
+	.clkr.dvfs_data = &cam_cc_ife_0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_ife_1_clk_src",
 		.parent_data = cam_cc_parent_data_4,
@@ -1200,6 +1395,7 @@ static struct clk_rcg2 cam_cc_ife_2_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_5,
 	.freq_tbl = ftbl_cam_cc_ife_2_clk_src,
+	.clkr.dvfs_data = &cam_cc_ife_0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_ife_2_clk_src",
 		.parent_data = cam_cc_parent_data_5,
@@ -1215,6 +1411,7 @@ static struct clk_rcg2 cam_cc_ife_lite_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_csid_clk_src,
+	.clkr.dvfs_data = &cam_cc_ife_lite_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_ife_lite_clk_src",
 		.parent_data = cam_cc_parent_data_0,
@@ -1230,6 +1427,7 @@ static struct clk_rcg2 cam_cc_ife_lite_csid_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_csid_clk_src,
+	.clkr.dvfs_data = &cam_cc_ife_lite_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_ife_lite_csid_clk_src",
 		.parent_data = cam_cc_parent_data_0,
@@ -1253,6 +1451,20 @@ static struct clk_rcg2 cam_cc_ipe_nps_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_6,
 	.freq_tbl = ftbl_cam_cc_ipe_nps_clk_src,
+	.clkr.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+		.pd_indices = (const unsigned int[]) {
+			DT_PMDOMAIN_MMCX,
+			DT_PMDOMAIN_MXC,
+		},
+		.num_pd_indices = 2,
+		.rates = (const struct qcom_clk_dvfs_rate[]) {
+			{ 475000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+			{ 575000000, RPMH_REGULATOR_LEVEL_SVS },
+			{ 675000000, RPMH_REGULATOR_LEVEL_SVS_L1 },
+			{ 825000000, RPMH_REGULATOR_LEVEL_NOM },
+		},
+		.num_rates = 4,
+	},
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_ipe_nps_clk_src",
 		.parent_data = cam_cc_parent_data_6,
@@ -1277,6 +1489,20 @@ static struct clk_rcg2 cam_cc_jpeg_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_jpeg_clk_src,
+	.clkr.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+		.pd_indices = (const unsigned int[]) {
+			DT_PMDOMAIN_MMCX,
+			DT_PMDOMAIN_MXC,
+		},
+		.num_pd_indices = 2,
+		.rates = (const struct qcom_clk_dvfs_rate[]) {
+			{ 200000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+			{ 400000000, RPMH_REGULATOR_LEVEL_SVS },
+			{ 480000000, RPMH_REGULATOR_LEVEL_SVS_L1 },
+			{ 600000000, RPMH_REGULATOR_LEVEL_NOM },
+		},
+		.num_rates = 4,
+	},
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_jpeg_clk_src",
 		.parent_data = cam_cc_parent_data_0,
@@ -1299,6 +1525,7 @@ static struct clk_rcg2 cam_cc_mclk0_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_1,
 	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
+	.clkr.dvfs_data = &cam_cc_mclk0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_mclk0_clk_src",
 		.parent_data = cam_cc_parent_data_1,
@@ -1314,6 +1541,7 @@ static struct clk_rcg2 cam_cc_mclk1_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_1,
 	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
+	.clkr.dvfs_data = &cam_cc_mclk0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_mclk1_clk_src",
 		.parent_data = cam_cc_parent_data_1,
@@ -1329,6 +1557,7 @@ static struct clk_rcg2 cam_cc_mclk2_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_1,
 	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
+	.clkr.dvfs_data = &cam_cc_mclk0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_mclk2_clk_src",
 		.parent_data = cam_cc_parent_data_1,
@@ -1344,6 +1573,7 @@ static struct clk_rcg2 cam_cc_mclk3_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_1,
 	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
+	.clkr.dvfs_data = &cam_cc_mclk0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_mclk3_clk_src",
 		.parent_data = cam_cc_parent_data_1,
@@ -1359,6 +1589,7 @@ static struct clk_rcg2 cam_cc_mclk4_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_1,
 	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
+	.clkr.dvfs_data = &cam_cc_mclk0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_mclk4_clk_src",
 		.parent_data = cam_cc_parent_data_1,
@@ -1374,6 +1605,7 @@ static struct clk_rcg2 cam_cc_mclk5_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_1,
 	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
+	.clkr.dvfs_data = &cam_cc_mclk0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_mclk5_clk_src",
 		.parent_data = cam_cc_parent_data_1,
@@ -1389,6 +1621,7 @@ static struct clk_rcg2 cam_cc_mclk6_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_1,
 	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
+	.clkr.dvfs_data = &cam_cc_mclk0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_mclk6_clk_src",
 		.parent_data = cam_cc_parent_data_1,
@@ -1404,6 +1637,7 @@ static struct clk_rcg2 cam_cc_mclk7_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_1,
 	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
+	.clkr.dvfs_data = &cam_cc_mclk0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_mclk7_clk_src",
 		.parent_data = cam_cc_parent_data_1,
@@ -1427,6 +1661,18 @@ static struct clk_rcg2 cam_cc_qdss_debug_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_qdss_debug_clk_src,
+	.clkr.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+		.pd_indices = (const unsigned int[]) {
+			DT_PMDOMAIN_MMCX,
+		},
+		.num_pd_indices = 1,
+		.rates = (const struct qcom_clk_dvfs_rate[]) {
+			{ 75000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+			{ 150000000, RPMH_REGULATOR_LEVEL_SVS },
+			{ 300000000, RPMH_REGULATOR_LEVEL_SVS_L1 },
+		},
+		.num_rates = 3,
+	},
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_qdss_debug_clk_src",
 		.parent_data = cam_cc_parent_data_0,
@@ -1450,6 +1696,7 @@ static struct clk_rcg2 cam_cc_sfe_0_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_7,
 	.freq_tbl = ftbl_cam_cc_sfe_0_clk_src,
+	.clkr.dvfs_data = &cam_cc_ife_0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_sfe_0_clk_src",
 		.parent_data = cam_cc_parent_data_7,
@@ -1473,6 +1720,7 @@ static struct clk_rcg2 cam_cc_sfe_1_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_8,
 	.freq_tbl = ftbl_cam_cc_sfe_1_clk_src,
+	.clkr.dvfs_data = &cam_cc_ife_0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_sfe_1_clk_src",
 		.parent_data = cam_cc_parent_data_8,
@@ -1496,6 +1744,7 @@ static struct clk_rcg2 cam_cc_sfe_2_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_9,
 	.freq_tbl = ftbl_cam_cc_sfe_2_clk_src,
+	.clkr.dvfs_data = &cam_cc_ife_0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_sfe_2_clk_src",
 		.parent_data = cam_cc_parent_data_9,
@@ -1516,6 +1765,16 @@ static struct clk_rcg2 cam_cc_sleep_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_10,
 	.freq_tbl = ftbl_cam_cc_sleep_clk_src,
+	.clkr.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+		.pd_indices = (const unsigned int[]) {
+			DT_PMDOMAIN_MMCX,
+		},
+		.num_pd_indices = 1,
+		.rates = (const struct qcom_clk_dvfs_rate[]) {
+			{ 32000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+		},
+		.num_rates = 1,
+	},
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_sleep_clk_src",
 		.parent_data = cam_cc_parent_data_10,
@@ -1537,6 +1796,17 @@ static struct clk_rcg2 cam_cc_slow_ahb_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_slow_ahb_clk_src,
+	.clkr.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+		.pd_indices = (const unsigned int[]) {
+			DT_PMDOMAIN_MMCX,
+			DT_PMDOMAIN_MXC,
+		},
+		.num_pd_indices = 2,
+		.rates = (const struct qcom_clk_dvfs_rate[]) {
+			{ 80000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+		},
+		.num_rates = 1,
+	},
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "cam_cc_slow_ahb_clk_src",
 		.parent_data = cam_cc_parent_data_0,
@@ -3214,6 +3484,9 @@ static struct gdsc cam_cc_titan_top_gdsc = {
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
+	.required_pds = (const unsigned int[]){ DT_PMDOMAIN_MMCX,
+						       DT_PMDOMAIN_MXC },
+	.num_required_pds = 2,
 };
 
 static struct gdsc cam_cc_bps_gdsc = {
@@ -3554,6 +3827,12 @@ static const struct qcom_cc_driver_data cam_cc_sm8650_driver_data = {
 	.num_clk_cbcrs = ARRAY_SIZE(cam_cc_sm8650_critical_cbcrs),
 };
 
+static const unsigned int cam_cc_sm8650_access_pd_indices[] = {
+	DT_PMDOMAIN_MMCX,
+	DT_PMDOMAIN_MXC,
+	DT_PMDOMAIN_MX,
+};
+
 static const struct qcom_cc_desc cam_cc_sm8650_desc = {
 	.config = &cam_cc_sm8650_regmap_config,
 	.clks = cam_cc_sm8650_clocks,
@@ -3563,6 +3842,9 @@ static const struct qcom_cc_desc cam_cc_sm8650_desc = {
 	.gdscs = cam_cc_sm8650_gdscs,
 	.num_gdscs = ARRAY_SIZE(cam_cc_sm8650_gdscs),
 	.use_rpm = true,
+	.pd_indices = cam_cc_sm8650_access_pd_indices,
+	.num_pd_indices = ARRAY_SIZE(cam_cc_sm8650_access_pd_indices),
+	.num_dvfs_rail_voters = 3,
 	.driver_data = &cam_cc_sm8650_driver_data,
 };
 
diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
index 030fc7ef1fbf..0b737e366037 100644
--- a/drivers/clk/qcom/dispcc-sm8550.c
+++ b/drivers/clk/qcom/dispcc-sm8550.c
@@ -5,15 +5,16 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/pm_runtime.h>
 
 #include <dt-bindings/clock/qcom,sm8550-dispcc.h>
+#include <dt-bindings/power/qcom,rpmhpd.h>
 
+#include "clk-dvfs.h"
 #include "common.h"
 #include "clk-alpha-pll.h"
 #include "clk-branch.h"
@@ -69,6 +70,85 @@ enum {
 	P_SLEEP_CLK,
 };
 
+enum {
+	DT_PMDOMAIN_MMCX,
+	DT_PMDOMAIN_MX,
+};
+
+static const unsigned int disp_cc_sm8650_block_pd_indices[] = {
+	DT_PMDOMAIN_MMCX,
+};
+
+static const struct qcom_clk_dvfs_data disp_cc_pll0_dvfs = {
+	.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_MMCX },
+	.num_pd_indices = 1,
+	.rates = (const struct qcom_clk_dvfs_rate[]) {
+		{ 615000000, RPMH_REGULATOR_LEVEL_LOW_SVS_D1 },
+		{ 1100000000, RPMH_REGULATOR_LEVEL_SVS },
+		{ 1600000000, RPMH_REGULATOR_LEVEL_SVS_L1 },
+		{ 2000000000, RPMH_REGULATOR_LEVEL_NOM },
+		{ 2100000000, RPMH_REGULATOR_LEVEL_TURBO_L1 },
+	},
+	.num_rates = 5,
+};
+
+static const struct qcom_clk_dvfs_data disp_cc_mdss_byte0_clk_src_dvfs = {
+	.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_MMCX },
+	.num_pd_indices = 1,
+	.rates = (const struct qcom_clk_dvfs_rate[]) {
+		{ 140630000, RPMH_REGULATOR_LEVEL_LOW_SVS_D1 },
+		{ 187500000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+		{ 300000000, RPMH_REGULATOR_LEVEL_SVS },
+		{ 358000000, RPMH_REGULATOR_LEVEL_SVS_L1 },
+	},
+	.num_rates = 4,
+};
+
+static const struct qcom_clk_dvfs_data disp_cc_mdss_dptx0_aux_clk_src_dvfs = {
+	.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_MMCX },
+	.num_pd_indices = 1,
+	.rates = (const struct qcom_clk_dvfs_rate[]) {
+		{ 19200000, RPMH_REGULATOR_LEVEL_LOW_SVS_D1 },
+	},
+	.num_rates = 1,
+};
+
+static const struct qcom_clk_dvfs_data disp_cc_mdss_dptx0_link_clk_src_dvfs = {
+	.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_MMCX },
+	.num_pd_indices = 1,
+	.rates = (const struct qcom_clk_dvfs_rate[]) {
+		{ 19200000, RPMH_REGULATOR_LEVEL_LOW_SVS_D1 },
+		{ 270000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+		{ 540000000, RPMH_REGULATOR_LEVEL_SVS_L1 },
+		{ 810000000, RPMH_REGULATOR_LEVEL_NOM },
+	},
+	.num_rates = 4,
+};
+
+static const struct qcom_clk_dvfs_data disp_cc_mdss_dptx0_pixel0_clk_src_dvfs = {
+	.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_MMCX },
+	.num_pd_indices = 1,
+	.rates = (const struct qcom_clk_dvfs_rate[]) {
+		{ 19200000, RPMH_REGULATOR_LEVEL_LOW_SVS_D1 },
+		{ 337500000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+		{ 405000000, RPMH_REGULATOR_LEVEL_SVS_L1 },
+		{ 675000000, RPMH_REGULATOR_LEVEL_NOM },
+	},
+	.num_rates = 4,
+};
+
+static const struct qcom_clk_dvfs_data disp_cc_mdss_pclk0_clk_src_dvfs = {
+	.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_MMCX },
+	.num_pd_indices = 1,
+	.rates = (const struct qcom_clk_dvfs_rate[]) {
+		{ 225000000, RPMH_REGULATOR_LEVEL_LOW_SVS_D1 },
+		{ 300000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+		{ 480000000, RPMH_REGULATOR_LEVEL_SVS },
+		{ 625000000, RPMH_REGULATOR_LEVEL_SVS_L1 },
+	},
+	.num_rates = 4,
+};
+
 static struct pll_vco lucid_ole_vco[] = {
 	{ 249600000, 2000000000, 0 },
 };
@@ -89,10 +169,12 @@ static struct alpha_pll_config disp_cc_pll0_config = {
 
 static struct clk_alpha_pll disp_cc_pll0 = {
 	.offset = 0x0,
+	.config = &disp_cc_pll0_config,
 	.vco_table = lucid_ole_vco,
 	.num_vco = ARRAY_SIZE(lucid_ole_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &disp_cc_pll0_dvfs,
 		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_pll0",
 			.parent_data = &(const struct clk_parent_data) {
@@ -120,10 +202,12 @@ static struct alpha_pll_config disp_cc_pll1_config = {
 
 static struct clk_alpha_pll disp_cc_pll1 = {
 	.offset = 0x1000,
+	.config = &disp_cc_pll1_config,
 	.vco_table = lucid_ole_vco,
 	.num_vco = ARRAY_SIZE(lucid_ole_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &disp_cc_pll0_dvfs,
 		.hw.init = &(const struct clk_init_data) {
 			.name = "disp_cc_pll1",
 			.parent_data = &(const struct clk_parent_data) {
@@ -284,6 +368,16 @@ static struct clk_rcg2 disp_cc_mdss_ahb_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_6,
 	.freq_tbl = ftbl_disp_cc_mdss_ahb_clk_src,
+	.clkr.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+		.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_MMCX },
+		.num_pd_indices = 1,
+		.rates = (const struct qcom_clk_dvfs_rate[]) {
+			{ 19200000, RPMH_REGULATOR_LEVEL_LOW_SVS_D1 },
+			{ 37500000, RPMH_REGULATOR_LEVEL_SVS },
+			{ 75000000, RPMH_REGULATOR_LEVEL_NOM },
+		},
+		.num_rates = 3,
+	},
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_ahb_clk_src",
 		.parent_data = disp_cc_parent_data_6,
@@ -304,6 +398,7 @@ static struct clk_rcg2 disp_cc_mdss_byte0_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_2,
 	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
+	.clkr.dvfs_data = &disp_cc_mdss_byte0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_byte0_clk_src",
 		.parent_data = disp_cc_parent_data_2,
@@ -319,6 +414,7 @@ static struct clk_rcg2 disp_cc_mdss_byte1_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_2,
 	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
+	.clkr.dvfs_data = &disp_cc_mdss_byte0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_byte1_clk_src",
 		.parent_data = disp_cc_parent_data_2,
@@ -334,6 +430,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx0_aux_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_0,
 	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
+	.clkr.dvfs_data = &disp_cc_mdss_dptx0_aux_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx0_aux_clk_src",
 		.parent_data = disp_cc_parent_data_0,
@@ -348,6 +445,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx0_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_7,
+	.clkr.dvfs_data = &disp_cc_mdss_dptx0_link_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx0_link_clk_src",
 		.parent_data = disp_cc_parent_data_7,
@@ -363,6 +461,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx0_pixel0_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_4,
 	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
+	.clkr.dvfs_data = &disp_cc_mdss_dptx0_pixel0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx0_pixel0_clk_src",
 		.parent_data = disp_cc_parent_data_4,
@@ -378,6 +477,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx0_pixel1_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_4,
 	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
+	.clkr.dvfs_data = &disp_cc_mdss_dptx0_pixel0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx0_pixel1_clk_src",
 		.parent_data = disp_cc_parent_data_4,
@@ -393,6 +493,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx1_aux_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_0,
 	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
+	.clkr.dvfs_data = &disp_cc_mdss_dptx0_aux_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx1_aux_clk_src",
 		.parent_data = disp_cc_parent_data_0,
@@ -407,6 +508,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx1_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
+	.clkr.dvfs_data = &disp_cc_mdss_dptx0_link_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx1_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
@@ -422,6 +524,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx1_pixel0_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_1,
 	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
+	.clkr.dvfs_data = &disp_cc_mdss_dptx0_pixel0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx1_pixel0_clk_src",
 		.parent_data = disp_cc_parent_data_1,
@@ -437,6 +540,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx1_pixel1_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_1,
 	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
+	.clkr.dvfs_data = &disp_cc_mdss_dptx0_pixel0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx1_pixel1_clk_src",
 		.parent_data = disp_cc_parent_data_1,
@@ -452,6 +556,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx2_aux_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_0,
 	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
+	.clkr.dvfs_data = &disp_cc_mdss_dptx0_aux_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx2_aux_clk_src",
 		.parent_data = disp_cc_parent_data_0,
@@ -466,6 +571,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx2_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
+	.clkr.dvfs_data = &disp_cc_mdss_dptx0_link_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx2_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
@@ -481,6 +587,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx2_pixel0_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_1,
 	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
+	.clkr.dvfs_data = &disp_cc_mdss_dptx0_pixel0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx2_pixel0_clk_src",
 		.parent_data = disp_cc_parent_data_1,
@@ -496,6 +603,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx2_pixel1_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_1,
 	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
+	.clkr.dvfs_data = &disp_cc_mdss_dptx0_pixel0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx2_pixel1_clk_src",
 		.parent_data = disp_cc_parent_data_1,
@@ -511,6 +619,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx3_aux_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_0,
 	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
+	.clkr.dvfs_data = &disp_cc_mdss_dptx0_aux_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx3_aux_clk_src",
 		.parent_data = disp_cc_parent_data_0,
@@ -525,6 +634,17 @@ static struct clk_rcg2 disp_cc_mdss_dptx3_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
+	.clkr.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+		.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_MMCX },
+		.num_pd_indices = 1,
+		.rates = (const struct qcom_clk_dvfs_rate[]) {
+			{ 19200000, RPMH_REGULATOR_LEVEL_LOW_SVS_D1 },
+			{ 270000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+			{ 594000000, RPMH_REGULATOR_LEVEL_SVS },
+			{ 810000000, RPMH_REGULATOR_LEVEL_NOM },
+		},
+		.num_rates = 4,
+	},
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx3_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
@@ -540,6 +660,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx3_pixel0_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_1,
 	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
+	.clkr.dvfs_data = &disp_cc_mdss_dptx0_pixel0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx3_pixel0_clk_src",
 		.parent_data = disp_cc_parent_data_1,
@@ -555,6 +676,7 @@ static struct clk_rcg2 disp_cc_mdss_esc0_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_5,
 	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
+	.clkr.dvfs_data = &disp_cc_mdss_dptx0_aux_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_esc0_clk_src",
 		.parent_data = disp_cc_parent_data_5,
@@ -570,6 +692,7 @@ static struct clk_rcg2 disp_cc_mdss_esc1_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_5,
 	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
+	.clkr.dvfs_data = &disp_cc_mdss_dptx0_aux_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_esc1_clk_src",
 		.parent_data = disp_cc_parent_data_5,
@@ -617,6 +740,21 @@ static struct clk_rcg2 disp_cc_mdss_mdp_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_8,
 	.freq_tbl = ftbl_disp_cc_mdss_mdp_clk_src,
+	.clkr.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+		.pd_indices = (const unsigned int[]) {
+			DT_PMDOMAIN_MMCX,
+			DT_PMDOMAIN_MX,
+		},
+		.num_pd_indices = 2,
+		.rates = (const struct qcom_clk_dvfs_rate[]) {
+			{ 150000000, RPMH_REGULATOR_LEVEL_LOW_SVS_D1 },
+			{ 200000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+			{ 325000000, RPMH_REGULATOR_LEVEL_SVS },
+			{ 402000000, RPMH_REGULATOR_LEVEL_SVS_L1 },
+			{ 514000000, RPMH_REGULATOR_LEVEL_NOM },
+		},
+		.num_rates = 5,
+	},
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_mdp_clk_src",
 		.parent_data = disp_cc_parent_data_8,
@@ -632,6 +770,7 @@ static struct clk_rcg2 disp_cc_mdss_pclk0_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_2,
 	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
+	.clkr.dvfs_data = &disp_cc_mdss_pclk0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_pclk0_clk_src",
 		.parent_data = disp_cc_parent_data_2,
@@ -647,6 +786,7 @@ static struct clk_rcg2 disp_cc_mdss_pclk1_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_2,
 	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
+	.clkr.dvfs_data = &disp_cc_mdss_pclk0_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_pclk1_clk_src",
 		.parent_data = disp_cc_parent_data_2,
@@ -662,6 +802,7 @@ static struct clk_rcg2 disp_cc_mdss_vsync_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_0,
 	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
+	.clkr.dvfs_data = &disp_cc_mdss_dptx0_aux_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_vsync_clk_src",
 		.parent_data = disp_cc_parent_data_0,
@@ -682,6 +823,14 @@ static struct clk_rcg2 disp_cc_sleep_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_9,
 	.freq_tbl = ftbl_disp_cc_sleep_clk_src,
+	.clkr.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+		.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_MMCX },
+		.num_pd_indices = 1,
+		.rates = (const struct qcom_clk_dvfs_rate[]) {
+			{ 32000, RPMH_REGULATOR_LEVEL_LOW_SVS_D1 },
+		},
+		.num_rates = 1,
+	},
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_sleep_clk_src",
 		.parent_data = disp_cc_parent_data_9,
@@ -1629,6 +1778,8 @@ static struct gdsc mdss_gdsc = {
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | HW_CTRL | RETAIN_FF_ENABLE,
+	.required_pds = disp_cc_sm8650_block_pd_indices,
+	.num_required_pds = ARRAY_SIZE(disp_cc_sm8650_block_pd_indices),
 };
 
 static struct gdsc mdss_int2_gdsc = {
@@ -1638,6 +1789,8 @@ static struct gdsc mdss_int2_gdsc = {
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | HW_CTRL | RETAIN_FF_ENABLE,
+	.required_pds = disp_cc_sm8650_block_pd_indices,
+	.num_required_pds = ARRAY_SIZE(disp_cc_sm8650_block_pd_indices),
 };
 
 static struct clk_regmap *disp_cc_sm8550_clocks[] = {
@@ -1725,6 +1878,91 @@ static struct clk_regmap *disp_cc_sm8550_clocks[] = {
 	[DISP_CC_XO_CLK_SRC] = &disp_cc_xo_clk_src.clkr,
 };
 
+static struct clk_regmap *disp_cc_sm8650_clocks[] = {
+	[DISP_CC_MDSS_ACCU_CLK] = &disp_cc_mdss_accu_clk.clkr,
+	[DISP_CC_MDSS_AHB1_CLK] = &disp_cc_mdss_ahb1_clk.clkr,
+	[DISP_CC_MDSS_AHB_CLK] = &disp_cc_mdss_ahb_clk.clkr,
+	[DISP_CC_MDSS_AHB_CLK_SRC] = &disp_cc_mdss_ahb_clk_src.clkr,
+	[DISP_CC_MDSS_BYTE0_CLK] = &disp_cc_mdss_byte0_clk.clkr,
+	[DISP_CC_MDSS_BYTE0_CLK_SRC] = &disp_cc_mdss_byte0_clk_src.clkr,
+	[DISP_CC_MDSS_BYTE0_DIV_CLK_SRC] = &disp_cc_mdss_byte0_div_clk_src.clkr,
+	[DISP_CC_MDSS_BYTE0_INTF_CLK] = &disp_cc_mdss_byte0_intf_clk.clkr,
+	[DISP_CC_MDSS_BYTE1_CLK] = &disp_cc_mdss_byte1_clk.clkr,
+	[DISP_CC_MDSS_BYTE1_CLK_SRC] = &disp_cc_mdss_byte1_clk_src.clkr,
+	[DISP_CC_MDSS_BYTE1_DIV_CLK_SRC] = &disp_cc_mdss_byte1_div_clk_src.clkr,
+	[DISP_CC_MDSS_BYTE1_INTF_CLK] = &disp_cc_mdss_byte1_intf_clk.clkr,
+	[DISP_CC_MDSS_DPTX0_AUX_CLK] = &disp_cc_mdss_dptx0_aux_clk.clkr,
+	[DISP_CC_MDSS_DPTX0_AUX_CLK_SRC] = &disp_cc_mdss_dptx0_aux_clk_src.clkr,
+	[DISP_CC_MDSS_DPTX0_CRYPTO_CLK] = &disp_cc_mdss_dptx0_crypto_clk.clkr,
+	[DISP_CC_MDSS_DPTX0_LINK_CLK] = &disp_cc_mdss_dptx0_link_clk.clkr,
+	[DISP_CC_MDSS_DPTX0_LINK_CLK_SRC] = &disp_cc_mdss_dptx0_link_clk_src.clkr,
+	[DISP_CC_MDSS_DPTX0_LINK_DIV_CLK_SRC] = &disp_cc_mdss_dptx0_link_div_clk_src.clkr,
+	[DISP_CC_MDSS_DPTX0_LINK_INTF_CLK] = &disp_cc_mdss_dptx0_link_intf_clk.clkr,
+	[DISP_CC_MDSS_DPTX0_PIXEL0_CLK] = &disp_cc_mdss_dptx0_pixel0_clk.clkr,
+	[DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC] = &disp_cc_mdss_dptx0_pixel0_clk_src.clkr,
+	[DISP_CC_MDSS_DPTX0_PIXEL1_CLK] = &disp_cc_mdss_dptx0_pixel1_clk.clkr,
+	[DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC] = &disp_cc_mdss_dptx0_pixel1_clk_src.clkr,
+	[DISP_CC_MDSS_DPTX0_USB_ROUTER_LINK_INTF_CLK] =
+		&disp_cc_mdss_dptx0_usb_router_link_intf_clk.clkr,
+	[DISP_CC_MDSS_DPTX1_AUX_CLK] = &disp_cc_mdss_dptx1_aux_clk.clkr,
+	[DISP_CC_MDSS_DPTX1_AUX_CLK_SRC] = &disp_cc_mdss_dptx1_aux_clk_src.clkr,
+	[DISP_CC_MDSS_DPTX1_CRYPTO_CLK] = &disp_cc_mdss_dptx1_crypto_clk.clkr,
+	[DISP_CC_MDSS_DPTX1_LINK_CLK] = &disp_cc_mdss_dptx1_link_clk.clkr,
+	[DISP_CC_MDSS_DPTX1_LINK_CLK_SRC] = &disp_cc_mdss_dptx1_link_clk_src.clkr,
+	[DISP_CC_MDSS_DPTX1_LINK_DIV_CLK_SRC] = &disp_cc_mdss_dptx1_link_div_clk_src.clkr,
+	[DISP_CC_MDSS_DPTX1_LINK_INTF_CLK] = &disp_cc_mdss_dptx1_link_intf_clk.clkr,
+	[DISP_CC_MDSS_DPTX1_PIXEL0_CLK] = &disp_cc_mdss_dptx1_pixel0_clk.clkr,
+	[DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC] = &disp_cc_mdss_dptx1_pixel0_clk_src.clkr,
+	[DISP_CC_MDSS_DPTX1_PIXEL1_CLK] = &disp_cc_mdss_dptx1_pixel1_clk.clkr,
+	[DISP_CC_MDSS_DPTX1_PIXEL1_CLK_SRC] = &disp_cc_mdss_dptx1_pixel1_clk_src.clkr,
+	[DISP_CC_MDSS_DPTX1_USB_ROUTER_LINK_INTF_CLK] =
+		&disp_cc_mdss_dptx1_usb_router_link_intf_clk.clkr,
+	[DISP_CC_MDSS_DPTX2_AUX_CLK] = &disp_cc_mdss_dptx2_aux_clk.clkr,
+	[DISP_CC_MDSS_DPTX2_AUX_CLK_SRC] = &disp_cc_mdss_dptx2_aux_clk_src.clkr,
+	[DISP_CC_MDSS_DPTX2_CRYPTO_CLK] = &disp_cc_mdss_dptx2_crypto_clk.clkr,
+	[DISP_CC_MDSS_DPTX2_LINK_CLK] = &disp_cc_mdss_dptx2_link_clk.clkr,
+	[DISP_CC_MDSS_DPTX2_LINK_CLK_SRC] = &disp_cc_mdss_dptx2_link_clk_src.clkr,
+	[DISP_CC_MDSS_DPTX2_LINK_DIV_CLK_SRC] = &disp_cc_mdss_dptx2_link_div_clk_src.clkr,
+	[DISP_CC_MDSS_DPTX2_LINK_INTF_CLK] = &disp_cc_mdss_dptx2_link_intf_clk.clkr,
+	[DISP_CC_MDSS_DPTX2_PIXEL0_CLK] = &disp_cc_mdss_dptx2_pixel0_clk.clkr,
+	[DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC] = &disp_cc_mdss_dptx2_pixel0_clk_src.clkr,
+	[DISP_CC_MDSS_DPTX2_PIXEL1_CLK] = &disp_cc_mdss_dptx2_pixel1_clk.clkr,
+	[DISP_CC_MDSS_DPTX2_PIXEL1_CLK_SRC] = &disp_cc_mdss_dptx2_pixel1_clk_src.clkr,
+	[DISP_CC_MDSS_DPTX3_AUX_CLK] = &disp_cc_mdss_dptx3_aux_clk.clkr,
+	[DISP_CC_MDSS_DPTX3_AUX_CLK_SRC] = &disp_cc_mdss_dptx3_aux_clk_src.clkr,
+	[DISP_CC_MDSS_DPTX3_CRYPTO_CLK] = &disp_cc_mdss_dptx3_crypto_clk.clkr,
+	[DISP_CC_MDSS_DPTX3_LINK_CLK] = &disp_cc_mdss_dptx3_link_clk.clkr,
+	[DISP_CC_MDSS_DPTX3_LINK_CLK_SRC] = &disp_cc_mdss_dptx3_link_clk_src.clkr,
+	[DISP_CC_MDSS_DPTX3_LINK_DIV_CLK_SRC] = &disp_cc_mdss_dptx3_link_div_clk_src.clkr,
+	[DISP_CC_MDSS_DPTX3_LINK_INTF_CLK] = &disp_cc_mdss_dptx3_link_intf_clk.clkr,
+	[DISP_CC_MDSS_DPTX3_PIXEL0_CLK] = &disp_cc_mdss_dptx3_pixel0_clk.clkr,
+	[DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC] = &disp_cc_mdss_dptx3_pixel0_clk_src.clkr,
+	[DISP_CC_MDSS_ESC0_CLK] = &disp_cc_mdss_esc0_clk.clkr,
+	[DISP_CC_MDSS_ESC0_CLK_SRC] = &disp_cc_mdss_esc0_clk_src.clkr,
+	[DISP_CC_MDSS_ESC1_CLK] = &disp_cc_mdss_esc1_clk.clkr,
+	[DISP_CC_MDSS_ESC1_CLK_SRC] = &disp_cc_mdss_esc1_clk_src.clkr,
+	[DISP_CC_MDSS_MDP1_CLK] = &disp_cc_mdss_mdp1_clk.clkr,
+	[DISP_CC_MDSS_MDP_CLK] = &disp_cc_mdss_mdp_clk.clkr,
+	[DISP_CC_MDSS_MDP_CLK_SRC] = &disp_cc_mdss_mdp_clk_src.clkr,
+	[DISP_CC_MDSS_MDP_LUT1_CLK] = &disp_cc_mdss_mdp_lut1_clk.clkr,
+	[DISP_CC_MDSS_MDP_LUT_CLK] = &disp_cc_mdss_mdp_lut_clk.clkr,
+	[DISP_CC_MDSS_NON_GDSC_AHB_CLK] = &disp_cc_mdss_non_gdsc_ahb_clk.clkr,
+	[DISP_CC_MDSS_PCLK0_CLK] = &disp_cc_mdss_pclk0_clk.clkr,
+	[DISP_CC_MDSS_PCLK0_CLK_SRC] = &disp_cc_mdss_pclk0_clk_src.clkr,
+	[DISP_CC_MDSS_PCLK1_CLK] = &disp_cc_mdss_pclk1_clk.clkr,
+	[DISP_CC_MDSS_PCLK1_CLK_SRC] = &disp_cc_mdss_pclk1_clk_src.clkr,
+	[DISP_CC_MDSS_RSCC_AHB_CLK] = &disp_cc_mdss_rscc_ahb_clk.clkr,
+	[DISP_CC_MDSS_RSCC_VSYNC_CLK] = &disp_cc_mdss_rscc_vsync_clk.clkr,
+	[DISP_CC_MDSS_VSYNC1_CLK] = &disp_cc_mdss_vsync1_clk.clkr,
+	[DISP_CC_MDSS_VSYNC_CLK] = &disp_cc_mdss_vsync_clk.clkr,
+	[DISP_CC_MDSS_VSYNC_CLK_SRC] = &disp_cc_mdss_vsync_clk_src.clkr,
+	[DISP_CC_PLL0] = &disp_cc_pll0.clkr,
+	[DISP_CC_PLL1] = &disp_cc_pll1.clkr,
+	[DISP_CC_SLEEP_CLK] = &disp_cc_sleep_clk.clkr,
+	[DISP_CC_SLEEP_CLK_SRC] = &disp_cc_sleep_clk_src.clkr,
+	[DISP_CC_XO_CLK_SRC] = &disp_cc_xo_clk_src.clkr,
+};
+
 static const struct qcom_reset_map disp_cc_sm8550_resets[] = {
 	[DISP_CC_MDSS_CORE_BCR] = { 0x8000 },
 	[DISP_CC_MDSS_CORE_INT2_BCR] = { 0xa000 },
@@ -1744,13 +1982,25 @@ static const struct regmap_config disp_cc_sm8550_regmap_config = {
 	.fast_io = true,
 };
 
-static const u32 disp_cc_sm8550_critical_cbcrs[] = {
-	0xe054, /* DISP_CC_XO_CLK */
+static struct clk_alpha_pll *disp_cc_sm8550_plls[] = {
+	&disp_cc_pll0,
+	&disp_cc_pll1,
 };
 
+static void disp_cc_sm8550_clk_regs_configure(struct device *dev,
+					       struct regmap *regmap)
+{
+	/* Enable clock gating for MDP clocks. */
+	regmap_update_bits(regmap, DISP_CC_MISC_CMD, 0x10, 0x10);
+
+	/* Keep the XO clock always on. */
+	qcom_branch_set_clk_en(regmap, 0xe054);
+}
+
 static const struct qcom_cc_driver_data disp_cc_sm8550_driver_data = {
-	.clk_cbcrs = disp_cc_sm8550_critical_cbcrs,
-	.num_clk_cbcrs = ARRAY_SIZE(disp_cc_sm8550_critical_cbcrs),
+	.alpha_plls = disp_cc_sm8550_plls,
+	.num_alpha_plls = ARRAY_SIZE(disp_cc_sm8550_plls),
+	.clk_regs_configure = disp_cc_sm8550_clk_regs_configure,
 };
 
 static const struct qcom_cc_desc disp_cc_sm8550_desc = {
@@ -1762,36 +2012,43 @@ static const struct qcom_cc_desc disp_cc_sm8550_desc = {
 	.num_resets = ARRAY_SIZE(disp_cc_sm8550_resets),
 	.gdscs = disp_cc_sm8550_gdscs,
 	.num_gdscs = ARRAY_SIZE(disp_cc_sm8550_gdscs),
+	.use_rpm = true,
+};
+
+static const unsigned int disp_cc_sm8650_access_pd_indices[] = {
+	DT_PMDOMAIN_MMCX,
+	DT_PMDOMAIN_MX,
+};
+
+static const struct qcom_cc_desc disp_cc_sm8650_desc = {
+	.config = &disp_cc_sm8550_regmap_config,
+	.clks = disp_cc_sm8650_clocks,
+	.num_clks = ARRAY_SIZE(disp_cc_sm8650_clocks),
+	.resets = disp_cc_sm8550_resets,
+	.num_resets = ARRAY_SIZE(disp_cc_sm8550_resets),
+	.gdscs = disp_cc_sm8550_gdscs,
+	.num_gdscs = ARRAY_SIZE(disp_cc_sm8550_gdscs),
+	.use_rpm = true,
+	.pd_indices = disp_cc_sm8650_access_pd_indices,
+	.num_pd_indices = ARRAY_SIZE(disp_cc_sm8650_access_pd_indices),
+	.num_dvfs_rail_voters = 2,
+	.driver_data = &disp_cc_sm8550_driver_data,
 };
 
 static const struct of_device_id disp_cc_sm8550_match_table[] = {
-	{ .compatible = "qcom,sar2130p-dispcc" },
-	{ .compatible = "qcom,sm8550-dispcc" },
-	{ .compatible = "qcom,sm8650-dispcc" },
+	{ .compatible = "qcom,sar2130p-dispcc", .data = &disp_cc_sm8550_desc },
+	{ .compatible = "qcom,sm8550-dispcc", .data = &disp_cc_sm8550_desc },
+	{ .compatible = "qcom,sm8650-dispcc", .data = &disp_cc_sm8650_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, disp_cc_sm8550_match_table);
 
 static int disp_cc_sm8550_probe(struct platform_device *pdev)
 {
-	struct regmap *regmap;
-	int ret;
+	const struct qcom_cc_desc *desc = of_device_get_match_data(&pdev->dev);
+	bool sm8650 = desc == &disp_cc_sm8650_desc;
 
-	ret = devm_pm_runtime_enable(&pdev->dev);
-	if (ret)
-		return ret;
-
-	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret)
-		return ret;
-
-	regmap = qcom_cc_map(pdev, &disp_cc_sm8550_desc);
-	if (IS_ERR(regmap)) {
-		ret = PTR_ERR(regmap);
-		goto err_put_rpm;
-	}
-
-	if (of_device_is_compatible(pdev->dev.of_node, "qcom,sm8650-dispcc")) {
+	if (sm8650) {
 		lucid_ole_vco[0].max_freq = 2100000000;
 		disp_cc_mdss_mdp_clk_src.freq_tbl = ftbl_disp_cc_mdss_mdp_clk_src_sm8650;
 		disp_cc_mdss_dptx1_usb_router_link_intf_clk.clkr.hw.init->parent_hws[0] =
@@ -1804,24 +2061,7 @@ static int disp_cc_sm8550_probe(struct platform_device *pdev)
 		disp_cc_mdss_mdp_clk_src.freq_tbl = ftbl_disp_cc_mdss_mdp_clk_src_sar2130p;
 	}
 
-	clk_lucid_ole_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
-	clk_lucid_ole_pll_configure(&disp_cc_pll1, regmap, &disp_cc_pll1_config);
-
-	/* Enable clock gating for MDP clocks */
-	regmap_update_bits(regmap, DISP_CC_MISC_CMD, 0x10, 0x10);
-
-	ret = qcom_cc_really_probe(&pdev->dev, &disp_cc_sm8550_desc, regmap);
-	if (ret)
-		goto err_put_rpm;
-
-	pm_runtime_put(&pdev->dev);
-
-	return 0;
-
-err_put_rpm:
-	pm_runtime_put_sync(&pdev->dev);
-
-	return ret;
+	return qcom_cc_probe(pdev, desc);
 }
 
 static struct platform_driver disp_cc_sm8550_driver = {
diff --git a/drivers/clk/qcom/gcc-sm8650.c b/drivers/clk/qcom/gcc-sm8650.c
index e439c958ae16..8e1fd75b606c 100644
--- a/drivers/clk/qcom/gcc-sm8650.c
+++ b/drivers/clk/qcom/gcc-sm8650.c
@@ -11,9 +11,11 @@
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,sm8650-gcc.h>
+#include <dt-bindings/power/qcom,rpmhpd.h>
 
 #include "clk-alpha-pll.h"
 #include "clk-branch.h"
+#include "clk-dvfs.h"
 #include "clk-rcg.h"
 #include "clk-regmap.h"
 #include "clk-regmap-divider.h"
@@ -59,10 +61,100 @@ enum {
 	P_USB3_PHY_WRAPPER_GCC_USB30_PIPE_CLK,
 };
 
+enum {
+	DT_PMDOMAIN_CX,
+	DT_PMDOMAIN_CX_AO,
+	DT_PMDOMAIN_MX,
+};
+
+static const unsigned int gcc_sm8650_cx_block_pd_indices[] = {
+	DT_PMDOMAIN_CX,
+};
+
+static const unsigned int gcc_sm8650_mx_block_pd_indices[] = {
+	DT_PMDOMAIN_MX,
+};
+
+static const struct qcom_clk_dvfs_data gcc_gpll0_dvfs = {
+	.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_CX },
+	.num_pd_indices = 1,
+	.rates = (const struct qcom_clk_dvfs_rate[]) {
+		{ 615000000, RPMH_REGULATOR_LEVEL_LOW_SVS_D1 },
+		{ 1100000000, RPMH_REGULATOR_LEVEL_SVS },
+		{ 1600000000, RPMH_REGULATOR_LEVEL_SVS_L1 },
+		{ 2000000000, RPMH_REGULATOR_LEVEL_NOM },
+		{ 2100000000, RPMH_REGULATOR_LEVEL_TURBO_L1 },
+	},
+	.num_rates = 5,
+};
+
+static const struct qcom_clk_dvfs_data gcc_gpll0_ao_dvfs = {
+	.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_CX_AO },
+	.num_pd_indices = 1,
+	.rates = (const struct qcom_clk_dvfs_rate[]) {
+		{ 615000000, RPMH_REGULATOR_LEVEL_LOW_SVS_D1 },
+		{ 1100000000, RPMH_REGULATOR_LEVEL_SVS },
+		{ 1600000000, RPMH_REGULATOR_LEVEL_SVS_L1 },
+		{ 2000000000, RPMH_REGULATOR_LEVEL_NOM },
+		{ 2100000000, RPMH_REGULATOR_LEVEL_TURBO_L1 },
+	},
+	.num_rates = 5,
+};
+
+static const struct qcom_clk_dvfs_data gcc_gp1_clk_src_dvfs = {
+	.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_CX },
+	.num_pd_indices = 1,
+	.rates = (const struct qcom_clk_dvfs_rate[]) {
+		{ 50000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+		{ 100000000, RPMH_REGULATOR_LEVEL_SVS },
+		{ 200000000, RPMH_REGULATOR_LEVEL_NOM },
+	},
+	.num_rates = 3,
+};
+
+static const struct qcom_clk_dvfs_data gcc_pcie_0_aux_clk_src_dvfs = {
+	.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_CX, DT_PMDOMAIN_MX },
+	.num_pd_indices = 2,
+	.rates = (const struct qcom_clk_dvfs_rate[]) {
+		{ 19200000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+	},
+	.num_rates = 1,
+};
+
+static const struct qcom_clk_dvfs_data gcc_pcie_0_phy_rchng_clk_src_dvfs = {
+	.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_CX },
+	.num_pd_indices = 1,
+	.rates = (const struct qcom_clk_dvfs_rate[]) {
+		{ 100000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+	},
+	.num_rates = 1,
+};
+
+static const struct qcom_clk_dvfs_data gcc_qupv3_i2c_s0_clk_src_dvfs = {
+	.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_CX },
+	.num_pd_indices = 1,
+	.rates = (const struct qcom_clk_dvfs_rate[]) {
+		{ 19200000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+	},
+	.num_rates = 1,
+};
+
+static const struct qcom_clk_dvfs_data gcc_ufs_phy_axi_clk_src_dvfs = {
+	.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_CX, DT_PMDOMAIN_MX },
+	.num_pd_indices = 2,
+	.rates = (const struct qcom_clk_dvfs_rate[]) {
+		{ 100000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+		{ 201500000, RPMH_REGULATOR_LEVEL_SVS },
+		{ 403000000, RPMH_REGULATOR_LEVEL_NOM },
+	},
+	.num_rates = 3,
+};
+
 static struct clk_alpha_pll gcc_gpll0 = {
 	.offset = 0x0,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &gcc_gpll0_dvfs,
 		.enable_reg = 0x52020,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
@@ -80,6 +172,7 @@ static struct clk_alpha_pll gcc_gpll0_ao = {
 	.offset = 0x0,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &gcc_gpll0_ao_dvfs,
 		.enable_reg = 0x57020,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
@@ -136,6 +229,7 @@ static struct clk_alpha_pll gcc_gpll1 = {
 	.offset = 0x4000,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &gcc_gpll0_dvfs,
 		.enable_reg = 0x52020,
 		.enable_mask = BIT(1),
 		.hw.init = &(const struct clk_init_data) {
@@ -153,6 +247,7 @@ static struct clk_alpha_pll gcc_gpll1_ao = {
 	.offset = 0x1000,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &gcc_gpll0_ao_dvfs,
 		.enable_reg = 0x57020,
 		.enable_mask = BIT(1),
 		.hw.init = &(const struct clk_init_data) {
@@ -170,6 +265,7 @@ static struct clk_alpha_pll gcc_gpll3 = {
 	.offset = 0x3000,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &gcc_gpll0_dvfs,
 		.enable_reg = 0x52020,
 		.enable_mask = BIT(3),
 		.hw.init = &(const struct clk_init_data) {
@@ -187,6 +283,7 @@ static struct clk_alpha_pll gcc_gpll3_ao = {
 	.offset = 0x3000,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &gcc_gpll0_ao_dvfs,
 		.enable_reg = 0x57020,
 		.enable_mask = BIT(3),
 		.hw.init = &(const struct clk_init_data) {
@@ -204,6 +301,7 @@ static struct clk_alpha_pll gcc_gpll4 = {
 	.offset = 0x4000,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &gcc_gpll0_dvfs,
 		.enable_reg = 0x52020,
 		.enable_mask = BIT(4),
 		.hw.init = &(const struct clk_init_data) {
@@ -221,6 +319,7 @@ static struct clk_alpha_pll gcc_gpll4_ao = {
 	.offset = 0x4000,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &gcc_gpll0_ao_dvfs,
 		.enable_reg = 0x57020,
 		.enable_mask = BIT(4),
 		.hw.init = &(const struct clk_init_data) {
@@ -238,6 +337,7 @@ static struct clk_alpha_pll gcc_gpll6 = {
 	.offset = 0x6000,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &gcc_gpll0_dvfs,
 		.enable_reg = 0x52020,
 		.enable_mask = BIT(6),
 		.hw.init = &(const struct clk_init_data) {
@@ -255,6 +355,7 @@ static struct clk_alpha_pll gcc_gpll6_ao = {
 	.offset = 0x6000,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &gcc_gpll0_ao_dvfs,
 		.enable_reg = 0x57020,
 		.enable_mask = BIT(6),
 		.hw.init = &(const struct clk_init_data) {
@@ -272,6 +373,7 @@ static struct clk_alpha_pll gcc_gpll7 = {
 	.offset = 0x7000,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &gcc_gpll0_dvfs,
 		.enable_reg = 0x52020,
 		.enable_mask = BIT(7),
 		.hw.init = &(const struct clk_init_data) {
@@ -289,6 +391,7 @@ static struct clk_alpha_pll gcc_gpll9 = {
 	.offset = 0x9000,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &gcc_gpll0_dvfs,
 		.enable_reg = 0x52020,
 		.enable_mask = BIT(9),
 		.hw.init = &(const struct clk_init_data) {
@@ -344,6 +447,18 @@ static const struct clk_parent_data gcc_parent_data_2[] = {
 	{ .hw = &gcc_gpll0_out_even.clkr.hw },
 };
 
+static const struct parent_map gcc_parent_map_6[] = {
+	{ P_GCC_GPLL0_OUT_EVEN, 6 },
+	{ P_GCC_GPLL1_OUT_MAIN, 4 },
+	{ P_GCC_GPLL4_OUT_MAIN, 5 },
+};
+
+static const struct clk_parent_data gcc_parent_data_6_ao[] = {
+	{ .hw = &gcc_gpll0_out_even_ao.clkr.hw },
+	{ .hw = &gcc_gpll1_ao.clkr.hw },
+	{ .hw = &gcc_gpll4_ao.clkr.hw },
+};
+
 static const struct parent_map gcc_parent_map_3[] = {
 	{ P_BI_TCXO, 0 },
 	{ P_GCC_GPLL0_OUT_MAIN, 1 },
@@ -566,12 +681,47 @@ static const struct freq_tbl ftbl_gcc_gp1_clk_src[] = {
 	{ }
 };
 
+static const struct freq_tbl ftbl_gcc_cpuss_ubwcp_clk_src[] = {
+	F(300000000, P_GCC_GPLL0_OUT_EVEN, 1, 0, 0),
+	F(403000000, P_GCC_GPLL4_OUT_MAIN, 2, 0, 0),
+	F(533000000, P_GCC_GPLL1_OUT_MAIN, 2, 0, 0),
+	F(710666667, P_GCC_GPLL1_OUT_MAIN, 1.5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_cpuss_ubwcp_clk_src = {
+	.cmd_rcgr = 0x63004,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_6,
+	.freq_tbl = ftbl_gcc_cpuss_ubwcp_clk_src,
+	.clkr.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+		.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_CX_AO },
+		.num_pd_indices = 1,
+		.rates = (const struct qcom_clk_dvfs_rate[]) {
+			{ 300000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+			{ 403000000, RPMH_REGULATOR_LEVEL_SVS },
+			{ 533000000, RPMH_REGULATOR_LEVEL_NOM },
+			{ 710666667, RPMH_REGULATOR_LEVEL_TURBO },
+		},
+		.num_rates = 4,
+	},
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_cpuss_ubwcp_clk_src",
+		.parent_data = gcc_parent_data_6_ao,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_6_ao),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
 static struct clk_rcg2 gcc_gp1_clk_src = {
 	.cmd_rcgr = 0x64004,
 	.mnd_width = 16,
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_1,
 	.freq_tbl = ftbl_gcc_gp1_clk_src,
+	.clkr.dvfs_data = &gcc_gp1_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_gp1_clk_src",
 		.parent_data = gcc_parent_data_1,
@@ -587,6 +737,7 @@ static struct clk_rcg2 gcc_gp2_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_1,
 	.freq_tbl = ftbl_gcc_gp1_clk_src,
+	.clkr.dvfs_data = &gcc_gp1_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_gp2_clk_src",
 		.parent_data = gcc_parent_data_1,
@@ -602,6 +753,7 @@ static struct clk_rcg2 gcc_gp3_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_1,
 	.freq_tbl = ftbl_gcc_gp1_clk_src,
+	.clkr.dvfs_data = &gcc_gp1_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_gp3_clk_src",
 		.parent_data = gcc_parent_data_1,
@@ -622,6 +774,7 @@ static struct clk_rcg2 gcc_pcie_0_aux_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_4,
 	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
+	.clkr.dvfs_data = &gcc_pcie_0_aux_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_pcie_0_aux_clk_src",
 		.parent_data = gcc_parent_data_4,
@@ -642,6 +795,7 @@ static struct clk_rcg2 gcc_pcie_0_phy_rchng_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_0,
 	.freq_tbl = ftbl_gcc_pcie_0_phy_rchng_clk_src,
+	.clkr.dvfs_data = &gcc_pcie_0_phy_rchng_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_pcie_0_phy_rchng_clk_src",
 		.parent_data = gcc_parent_data_0,
@@ -657,6 +811,7 @@ static struct clk_rcg2 gcc_pcie_1_aux_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_4,
 	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
+	.clkr.dvfs_data = &gcc_pcie_0_aux_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_pcie_1_aux_clk_src",
 		.parent_data = gcc_parent_data_4,
@@ -672,6 +827,7 @@ static struct clk_rcg2 gcc_pcie_1_phy_rchng_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_0,
 	.freq_tbl = ftbl_gcc_pcie_0_phy_rchng_clk_src,
+	.clkr.dvfs_data = &gcc_pcie_0_phy_rchng_clk_src_dvfs,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_pcie_1_phy_rchng_clk_src",
 		.parent_data = gcc_parent_data_0,
@@ -692,6 +848,14 @@ static struct clk_rcg2 gcc_pdm2_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_0,
 	.freq_tbl = ftbl_gcc_pdm2_clk_src,
+	.clkr.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+		.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_CX },
+		.num_pd_indices = 1,
+		.rates = (const struct qcom_clk_dvfs_rate[]) {
+			{ 60000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+		},
+		.num_rates = 1,
+	},
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_pdm2_clk_src",
 		.parent_data = gcc_parent_data_0,
@@ -702,6 +866,7 @@ static struct clk_rcg2 gcc_pdm2_clk_src = {
 };
 
 static struct clk_rcg2 gcc_qupv3_i2c_s0_clk_src = {
+	.clkr.dvfs_data = &gcc_qupv3_i2c_s0_clk_src_dvfs,
 	.cmd_rcgr = 0x17008,
 	.mnd_width = 0,
 	.hid_width = 5,
@@ -717,6 +882,7 @@ static struct clk_rcg2 gcc_qupv3_i2c_s0_clk_src = {
 };
 
 static struct clk_rcg2 gcc_qupv3_i2c_s1_clk_src = {
+	.clkr.dvfs_data = &gcc_qupv3_i2c_s0_clk_src_dvfs,
 	.cmd_rcgr = 0x17024,
 	.mnd_width = 0,
 	.hid_width = 5,
@@ -732,6 +898,7 @@ static struct clk_rcg2 gcc_qupv3_i2c_s1_clk_src = {
 };
 
 static struct clk_rcg2 gcc_qupv3_i2c_s2_clk_src = {
+	.clkr.dvfs_data = &gcc_qupv3_i2c_s0_clk_src_dvfs,
 	.cmd_rcgr = 0x17040,
 	.mnd_width = 0,
 	.hid_width = 5,
@@ -747,6 +914,7 @@ static struct clk_rcg2 gcc_qupv3_i2c_s2_clk_src = {
 };
 
 static struct clk_rcg2 gcc_qupv3_i2c_s3_clk_src = {
+	.clkr.dvfs_data = &gcc_qupv3_i2c_s0_clk_src_dvfs,
 	.cmd_rcgr = 0x1705c,
 	.mnd_width = 0,
 	.hid_width = 5,
@@ -762,6 +930,7 @@ static struct clk_rcg2 gcc_qupv3_i2c_s3_clk_src = {
 };
 
 static struct clk_rcg2 gcc_qupv3_i2c_s4_clk_src = {
+	.clkr.dvfs_data = &gcc_qupv3_i2c_s0_clk_src_dvfs,
 	.cmd_rcgr = 0x17078,
 	.mnd_width = 0,
 	.hid_width = 5,
@@ -777,6 +946,7 @@ static struct clk_rcg2 gcc_qupv3_i2c_s4_clk_src = {
 };
 
 static struct clk_rcg2 gcc_qupv3_i2c_s5_clk_src = {
+	.clkr.dvfs_data = &gcc_qupv3_i2c_s0_clk_src_dvfs,
 	.cmd_rcgr = 0x17094,
 	.mnd_width = 0,
 	.hid_width = 5,
@@ -792,6 +962,7 @@ static struct clk_rcg2 gcc_qupv3_i2c_s5_clk_src = {
 };
 
 static struct clk_rcg2 gcc_qupv3_i2c_s6_clk_src = {
+	.clkr.dvfs_data = &gcc_qupv3_i2c_s0_clk_src_dvfs,
 	.cmd_rcgr = 0x170b0,
 	.mnd_width = 0,
 	.hid_width = 5,
@@ -807,6 +978,7 @@ static struct clk_rcg2 gcc_qupv3_i2c_s6_clk_src = {
 };
 
 static struct clk_rcg2 gcc_qupv3_i2c_s7_clk_src = {
+	.clkr.dvfs_data = &gcc_qupv3_i2c_s0_clk_src_dvfs,
 	.cmd_rcgr = 0x170cc,
 	.mnd_width = 0,
 	.hid_width = 5,
@@ -822,6 +994,7 @@ static struct clk_rcg2 gcc_qupv3_i2c_s7_clk_src = {
 };
 
 static struct clk_rcg2 gcc_qupv3_i2c_s8_clk_src = {
+	.clkr.dvfs_data = &gcc_qupv3_i2c_s0_clk_src_dvfs,
 	.cmd_rcgr = 0x170e8,
 	.mnd_width = 0,
 	.hid_width = 5,
@@ -837,6 +1010,7 @@ static struct clk_rcg2 gcc_qupv3_i2c_s8_clk_src = {
 };
 
 static struct clk_rcg2 gcc_qupv3_i2c_s9_clk_src = {
+	.clkr.dvfs_data = &gcc_qupv3_i2c_s0_clk_src_dvfs,
 	.cmd_rcgr = 0x17104,
 	.mnd_width = 0,
 	.hid_width = 5,
@@ -1048,6 +1222,16 @@ static const struct freq_tbl ftbl_gcc_qupv3_wrap2_ibi_ctrl_0_clk_src[] = {
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap2_ibi_ctrl_0_clk_src = {
+	.clkr.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+		.pd_indices = (const unsigned int[]) {
+			DT_PMDOMAIN_CX, DT_PMDOMAIN_MX,
+		},
+		.num_pd_indices = 2,
+		.rates = (const struct qcom_clk_dvfs_rate[]) {
+			{ 37500000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+		},
+		.num_rates = 1,
+	},
 	.cmd_rcgr = 0x1e9d4,
 	.mnd_width = 0,
 	.hid_width = 5,
@@ -1246,6 +1430,17 @@ static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
 };
 
 static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
+	.clkr.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+		.pd_indices = (const unsigned int[]) {
+			DT_PMDOMAIN_CX, DT_PMDOMAIN_MX,
+		},
+		.num_pd_indices = 2,
+		.rates = (const struct qcom_clk_dvfs_rate[]) {
+			{ 100000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+			{ 202000000, RPMH_REGULATOR_LEVEL_SVS_L1 },
+		},
+		.num_rates = 2,
+	},
 	.cmd_rcgr = 0x14018,
 	.mnd_width = 8,
 	.hid_width = 5,
@@ -1268,6 +1463,16 @@ static const struct freq_tbl ftbl_gcc_sdcc4_apps_clk_src[] = {
 };
 
 static struct clk_rcg2 gcc_sdcc4_apps_clk_src = {
+	.clkr.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+		.pd_indices = (const unsigned int[]) {
+			DT_PMDOMAIN_CX, DT_PMDOMAIN_MX,
+		},
+		.num_pd_indices = 2,
+		.rates = (const struct qcom_clk_dvfs_rate[]) {
+			{ 75000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+		},
+		.num_rates = 1,
+	},
 	.cmd_rcgr = 0x16018,
 	.mnd_width = 8,
 	.hid_width = 5,
@@ -1291,6 +1496,7 @@ static const struct freq_tbl ftbl_gcc_ufs_phy_axi_clk_src[] = {
 };
 
 static struct clk_rcg2 gcc_ufs_phy_axi_clk_src = {
+	.clkr.dvfs_data = &gcc_ufs_phy_axi_clk_src_dvfs,
 	.cmd_rcgr = 0x77030,
 	.mnd_width = 8,
 	.hid_width = 5,
@@ -1313,6 +1519,7 @@ static const struct freq_tbl ftbl_gcc_ufs_phy_ice_core_clk_src[] = {
 };
 
 static struct clk_rcg2 gcc_ufs_phy_ice_core_clk_src = {
+	.clkr.dvfs_data = &gcc_ufs_phy_axi_clk_src_dvfs,
 	.cmd_rcgr = 0x77080,
 	.mnd_width = 0,
 	.hid_width = 5,
@@ -1334,6 +1541,7 @@ static const struct freq_tbl ftbl_gcc_ufs_phy_phy_aux_clk_src[] = {
 };
 
 static struct clk_rcg2 gcc_ufs_phy_phy_aux_clk_src = {
+	.clkr.dvfs_data = &gcc_qupv3_i2c_s0_clk_src_dvfs,
 	.cmd_rcgr = 0x770b4,
 	.mnd_width = 0,
 	.hid_width = 5,
@@ -1349,6 +1557,7 @@ static struct clk_rcg2 gcc_ufs_phy_phy_aux_clk_src = {
 };
 
 static struct clk_rcg2 gcc_ufs_phy_unipro_core_clk_src = {
+	.clkr.dvfs_data = &gcc_ufs_phy_axi_clk_src_dvfs,
 	.cmd_rcgr = 0x77098,
 	.mnd_width = 0,
 	.hid_width = 5,
@@ -1372,6 +1581,19 @@ static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
 };
 
 static struct clk_rcg2 gcc_usb30_prim_master_clk_src = {
+	.clkr.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+		.pd_indices = (const unsigned int[]) {
+			DT_PMDOMAIN_CX, DT_PMDOMAIN_MX,
+		},
+		.num_pd_indices = 2,
+		.rates = (const struct qcom_clk_dvfs_rate[]) {
+			{ 66666667, RPMH_REGULATOR_LEVEL_LOW_SVS },
+			{ 133333333, RPMH_REGULATOR_LEVEL_SVS },
+			{ 200000000, RPMH_REGULATOR_LEVEL_NOM },
+			{ 240000000, RPMH_REGULATOR_LEVEL_TURBO },
+		},
+		.num_rates = 4,
+	},
 	.cmd_rcgr = 0x3902c,
 	.mnd_width = 8,
 	.hid_width = 5,
@@ -1387,6 +1609,7 @@ static struct clk_rcg2 gcc_usb30_prim_master_clk_src = {
 };
 
 static struct clk_rcg2 gcc_usb30_prim_mock_utmi_clk_src = {
+	.clkr.dvfs_data = &gcc_qupv3_i2c_s0_clk_src_dvfs,
 	.cmd_rcgr = 0x39044,
 	.mnd_width = 0,
 	.hid_width = 5,
@@ -1402,6 +1625,7 @@ static struct clk_rcg2 gcc_usb30_prim_mock_utmi_clk_src = {
 };
 
 static struct clk_rcg2 gcc_usb3_prim_phy_aux_clk_src = {
+	.clkr.dvfs_data = &gcc_qupv3_i2c_s0_clk_src_dvfs,
 	.cmd_rcgr = 0x39070,
 	.mnd_width = 0,
 	.hid_width = 5,
@@ -1631,6 +1855,26 @@ static struct clk_branch gcc_cnoc_pcie_sf_axi_clk = {
 	},
 };
 
+static struct clk_branch gcc_cpuss_ubwcp_clk = {
+	.halt_reg = 0x63000,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x63000,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x63000,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_cpuss_ubwcp_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&gcc_cpuss_ubwcp_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_ddrss_gpu_axi_clk = {
 	.halt_reg = 0x71154,
 	.halt_check = BRANCH_HALT_SKIP,
@@ -3438,6 +3682,8 @@ static struct gdsc pcie_0_gdsc = {
 	},
 	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
+	.required_pds = gcc_sm8650_cx_block_pd_indices,
+	.num_required_pds = ARRAY_SIZE(gcc_sm8650_cx_block_pd_indices),
 };
 
 static struct gdsc pcie_0_phy_gdsc = {
@@ -3449,6 +3695,8 @@ static struct gdsc pcie_0_phy_gdsc = {
 	},
 	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
+	.required_pds = gcc_sm8650_mx_block_pd_indices,
+	.num_required_pds = ARRAY_SIZE(gcc_sm8650_mx_block_pd_indices),
 };
 
 static struct gdsc pcie_1_gdsc = {
@@ -3460,6 +3708,8 @@ static struct gdsc pcie_1_gdsc = {
 	},
 	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
+	.required_pds = gcc_sm8650_cx_block_pd_indices,
+	.num_required_pds = ARRAY_SIZE(gcc_sm8650_cx_block_pd_indices),
 };
 
 static struct gdsc pcie_1_phy_gdsc = {
@@ -3471,6 +3721,8 @@ static struct gdsc pcie_1_phy_gdsc = {
 	},
 	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
+	.required_pds = gcc_sm8650_mx_block_pd_indices,
+	.num_required_pds = ARRAY_SIZE(gcc_sm8650_mx_block_pd_indices),
 };
 
 static struct gdsc ufs_phy_gdsc = {
@@ -3480,6 +3732,8 @@ static struct gdsc ufs_phy_gdsc = {
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
+	.required_pds = gcc_sm8650_cx_block_pd_indices,
+	.num_required_pds = ARRAY_SIZE(gcc_sm8650_cx_block_pd_indices),
 };
 
 static struct gdsc ufs_mem_phy_gdsc = {
@@ -3489,6 +3743,8 @@ static struct gdsc ufs_mem_phy_gdsc = {
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
+	.required_pds = gcc_sm8650_mx_block_pd_indices,
+	.num_required_pds = ARRAY_SIZE(gcc_sm8650_mx_block_pd_indices),
 };
 
 static struct gdsc usb30_prim_gdsc = {
@@ -3507,6 +3763,8 @@ static struct gdsc usb3_phy_gdsc = {
 	},
 	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
+	.required_pds = gcc_sm8650_mx_block_pd_indices,
+	.num_required_pds = ARRAY_SIZE(gcc_sm8650_mx_block_pd_indices),
 };
 
 static struct clk_regmap *gcc_sm8650_clocks[] = {
@@ -3520,6 +3778,8 @@ static struct clk_regmap *gcc_sm8650_clocks[] = {
 	[GCC_CFG_NOC_PCIE_ANOC_AHB_CLK] = &gcc_cfg_noc_pcie_anoc_ahb_clk.clkr,
 	[GCC_CFG_NOC_USB3_PRIM_AXI_CLK] = &gcc_cfg_noc_usb3_prim_axi_clk.clkr,
 	[GCC_CNOC_PCIE_SF_AXI_CLK] = &gcc_cnoc_pcie_sf_axi_clk.clkr,
+	[GCC_CPUSS_UBWCP_CLK] = &gcc_cpuss_ubwcp_clk.clkr,
+	[GCC_CPUSS_UBWCP_CLK_SRC] = &gcc_cpuss_ubwcp_clk_src.clkr,
 	[GCC_DDRSS_GPU_AXI_CLK] = &gcc_ddrss_gpu_axi_clk.clkr,
 	[GCC_DDRSS_PCIE_SF_QTB_CLK] = &gcc_ddrss_pcie_sf_qtb_clk.clkr,
 	[GCC_DISP_HF_AXI_CLK] = &gcc_disp_hf_axi_clk.clkr,
@@ -3815,6 +4075,7 @@ static const struct qcom_cc_desc gcc_sm8650_desc = {
 	.gdscs = gcc_sm8650_gdscs,
 	.num_gdscs = ARRAY_SIZE(gcc_sm8650_gdscs),
 	.use_rpm = true,
+	.num_dvfs_rail_voters = 3,
 };
 
 static const struct of_device_id gcc_sm8650_match_table[] = {
diff --git a/drivers/clk/qcom/gpucc-sm8650.c b/drivers/clk/qcom/gpucc-sm8650.c
index a84fa35bc2ba..3fe4ca1ad3be 100644
--- a/drivers/clk/qcom/gpucc-sm8650.c
+++ b/drivers/clk/qcom/gpucc-sm8650.c
@@ -10,10 +10,12 @@
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,sm8650-gpucc.h>
+#include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/reset/qcom,sm8650-gpucc.h>
 
 #include "clk-alpha-pll.h"
 #include "clk-branch.h"
+#include "clk-dvfs.h"
 #include "clk-rcg.h"
 #include "clk-regmap.h"
 #include "clk-regmap-divider.h"
@@ -36,6 +38,13 @@ enum {
 	P_GPU_CC_PLL1_OUT_MAIN,
 };
 
+enum {
+	DT_PMDOMAIN_MX,
+	DT_PMDOMAIN_CX,
+	DT_PMDOMAIN_MXC,
+	DT_PMDOMAIN_GFX,
+};
+
 static const struct pll_vco lucid_ole_vco[] = {
 	{ 249600000, 2100000000, 0 },
 };
@@ -59,7 +68,22 @@ static struct clk_alpha_pll gpu_cc_pll0 = {
 	.vco_table = lucid_ole_vco,
 	.num_vco = ARRAY_SIZE(lucid_ole_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
+	.config = &gpu_cc_pll0_config,
 	.clkr = {
+		.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+			.pd_indices = (const unsigned int[]) {
+				DT_PMDOMAIN_MXC,
+			},
+			.num_pd_indices = 1,
+			.rates = (const struct qcom_clk_dvfs_rate[]) {
+				{ 615000000, RPMH_REGULATOR_LEVEL_LOW_SVS_D1 },
+				{ 1100000000, RPMH_REGULATOR_LEVEL_SVS },
+				{ 1600000000, RPMH_REGULATOR_LEVEL_SVS_L1 },
+				{ 2000000000, RPMH_REGULATOR_LEVEL_NOM },
+				{ 2100000000, RPMH_REGULATOR_LEVEL_TURBO_L1 },
+			},
+			.num_rates = 5,
+		},
 		.hw.init = &(struct clk_init_data){
 			.name = "gpu_cc_pll0",
 			.parent_data = &(const struct clk_parent_data){
@@ -90,7 +114,22 @@ static struct clk_alpha_pll gpu_cc_pll1 = {
 	.vco_table = lucid_ole_vco,
 	.num_vco = ARRAY_SIZE(lucid_ole_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
+	.config = &gpu_cc_pll1_config,
 	.clkr = {
+		.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+			.pd_indices = (const unsigned int[]) {
+				DT_PMDOMAIN_MX,
+			},
+			.num_pd_indices = 1,
+			.rates = (const struct qcom_clk_dvfs_rate[]) {
+				{ 615000000, RPMH_REGULATOR_LEVEL_LOW_SVS_D1 },
+				{ 1100000000, RPMH_REGULATOR_LEVEL_SVS },
+				{ 1600000000, RPMH_REGULATOR_LEVEL_SVS_L1 },
+				{ 2000000000, RPMH_REGULATOR_LEVEL_NOM },
+				{ 2100000000, RPMH_REGULATOR_LEVEL_TURBO_L1 },
+			},
+			.num_rates = 5,
+		},
 		.hw.init = &(struct clk_init_data){
 			.name = "gpu_cc_pll1",
 			.parent_data = &(const struct clk_parent_data){
@@ -156,6 +195,16 @@ static struct clk_rcg2 gpu_cc_ff_clk_src = {
 	.parent_map = gpu_cc_parent_map_0,
 	.freq_tbl = ftbl_gpu_cc_ff_clk_src,
 	.hw_clk_ctrl = true,
+	.clkr.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+		.pd_indices = (const unsigned int[]) {
+			DT_PMDOMAIN_CX,
+		},
+		.num_pd_indices = 1,
+		.rates = (const struct qcom_clk_dvfs_rate[]) {
+			{ 200000000, RPMH_REGULATOR_LEVEL_LOW_SVS_D1 },
+		},
+		.num_rates = 1,
+	},
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpu_cc_ff_clk_src",
 		.parent_data = gpu_cc_parent_data_0,
@@ -179,6 +228,18 @@ static struct clk_rcg2 gpu_cc_gmu_clk_src = {
 	.parent_map = gpu_cc_parent_map_1,
 	.freq_tbl = ftbl_gpu_cc_gmu_clk_src,
 	.hw_clk_ctrl = true,
+	.clkr.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+		.pd_indices = (const unsigned int[]) {
+			DT_PMDOMAIN_CX,
+			DT_PMDOMAIN_MX,
+		},
+		.num_pd_indices = 2,
+		.rates = (const struct qcom_clk_dvfs_rate[]) {
+			{ 260000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+			{ 625000000, RPMH_REGULATOR_LEVEL_SVS },
+		},
+		.num_rates = 2,
+	},
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpu_cc_gmu_clk_src",
 		.parent_data = gpu_cc_parent_data_1,
@@ -201,6 +262,18 @@ static struct clk_rcg2 gpu_cc_hub_clk_src = {
 	.parent_map = gpu_cc_parent_map_2,
 	.freq_tbl = ftbl_gpu_cc_hub_clk_src,
 	.hw_clk_ctrl = true,
+	.clkr.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+		.pd_indices = (const unsigned int[]) {
+			DT_PMDOMAIN_CX,
+		},
+		.num_pd_indices = 1,
+		.rates = (const struct qcom_clk_dvfs_rate[]) {
+			{ 200000000, RPMH_REGULATOR_LEVEL_LOW_SVS_D1 },
+			{ 300000000, RPMH_REGULATOR_LEVEL_SVS },
+			{ 312500000, RPMH_REGULATOR_LEVEL_SVS_L1 },
+		},
+		.num_rates = 3,
+	},
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpu_cc_hub_clk_src",
 		.parent_data = gpu_cc_parent_data_2,
@@ -547,6 +620,8 @@ static struct gdsc gpu_cx_gdsc = {
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = VOTABLE | RETAIN_FF_ENABLE,
+	.required_pds = (const unsigned int[]){ DT_PMDOMAIN_CX },
+	.num_required_pds = 1,
 };
 
 static struct gdsc gpu_gx_gdsc = {
@@ -562,6 +637,9 @@ static struct gdsc gpu_gx_gdsc = {
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = CLAMP_IO | AON_RESET | SW_RESET | POLL_CFG_GDSCR,
+	.required_pds = (const unsigned int[]){ DT_PMDOMAIN_GFX,
+						       DT_PMDOMAIN_MXC },
+	.num_required_pds = 2,
 };
 
 static struct clk_regmap *gpu_cc_sm8650_clocks[] = {
@@ -619,6 +697,16 @@ static const struct regmap_config gpu_cc_sm8650_regmap_config = {
 	.fast_io = true,
 };
 
+static struct clk_alpha_pll *gpu_cc_sm8650_plls[] = {
+	&gpu_cc_pll0,
+	&gpu_cc_pll1,
+};
+
+static const struct qcom_cc_driver_data gpu_cc_sm8650_driver_data = {
+	.alpha_plls = gpu_cc_sm8650_plls,
+	.num_alpha_plls = ARRAY_SIZE(gpu_cc_sm8650_plls),
+};
+
 static const struct qcom_cc_desc gpu_cc_sm8650_desc = {
 	.config = &gpu_cc_sm8650_regmap_config,
 	.clks = gpu_cc_sm8650_clocks,
@@ -627,6 +715,8 @@ static const struct qcom_cc_desc gpu_cc_sm8650_desc = {
 	.num_resets = ARRAY_SIZE(gpu_cc_sm8650_resets),
 	.gdscs = gpu_cc_sm8650_gdscs,
 	.num_gdscs = ARRAY_SIZE(gpu_cc_sm8650_gdscs),
+	.num_dvfs_rail_voters = 4,
+	.driver_data = &gpu_cc_sm8650_driver_data,
 };
 
 static const struct of_device_id gpu_cc_sm8650_match_table[] = {
@@ -637,16 +727,7 @@ MODULE_DEVICE_TABLE(of, gpu_cc_sm8650_match_table);
 
 static int gpu_cc_sm8650_probe(struct platform_device *pdev)
 {
-	struct regmap *regmap;
-
-	regmap = qcom_cc_map(pdev, &gpu_cc_sm8650_desc);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
-
-	clk_lucid_ole_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
-	clk_lucid_ole_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
-
-	return qcom_cc_really_probe(&pdev->dev, &gpu_cc_sm8650_desc, regmap);
+	return qcom_cc_probe(pdev, &gpu_cc_sm8650_desc);
 }
 
 static struct platform_driver gpu_cc_sm8650_driver = {
diff --git a/drivers/clk/qcom/videocc-sm8550.c b/drivers/clk/qcom/videocc-sm8550.c
index c2f11489a222..682ee4f3f3ed 100644
--- a/drivers/clk/qcom/videocc-sm8550.c
+++ b/drivers/clk/qcom/videocc-sm8550.c
@@ -9,9 +9,11 @@
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,sm8650-videocc.h>
+#include <dt-bindings/power/qcom,rpmhpd.h>
 
 #include "clk-alpha-pll.h"
 #include "clk-branch.h"
+#include "clk-dvfs.h"
 #include "clk-rcg.h"
 #include "clk-regmap.h"
 #include "clk-regmap-divider.h"
@@ -29,6 +31,29 @@ enum {
 	P_VIDEO_CC_PLL1_OUT_MAIN,
 };
 
+enum {
+	DT_PMDOMAIN_MMCX,
+	DT_PMDOMAIN_MXC,
+};
+
+static const unsigned int video_cc_sm8650_block_pd_indices[] = {
+	DT_PMDOMAIN_MMCX,
+	DT_PMDOMAIN_MXC,
+};
+
+static const struct qcom_clk_dvfs_data video_cc_pll0_dvfs = {
+	.pd_indices = (const unsigned int[]) { DT_PMDOMAIN_MXC },
+	.num_pd_indices = 1,
+	.rates = (const struct qcom_clk_dvfs_rate[]) {
+		{ 615000000, RPMH_REGULATOR_LEVEL_LOW_SVS_D1 },
+		{ 1100000000, RPMH_REGULATOR_LEVEL_SVS },
+		{ 1600000000, RPMH_REGULATOR_LEVEL_SVS_L1 },
+		{ 2000000000, RPMH_REGULATOR_LEVEL_NOM },
+		{ 2100000000, RPMH_REGULATOR_LEVEL_TURBO_L1 },
+	},
+	.num_rates = 5,
+};
+
 static const struct pll_vco lucid_ole_vco[] = {
 	{ 249600000, 2300000000, 0 },
 };
@@ -54,6 +79,7 @@ static struct clk_alpha_pll video_cc_pll0 = {
 	.num_vco = ARRAY_SIZE(lucid_ole_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &video_cc_pll0_dvfs,
 		.hw.init = &(const struct clk_init_data) {
 			.name = "video_cc_pll0",
 			.parent_data = &(const struct clk_parent_data) {
@@ -86,6 +112,7 @@ static struct clk_alpha_pll video_cc_pll1 = {
 	.num_vco = ARRAY_SIZE(lucid_ole_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
 	.clkr = {
+		.dvfs_data = &video_cc_pll0_dvfs,
 		.hw.init = &(const struct clk_init_data) {
 			.name = "video_cc_pll1",
 			.parent_data = &(const struct clk_parent_data) {
@@ -160,6 +187,22 @@ static struct clk_rcg2 video_cc_mvs0_clk_src = {
 	.hid_width = 5,
 	.parent_map = video_cc_parent_map_0,
 	.freq_tbl = ftbl_video_cc_mvs0_clk_src,
+	.clkr.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+		.pd_indices = (const unsigned int[]) {
+			DT_PMDOMAIN_MMCX,
+			DT_PMDOMAIN_MXC,
+		},
+		.num_pd_indices = 2,
+		.rates = (const struct qcom_clk_dvfs_rate[]) {
+			{ 588000000, RPMH_REGULATOR_LEVEL_LOW_SVS_D1 },
+			{ 900000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+			{ 1140000000, RPMH_REGULATOR_LEVEL_SVS },
+			{ 1305000000, RPMH_REGULATOR_LEVEL_SVS_L1 },
+			{ 1440000000, RPMH_REGULATOR_LEVEL_NOM },
+			{ 1600000000, RPMH_REGULATOR_LEVEL_TURBO },
+		},
+		.num_rates = 6,
+	},
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "video_cc_mvs0_clk_src",
 		.parent_data = video_cc_parent_data_0,
@@ -201,6 +244,21 @@ static struct clk_rcg2 video_cc_mvs1_clk_src = {
 	.hid_width = 5,
 	.parent_map = video_cc_parent_map_1,
 	.freq_tbl = ftbl_video_cc_mvs1_clk_src,
+	.clkr.dvfs_data = &(const struct qcom_clk_dvfs_data) {
+		.pd_indices = (const unsigned int[]) {
+			DT_PMDOMAIN_MMCX,
+			DT_PMDOMAIN_MXC,
+		},
+		.num_pd_indices = 2,
+		.rates = (const struct qcom_clk_dvfs_rate[]) {
+			{ 840000000, RPMH_REGULATOR_LEVEL_LOW_SVS_D1 },
+			{ 1110000000, RPMH_REGULATOR_LEVEL_LOW_SVS },
+			{ 1350000000, RPMH_REGULATOR_LEVEL_SVS },
+			{ 1500000000, RPMH_REGULATOR_LEVEL_SVS_L1 },
+			{ 1650000000, RPMH_REGULATOR_LEVEL_NOM },
+		},
+		.num_rates = 5,
+	},
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "video_cc_mvs1_clk_src",
 		.parent_data = video_cc_parent_data_1,
@@ -456,6 +514,8 @@ static struct gdsc video_cc_mvs0c_gdsc = {
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
+	.required_pds = video_cc_sm8650_block_pd_indices,
+	.num_required_pds = ARRAY_SIZE(video_cc_sm8650_block_pd_indices),
 };
 
 static struct gdsc video_cc_mvs0_gdsc = {
@@ -469,6 +529,8 @@ static struct gdsc video_cc_mvs0_gdsc = {
 	.pwrsts = PWRSTS_OFF_ON,
 	.parent = &video_cc_mvs0c_gdsc.pd,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | HW_CTRL_TRIGGER,
+	.required_pds = video_cc_sm8650_block_pd_indices,
+	.num_required_pds = ARRAY_SIZE(video_cc_sm8650_block_pd_indices),
 };
 
 static struct gdsc video_cc_mvs1c_gdsc = {
@@ -481,6 +543,8 @@ static struct gdsc video_cc_mvs1c_gdsc = {
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
+	.required_pds = video_cc_sm8650_block_pd_indices,
+	.num_required_pds = ARRAY_SIZE(video_cc_sm8650_block_pd_indices),
 };
 
 static struct gdsc video_cc_mvs1_gdsc = {
@@ -494,6 +558,8 @@ static struct gdsc video_cc_mvs1_gdsc = {
 	.pwrsts = PWRSTS_OFF_ON,
 	.parent = &video_cc_mvs1c_gdsc.pd,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | HW_CTRL_TRIGGER,
+	.required_pds = video_cc_sm8650_block_pd_indices,
+	.num_required_pds = ARRAY_SIZE(video_cc_sm8650_block_pd_indices),
 };
 
 static struct clk_regmap *video_cc_sm8550_clocks[] = {
@@ -512,6 +578,26 @@ static struct clk_regmap *video_cc_sm8550_clocks[] = {
 	[VIDEO_CC_XO_CLK_SRC] = NULL,
 };
 
+static struct clk_regmap *video_cc_sm8650_clocks[] = {
+	[VIDEO_CC_MVS0_CLK] = &video_cc_mvs0_clk.clkr,
+	[VIDEO_CC_MVS0_CLK_SRC] = &video_cc_mvs0_clk_src.clkr,
+	[VIDEO_CC_MVS0_DIV_CLK_SRC] = &video_cc_mvs0_div_clk_src.clkr,
+	[VIDEO_CC_MVS0_SHIFT_CLK] = &video_cc_mvs0_shift_clk.clkr,
+	[VIDEO_CC_MVS0C_CLK] = &video_cc_mvs0c_clk.clkr,
+	[VIDEO_CC_MVS0C_DIV2_DIV_CLK_SRC] = &video_cc_mvs0c_div2_div_clk_src.clkr,
+	[VIDEO_CC_MVS0C_SHIFT_CLK] = &video_cc_mvs0c_shift_clk.clkr,
+	[VIDEO_CC_MVS1_CLK] = &video_cc_mvs1_clk.clkr,
+	[VIDEO_CC_MVS1_CLK_SRC] = &video_cc_mvs1_clk_src.clkr,
+	[VIDEO_CC_MVS1_DIV_CLK_SRC] = &video_cc_mvs1_div_clk_src.clkr,
+	[VIDEO_CC_MVS1_SHIFT_CLK] = &video_cc_mvs1_shift_clk.clkr,
+	[VIDEO_CC_MVS1C_CLK] = &video_cc_mvs1c_clk.clkr,
+	[VIDEO_CC_MVS1C_DIV2_DIV_CLK_SRC] = &video_cc_mvs1c_div2_div_clk_src.clkr,
+	[VIDEO_CC_MVS1C_SHIFT_CLK] = &video_cc_mvs1c_shift_clk.clkr,
+	[VIDEO_CC_PLL0] = &video_cc_pll0.clkr,
+	[VIDEO_CC_PLL1] = &video_cc_pll1.clkr,
+	[VIDEO_CC_XO_CLK_SRC] = &video_cc_xo_clk_src.clkr,
+};
+
 static struct gdsc *video_cc_sm8550_gdscs[] = {
 	[VIDEO_CC_MVS0C_GDSC] = &video_cc_mvs0c_gdsc,
 	[VIDEO_CC_MVS0_GDSC] = &video_cc_mvs0_gdsc,
@@ -562,6 +648,13 @@ static struct qcom_cc_driver_data video_cc_sm8550_driver_data = {
 	.num_clk_cbcrs = ARRAY_SIZE(video_cc_sm8550_critical_cbcrs),
 };
 
+static const struct qcom_cc_driver_data video_cc_sm8650_driver_data = {
+	.alpha_plls = video_cc_sm8550_plls,
+	.num_alpha_plls = ARRAY_SIZE(video_cc_sm8550_plls),
+	.clk_cbcrs = video_cc_sm8650_critical_cbcrs,
+	.num_clk_cbcrs = ARRAY_SIZE(video_cc_sm8650_critical_cbcrs),
+};
+
 static const struct qcom_cc_desc video_cc_sm8550_desc = {
 	.config = &video_cc_sm8550_regmap_config,
 	.clks = video_cc_sm8550_clocks,
@@ -574,16 +667,39 @@ static const struct qcom_cc_desc video_cc_sm8550_desc = {
 	.driver_data = &video_cc_sm8550_driver_data,
 };
 
+static const unsigned int video_cc_sm8650_access_pd_indices[] = {
+	DT_PMDOMAIN_MMCX,
+	DT_PMDOMAIN_MXC,
+};
+
+static const struct qcom_cc_desc video_cc_sm8650_desc = {
+	.config = &video_cc_sm8550_regmap_config,
+	.clks = video_cc_sm8650_clocks,
+	.num_clks = ARRAY_SIZE(video_cc_sm8650_clocks),
+	.resets = video_cc_sm8550_resets,
+	.num_resets = ARRAY_SIZE(video_cc_sm8550_resets),
+	.gdscs = video_cc_sm8550_gdscs,
+	.num_gdscs = ARRAY_SIZE(video_cc_sm8550_gdscs),
+	.use_rpm = true,
+	.pd_indices = video_cc_sm8650_access_pd_indices,
+	.num_pd_indices = ARRAY_SIZE(video_cc_sm8650_access_pd_indices),
+	.num_dvfs_rail_voters = 2,
+	.driver_data = &video_cc_sm8650_driver_data,
+};
+
 static const struct of_device_id video_cc_sm8550_match_table[] = {
-	{ .compatible = "qcom,sm8550-videocc" },
-	{ .compatible = "qcom,sm8650-videocc" },
-	{ .compatible = "qcom,x1e80100-videocc" },
+	{ .compatible = "qcom,sm8550-videocc", .data = &video_cc_sm8550_desc },
+	{ .compatible = "qcom,sm8650-videocc", .data = &video_cc_sm8650_desc },
+	{ .compatible = "qcom,x1e80100-videocc", .data = &video_cc_sm8550_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, video_cc_sm8550_match_table);
 
 static int video_cc_sm8550_probe(struct platform_device *pdev)
 {
+	const struct qcom_cc_desc *desc = of_device_get_match_data(&pdev->dev);
+	bool sm8650 = desc == &video_cc_sm8650_desc;
+
 	if (of_device_is_compatible(pdev->dev.of_node, "qcom,x1e80100-videocc")) {
 		video_cc_pll0_config.l = 0x1e;
 		video_cc_pll0_config.alpha = 0x0000;
@@ -593,25 +709,16 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
 		video_cc_mvs1_clk_src.freq_tbl = ftbl_video_cc_mvs1_clk_src_x1e80100;
 	}
 
-	if (of_device_is_compatible(pdev->dev.of_node, "qcom,sm8650-videocc")) {
+	if (sm8650) {
 		video_cc_pll0_config.l = 0x1e;
 		video_cc_pll0_config.alpha = 0xa000;
 		video_cc_pll1_config.l = 0x2b;
 		video_cc_pll1_config.alpha = 0xc000;
 		video_cc_mvs0_clk_src.freq_tbl = ftbl_video_cc_mvs0_clk_src_sm8650;
 		video_cc_mvs1_clk_src.freq_tbl = ftbl_video_cc_mvs1_clk_src_sm8650;
-		video_cc_sm8550_clocks[VIDEO_CC_MVS0_SHIFT_CLK] = &video_cc_mvs0_shift_clk.clkr;
-		video_cc_sm8550_clocks[VIDEO_CC_MVS0C_SHIFT_CLK] = &video_cc_mvs0c_shift_clk.clkr;
-		video_cc_sm8550_clocks[VIDEO_CC_MVS1_SHIFT_CLK] = &video_cc_mvs1_shift_clk.clkr;
-		video_cc_sm8550_clocks[VIDEO_CC_MVS1C_SHIFT_CLK] = &video_cc_mvs1c_shift_clk.clkr;
-		video_cc_sm8550_clocks[VIDEO_CC_XO_CLK_SRC] = &video_cc_xo_clk_src.clkr;
-
-		video_cc_sm8550_driver_data.clk_cbcrs = video_cc_sm8650_critical_cbcrs;
-		video_cc_sm8550_driver_data.num_clk_cbcrs =
-							ARRAY_SIZE(video_cc_sm8650_critical_cbcrs);
 	}
 
-	return qcom_cc_probe(pdev, &video_cc_sm8550_desc);
+	return qcom_cc_probe(pdev, desc);
 }
 
 static struct platform_driver video_cc_sm8550_driver = {
diff --git a/include/dt-bindings/clock/qcom,sm8650-gcc.h b/include/dt-bindings/clock/qcom,sm8650-gcc.h
index 0c543ba46079..bbf33fba2c75 100644
--- a/include/dt-bindings/clock/qcom,sm8650-gcc.h
+++ b/include/dt-bindings/clock/qcom,sm8650-gcc.h
@@ -202,6 +202,8 @@
 #define GCC_GPLL3_AO						191
 #define GCC_GPLL4_AO						192
 #define GCC_GPLL6_AO						193
+#define GCC_CPUSS_UBWCP_CLK					194
+#define GCC_CPUSS_UBWCP_CLK_SRC					195
 
 /* GCC resets */
 #define GCC_CAMERA_BCR						0

-- 
2.56.0

