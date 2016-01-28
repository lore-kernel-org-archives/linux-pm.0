From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 14/16] cpufreq: dt: Use dev_pm_opp_set_rate() to switch frequency
Date: Thu, 28 Jan 2016 13:50:43 +0530
Message-ID: <0aea45d1102903282f53f2b01189d83c6b371628.1453965717.git.viresh.kumar@linaro.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1453965717.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1453965717.git.viresh.kumar@linaro.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

OPP core supports frequency/voltage changes based on the target
frequency now, use that instead of open coding the same in cpufreq-dt
driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/cpufreq/cpufreq-dt.c | 73 ++------------------------------------------
 1 file changed, 2 insertions(+), 71 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 214612c473d4..13338365f24e 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -45,79 +45,10 @@ static struct freq_attr *cpufreq_dt_attr[] = {
 
 static int set_target(struct cpufreq_policy *policy, unsigned int index)
 {
-	struct dev_pm_opp *opp;
-	struct cpufreq_frequency_table *freq_table = policy->freq_table;
-	struct clk *cpu_clk = policy->clk;
 	struct private_data *priv = policy->driver_data;
-	struct device *cpu_dev = priv->cpu_dev;
-	struct regulator *cpu_reg = priv->cpu_reg;
-	unsigned long volt = 0, tol = 0;
-	int volt_old = 0;
-	unsigned int old_freq, new_freq;
-	long freq_Hz, freq_exact;
-	int ret;
-
-	freq_Hz = clk_round_rate(cpu_clk, freq_table[index].frequency * 1000);
-	if (freq_Hz <= 0)
-		freq_Hz = freq_table[index].frequency * 1000;
-
-	freq_exact = freq_Hz;
-	new_freq = freq_Hz / 1000;
-	old_freq = clk_get_rate(cpu_clk) / 1000;
-
-	if (!IS_ERR(cpu_reg)) {
-		unsigned long opp_freq;
-
-		rcu_read_lock();
-		opp = dev_pm_opp_find_freq_ceil(cpu_dev, &freq_Hz);
-		if (IS_ERR(opp)) {
-			rcu_read_unlock();
-			dev_err(cpu_dev, "failed to find OPP for %ld\n",
-				freq_Hz);
-			return PTR_ERR(opp);
-		}
-		volt = dev_pm_opp_get_voltage(opp);
-		opp_freq = dev_pm_opp_get_freq(opp);
-		rcu_read_unlock();
-		tol = volt * priv->voltage_tolerance / 100;
-		volt_old = regulator_get_voltage(cpu_reg);
-		dev_dbg(cpu_dev, "Found OPP: %ld kHz, %ld uV\n",
-			opp_freq / 1000, volt);
-	}
-
-	dev_dbg(cpu_dev, "%u MHz, %d mV --> %u MHz, %ld mV\n",
-		old_freq / 1000, (volt_old > 0) ? volt_old / 1000 : -1,
-		new_freq / 1000, volt ? volt / 1000 : -1);
-
-	/* scaling up?  scale voltage before frequency */
-	if (!IS_ERR(cpu_reg) && new_freq > old_freq) {
-		ret = regulator_set_voltage_tol(cpu_reg, volt, tol);
-		if (ret) {
-			dev_err(cpu_dev, "failed to scale voltage up: %d\n",
-				ret);
-			return ret;
-		}
-	}
-
-	ret = clk_set_rate(cpu_clk, freq_exact);
-	if (ret) {
-		dev_err(cpu_dev, "failed to set clock rate: %d\n", ret);
-		if (!IS_ERR(cpu_reg) && volt_old > 0)
-			regulator_set_voltage_tol(cpu_reg, volt_old, tol);
-		return ret;
-	}
 
-	/* scaling down?  scale voltage after frequency */
-	if (!IS_ERR(cpu_reg) && new_freq < old_freq) {
-		ret = regulator_set_voltage_tol(cpu_reg, volt, tol);
-		if (ret) {
-			dev_err(cpu_dev, "failed to scale voltage down: %d\n",
-				ret);
-			clk_set_rate(cpu_clk, old_freq * 1000);
-		}
-	}
-
-	return ret;
+	return dev_pm_opp_set_rate(priv->cpu_dev,
+				   policy->freq_table[index].frequency * 1000);
 }
 
 /*
-- 
2.7.0.79.gdc08a19
