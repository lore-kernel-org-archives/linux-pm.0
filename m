From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 11/11] cpufreq: drivers: Free frequency tables after being used
Date: Thu,  2 Jun 2016 19:49:11 +0530
Message-ID: <322fe1420334fb7db1e9c01faacd47b6cd8dfb6b.1464876460.git.viresh.kumar@linaro.org>
References: <cover.1464876460.git.viresh.kumar@linaro.org>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <cover.1464876460.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464876460.git.viresh.kumar@linaro.org>
References: <cover.1464876460.git.viresh.kumar@linaro.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Keguang Zhang <keguang.zhang@gmail.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Shawn Guo <shawn.guo@freescale.com>, Steven Miao <realmz6@gmail.com>
List-Id: linux-pm@vger.kernel.org

The cpufreq core doesn't use these tables anymore after
cpufreq_table_validate_and_show() has returned.  And so these can be
freed early.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/acpi-cpufreq.c      |  7 +++----
 drivers/cpufreq/at32ap-cpufreq.c    |  6 +++---
 drivers/cpufreq/cpufreq-dt.c        |  9 ++++-----
 drivers/cpufreq/e_powersaver.c      | 24 ++++++++++++++----------
 drivers/cpufreq/ia64-acpi-cpufreq.c |  7 +++----
 drivers/cpufreq/loongson1-cpufreq.c | 10 +---------
 6 files changed, 28 insertions(+), 35 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 4f9f7504a17c..047425bcaa84 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -814,8 +814,10 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	perf->state = 0;
 
 	result = cpufreq_table_validate_and_show(policy, freq_table);
+	kfree(freq_table);
+
 	if (result)
-		goto err_freqfree;
+		goto err_unreg;
 
 	if (perf->states[0].core_frequency * 1000 != policy->cpuinfo.max_freq)
 		pr_warn(FW_WARN "P-state 0 is not max freq\n");
@@ -859,8 +861,6 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	return result;
 
-err_freqfree:
-	kfree(freq_table);
 err_unreg:
 	acpi_processor_unregister_performance(cpu);
 err_free_mask:
@@ -882,7 +882,6 @@ static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 	policy->driver_data = NULL;
 	acpi_processor_unregister_performance(data->acpi_perf_cpu);
 	free_cpumask_var(data->freqdomain_cpus);
-	kfree(policy->freq_table);
 	kfree(data);
 
 	return 0;
diff --git a/drivers/cpufreq/at32ap-cpufreq.c b/drivers/cpufreq/at32ap-cpufreq.c
index 9231b1efb70d..c9751572ac8b 100644
--- a/drivers/cpufreq/at32ap-cpufreq.c
+++ b/drivers/cpufreq/at32ap-cpufreq.c
@@ -21,8 +21,6 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 
-static struct cpufreq_frequency_table *freq_table;
-
 static unsigned int	ref_freq;
 static unsigned long	loops_per_jiffy_ref;
 
@@ -51,6 +49,7 @@ static int at32_set_target(struct cpufreq_policy *policy, unsigned int index)
 
 static int at32_cpufreq_driver_init(struct cpufreq_policy *policy)
 {
+	struct cpufreq_frequency_table *freq_table;
 	unsigned int frequency, rate, min_freq;
 	struct clk *cpuclk;
 	int retval, steps, i;
@@ -99,12 +98,13 @@ static int at32_cpufreq_driver_init(struct cpufreq_policy *policy)
 	freq_table[steps - 1].frequency = CPUFREQ_TABLE_END;
 
 	retval = cpufreq_table_validate_and_show(policy, freq_table);
+	kfree(freq_table);
+
 	if (!retval) {
 		printk("cpufreq: AT32AP CPU frequency driver\n");
 		return 0;
 	}
 
-	kfree(freq_table);
 out_err_put_clk:
 	clk_put(cpuclk);
 out_err:
diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 3957de801ae8..d46741b69c59 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -253,10 +253,12 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	rcu_read_unlock();
 
 	ret = cpufreq_table_validate_and_show(policy, freq_table);
+	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
+
 	if (ret) {
 		dev_err(cpu_dev, "%s: invalid frequency table: %d\n", __func__,
 			ret);
-		goto out_free_cpufreq_table;
+		goto out_free_priv;
 	}
 
 	/* Support turbo/boost mode */
@@ -264,7 +266,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		/* This gets disabled by core on driver unregister */
 		ret = cpufreq_enable_boost_support();
 		if (ret)
-			goto out_free_cpufreq_table;
+			goto out_free_priv;
 		cpufreq_dt_attr[1] = &cpufreq_freq_attr_scaling_boost_freqs;
 	}
 
@@ -276,8 +278,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 
 	return 0;
 
-out_free_cpufreq_table:
-	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
 out_free_priv:
 	kfree(priv);
 out_free_opp:
@@ -295,7 +295,6 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 	struct private_data *priv = policy->driver_data;
 
 	cpufreq_cooling_unregister(priv->cdev);
