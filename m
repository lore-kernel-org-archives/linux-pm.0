From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] cpufreq: exynos: remove dead ->need_apll_change method
Date: Fri, 27 Mar 2015 17:32:53 +0100
Message-ID: <2557080.JPtuM0lETZ@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sachin Kamat <sachin.kamat@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Commit 26ab1c62b6e1 ("cpufreq: exynos5250: Set APLL rate
using CCF API") removed the last user of ->need_apll_change
method.  Remove it and then cleanup exynos_cpufreq_scale()
accordingly.

This patch was tested on Exynos4412 SoC based Trats2 board.

There should be no functional changes caused by this patch.

Cc: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/cpufreq/exynos-cpufreq.c |   30 +++---------------------------
 drivers/cpufreq/exynos-cpufreq.h |    1 -
 2 files changed, 3 insertions(+), 28 deletions(-)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 82d2fbb..01ed166 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -45,11 +45,9 @@ static int exynos_cpufreq_get_index(unsigned int freq)
 
 static int exynos_cpufreq_scale(unsigned int target_freq)
 {
-	struct cpufreq_frequency_table *freq_table = exynos_info->freq_table;
 	unsigned int *volt_table = exynos_info->volt_table;
 	struct cpufreq_policy *policy = cpufreq_cpu_get(0);
-	unsigned int arm_volt, safe_arm_volt = 0;
-	unsigned int mpll_freq_khz = exynos_info->mpll_freq_khz;
+	unsigned int arm_volt;
 	struct device *dev = exynos_info->dev;
 	unsigned int old_freq;
 	int index, old_index;
@@ -74,21 +72,10 @@ static int exynos_cpufreq_scale(unsigned int target_freq)
 		goto out;
 	}
 
-	/*
-	 * ARM clock source will be changed APLL to MPLL temporary
-	 * To support this level, need to control regulator for
-	 * required voltage level
-	 */
-	if (exynos_info->need_apll_change != NULL) {
-		if (exynos_info->need_apll_change(old_index, index) &&
-		   (freq_table[index].frequency < mpll_freq_khz) &&
-		   (freq_table[old_index].frequency < mpll_freq_khz))
-			safe_arm_volt = volt_table[exynos_info->pll_safe_idx];
-	}
 	arm_volt = volt_table[index];
 
 	/* When the new frequency is higher than current frequency */
-	if ((target_freq > old_freq) && !safe_arm_volt) {
+	if (target_freq > old_freq) {
 		/* Firstly, voltage up to increase frequency */
 		ret = regulator_set_voltage(arm_regulator, arm_volt, arm_volt);
 		if (ret) {
@@ -98,21 +85,10 @@ static int exynos_cpufreq_scale(unsigned int target_freq)
 		}
 	}
 
-	if (safe_arm_volt) {
-		ret = regulator_set_voltage(arm_regulator, safe_arm_volt,
-				      safe_arm_volt);
-		if (ret) {
-			dev_err(dev, "failed to set cpu voltage to %d\n",
-				safe_arm_volt);
-			return ret;
-		}
-	}
-
 	exynos_info->set_freq(old_index, index);
 
 	/* When the new frequency is lower than current frequency */
-	if ((target_freq < old_freq) ||
-	   ((target_freq > old_freq) && safe_arm_volt)) {
+	if (target_freq < old_freq) {
 		/* down the voltage after frequency change */
 		ret = regulator_set_voltage(arm_regulator, arm_volt,
 				arm_volt);
diff --git a/drivers/cpufreq/exynos-cpufreq.h b/drivers/cpufreq/exynos-cpufreq.h
index 9f2062a..fe5a105 100644
--- a/drivers/cpufreq/exynos-cpufreq.h
+++ b/drivers/cpufreq/exynos-cpufreq.h
@@ -49,7 +49,6 @@ struct exynos_dvfs_info {
 	unsigned int	*volt_table;
 	struct cpufreq_frequency_table	*freq_table;
 	void (*set_freq)(unsigned int, unsigned int);
-	bool (*need_apll_change)(unsigned int, unsigned int);
 	void __iomem	*cmu_regs;
 };
 
-- 
1.7.9.5
