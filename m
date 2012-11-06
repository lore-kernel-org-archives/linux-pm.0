From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: [PATCH 2/6 v3] clk, highbank: remove non-bypass reset mode
Date: Tue,  6 Nov 2012 14:18:04 -0600
Message-ID: <1352233089-22586-3-git-send-email-mark.langsdorf@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1352233089-22586-1-git-send-email-mark.langsdorf@calxeda.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352233089-22586-1-git-send-email-mark.langsdorf@calxeda.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, mark.langsdorf@calxeda.com
List-Id: linux-pm@vger.kernel.org

The highbank clock will glitch if the clock rate is reset without
relocking the PLL. Remove the option to attempt reseting without
relocking.

Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
---
Changes from v2:
	None
Changes from v1:
        Removed erroneous reformating.

 drivers/clk/clk-highbank.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-highbank.c b/drivers/clk/clk-highbank.c
index 52fecad..4f50c42 100644
--- a/drivers/clk/clk-highbank.c
+++ b/drivers/clk/clk-highbank.c
@@ -171,7 +171,8 @@ static int clk_pll_set_rate(struct clk_hw *hwclk, unsigned long rate,
 
 		writel(reg | HB_PLL_RESET, hbclk->reg);
 		reg &= ~(HB_PLL_DIVF_MASK | HB_PLL_DIVQ_MASK);
-		reg |= (divf << HB_PLL_DIVF_SHIFT) | (divq << HB_PLL_DIVQ_SHIFT);
+		reg |= (divf << HB_PLL_DIVF_SHIFT) |
+			(divq << HB_PLL_DIVQ_SHIFT);
 		writel(reg | HB_PLL_RESET, hbclk->reg);
 		writel(reg, hbclk->reg);
 
@@ -182,8 +183,10 @@ static int clk_pll_set_rate(struct clk_hw *hwclk, unsigned long rate,
 		reg |= HB_PLL_EXT_ENA;
 		reg &= ~HB_PLL_EXT_BYPASS;
 	} else {
+		writel(reg | HB_PLL_EXT_BYPASS, hbclk->reg);
 		reg &= ~HB_PLL_DIVQ_MASK;
 		reg |= divq << HB_PLL_DIVQ_SHIFT;
+		writel(reg | HB_PLL_EXT_BYPASS, hbclk->reg);
 	}
 	writel(reg, hbclk->reg);
 
-- 
1.7.11.7
