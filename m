From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v7 08/13] clk: qcom: gdsc: Add GDSCs in msm8916 GCC
Date: Tue, 28 Jul 2015 15:04:01 +0530
Message-ID: <1438076046-4706-9-git-send-email-rnayak@codeaurora.org>
References: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57479 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204AbbG1Jf3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 05:35:29 -0400
In-Reply-To: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>

Add all data for the GDSCs which are part of msm8916 GCC block.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/Kconfig                     |  1 +
 drivers/clk/qcom/gcc-msm8916.c               | 57 ++++++++++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-msm8916.h |  8 ++++
 3 files changed, 66 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index d3a695b..abec45a 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -53,6 +53,7 @@ config MSM_GCC_8660
 
 config MSM_GCC_8916
 	tristate "MSM8916 Global Clock Controller"
+	select QCOM_GDSC
 	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on msm8916 devices.
diff --git a/drivers/clk/qcom/gcc-msm8916.c b/drivers/clk/qcom/gcc-msm8916.c
index c66f7bc..4da1223 100644
--- a/drivers/clk/qcom/gcc-msm8916.c
+++ b/drivers/clk/qcom/gcc-msm8916.c
@@ -31,6 +31,7 @@
 #include "clk-rcg.h"
 #include "clk-branch.h"
 #include "reset.h"
+#include "gdsc.h"
 
 enum {
 	P_XO,
@@ -2562,6 +2563,52 @@ static struct clk_branch gcc_venus0_vcodec0_clk = {
 	},
 };
 
+static struct gdsc venus_gdsc = {
+	.gdscr = 0x4c018,
+	.pd = {
+		.name = "venus",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.con_ids = { NULL },
+};
+
+static struct gdsc mdss_gdsc = {
+	.gdscr = 0x4d078,
+	.pd = {
+		.name = "mdss",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.con_ids = { NULL },
+};
+
+static struct gdsc jpeg_gdsc = {
+	.gdscr = 0x5701c,
+	.pd = {
+		.name = "jpeg",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.con_ids = { NULL },
+};
+
+static struct gdsc vfe_gdsc = {
+	.gdscr = 0x58034,
+	.pd = {
+		.name = "vfe",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.con_ids = { NULL },
+};
+
+static struct gdsc oxili_gdsc = {
+	.gdscr = 0x5901c,
+	.pd = {
+		.name = "oxili",
+	},
+	.root_con_id = "gfx3d_clk_src",
+	.pwrsts = PWRSTS_OFF_ON,
+	.con_ids = { NULL },
+};
+
 static struct clk_regmap *gcc_msm8916_clocks[] = {
 	[GPLL0] = &gpll0.clkr,
 	[GPLL0_VOTE] = &gpll0_vote,
@@ -2703,6 +2750,14 @@ static struct clk_regmap *gcc_msm8916_clocks[] = {
 	[GCC_VENUS0_VCODEC0_CLK] = &gcc_venus0_vcodec0_clk.clkr,
 };
 
+static struct gdsc *gcc_msm8916_gdscs[] = {
+	[VENUS_GDSC] = &venus_gdsc,
+	[MDSS_GDSC] = &mdss_gdsc,
+	[JPEG_GDSC] = &jpeg_gdsc,
+	[VFE_GDSC] = &vfe_gdsc,
+	[OXILI_GDSC] = &oxili_gdsc,
+};
+
 static const struct qcom_reset_map gcc_msm8916_resets[] = {
 	[GCC_BLSP1_BCR] = { 0x01000 },
 	[GCC_BLSP1_QUP1_BCR] = { 0x02000 },
@@ -2810,6 +2865,8 @@ static const struct qcom_cc_desc gcc_msm8916_desc = {
 	.num_clks = ARRAY_SIZE(gcc_msm8916_clocks),
 	.resets = gcc_msm8916_resets,
 	.num_resets = ARRAY_SIZE(gcc_msm8916_resets),
+	.gdscs = gcc_msm8916_gdscs,
+	.num_gdscs = ARRAY_SIZE(gcc_msm8916_gdscs),
 };
 
 static const struct of_device_id gcc_msm8916_match_table[] = {
diff --git a/include/dt-bindings/clock/qcom,gcc-msm8916.h b/include/dt-bindings/clock/qcom,gcc-msm8916.h
index e430f64..11566c5 100644
--- a/include/dt-bindings/clock/qcom,gcc-msm8916.h
+++ b/include/dt-bindings/clock/qcom,gcc-msm8916.h
@@ -153,4 +153,12 @@
 #define GCC_VENUS0_AXI_CLK			136
 #define GCC_VENUS0_VCODEC0_CLK			137
 
+/* Indexes for GDSCs */
+#define BIMC_GDSC				0
+#define VENUS_GDSC				1
+#define MDSS_GDSC				2
+#define JPEG_GDSC				3
+#define VFE_GDSC				4
+#define OXILI_GDSC				5
+
 #endif
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

