From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v7 11/13] clk: qcom: gdsc: Add GDSCs in apq8084 GCC
Date: Tue, 28 Jul 2015 15:04:04 +0530
Message-ID: <1438076046-4706-12-git-send-email-rnayak@codeaurora.org>
References: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Add the GDSC instances that exist as part of apq8084 GCC block

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/Kconfig                     |  1 +
 drivers/clk/qcom/gcc-apq8084.c               | 46 ++++++++++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-apq8084.h |  6 ++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index edab172..fe00dd6 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -7,6 +7,7 @@ config COMMON_CLK_QCOM
 
 config APQ_GCC_8084
 	tristate "APQ8084 Global Clock Controller"
+	select QCOM_GDSC
 	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on apq8084 devices.
diff --git a/drivers/clk/qcom/gcc-apq8084.c b/drivers/clk/qcom/gcc-apq8084.c
index 54a756b9..54132f2 100644
--- a/drivers/clk/qcom/gcc-apq8084.c
+++ b/drivers/clk/qcom/gcc-apq8084.c
@@ -31,6 +31,7 @@
 #include "clk-rcg.h"
 #include "clk-branch.h"
 #include "reset.h"
+#include "gdsc.h"
 
 enum {
 	P_XO,
@@ -3253,6 +3254,42 @@ static struct clk_branch gcc_usb_hsic_system_clk = {
 	},
 };
 
+static struct gdsc usb_hs_hsic_gdsc = {
+	.gdscr = 0x404,
+	.pd = {
+		.name = "usb_hs_hsic",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.con_ids = { NULL },
+};
+
+static struct gdsc pcie0_gdsc = {
+	.gdscr = 0x1ac4,
+	.pd = {
+		.name = "pcie0",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.con_ids = { NULL },
+};
+
+static struct gdsc pcie1_gdsc = {
+	.gdscr = 0x1b44,
+	.pd = {
+		.name = "pcie1",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.con_ids = { NULL },
+};
+
+static struct gdsc usb30_gdsc = {
+	.gdscr = 0x1e84,
+	.pd = {
+		.name = "usb30",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.con_ids = { NULL },
+};
+
 static struct clk_regmap *gcc_apq8084_clocks[] = {
 	[GPLL0] = &gpll0.clkr,
 	[GPLL0_VOTE] = &gpll0_vote,
@@ -3446,6 +3483,13 @@ static struct clk_regmap *gcc_apq8084_clocks[] = {
 	[GCC_USB_HSIC_SYSTEM_CLK] = &gcc_usb_hsic_system_clk.clkr,
 };
 
+static struct gdsc *gcc_apq8084_gdscs[] = {
+	[USB_HS_HSIC_GDSC] = &usb_hs_hsic_gdsc,
+	[PCIE0_GDSC] = &pcie0_gdsc,
+	[PCIE1_GDSC] = &pcie1_gdsc,
+	[USB30_GDSC] = &usb30_gdsc,
+};
+
 static const struct qcom_reset_map gcc_apq8084_resets[] = {
 	[GCC_SYSTEM_NOC_BCR] = { 0x0100 },
 	[GCC_CONFIG_NOC_BCR] = { 0x0140 },
@@ -3554,6 +3598,8 @@ static const struct qcom_cc_desc gcc_apq8084_desc = {
 	.num_clks = ARRAY_SIZE(gcc_apq8084_clocks),
 	.resets = gcc_apq8084_resets,
 	.num_resets = ARRAY_SIZE(gcc_apq8084_resets),
+	.gdscs = gcc_apq8084_gdscs,
+	.num_gdscs = ARRAY_SIZE(gcc_apq8084_gdscs),
 };
 
 static const struct of_device_id gcc_apq8084_match_table[] = {
diff --git a/include/dt-bindings/clock/qcom,gcc-apq8084.h b/include/dt-bindings/clock/qcom,gcc-apq8084.h
index 2c0da56..5aa7ebe 100644
--- a/include/dt-bindings/clock/qcom,gcc-apq8084.h
+++ b/include/dt-bindings/clock/qcom,gcc-apq8084.h
@@ -348,4 +348,10 @@
 #define GCC_PCIE_1_PIPE_CLK				331
 #define GCC_PCIE_1_SLV_AXI_CLK				332
 
+/* gdscs */
+#define USB_HS_HSIC_GDSC				0
+#define PCIE0_GDSC					1
+#define PCIE1_GDSC					2
+#define USB30_GDSC					3
+
 #endif
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
