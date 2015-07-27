From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 2/9] cpufreq: conservative: remove 'enable' field
Date: Mon, 27 Jul 2015 17:58:07 +0530
Message-ID: <91abed4ff8fe68f26fe0bdc840982bb972dba6dc.1437999691.git.viresh.kumar@linaro.org>
References: <cover.1437999691.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437999691.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437999691.git.viresh.kumar@linaro.org>
References: <cover.1437999691.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, preeti.lkml@gmail.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Conservative governor has its own 'enable' field to check if
conservative governor is used for a CPU or not

This can be checked by policy->governor with 'cpufreq_gov_conservative'
and so this field can be dropped.

Because its not guaranteed that dbs_info->cdbs.shared will a valid
pointer for all CPUs (will be NULL for CPUs that don't use
ondemand/conservative governors), we can't use it anymore. Lets get
policy with cpufreq_cpu_get() instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 34 +++++++++++++++++++++-------------
 drivers/cpufreq/cpufreq_governor.c     | 12 +-----------
 drivers/cpufreq/cpufreq_governor.h     |  1 -
 3 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 84a1506950a7..18bfbc313e48 100644
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
+	struct cpufreq_policy *policy = cpufreq_cpu_get(freq->cpu);
 
-	if (!dbs_info->enable)
+	if (!policy)
 		return 0;
 
-	policy = dbs_info->cdbs.shared->policy;
+	/* policy isn't governed by conservative governor */
+	if (policy->governor != &cpufreq_gov_conservative)
+		goto policy_put;
 
 	/*
 	 * we only care if our internally tracked freq moves outside the 'valid'
@@ -134,6 +149,9 @@ static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
 			|| dbs_info->requested_freq < policy->min)
 		dbs_info->requested_freq = freq->new;
 
+policy_put:
+	cpufreq_cpu_put(policy);
+
 	return 0;
 }
 
@@ -367,16 +385,6 @@ static int cs_cpufreq_governor_dbs(struct cpufreq_policy *policy,
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
index 50f171796632..5621bb03e874 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -170,7 +170,6 @@ struct cs_cpu_dbs_info_s {
 	struct cpu_dbs_info cdbs;
 	unsigned int down_skip;
 	unsigned int requested_freq;
-	unsigned int enable:1;
 };
 
 /* Per policy Governors sysfs tunables */
-- 
2.4.0
