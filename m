From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v5 07/11] clk: qcom: gdsc: Add GDSCs in apq8084 MMCC
Date: Tue, 14 Apr 2015 18:42:13 +0530
Message-ID: <1429017137-20218-8-git-send-email-rnayak@codeaurora.org>
References: <1429017137-20218-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1429017137-20218-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@linaro.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

From: Stephane Viau <sviau@codeaurora.org>

Add the GDSC instances that exist as part of apq8084 MMCC block.

Signed-off-by: Stephane Viau <sviau@codeaurora.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/Kconfig                      |  1 +
 drivers/clk/qcom/mmcc-apq8084.c               | 56 ++++++++++++++++++++++++++-
 include/dt-bindings/clock/qcom,mmcc-apq8084.h |  8 ++++
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 7dcb7e5..8b6c49d 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -17,6 +17,7 @@ config APQ_GCC_8084
 config APQ_MMCC_8084
 	tristate "APQ8084 Multimedia Clock Controller"
 	select APQ_GCC_8084
+	select QCOM_GDSC
 	depends on COMMON_CLK_QCOM
 	help
 	  Support for the multimedia clock controller on apq8084 devices.
diff --git a/drivers/clk/qcom/mmcc-apq8084.c b/drivers/clk/qcom/mmcc-apq8084.c
index 1b17df2..a4d7428 100644
--- a/drivers/clk/qcom/mmcc-apq8084.c
+++ b/drivers/clk/qcom/mmcc-apq8084.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2014, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -26,6 +26,7 @@
 #include "clk-rcg.h"
 #include "clk-branch.h"
 #include "reset.h"
+#include "gdsc.h"
 
 enum {
 	P_XO,
@@ -3077,6 +3078,48 @@ static const struct pll_config mmpll3_config = {
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
 static struct clk_regmap *mmcc_apq8084_clocks[] = {
 	[MMSS_AHB_CLK_SRC] = &mmss_ahb_clk_src.clkr,
 	[MMSS_AXI_CLK_SRC] = &mmss_axi_clk_src.clkr,
@@ -3294,6 +3337,15 @@ static const struct qcom_reset_map mmcc_apq8084_resets[] = {
 	[MMSSNOCAXI_RESET] = { 0x5060 },
 };
 
+static struct gdsc *mmcc_apq8084_gdscs[] = {
+	[VENUS0_GDSC] = &venus0_gdsc,
+	[MDSS_GDSC] = &mdss_gdsc,
+	[CAMSS_JPEG_GDSC] = &camss_jpeg_gdsc,
+	[CAMSS_VFE_GDSC] = &camss_vfe_gdsc,
+	[OXILI_GDSC] = &oxili_gdsc,
+	[OXILICX_GDSC] = &oxilicx_gdsc,
+};
+
 static const struct regmap_config mmcc_apq8084_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -3308,6 +3360,8 @@ static const struct qcom_cc_desc mmcc_apq8084_desc = {
 	.num_clks = ARRAY_SIZE(mmcc_apq8084_clocks),
 	.resets = mmcc_apq8084_resets,
 	.num_resets = ARRAY_SIZE(mmcc_apq8084_resets),
+	.gdscs = mmcc_apq8084_gdscs,
+	.num_gdscs = ARRAY_SIZE(mmcc_apq8084_gdscs),
 };
 
 static const struct of_device_id mmcc_apq8084_match_table[] = {
diff --git a/include/dt-bindings/clock/qcom,mmcc-apq8084.h b/include/dt-bindings/clock/qcom,mmcc-apq8084.h
index d72b5b3..21fec5d 100644
--- a/include/dt-bindings/clock/qcom,mmcc-apq8084.h
+++ b/include/dt-bindings/clock/qcom,mmcc-apq8084.h
@@ -180,4 +180,12 @@
 #define VPU_SLEEP_CLK			163
 #define VPU_VDP_CLK			164
 
+/* GDSCs */
+#define VENUS0_GDSC			0
+#define MDSS_GDSC			1
+#define CAMSS_JPEG_GDSC			2
+#define CAMSS_VFE_GDSC			3
+#define OXILI_GDSC			4
+#define OXILICX_GDSC			5
+
 #endif
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
