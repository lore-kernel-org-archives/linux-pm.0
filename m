From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: [PATCH 2/4 v11] clk, highbank: Prevent glitches in non-bypass reset mode
Date: Fri, 25 Jan 2013 13:46:43 -0600
Message-ID: <1359143205-20279-3-git-send-email-mark.langsdorf@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1359143205-20279-1-git-send-email-mark.langsdorf@calxeda.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp187.dfw.emailsrvr.com ([67.192.241.187]:55099 "EHLO
	smtp187.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab3AYTql (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Jan 2013 14:46:41 -0500
In-Reply-To: <1359143205-20279-1-git-send-email-mark.langsdorf@calxeda.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>, Rob Herring <rob.herring@calxeda.com>

The highbank clock will glitch with the current code if the
clock rate is reset without relocking the PLL. Program the PLL
correctly to prevent glitches.

Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Mike Turquette <mturquette@linaro.org>
---
Changes from v6, v7, v8, v9, v10
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

