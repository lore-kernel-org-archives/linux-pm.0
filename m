From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: [PATCH 2/4 v12] clk, highbank: Prevent glitches in non-bypass reset mode
Date: Mon, 28 Jan 2013 10:13:13 -0600
Message-ID: <1359389595-26580-3-git-send-email-mark.langsdorf@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1359389595-26580-1-git-send-email-mark.langsdorf@calxeda.com>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1359389595-26580-1-git-send-email-mark.langsdorf@calxeda.com>
Sender: cpufreq-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>, Rob Herring <rob.herring@calxeda.com>
List-Id: linux-pm@vger.kernel.org

The highbank clock will glitch with the current code if the
clock rate is reset without relocking the PLL. Program the PLL
correctly to prevent glitches.

Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Mike Turquette <mturquette@linaro.org>
---
Changes from v6, v7, v8, v9, v10, v11
        None.
Changes from v5
        Added Mike Turquette's ack.
Changes from v4
        None.
Changes from v3
        Changelog text and patch name now correspond to the actual patch.
        was clk, highbank: remove non-bypass reset mode.
Changes from v2
        None.
Changes from v1
        Removed erroneous reformating.

 drivers/clk/clk-highbank.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/clk-highbank.c b/drivers/clk/clk-highbank.c
index 52fecad..3a0b723 100644
--- a/drivers/clk/clk-highbank.c
+++ b/drivers/clk/clk-highbank.c
@@ -182,8 +182,10 @@ static int clk_pll_set_rate(struct clk_hw *hwclk, unsigned long rate,
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

