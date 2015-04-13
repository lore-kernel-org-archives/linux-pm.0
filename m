From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH] clk: divider: handle integer overflow when dividing large clock rates
Date: Mon, 13 Apr 2015 16:03:21 -0700
Message-ID: <1428966201-23365-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33521 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbbDMXEH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2015 19:04:07 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@linaro.org>
Cc: Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Jim Quinlan <jim2101024@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, u.kleine-koenig@pengutronix.de

On 32-bit architectures, 'unsigned long' (the type used to hold clock
rates, in Hz) is often only 32 bits wide. DIV_ROUND_UP() (as used in,
e.g., commit b11d282dbea2 "clk: divider: fix rate calculation for
fractional rates") can yield an integer overflow on clock rates that are
not (by themselves) too large to fit in 32 bits, because it performs
addition before the division. See for example:

  DIV_ROUND_UP(3000000000, 1500000000) = (3.0G + 1.5G - 1) / 1.5G
                                       = OVERFLOW / 1.5G

This patch fixes such cases by always promoting the dividend to 64-bits
(unsigned long long) before doing the division. While this patch does
not resolve the issue with large clock rates across the common clock
framework nor address the problems with doing full 64-bit arithmetic on
a 32-bit architecture, it does fix some issues seen when using clock
dividers on a 3GHz reference clock to produce a 1.5GHz CPU clock for an
ARMv7 Brahma B15 SoC.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Reference: lkml.kernel.org/g/20150413201433.GQ32500@ld-irv-0074
---
I'll admit I only compile-tested this particular patch. I have tested a version
of this patch on top of a few backports on an older kernel, and everything
works fine. Unforunately, some of my SoC's clock drivers still rely on
out-of-tree code.

 drivers/clk/clk-divider.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 25006a8bb8e6..2928bc361506 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -24,7 +24,7 @@
  * Traits of this clock:
  * prepare - clk_prepare only ensures that parents are prepared
  * enable - clk_enable only ensures that parents are enabled
- * rate - rate is adjustable.  clk->rate = DIV_ROUND_UP(parent->rate / divisor)
+ * rate - rate is adjustable.  clk->rate = ceiling(parent->rate / divisor)
  * parent - fixed parent.  No clk_set_parent support
  */
 
@@ -127,7 +127,7 @@ unsigned long divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate,
 		return parent_rate;
 	}
 
-	return DIV_ROUND_UP(parent_rate, div);
+	return DIV_ROUND_UP_ULL((u64)parent_rate, div);
 }
 EXPORT_SYMBOL_GPL(divider_recalc_rate);
 
@@ -205,7 +205,7 @@ static int _div_round_up(const struct clk_div_table *table,
 			 unsigned long parent_rate, unsigned long rate,
 			 unsigned long flags)
 {
-	int div = DIV_ROUND_UP(parent_rate, rate);
+	int div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
 
 	if (flags & CLK_DIVIDER_POWER_OF_TWO)
 		div = __roundup_pow_of_two(div);
@@ -222,7 +222,7 @@ static int _div_round_closest(const struct clk_div_table *table,
 	int up, down;
 	unsigned long up_rate, down_rate;
 
-	up = DIV_ROUND_UP(parent_rate, rate);
+	up = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
 	down = parent_rate / rate;
 
 	if (flags & CLK_DIVIDER_POWER_OF_TWO) {
@@ -233,8 +233,8 @@ static int _div_round_closest(const struct clk_div_table *table,
 		down = _round_down_table(table, down);
 	}
 
-	up_rate = DIV_ROUND_UP(parent_rate, up);
-	down_rate = DIV_ROUND_UP(parent_rate, down);
+	up_rate = DIV_ROUND_UP_ULL((u64)parent_rate, up);
+	down_rate = DIV_ROUND_UP_ULL((u64)parent_rate, down);
 
 	return (rate - up_rate) <= (down_rate - rate) ? up : down;
 }
@@ -313,7 +313,7 @@ static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
 		}
 		parent_rate = __clk_round_rate(__clk_get_parent(hw->clk),
 					       rate * i);
-		now = DIV_ROUND_UP(parent_rate, i);
+		now = DIV_ROUND_UP_ULL((u64)parent_rate, i);
 		if (_is_best_div(rate, now, best, flags)) {
 			bestdiv = i;
 			best = now;
@@ -337,7 +337,7 @@ long divider_round_rate(struct clk_hw *hw, unsigned long rate,
 
 	div = clk_divider_bestdiv(hw, rate, prate, table, width, flags);
 
-	return DIV_ROUND_UP(*prate, div);
+	return DIV_ROUND_UP_ULL((u64)*prate, div);
 }
 EXPORT_SYMBOL_GPL(divider_round_rate);
 
@@ -352,7 +352,7 @@ static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
 		bestdiv = readl(divider->reg) >> divider->shift;
 		bestdiv &= div_mask(divider->width);
 		bestdiv = _get_div(divider->table, bestdiv, divider->flags);
-		return DIV_ROUND_UP(*prate, bestdiv);
+		return DIV_ROUND_UP_ULL((u64)*prate, bestdiv);
 	}
 
 	return divider_round_rate(hw, rate, prate, divider->table,
@@ -365,7 +365,7 @@ int divider_get_val(unsigned long rate, unsigned long parent_rate,
 {
 	unsigned int div, value;
 
-	div = DIV_ROUND_UP(parent_rate, rate);
+	div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
 
 	if (!_is_valid_div(table, div, flags))
 		return -EINVAL;
-- 
1.9.1

