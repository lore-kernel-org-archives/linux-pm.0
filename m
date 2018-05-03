From: Ilia Lin <ilialin@codeaurora.org>
Subject: [PATCH v5 02/14] clk: qcom: Make clk_alpha_pll_configure available to modules
Date: Thu,  3 May 2018 14:52:23 +0300
Message-ID: <1525348355-25471-3-git-send-email-ilialin@codeaurora.org>
References: <1525348355-25471-1-git-send-email-ilialin@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525348355-25471-1-git-send-email-ilialin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, andy.gross@linaro.org, david.brown@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-clk@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@codeaurora.org, ilialin@codeaurora.org, amit.kucheria@linaro.org, nicolas.dechesne@linaro.org, celster@codeaurora.org, tfinkel@codeaurora.org
List-Id: linux-pm@vger.kernel.org

From: Rajendra Nayak <rnayak@codeaurora.org>

Allow clk_alpha_pll_configure to be called from loadable
kernel modules.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 9722b70..57f2084 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -228,6 +228,7 @@ void clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 	if (pll->flags & SUPPORTS_FSM_MODE)
 		qcom_pll_set_fsm_mode(regmap, PLL_MODE(pll), 6, 0);
 }
+EXPORT_SYMBOL_GPL(clk_alpha_pll_configure);
 
 static int clk_alpha_pll_hwfsm_enable(struct clk_hw *hw)
 {
-- 
1.9.1
