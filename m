From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: conservative: Do not use transition notifications
Date: Fri, 10 Jun 2016 03:00:37 +0200
Message-ID: <2899343.d3UcWvo4TA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54647 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751315AbcFJA4g (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2016 20:56:36 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The conservative governor registers a transition notifier so it
can update its internal requested_freq value if it falls out of the
policy->min...policy->max range, but that's not the most
straightforward way to achieve that.

To do it in a more straightforward way, first make sure that
cs_dbs_timer() will only set frequencies between min and max.

With that, note that requested_freq will always fall between min
and max unless either policy->min or policy->max changes and the
governor's ->limits() callback will be invoked then.

Using this observation, add a ->limits callback pointer to
struct dbs_governor, make cpufreq_dbs_governor_limits() invoke
that callback if present, implement that callback in the conservative
governor to update requested_freq if needed and drop the transition
notifier from it, which also makes it possible to drop the
struct cs_governor definition from there and simplify the code
accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_conservative.c |   85 +++++++--------------------------
 drivers/cpufreq/cpufreq_governor.c     |    4 +
 drivers/cpufreq/cpufreq_governor.h     |    1 
 3 files changed, 25 insertions(+), 65 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
@@ -106,7 +106,8 @@ static unsigned int cs_dbs_timer(struct
 			goto out;
 
 		freq_target = get_freq_target(cs_tuners, policy);
-		if (dbs_info->requested_freq > freq_target)
+		if (dbs_info->requested_freq > freq_target
+		    && dbs_info->requested_freq - freq_target > policy->min)
 			dbs_info->requested_freq -= freq_target;
 		else
 			dbs_info->requested_freq = policy->min;
@@ -119,13 +120,6 @@ static unsigned int cs_dbs_timer(struct
 	return dbs_data->sampling_rate;
 }
 
-static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
-				void *data);
-
-static struct notifier_block cs_cpufreq_notifier_block = {
-	.notifier_call = dbs_cpufreq_notifier,
-};
-
 /************************** sysfs interface ************************/
 
 static ssize_t store_sampling_down_factor(struct gov_attr_set *attr_set,
@@ -254,13 +248,6 @@ static struct attribute *cs_attributes[]
 
 /************************** sysfs end ************************/
 
-struct cs_governor {
-	struct dbs_governor dbs_gov;
-	unsigned int usage_count;
-};
-
-static struct cs_governor cs_gov;
-
 static struct policy_dbs_info *cs_alloc(void)
 {
 	struct cs_policy_dbs_info *dbs_info;
@@ -294,25 +281,11 @@ static int cs_init(struct dbs_data *dbs_
 	dbs_data->min_sampling_rate = MIN_SAMPLING_RATE_RATIO *
 		jiffies_to_usecs(10);
 
-	/*
-	 * This function and cs_exit() are only called under gov_dbs_data_mutex
-	 * which is global, so the cs_gov.usage_count accesses are guaranteed
-	 * to be serialized.
-	 */
-	if (!cs_gov.usage_count++)
-		cpufreq_register_notifier(&cs_cpufreq_notifier_block,
-					  CPUFREQ_TRANSITION_NOTIFIER);
-
 	return 0;
 }
 
 static void cs_exit(struct dbs_data *dbs_data)
 {
-	/* Protected by gov_dbs_data_mutex - see the comment in cs_init(). */
-	if (!--cs_gov.usage_count)
-		cpufreq_unregister_notifier(&cs_cpufreq_notifier_block,
-					    CPUFREQ_TRANSITION_NOTIFIER);
-
 	kfree(dbs_data->tuners);
 }
 
@@ -324,47 +297,29 @@ static void cs_start(struct cpufreq_poli
 	dbs_info->requested_freq = policy->cur;
 }
 
-static struct cs_governor cs_gov = {
-	.dbs_gov = {
-		.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
-		.kobj_type = { .default_attrs = cs_attributes },
-		.gov_dbs_timer = cs_dbs_timer,
-		.alloc = cs_alloc,
-		.free = cs_free,
-		.init = cs_init,
-		.exit = cs_exit,
-		.start = cs_start,
-	},
-};
-
-#define CPU_FREQ_GOV_CONSERVATIVE	(&cs_gov.dbs_gov.gov)
-
-static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
-				void *data)
+static void cs_limits(struct cpufreq_policy *policy)
 {
-	struct cpufreq_freqs *freq = data;
-	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(freq->cpu);
-	struct cs_policy_dbs_info *dbs_info;
-
-	if (!policy)
-		return 0;
-
-	/* policy isn't governed by conservative governor */
-	if (policy->governor != CPU_FREQ_GOV_CONSERVATIVE)
-		return 0;
+	struct cs_policy_dbs_info *dbs_info = to_dbs_info(policy->governor_data);
 
-	dbs_info = to_dbs_info(policy->governor_data);
-	/*
-	 * we only care if our internally tracked freq moves outside the 'valid'
-	 * ranges of frequency available to us otherwise we do not change it
-	*/
 	if (dbs_info->requested_freq > policy->max
-			|| dbs_info->requested_freq < policy->min)
-		dbs_info->requested_freq = freq->new;
-
-	return 0;
+	    || dbs_info->requested_freq < policy->min)
+		dbs_info->requested_freq = policy->cur;
 }
 
+static struct dbs_governor cs_governor = {
+	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
+	.kobj_type = { .default_attrs = cs_attributes },
+	.gov_dbs_timer = cs_dbs_timer,
+	.alloc = cs_alloc,
+	.free = cs_free,
+	.init = cs_init,
+	.exit = cs_exit,
+	.start = cs_start,
+	.limits = cs_limits,
+};
+
+#define CPU_FREQ_GOV_CONSERVATIVE	(&cs_governor.gov)
+
 static int __init cpufreq_gov_dbs_init(void)
 {
 	return cpufreq_register_governor(CPU_FREQ_GOV_CONSERVATIVE);
Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -545,6 +545,7 @@ EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_s
 
 void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
 {
+	struct dbs_governor *gov = dbs_governor_of(policy);
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 
 	mutex_lock(&policy_dbs->timer_mutex);
@@ -554,6 +555,9 @@ void cpufreq_dbs_governor_limits(struct
 	else if (policy->min > policy->cur)
 		__cpufreq_driver_target(policy, policy->min, CPUFREQ_RELATION_L);
 
+	if (gov->limits)
+		gov->limits(policy);
+
 	gov_update_sample_delay(policy_dbs, 0);
 
 	mutex_unlock(&policy_dbs->timer_mutex);
Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -141,6 +141,7 @@ struct dbs_governor {
 	int (*init)(struct dbs_data *dbs_data);
 	void (*exit)(struct dbs_data *dbs_data);
 	void (*start)(struct cpufreq_policy *policy);
+	void (*limits)(struct cpufreq_policy *policy);
 };
 
 static inline struct dbs_governor *dbs_governor_of(struct cpufreq_policy *policy)

