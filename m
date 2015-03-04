From: "pi-cheng.chen" <pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 1/4] cpufreq-dt: add clock domain and intermediate frequency support
Date: Wed,  4 Mar 2015 16:49:13 +0800
Message-ID: <1425458956-20665-2-git-send-email-pi-cheng.chen@linaro.org>
References: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425458956-20665-1-git-send-email-pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "pi-cheng.chen" <pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Joe.C" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Howard Chen <ibanezchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ashwin Chaugule <ashwin.chaugule-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, fan.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

In this patch, CPU clock/power domain information is added into the 
platform_data of cpufreq-dt so that cpufreq-dt driver could check with CPUs
share clock/power. Also, intermediate frequency support is added in this
version. Since the program flows of .target_index and .target_intermediate
are quite similar, consolidate the flow as a new function to keep readibility.

Signed-off-by: pi-cheng.chen <pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/cpufreq/cpufreq-dt.c | 68 +++++++++++++++++++++++++++++++++++++++-----
 include/linux/cpufreq-dt.h   |  7 +++++
 2 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index bab67db..5948bdf 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -34,25 +34,37 @@ struct private_data {
 	struct regulator *cpu_reg;
 	struct thermal_cooling_device *cdev;
 	unsigned int voltage_tolerance; /* in percentage */
+	unsigned long intermediate_freq;
 };
 
-static int set_target(struct cpufreq_policy *policy, unsigned int index)
+static unsigned int get_intermediate(struct cpufreq_policy *policy,
+				     unsigned int index)
+{
+	struct private_data *priv = policy->driver_data;
+	struct cpufreq_frequency_table *freq_table;
+	unsigned long freq = clk_get_rate(policy->clk);
+
+	freq_table = cpufreq_frequency_get_table(policy->cpu);
+
+	if (freq == priv->intermediate_freq ||
+	    freq_table[index].frequency * 1000 == freq)
+		return 0;
+
+	return priv->intermediate_freq;
+}
+
+static int set_frequency(struct cpufreq_policy *policy, long freq_Hz)
 {
 	struct dev_pm_opp *opp;
-	struct cpufreq_frequency_table *freq_table = policy->freq_table;
 	struct clk *cpu_clk = policy->clk;
 	struct private_data *priv = policy->driver_data;
 	struct device *cpu_dev = priv->cpu_dev;
 	struct regulator *cpu_reg = priv->cpu_reg;
 	unsigned long volt = 0, volt_old = 0, tol = 0;
 	unsigned int old_freq, new_freq;
-	long freq_Hz, freq_exact;
+	long freq_exact;
 	int ret;
 
-	freq_Hz = clk_round_rate(cpu_clk, freq_table[index].frequency * 1000);
-	if (freq_Hz <= 0)
-		freq_Hz = freq_table[index].frequency * 1000;
-
 	freq_exact = freq_Hz;
 	new_freq = freq_Hz / 1000;
 	old_freq = clk_get_rate(cpu_clk) / 1000;
@@ -112,6 +124,29 @@ static int set_target(struct cpufreq_policy *policy, unsigned int index)
 	return ret;
 }
 
+static int target_intermediate(struct cpufreq_policy *policy,
+			       unsigned int index)
+{
+	struct private_data *priv = policy->driver_data;
+	long freq_Hz;
+
+	freq_Hz = priv->intermediate_freq;
+	return set_frequency(policy, freq_Hz);
+}
+
+static int set_target(struct cpufreq_policy *policy, unsigned int index)
+{
+	struct cpufreq_frequency_table *freq_table = policy->freq_table;
+	struct clk *cpu_clk = policy->clk;
+	long freq_Hz;
+
+	freq_Hz = clk_round_rate(cpu_clk, freq_table[index].frequency * 1000);
+	if (freq_Hz <= 0)
+		freq_Hz = freq_table[index].frequency * 1000;
+
+	return set_frequency(policy, freq_Hz);
+}
+
 static int allocate_resources(int cpu, struct device **cdev,
 			      struct regulator **creg, struct clk **cclk)
 {
@@ -296,6 +331,23 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	pd = cpufreq_get_driver_data();
 	if (!pd || !pd->independent_clocks)
 		cpumask_setall(policy->cpus);
+	else if (pd && !list_empty(&pd->domain_list)) {
+		struct list_head *domain_node;
+		struct cpufreq_cpu_domain *domain;
+
+		list_for_each(domain_node, &pd->domain_list) {
+			domain = container_of(domain_node,
+					      struct cpufreq_cpu_domain, node);
+			if (!cpumask_test_cpu(policy->cpu, &domain->cpus))
+				continue;
+
+			if (domain->intermediate_freq)
+				priv->intermediate_freq =
+						domain->intermediate_freq;
+			cpumask_copy(policy->cpus, &domain->cpus);
+			break;
+		}
+	}
 
 	of_node_put(np);
 
@@ -363,6 +415,8 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = set_target,
 	.get = cpufreq_generic_get,
+	.get_intermediate = get_intermediate,
+	.target_intermediate = target_intermediate,
 	.init = cpufreq_init,
 	.exit = cpufreq_exit,
 	.ready = cpufreq_ready,
diff --git a/include/linux/cpufreq-dt.h b/include/linux/cpufreq-dt.h
index 0414009..d6e2097 100644
--- a/include/linux/cpufreq-dt.h
+++ b/include/linux/cpufreq-dt.h
@@ -10,6 +10,12 @@
 #ifndef __CPUFREQ_DT_H__
 #define __CPUFREQ_DT_H__
 
+struct cpufreq_cpu_domain {
+	struct list_head node;
+	cpumask_t cpus;
+	unsigned long intermediate_freq;
+};
+
 struct cpufreq_dt_platform_data {
 	/*
 	 * True when each CPU has its own clock to control its
@@ -17,6 +23,7 @@ struct cpufreq_dt_platform_data {
 	 * clock.
 	 */
 	bool independent_clocks;
+	struct list_head domain_list;
 };
 
 #endif /* __CPUFREQ_DT_H__ */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
