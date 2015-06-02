From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 5/6] cpufreq-dt: Handle OPP voltage adjust events
Date: Mon,  1 Jun 2015 18:47:58 -0700
Message-ID: <1433209679-31389-6-git-send-email-sboyd@codeaurora.org>
References: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andy Gross <agross@codeaurora.org>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>, David Collins <collinsd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On some SoCs the Adaptive Voltage Scaling (AVS) technique is
employed to optimize the operating voltage of a device. At a
given frequency, the hardware monitors dynamic factors and either
makes a suggestion for how much to adjust a voltage for the
current frequency, or it automatically adjusts the voltage
without software intervention.

In the former case, an AVS driver will call
dev_pm_opp_modify_voltage() and update the voltage for the
particular OPP the CPUs are using. Add an OPP notifier to
cpufreq-dt so that we can adjust the voltage of the CPU when AVS
updates the OPP.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/cpufreq/cpufreq-dt.c | 73 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 67 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index bab67db54b7e..616218f133be 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -34,8 +34,48 @@ struct private_data {
 	struct regulator *cpu_reg;
 	struct thermal_cooling_device *cdev;
 	unsigned int voltage_tolerance; /* in percentage */
+	struct notifier_block opp_nb;
+	struct mutex lock;
+	unsigned long opp_freq;
 };
 
+
+static int opp_notifier(struct notifier_block *nb, unsigned long event,
+			void *data)
+{
+	struct dev_pm_opp *opp = data;
+	struct private_data *priv = container_of(nb, struct private_data,
+						 opp_nb);
+	struct device *cpu_dev = priv->cpu_dev;
+	struct regulator *cpu_reg = priv->cpu_reg;
+	unsigned long volt, tol, freq;
+	int ret = 0;
+
+	switch (event) {
+		case OPP_EVENT_ADJUST_VOLTAGE:
+			volt = dev_pm_opp_get_voltage(opp);
+			freq = dev_pm_opp_get_freq(opp);
+			tol = volt * priv->voltage_tolerance / 100;
+
+			mutex_lock(&priv->lock);
+			if (freq == priv->opp_freq)
+				ret = regulator_set_voltage_tol(cpu_reg, volt,
+								tol);
+			mutex_unlock(&priv->lock);
+			if (ret) {
+				dev_err(cpu_dev,
+					"failed to scale voltage up: %d\n",
+					ret);
+				return ret;
+			}
+			break;
+		default:
+			break;
+	}
+
+	return 0;
+}
+
 static int set_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	struct dev_pm_opp *opp;
@@ -47,6 +87,7 @@ static int set_target(struct cpufreq_policy *policy, unsigned int index)
 	unsigned long volt = 0, volt_old = 0, tol = 0;
 	unsigned int old_freq, new_freq;
 	long freq_Hz, freq_exact;
+	unsigned long opp_freq = 0;
 	int ret;
 
 	freq_Hz = clk_round_rate(cpu_clk, freq_table[index].frequency * 1000);
@@ -57,8 +98,8 @@ static int set_target(struct cpufreq_policy *policy, unsigned int index)
 	new_freq = freq_Hz / 1000;
 	old_freq = clk_get_rate(cpu_clk) / 1000;
 
+	mutex_lock(&priv->lock);
 	if (!IS_ERR(cpu_reg)) {
-		unsigned long opp_freq;
 
 		rcu_read_lock();
 		opp = dev_pm_opp_find_freq_ceil(cpu_dev, &freq_Hz);
@@ -66,7 +107,8 @@ static int set_target(struct cpufreq_policy *policy, unsigned int index)
 			rcu_read_unlock();
 			dev_err(cpu_dev, "failed to find OPP for %ld\n",
 				freq_Hz);
-			return PTR_ERR(opp);
+			ret = PTR_ERR(opp);
+			goto out;
 		}
 		volt = dev_pm_opp_get_voltage(opp);
 		opp_freq = dev_pm_opp_get_freq(opp);
@@ -87,7 +129,7 @@ static int set_target(struct cpufreq_policy *policy, unsigned int index)
 		if (ret) {
 			dev_err(cpu_dev, "failed to scale voltage up: %d\n",
 				ret);
-			return ret;
+			goto out;
 		}
 	}
 
@@ -96,7 +138,7 @@ static int set_target(struct cpufreq_policy *policy, unsigned int index)
 		dev_err(cpu_dev, "failed to set clock rate: %d\n", ret);
 		if (!IS_ERR(cpu_reg) && volt_old > 0)
 			regulator_set_voltage_tol(cpu_reg, volt_old, tol);
-		return ret;
+		goto out;
 	}
 
 	/* scaling down?  scale voltage after frequency */
@@ -106,9 +148,12 @@ static int set_target(struct cpufreq_policy *policy, unsigned int index)
 			dev_err(cpu_dev, "failed to scale voltage down: %d\n",
 				ret);
 			clk_set_rate(cpu_clk, old_freq * 1000);
+			goto out;
 		}
 	}
-
+	priv->opp_freq = opp_freq;
+out:
+	mutex_unlock(&priv->lock);
 	return ret;
 }
 
@@ -194,6 +239,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	unsigned long min_uV = ~0, max_uV = 0;
 	unsigned int transition_latency;
 	int ret;
+	struct srcu_notifier_head *opp_srcu_head;
 
 	ret = allocate_resources(policy->cpu, &cpu_dev, &cpu_reg, &cpu_clk);
 	if (ret) {
@@ -228,6 +274,19 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		goto out_free_opp;
 	}
 
+	mutex_init(&priv->lock);
+
+	opp_srcu_head = dev_pm_opp_get_notifier(cpu_dev);
+	if (IS_ERR(opp_srcu_head)) {
+		ret = PTR_ERR(opp_srcu_head);
+		goto out_free_priv;
+	}
+
+	priv->opp_nb.notifier_call = opp_notifier;
+	ret = srcu_notifier_chain_register(opp_srcu_head, &priv->opp_nb);
+	if (ret)
+		goto out_free_priv;
+
 	of_property_read_u32(np, "voltage-tolerance", &priv->voltage_tolerance);
 
 	if (of_property_read_u32(np, "clock-latency", &transition_latency))
@@ -276,7 +335,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
 	if (ret) {
 		pr_err("failed to init cpufreq table: %d\n", ret);
-		goto out_free_priv;
+		goto out_unregister_nb;
 	}
 
 	priv->cpu_dev = cpu_dev;
@@ -303,6 +362,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 
 out_free_cpufreq_table:
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
+out_unregister_nb:
+	srcu_notifier_chain_unregister(opp_srcu_head, &priv->opp_nb);
 out_free_priv:
 	kfree(priv);
 out_free_opp:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
