From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 4/10] cpufreq: governor: Put governor structure into common_dbs_data
Date: Fri, 05 Feb 2016 03:16:08 +0100
Message-ID: <6890353.1AtO67aiJ6@vostro.rjw.lan>
References: <3705929.bslqXH980s@vostro.rjw.lan> <9008098.QDD8C89zDx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9008098.QDD8C89zDx@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

For the ondemand and conservative governors (generally, governors
that use the common code in cpufreq_governor.c), there are two static
data structures representing the governor, the struct governor
structure (the interface to the cpufreq core) and the struct
common_dbs_data one (the interface to the cpufreq_governor.c code).

There's no fundamental reason why those two structures have to be
separate.  Moreover, if the struct governor one is included into
struct common_dbs_data, it will be possible to reach the latter from
the policy via its policy->governor pointer, so it won't be necessary
to pass a separate pointer to it around.  For this reason, embed
struct governor in struct common_dbs_data.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Saravana Kannan <skannan@codeaurora.org>
---
 drivers/cpufreq/cpufreq_conservative.c |   78 +++++++++++++++++----------------
 drivers/cpufreq/cpufreq_governor.h     |    3 -
 drivers/cpufreq/cpufreq_ondemand.c     |   28 ++++++-----
 3 files changed, 58 insertions(+), 51 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -31,8 +31,6 @@ static DEFINE_PER_CPU(struct od_cpu_dbs_
 
 static struct od_ops od_ops;
 
-static struct cpufreq_governor cpufreq_gov_ondemand;
-
 static unsigned int default_powersave_bias;
 
 static void ondemand_powersave_bias_init_cpu(int cpu)
@@ -537,7 +535,16 @@ static struct od_ops od_ops = {
 	.freq_increase = dbs_freq_increase,
 };
 
+static int od_cpufreq_governor_dbs(struct cpufreq_policy *policy,
+				   unsigned int event);
+
 static struct common_dbs_data od_dbs_cdata = {
+	.gov = {
+		.name = "ondemand",
+		.governor = od_cpufreq_governor_dbs,
+		.max_transition_latency	= TRANSITION_LATENCY_LIMIT,
+		.owner = THIS_MODULE,
+	},
 	.governor = GOV_ONDEMAND,
 	.attr_group_gov_sys = &od_attr_group_gov_sys,
 	.attr_group_gov_pol = &od_attr_group_gov_pol,
@@ -550,19 +557,14 @@ static struct common_dbs_data od_dbs_cda
 	.exit = od_exit,
 };
 
+#define CPU_FREQ_GOV_ONDEMAND	(&od_dbs_cdata.gov)
+
 static int od_cpufreq_governor_dbs(struct cpufreq_policy *policy,
 		unsigned int event)
 {
 	return cpufreq_governor_dbs(policy, &od_dbs_cdata, event);
 }
 
-static struct cpufreq_governor cpufreq_gov_ondemand = {
-	.name			= "ondemand",
-	.governor		= od_cpufreq_governor_dbs,
-	.max_transition_latency	= TRANSITION_LATENCY_LIMIT,
-	.owner			= THIS_MODULE,
-};
-
 static void od_set_powersave_bias(unsigned int powersave_bias)
 {
 	struct cpufreq_policy *policy;
@@ -588,7 +590,7 @@ static void od_set_powersave_bias(unsign
 		policy = shared->policy;
 		cpumask_or(&done, &done, policy->cpus);
 
-		if (policy->governor != &cpufreq_gov_ondemand)
+		if (policy->governor != CPU_FREQ_GOV_ONDEMAND)
 			continue;
 
 		dbs_data = policy->governor_data;
@@ -616,12 +618,12 @@ EXPORT_SYMBOL_GPL(od_unregister_powersav
 
 static int __init cpufreq_gov_dbs_init(void)
 {
-	return cpufreq_register_governor(&cpufreq_gov_ondemand);
+	return cpufreq_register_governor(CPU_FREQ_GOV_ONDEMAND);
 }
 
 static void __exit cpufreq_gov_dbs_exit(void)
 {
-	cpufreq_unregister_governor(&cpufreq_gov_ondemand);
+	cpufreq_unregister_governor(CPU_FREQ_GOV_ONDEMAND);
 }
 
 MODULE_AUTHOR("Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>");
@@ -633,7 +635,7 @@ MODULE_LICENSE("GPL");
 #ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
 struct cpufreq_governor *cpufreq_default_governor(void)
 {
-	return &cpufreq_gov_ondemand;
+	return CPU_FREQ_GOV_ONDEMAND;
 }
 
 fs_initcall(cpufreq_gov_dbs_init);
Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
@@ -23,16 +23,6 @@
 
 static DEFINE_PER_CPU(struct cs_cpu_dbs_info_s, cs_cpu_dbs_info);
 
-static int cs_cpufreq_governor_dbs(struct cpufreq_policy *policy,
-				   unsigned int event);
-
-static struct cpufreq_governor cpufreq_gov_conservative = {
-	.name			= "conservative",
-	.governor		= cs_cpufreq_governor_dbs,
-	.max_transition_latency	= TRANSITION_LATENCY_LIMIT,
-	.owner			= THIS_MODULE,
-};
-
 static inline unsigned int get_freq_target(struct cs_dbs_tuners *cs_tuners,
 					   struct cpufreq_policy *policy)
 {
@@ -122,30 +112,7 @@ static unsigned int cs_dbs_timer(struct
 }
 
 static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
-		void *data)
-{
-	struct cpufreq_freqs *freq = data;
-	struct cs_cpu_dbs_info_s *dbs_info =
-					&per_cpu(cs_cpu_dbs_info, freq->cpu);
-	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(freq->cpu);
-
-	if (!policy)
-		return 0;
-
-	/* policy isn't governed by conservative governor */
-	if (policy->governor != &cpufreq_gov_conservative)
-		return 0;
-
-	/*
-	 * we only care if our internally tracked freq moves outside the 'valid'
-	 * ranges of frequency available to us otherwise we do not change it
-	*/
-	if (dbs_info->requested_freq > policy->max
-			|| dbs_info->requested_freq < policy->min)
-		dbs_info->requested_freq = freq->new;
-
-	return 0;
-}
+				void *data);
 
 static struct notifier_block cs_cpufreq_notifier_block = {
 	.notifier_call = dbs_cpufreq_notifier,
@@ -358,7 +325,16 @@ static void cs_exit(struct dbs_data *dbs
 
 define_get_cpu_dbs_routines(cs_cpu_dbs_info);
 
+static int cs_cpufreq_governor_dbs(struct cpufreq_policy *policy,
+				   unsigned int event);
+
 static struct common_dbs_data cs_dbs_cdata = {
+	.gov = {
+		.name = "conservative",
+		.governor = cs_cpufreq_governor_dbs,
+		.max_transition_latency = TRANSITION_LATENCY_LIMIT,
+		.owner = THIS_MODULE,
+	},
 	.governor = GOV_CONSERVATIVE,
 	.attr_group_gov_sys = &cs_attr_group_gov_sys,
 	.attr_group_gov_pol = &cs_attr_group_gov_pol,
@@ -370,20 +346,48 @@ static struct common_dbs_data cs_dbs_cda
 	.exit = cs_exit,
 };
 
+#define CPU_FREQ_GOV_CONSERVATIVE	(&cs_dbs_cdata.gov)
+
 static int cs_cpufreq_governor_dbs(struct cpufreq_policy *policy,
 				   unsigned int event)
 {
 	return cpufreq_governor_dbs(policy, &cs_dbs_cdata, event);
 }
 
+static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
+				void *data)
+{
+	struct cpufreq_freqs *freq = data;
+	struct cs_cpu_dbs_info_s *dbs_info =
+					&per_cpu(cs_cpu_dbs_info, freq->cpu);
+	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(freq->cpu);
+
+	if (!policy)
+		return 0;
+
+	/* policy isn't governed by conservative governor */
+	if (policy->governor != CPU_FREQ_GOV_CONSERVATIVE)
+		return 0;
+
+	/*
+	 * we only care if our internally tracked freq moves outside the 'valid'
+	 * ranges of frequency available to us otherwise we do not change it
+	*/
+	if (dbs_info->requested_freq > policy->max
+			|| dbs_info->requested_freq < policy->min)
+		dbs_info->requested_freq = freq->new;
+
+	return 0;
+}
+
 static int __init cpufreq_gov_dbs_init(void)
 {
-	return cpufreq_register_governor(&cpufreq_gov_conservative);
+	return cpufreq_register_governor(CPU_FREQ_GOV_CONSERVATIVE);
 }
 
 static void __exit cpufreq_gov_dbs_exit(void)
 {
-	cpufreq_unregister_governor(&cpufreq_gov_conservative);
+	cpufreq_unregister_governor(CPU_FREQ_GOV_CONSERVATIVE);
 }
 
 MODULE_AUTHOR("Alexander Clouter <alex@digriz.org.uk>");
@@ -395,7 +399,7 @@ MODULE_LICENSE("GPL");
 #ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
 struct cpufreq_governor *cpufreq_default_governor(void)
 {
-	return &cpufreq_gov_conservative;
+	return CPU_FREQ_GOV_CONSERVATIVE;
 }
 
 fs_initcall(cpufreq_gov_dbs_init);
Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -203,7 +203,8 @@ struct cs_dbs_tuners {
 /* Common Governor data across policies */
 struct dbs_data;
 struct common_dbs_data {
-	/* Common across governors */
+	struct cpufreq_governor gov;
+
 	#define GOV_ONDEMAND		0
 	#define GOV_CONSERVATIVE	1
 	int governor;
