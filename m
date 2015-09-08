From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 2/9] cpufreq: conservative: remove 'enable' field
Date: Tue,  8 Sep 2015 07:10:34 +0530
Message-ID: <793d7010e80e627a6ff007440f039652f81ca067.1441676358.git.viresh.kumar@linaro.org>
References: <2910194.KRcaApdNFO@vostro.rjw.lan>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2910194.KRcaApdNFO@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Conservative governor has its own 'enable' field to check if
conservative governor is used for a CPU or not

This can be checked by policy->governor with 'cpufreq_gov_conservative'
and so this field can be dropped.

Because its not guaranteed that dbs_info->cdbs.shared will a valid
pointer for all CPUs (will be NULL for CPUs that don't use
ondemand/conservative governors), we can't use it anymore. Lets get
policy with cpufreq_cpu_get_raw() instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Updates: use cpufreq_cpu_get_raw() instead of cpufreq_cpu_get().

 drivers/cpufreq/cpufreq.c              |  3 ++-
 drivers/cpufreq/cpufreq_conservative.c | 31 ++++++++++++++++++-------------
 drivers/cpufreq/cpufreq_governor.c     | 12 +-----------
 drivers/cpufreq/cpufreq_governor.h     |  2 +-
 4 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 82428099c569..2a0c2a26df11 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -239,12 +239,13 @@ int cpufreq_generic_init(struct cpufreq_policy *policy,
 EXPORT_SYMBOL_GPL(cpufreq_generic_init);
 
 /* Only for cpufreq core internal use */
-static struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
+struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
 
 	return policy && cpumask_test_cpu(cpu, policy->cpus) ? policy : NULL;
 }
+EXPORT_SYMBOL_GPL(cpufreq_cpu_get_raw);
 
 unsigned int cpufreq_generic_get(unsigned int cpu)
 {
diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 84a1506950a7..1fa1deb6e91f 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -23,6 +23,19 @@
 
 static DEFINE_PER_CPU(struct cs_cpu_dbs_info_s, cs_cpu_dbs_info);
 
+static int cs_cpufreq_governor_dbs(struct cpufreq_policy *policy,
+				   unsigned int event);
+
+#ifndef CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
+static
+#endif
+struct cpufreq_governor cpufreq_gov_conservative = {
+	.name			= "conservative",
+	.governor		= cs_cpufreq_governor_dbs,
+	.max_transition_latency	= TRANSITION_LATENCY_LIMIT,
+	.owner			= THIS_MODULE,
+};
+
 static inline unsigned int get_freq_target(struct cs_dbs_tuners *cs_tuners,
 					   struct cpufreq_policy *policy)
 {
@@ -119,12 +132,14 @@ static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
 	struct cpufreq_freqs *freq = data;
 	struct cs_cpu_dbs_info_s *dbs_info =
 					&per_cpu(cs_cpu_dbs_info, freq->cpu);
-	struct cpufreq_policy *policy;
+	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(freq->cpu);
 
-	if (!dbs_info->enable)
+	if (!policy)
 		return 0;
 
-	policy = dbs_info->cdbs.shared->policy;
+	/* policy isn't governed by conservative governor */
+	if (policy->governor != &cpufreq_gov_conservative)
+		return 0;
 
 	/*
 	 * we only care if our internally tracked freq moves outside the 'valid'
@@ -367,16 +382,6 @@ static int cs_cpufreq_governor_dbs(struct cpufreq_policy *policy,
 	return cpufreq_governor_dbs(policy, &cs_dbs_cdata, event);
 }
 
-#ifndef CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
-static
-#endif
-struct cpufreq_governor cpufreq_gov_conservative = {
-	.name			= "conservative",
-	.governor		= cs_cpufreq_governor_dbs,
-	.max_transition_latency	= TRANSITION_LATENCY_LIMIT,
-	.owner			= THIS_MODULE,
-};
-
 static int __init cpufreq_gov_dbs_init(void)
 {
 	return cpufreq_register_governor(&cpufreq_gov_conservative);
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 939197ffa4ac..750626d8fb03 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -463,7 +463,6 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 			cdata->get_cpu_dbs_info_s(cpu);
 
 		cs_dbs_info->down_skip = 0;
-		cs_dbs_info->enable = 1;
 		cs_dbs_info->requested_freq = policy->cur;
 	} else {
 		struct od_ops *od_ops = cdata->gov_ops;
@@ -482,9 +481,7 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 static int cpufreq_governor_stop(struct cpufreq_policy *policy,
 				 struct dbs_data *dbs_data)
 {
-	struct common_dbs_data *cdata = dbs_data->cdata;
-	unsigned int cpu = policy->cpu;
-	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
+	struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(policy->cpu);
 	struct cpu_common_dbs_info *shared = cdbs->shared;
 
 	/* State should be equivalent to START */
@@ -493,13 +490,6 @@ static int cpufreq_governor_stop(struct cpufreq_policy *policy,
 
 	gov_cancel_work(dbs_data, policy);
 
-	if (cdata->governor == GOV_CONSERVATIVE) {
-		struct cs_cpu_dbs_info_s *cs_dbs_info =
-			cdata->get_cpu_dbs_info_s(cpu);
-
-		cs_dbs_info->enable = 0;
-	}
-
 	shared->policy = NULL;
 	mutex_destroy(&shared->timer_mutex);
 	return 0;
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 50f171796632..2ed3c07fea5e 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -170,7 +170,6 @@ struct cs_cpu_dbs_info_s {
 	struct cpu_dbs_info cdbs;
 	unsigned int down_skip;
 	unsigned int requested_freq;
-	unsigned int enable:1;
 };
 
 /* Per policy Governors sysfs tunables */
@@ -270,6 +269,7 @@ static ssize_t show_sampling_rate_min_gov_pol				\
 
 extern struct mutex cpufreq_governor_lock;
 
+struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu);
 void dbs_check_cpu(struct dbs_data *dbs_data, int cpu);
 int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 		struct common_dbs_data *cdata, unsigned int event);
-- 
2.4.0
