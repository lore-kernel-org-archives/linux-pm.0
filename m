From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/6] clk: add CLK_RECALC_NEW_RATES clock flag for Exynos cpu
 clock support
Date: Fri, 03 Apr 2015 18:43:44 +0200
Message-ID: <1428079429-4252-2-git-send-email-b.zolnierkie@samsung.com>
References: <'@samsung.com>
 <1428079429-4252-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1428079429-4252-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

This flag is needed to fix the issue with wrong dividers being setup
by Common Clock Framework when using the new Exynos cpu clock support.

The issue happens because clk_core_set_rate_nolock()  calls
clk_calc_new_rates(clk, rate) before both pre/post clock notifiers have
a chance to run.  In case of Exynos cpu clock support pre/post clock
notifiers are registered for mout_apll clock which is a parent of armclk
cpu clock and dividers are modified in both pre and post clock notifier.
This results in wrong dividers values being later programmed by
clk_change_rate(top).  To workaround the problem CLK_RECALC_NEW_RATES
flag is added and it is set for mout_apll clock later so the correct
divider values are re-calculated after both pre and post clock notifiers
had run.

For example when using "performance" governor on Exynos4210 Origen board
the cpufreq-dt driver requests to change the frequency from 1000MHz to
1200MHz and after the change state of the relevant clocks is following:

Without use of CLK_GET_RATE_NOCACHE flag:

 fout_apll rate: 1200000000
         fout_apll_div_2 rate: 600000000
                 mout_clkout_cpu rate: 600000000
                         div_clkout_cpu rate: 600000000
                                 clkout_cpu rate: 600000000
         mout_apll rate: 1200000000
                 armclk rate: 1200000000
                 mout_hpm rate: 1200000000
                         div_copy rate: 300000000
                                 div_hpm rate: 300000000
                 mout_core rate: 1200000000
                         div_core rate: 1200000000
                                 div_core2 rate: 1200000000
                                         arm_clk_div_2 rate: 600000000
                                         div_corem0 rate: 300000000
                                         div_corem1 rate: 150000000
                                         div_periph rate: 300000000
                         div_atb rate: 300000000
                                 div_pclk_dbg rate: 150000000
                 sclk_apll rate: 1200000000
                         sclk_apll_div_2 rate: 600000000


With use of CLK_GET_RATE_NOCACHE flag:

 fout_apll rate: 1200000000
         fout_apll_div_2 rate: 600000000
                 mout_clkout_cpu rate: 600000000
                         div_clkout_cpu rate: 600000000
                                 clkout_cpu rate: 600000000
         mout_apll rate: 1200000000
                 armclk rate: 1200000000
                 mout_hpm rate: 1200000000
                         div_copy rate: 200000000
                                 div_hpm rate: 200000000
                 mout_core rate: 1200000000
                         div_core rate: 1200000000
                                 div_core2 rate: 1200000000
                                         arm_clk_div_2 rate: 600000000
                                         div_corem0 rate: 300000000
                                         div_corem1 rate: 150000000
                                         div_periph rate: 300000000
                         div_atb rate: 240000000
                                 div_pclk_dbg rate: 120000000
                 sclk_apll rate: 150000000
                         sclk_apll_div_2 rate: 75000000

Without this change cpufreq-dt driver showed ~10 mA larger energy
consumption when compared to cpufreq-exynos one when "performance"
cpufreq governor was used on Exynos4210 SoC based Origen board.

This issue was probably meant to be workarounded by use of
CLK_GET_RATE_NOCACHE and CLK_DIVIDER_READ_ONLY clock flags in
the original Exynos cpu clock patchset (in "[PATCH v12 6/6] clk:
samsung: remove unused clock aliases and update clock flags" patch)
but usage of these flags is not sufficient to fix the issue observed.

Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/clk/clk.c            |    3 +++
 include/linux/clk-provider.h |    1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index f85c8e2..97cc73e 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1771,6 +1771,9 @@ static void clk_change_rate(struct clk_core *clk)
 	if (clk->notifier_count && old_rate != clk->rate)
 		__clk_notify(clk, POST_RATE_CHANGE, old_rate, clk->rate);
 
+	if (clk->flags & CLK_RECALC_NEW_RATES)
+		(void)clk_calc_new_rates(clk, clk->new_rate);
+
 	/*
 	 * Use safe iteration, as change_rate can actually swap parents
 	 * for certain clock types.
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 28abf1b..8d1aebe 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -31,6 +31,7 @@
 #define CLK_GET_RATE_NOCACHE	BIT(6) /* do not use the cached clk rate */
 #define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
 #define CLK_GET_ACCURACY_NOCACHE BIT(8) /* do not use the cached clk accuracy */
+#define CLK_RECALC_NEW_RATES	BIT(9) /* recalc rates after notifications */
 
 struct clk_hw;
 struct clk_core;
-- 
1.7.9.5
