From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH v2 10/15] clk: qcom: Add IPQ806X's HFPLLs
Date: Fri,  5 Sep 2014 15:47:30 -0700
Message-ID: <1409957256-23729-12-git-send-email-sboyd@codeaurora.org>
References: <1409957256-23729-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1409957256-23729-1-git-send-email-sboyd@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Describe the HFPLLs present on IPQ806X devices.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/qcom/gcc-ipq806x.c | 83 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 4032e510d9aa..353261b12ba1 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -30,6 +30,7 @@
 #include "clk-pll.h"
 #include "clk-rcg.h"
 #include "clk-branch.h"
+#include "clk-hfpll.h"
 #include "reset.h"
 
 static struct clk_pll pll3 = {
@@ -75,6 +76,85 @@ static struct clk_regmap pll8_vote = {
 	},
 };
 
+static struct hfpll_data hfpll0_data = {
+	.mode_reg = 0x3200,
+	.l_reg = 0x3208,
+	.m_reg = 0x320c,
+	.n_reg = 0x3210,
+	.config_reg = 0x3204,
+	.status_reg = 0x321c,
+	.config_val = 0x7845c665,
+	.droop_reg = 0x3214,
+	.droop_val = 0x0108c000,
+	.min_rate = 600000000UL,
+	.max_rate = 1800000000UL,
+};
+
+static struct clk_hfpll hfpll0 = {
+	.d = &hfpll0_data,
+	.clkr.hw.init = &(struct clk_init_data){
+		.parent_names = (const char *[]){ "pxo" },
+		.num_parents = 1,
+		.name = "hfpll0",
+		.ops = &clk_ops_hfpll,
+		.flags = CLK_IGNORE_UNUSED,
+	},
+	.lock = __SPIN_LOCK_UNLOCKED(hfpll0.lock),
+};
+
+static struct hfpll_data hfpll1_data = {
+	.mode_reg = 0x3240,
+	.l_reg = 0x3248,
+	.m_reg = 0x324c,
+	.n_reg = 0x3250,
+	.config_reg = 0x3244,
+	.status_reg = 0x325c,
+	.config_val = 0x7845c665,
+	.droop_reg = 0x3314,
+	.droop_val = 0x0108c000,
+	.min_rate = 600000000UL,
+	.max_rate = 1800000000UL,
+};
+
+static struct clk_hfpll hfpll1 = {
+	.d = &hfpll1_data,
+	.clkr.hw.init = &(struct clk_init_data){
+		.parent_names = (const char *[]){ "pxo" },
+		.num_parents = 1,
+		.name = "hfpll1",
+		.ops = &clk_ops_hfpll,
+		.flags = CLK_IGNORE_UNUSED,
+	},
+	.lock = __SPIN_LOCK_UNLOCKED(hfpll1.lock),
+};
+
+static struct hfpll_data hfpll_l2_data = {
+	.mode_reg = 0x3300,
+	.l_reg = 0x3308,
+	.m_reg = 0x330c,
+	.n_reg = 0x3310,
+	.config_reg = 0x3304,
+	.status_reg = 0x331c,
+	.config_val = 0x7845c665,
+	.droop_reg = 0x3314,
+	.droop_val = 0x0108c000,
+	.min_rate = 600000000UL,
+	.max_rate = 1800000000UL,
+};
+
+static struct clk_hfpll hfpll_l2 = {
+	.d = &hfpll_l2_data,
+	.clkr.hw.init = &(struct clk_init_data){
+		.parent_names = (const char *[]){ "pxo" },
+		.num_parents = 1,
+		.name = "hfpll_l2",
+		.ops = &clk_ops_hfpll,
+		.flags = CLK_IGNORE_UNUSED,
+	},
+	.lock = __SPIN_LOCK_UNLOCKED(hfpll_l2.lock),
+};
+
+
 static struct clk_pll pll14 = {
 	.l_reg = 0x31c4,
 	.m_reg = 0x31c8,
@@ -2232,6 +2312,9 @@ static struct clk_regmap *gcc_ipq806x_clks[] = {
 	[USB_FS1_XCVR_SRC] = &usb_fs1_xcvr_clk_src.clkr,
 	[USB_FS1_XCVR_CLK] = &usb_fs1_xcvr_clk.clkr,
 	[USB_FS1_SYSTEM_CLK] = &usb_fs1_sys_clk.clkr,
+	[PLL9] = &hfpll0.clkr,
+	[PLL10] = &hfpll1.clkr,
+	[PLL12] = &hfpll_l2.clkr,
 };
 
 static const struct qcom_reset_map gcc_ipq806x_resets[] = {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
