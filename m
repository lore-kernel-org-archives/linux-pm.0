From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v5 05/11] clk: qcom: gdsc: Add GDSCs in msm8974 MMCC
Date: Tue, 14 Apr 2015 18:42:11 +0530
Message-ID: <1429017137-20218-6-git-send-email-rnayak@codeaurora.org>
References: <1429017137-20218-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1429017137-20218-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@linaro.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

Add the GDSC instances that exist as part of msm8974 MMCC block

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/Kconfig                      |  1 +
 drivers/clk/qcom/mmcc-msm8974.c               | 54 +++++++++++++++++++++++++++
 include/dt-bindings/clock/qcom,mmcc-msm8974.h |  8 ++++
 3 files changed, 63 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index c8a0863..34945fa 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -99,6 +99,7 @@ config MSM_GCC_8974
 config MSM_MMCC_8974
 	tristate "MSM8974 Multimedia Clock Controller"
 	select MSM_GCC_8974
+	select QCOM_GDSC
 	depends on COMMON_CLK_QCOM
 	help
 	  Support for the multimedia clock controller on msm8974 devices.
diff --git a/drivers/clk/qcom/mmcc-msm8974.c b/drivers/clk/qcom/mmcc-msm8974.c
index 07f4cc1..36242ae 100644
--- a/drivers/clk/qcom/mmcc-msm8974.c
+++ b/drivers/clk/qcom/mmcc-msm8974.c
@@ -31,6 +31,7 @@
 #include "clk-rcg.h"
 #include "clk-branch.h"
 #include "reset.h"
+#include "gdsc.h"
 
 enum {
 	P_XO,
@@ -2349,6 +2350,48 @@ static struct pll_config mmpll3_config = {
 	.aux_output_mask = BIT(1),
 };
 
+static struct gdsc venus0_gdsc = {
+	.gdscr = 0x1024,
+	.pd = {
+		.name = "venus0",
+	},
+};
+
+static struct gdsc mdss_gdsc = {
+	.gdscr = 0x2304,
+	.pd = {
+		.name = "mdss",
+	},
+};
+
+static struct gdsc camss_jpeg_gdsc = {
+	.gdscr = 0x35a4,
+	.pd = {
+		.name = "camss_jpeg",
+	},
+};
+
+static struct gdsc camss_vfe_gdsc = {
+	.gdscr = 0x36a4,
+	.pd = {
+		.name = "camss_vfe",
+	},
+};
+
+static struct gdsc oxili_gdsc = {
+	.gdscr = 0x4024,
+	.pd = {
+		.name = "oxili",
+	},
+};
+
+static struct gdsc oxilicx_gdsc = {
+	.gdscr = 0x4034,
+	.pd = {
+		.name = "oxilicx",
+	},
+};
+
 static struct clk_regmap *mmcc_msm8974_clocks[] = {
 	[MMSS_AHB_CLK_SRC] = &mmss_ahb_clk_src.clkr,
 	[MMSS_AXI_CLK_SRC] = &mmss_axi_clk_src.clkr,
@@ -2525,6 +2568,15 @@ static const struct qcom_reset_map mmcc_msm8974_resets[] = {
 	[OCMEMNOC_RESET] = { 0x50b0 },
 };
 
+static struct gdsc *mmcc_msm8974_gdscs[] = {
+	[VENUS0_GDSC] = &venus0_gdsc,
+	[MDSS_GDSC] = &mdss_gdsc,
+	[CAMSS_JPEG_GDSC] = &camss_jpeg_gdsc,
+	[CAMSS_VFE_GDSC] = &camss_vfe_gdsc,
+	[OXILI_GDSC] = &oxili_gdsc,
+	[OXILICX_GDSC] = &oxilicx_gdsc,
+};
+
 static const struct regmap_config mmcc_msm8974_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -2539,6 +2591,8 @@ static const struct qcom_cc_desc mmcc_msm8974_desc = {
 	.num_clks = ARRAY_SIZE(mmcc_msm8974_clocks),
 	.resets = mmcc_msm8974_resets,
 	.num_resets = ARRAY_SIZE(mmcc_msm8974_resets),
+	.gdscs = mmcc_msm8974_gdscs,
+	.num_gdscs = ARRAY_SIZE(mmcc_msm8974_gdscs),
 };
 
 static const struct of_device_id mmcc_msm8974_match_table[] = {
diff --git a/include/dt-bindings/clock/qcom,mmcc-msm8974.h b/include/dt-bindings/clock/qcom,mmcc-msm8974.h
index 032ed87..28651e5 100644
--- a/include/dt-bindings/clock/qcom,mmcc-msm8974.h
+++ b/include/dt-bindings/clock/qcom,mmcc-msm8974.h
@@ -158,4 +158,12 @@
 #define SPDM_RM_AXI					141
 #define SPDM_RM_OCMEMNOC				142
 
+/* gdscs */
+#define VENUS0_GDSC					0
+#define MDSS_GDSC					1
+#define CAMSS_JPEG_GDSC					2
+#define CAMSS_VFE_GDSC					3
+#define OXILI_GDSC					4
+#define OXILICX_GDSC					5
+
 #endif
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