-	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
 	if (priv->reg_name)
 		dev_pm_opp_put_regulator(priv->cpu_dev);
diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
index a284bddfb067..6c6090492889 100644
--- a/drivers/cpufreq/e_powersaver.c
+++ b/drivers/cpufreq/e_powersaver.c
@@ -38,7 +38,6 @@ struct eps_cpu_data {
 #if IS_ENABLED(CONFIG_ACPI_PROCESSOR)
 	u32 bios_limit;
 #endif
-	struct cpufreq_frequency_table freq_table[];
 };
 
 static struct eps_cpu_data *eps_cpu[NR_CPUS];
@@ -324,11 +323,17 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
 		states = 2;
 
 	/* Allocate private data and frequency table for current cpu */
-	centaur = kzalloc(sizeof(*centaur)
-		    + (states + 1) * sizeof(struct cpufreq_frequency_table),
-		    GFP_KERNEL);
+	centaur = kzalloc(sizeof(*centaur), GFP_KERNEL);
 	if (!centaur)
 		return -ENOMEM;
+
+	f_table = kzalloc((states + 1) * sizeof(struct cpufreq_frequency_table),
+			  GFP_KERNEL);
+	if (!f_table) {
+		kfree(centaur);
+		return -ENOMEM;
+	}
+
 	eps_cpu[0] = centaur;
 
 	/* Copy basic values */
@@ -338,7 +343,6 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
 #endif
 
 	/* Fill frequency and MSR value table */
-	f_table = &centaur->freq_table[0];
 	if (brand != EPS_BRAND_C7M) {
 		f_table[0].frequency = fsb * min_multiplier;
 		f_table[0].driver_data = (min_multiplier << 8) | min_voltage;
@@ -360,13 +364,13 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
 
 	policy->cpuinfo.transition_latency = 140000; /* 844mV -> 700mV in ns */
 
-	ret = cpufreq_table_validate_and_show(policy, &centaur->freq_table[0]);
-	if (ret) {
+	ret = cpufreq_table_validate_and_show(policy, f_table);
+	if (ret)
 		kfree(centaur);
-		return ret;
-	}
 
-	return 0;
+	kfree(f_table);
+
+	return ret;
 }
 
 static int eps_cpu_exit(struct cpufreq_policy *policy)
diff --git a/drivers/cpufreq/ia64-acpi-cpufreq.c b/drivers/cpufreq/ia64-acpi-cpufreq.c
index cc8bb1e5ac50..10e3bfac84d5 100644
--- a/drivers/cpufreq/ia64-acpi-cpufreq.c
+++ b/drivers/cpufreq/ia64-acpi-cpufreq.c
@@ -292,8 +292,10 @@ acpi_cpufreq_cpu_init (
 	}
 
 	result = cpufreq_table_validate_and_show(policy, freq_table);
+	kfree(freq_table);
+
 	if (result) {
-		goto err_freqfree;
+		goto err_unreg;
 	}
 
 	/* notify BIOS that we exist */
@@ -317,8 +319,6 @@ acpi_cpufreq_cpu_init (
 
 	return (result);
 
- err_freqfree:
-	kfree(freq_table);
  err_unreg:
 	acpi_processor_unregister_performance(cpu);
  err_free:
@@ -340,7 +340,6 @@ acpi_cpufreq_cpu_exit (
 	if (data) {
 		acpi_io_data[policy->cpu] = NULL;
 		acpi_processor_unregister_performance(policy->cpu);
-		kfree(policy->freq_table);
 		kfree(data);
 	}
 
diff --git a/drivers/cpufreq/loongson1-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
index be89416e2358..2d35d3cc2ad8 100644
--- a/drivers/cpufreq/loongson1-cpufreq.c
+++ b/drivers/cpufreq/loongson1-cpufreq.c
@@ -103,18 +103,11 @@ static int ls1x_cpufreq_init(struct cpufreq_policy *policy)
 
 	policy->clk = cpufreq->clk;
 	ret = cpufreq_generic_init(policy, freq_tbl, 0);
-	if (ret)
-		kfree(freq_tbl);
+	kfree(freq_tbl);
 
 	return ret;
 }
 
-static int ls1x_cpufreq_exit(struct cpufreq_policy *policy)
-{
-	kfree(policy->freq_table);
-	return 0;
-}
-
 static struct cpufreq_driver ls1x_cpufreq_driver = {
 	.name		= "cpufreq-ls1x",
 	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
@@ -122,7 +115,6 @@ static struct cpufreq_driver ls1x_cpufreq_driver = {
 	.target_index	= ls1x_cpufreq_target,
 	.get		= cpufreq_generic_get,
 	.init		= ls1x_cpufreq_init,
-	.exit		= ls1x_cpufreq_exit,
 	.attr		= cpufreq_generic_attr,
 };
 
-- 
2.7.1.410.g6faf27b
