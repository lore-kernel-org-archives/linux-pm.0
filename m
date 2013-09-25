From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 1/2] cpufreq: exynos4x12: Use the common clock framework to set
 APLL clock rate
Date: Wed, 25 Sep 2013 13:22:17 +0200
Message-ID: <1380108138-30402-2-git-send-email-l.majewski@samsung.com>
References: <1380108138-30402-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1380108138-30402-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, Kukjin Kim <kgene@kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

In the exynos4x12_set_apll() function, the APLL frequency is set with
direct register manipulation.

Such approach is not allowed in the common clock framework. The frequency
is changed, but the corresponding clock value is not updated. This causes
wrong frequency read from cpufreq's cpuinfo_cur_freq sysfs attribute.

Tested at:
- Exynos4412 - Trats2 board (linux 3.12-rc1)

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/cpufreq/exynos4x12-cpufreq.c |   23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/exynos4x12-cpufreq.c b/drivers/cpufreq/exynos4x12-cpufreq.c
index 08b7477..b2f51c9 100644
--- a/drivers/cpufreq/exynos4x12-cpufreq.c
+++ b/drivers/cpufreq/exynos4x12-cpufreq.c
@@ -128,9 +128,9 @@ static void exynos4x12_set_clkdiv(unsigned int div_index)
 
 static void exynos4x12_set_apll(unsigned int index)
 {
-	unsigned int tmp, pdiv;
+	unsigned int tmp, freq = apll_freq_4x12[index].freq;
 
-	/* 1. MUX_CORE_SEL = MPLL, ARMCLK uses MPLL for lock time */
+	/* MUX_CORE_SEL = MPLL, ARMCLK uses MPLL for lock time */
 	clk_set_parent(moutcore, mout_mpll);
 
 	do {
@@ -140,24 +140,9 @@ static void exynos4x12_set_apll(unsigned int index)
 		tmp &= 0x7;
 	} while (tmp != 0x2);
 
-	/* 2. Set APLL Lock time */
-	pdiv = ((apll_freq_4x12[index].mps >> 8) & 0x3f);
+	clk_set_rate(mout_apll, freq * 1000);
 
-	__raw_writel((pdiv * 250), EXYNOS4_APLL_LOCK);
-
-	/* 3. Change PLL PMS values */
-	tmp = __raw_readl(EXYNOS4_APLL_CON0);
-	tmp &= ~((0x3ff << 16) | (0x3f << 8) | (0x7 << 0));
-	tmp |= apll_freq_4x12[index].mps;
-	__raw_writel(tmp, EXYNOS4_APLL_CON0);
-
-	/* 4. wait_lock_time */
-	do {
-		cpu_relax();
-		tmp = __raw_readl(EXYNOS4_APLL_CON0);
-	} while (!(tmp & (0x1 << EXYNOS4_APLLCON0_LOCKED_SHIFT)));
-
-	/* 5. MUX_CORE_SEL = APLL */
+	/* MUX_CORE_SEL = APLL */
 	clk_set_parent(moutcore, mout_apll);
 
 	do {
-- 
1.7.10.4
