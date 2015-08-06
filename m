From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v8 06/13] clk: qcom: gdsc: Add GDSCs in msm8974 GCC
Date: Thu,  6 Aug 2015 16:07:47 +0530
Message-ID: <1438857474-20262-7-git-send-email-rnayak@codeaurora.org>
References: <1438857474-20262-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38711 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932169AbbHFKjh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2015 06:39:37 -0400
In-Reply-To: <1438857474-20262-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>

From: Stephen Boyd <sboyd@codeaurora.org>

There's just one GDSC as part of the msm8974 GCC block.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/Kconfig                     |  1 +
 drivers/clk/qcom/gcc-msm8974.c               | 15 +++++++++++++++
 include/dt-bindings/clock/qcom,gcc-msm8974.h |  3 +++
 3 files changed, 19 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index abec45a..a6fcb1d 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -88,6 +88,7 @@ config MSM_MMCC_8960
 
 config MSM_GCC_8974
 	tristate "MSM8974 Global Clock Controller"
+	select QCOM_GDSC
 	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on msm8974 devices.
diff --git a/drivers/clk/qcom/gcc-msm8974.c b/drivers/clk/qcom/gcc-msm8974.c
index c39d098..2c3c26f 100644
--- a/drivers/clk/qcom/gcc-msm8974.c
+++ b/drivers/clk/qcom/gcc-msm8974.c
@@ -31,6 +31,7 @@
 #include "clk-rcg.h"
 #include "clk-branch.h"
 #include "reset.h"
+#include "gdsc.h"
 
 enum {
 	P_XO,
@@ -2431,6 +2432,14 @@ static struct clk_branch gcc_usb_hsic_system_clk = {
 	},
 };
 
+static struct gdsc usb_hs_hsic_gdsc = {
+	.gdscr = 0x404,
+	.pd = {
+		.name = "usb_hs_hsic",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
 static struct clk_regmap *gcc_msm8974_clocks[] = {
 	[GPLL0] = &gpll0.clkr,
 	[GPLL0_VOTE] = &gpll0_vote,
@@ -2660,6 +2669,10 @@ static const struct qcom_reset_map gcc_msm8974_resets[] = {
 	[GCC_VENUS_RESTART] = { 0x1740 },
 };
 
+static struct gdsc *gcc_msm8974_gdscs[] = {
+	[USB_HS_HSIC_GDSC] = &usb_hs_hsic_gdsc,
+};
+
 static const struct regmap_config gcc_msm8974_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -2674,6 +2687,8 @@ static const struct qcom_cc_desc gcc_msm8974_desc = {
 	.num_clks = ARRAY_SIZE(gcc_msm8974_clocks),
 	.resets = gcc_msm8974_resets,
 	.num_resets = ARRAY_SIZE(gcc_msm8974_resets),
+	.gdscs = gcc_msm8974_gdscs,
+	.num_gdscs = ARRAY_SIZE(gcc_msm8974_gdscs),
 };
 
 static const struct of_device_id gcc_msm8974_match_table[] = {
diff --git a/include/dt-bindings/clock/qcom,gcc-msm8974.h b/include/dt-bindings/clock/qcom,gcc-msm8974.h
index 51e51c8..81d32f6 100644
--- a/include/dt-bindings/clock/qcom,gcc-msm8974.h
+++ b/include/dt-bindings/clock/qcom,gcc-msm8974.h
@@ -321,4 +321,7 @@
 #define GCC_SDCC1_CDCCAL_SLEEP_CLK				304
 #define GCC_SDCC1_CDCCAL_FF_CLK					305
 
+/* gdscs */
+#define USB_HS_HSIC_GDSC					0
+
 #endif
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

