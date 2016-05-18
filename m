From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: Drop the 'initialized' field from struct cpufreq_governor
Date: Wed, 18 May 2016 22:59:49 +0200
Message-ID: <1835934.f0fzDcHWum@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60417 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752669AbcERU4S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2016 16:56:18 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The 'initialized' field in struct cpufreq_governor is only used by
the conservative governor (as a usage counter) and the way that
happens is far from straightforward and arguably incorrect.

Namely, the value of 'initialized' is checked by
cpufreq_dbs_governor_init() and cpufreq_dbs_governor_exit() and
the results of those checks are passed (as the second argument) to
the ->init() and ->exit() callbacks in struct dbs_governor.  Those
callbacks are only implemented by the ondemand and conservative
governors and ondemand doesn't use their second argument at all.
In turn, the conservative governor uses it to decide whether or not
to either register or unregister a transition notifier.

That whole mechanism is not only unnecessarily convoluted, but also
racy, because the 'initialized' field of struct cpufreq_governor is
updated in cpufreq_init_governor() and cpufreq_exit_governor() under
policy->rwsem which doesn't help if one of these functions is run
twice in parallel for different policies (which isn't impossible in
principle), for example.

Instead of it, add a proper usage counter to the conservative
governor and update it from cs_init() and cs_exit() which is
guaranteed to be non-racy, as those functions are only called
under gov_dbs_data_mutex which is global.

With that in place, drop the 'initialized' field from struct
cpufreq_governor as it is not used any more.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is on top of https://patchwork.kernel.org/patch/9094021/

---
 drivers/cpufreq/cpufreq.c              |    3 --
 drivers/cpufreq/cpufreq_conservative.c |   44 +++++++++++++++++++++------------
 drivers/cpufreq/cpufreq_governor.c     |    6 ++--
 drivers/cpufreq/cpufreq_governor.h     |    4 +--
 drivers/cpufreq/cpufreq_ondemand.c     |    4 +--
 include/linux/cpufreq.h                |    1 
 6 files changed, 36 insertions(+), 26 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2031,7 +2031,6 @@ static int cpufreq_init_governor(struct
 		}
 	}
 
-	policy->governor->initialized++;
 	return 0;
 }
 
@@ -2045,7 +2044,6 @@ static void cpufreq_exit_governor(struct
 	if (policy->governor->exit)
 		policy->governor->exit(policy);
 
-	policy->governor->initialized--;
 	module_put(policy->governor->owner);
 }
 
@@ -2110,7 +2108,6 @@ int cpufreq_register_governor(struct cpu
 
 	mutex_lock(&cpufreq_governor_mutex);
 
-	governor->initialized = 0;
 	err = -EBUSY;
 	if (!find_governor(governor->name)) {
 		err = 0;
Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
@@ -127,7 +127,6 @@ static struct notifier_block cs_cpufreq_
 };
 
 /************************** sysfs interface ************************/
-static struct dbs_governor cs_dbs_gov;
 
 static ssize_t store_sampling_down_factor(struct gov_attr_set *attr_set,
 					  const char *buf, size_t count)
@@ -255,6 +254,13 @@ static struct attribute *cs_attributes[]
 
 /************************** sysfs end ************************/
 
+struct cs_governor {
+	struct dbs_governor dbs_gov;
+	unsigned int usage_count;
+};
+
+static struct cs_governor cs_gov;
+
 static struct policy_dbs_info *cs_alloc(void)
 {
 	struct cs_policy_dbs_info *dbs_info;
@@ -268,7 +274,7 @@ static void cs_free(struct policy_dbs_in
 	kfree(to_dbs_info(policy_dbs));
 }
 
-static int cs_init(struct dbs_data *dbs_data, bool notify)
+static int cs_init(struct dbs_data *dbs_data)
 {
 	struct cs_dbs_tuners *tuners;
 
@@ -288,16 +294,22 @@ static int cs_init(struct dbs_data *dbs_
 	dbs_data->min_sampling_rate = MIN_SAMPLING_RATE_RATIO *
 		jiffies_to_usecs(10);
 
-	if (notify)
+	/*
+	 * This function and cs_exit() are only called under gov_dbs_data_mutex
+	 * which is global, so the cs_gov.usage_count accesses are guaranteed
+	 * to be serialized.
+	 */
+	if (!cs_gov.usage_count++)
 		cpufreq_register_notifier(&cs_cpufreq_notifier_block,
 					  CPUFREQ_TRANSITION_NOTIFIER);
 
 	return 0;
 }
 
-static void cs_exit(struct dbs_data *dbs_data, bool notify)
+static void cs_exit(struct dbs_data *dbs_data)
 {
-	if (notify)
+	/* Protected by gov_dbs_data_mutex - see the comment in cs_init(). */
+	if (!--cs_gov.usage_count)
 		cpufreq_unregister_notifier(&cs_cpufreq_notifier_block,
 					    CPUFREQ_TRANSITION_NOTIFIER);
 
@@ -312,18 +324,20 @@ static void cs_start(struct cpufreq_poli
 	dbs_info->requested_freq = policy->cur;
 }
 
-static struct dbs_governor cs_dbs_gov = {
-	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
-	.kobj_type = { .default_attrs = cs_attributes },
-	.gov_dbs_timer = cs_dbs_timer,
-	.alloc = cs_alloc,
-	.free = cs_free,
-	.init = cs_init,
-	.exit = cs_exit,
-	.start = cs_start,
+static struct cs_governor cs_gov = {
+	.dbs_gov = {
+		.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
+		.kobj_type = { .default_attrs = cs_attributes },
+		.gov_dbs_timer = cs_dbs_timer,
+		.alloc = cs_alloc,
+		.free = cs_free,
+		.init = cs_init,
+		.exit = cs_exit,
+		.start = cs_start,
+	},
 };
 
-#define CPU_FREQ_GOV_CONSERVATIVE	(&cs_dbs_gov.gov)
+#define CPU_FREQ_GOV_CONSERVATIVE	(&cs_gov.dbs_gov.gov)
 
 static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
 				void *data)
Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -429,7 +429,7 @@ int cpufreq_dbs_governor_init(struct cpu
 
 	gov_attr_set_init(&dbs_data->attr_set, &policy_dbs->list);
 
-	ret = gov->init(dbs_data, !policy->governor->initialized);
+	ret = gov->init(dbs_data);
 	if (ret)
 		goto free_policy_dbs_info;
 
@@ -464,7 +464,7 @@ int cpufreq_dbs_governor_init(struct cpu
 
 	if (!have_governor_per_policy())
 		gov->gdbs_data = NULL;
-	gov->exit(dbs_data, !policy->governor->initialized);
+	gov->exit(dbs_data);
 	kfree(dbs_data);
 
 free_policy_dbs_info:
@@ -494,7 +494,7 @@ void cpufreq_dbs_governor_exit(struct cp
 		if (!have_governor_per_policy())
 			gov->gdbs_data = NULL;
 
-		gov->exit(dbs_data, policy->governor->initialized == 1);
+		gov->exit(dbs_data);
 		kfree(dbs_data);
 	}
 
Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -138,8 +138,8 @@ struct dbs_governor {
 	unsigned int (*gov_dbs_timer)(struct cpufreq_policy *policy);
 	struct policy_dbs_info *(*alloc)(void);
 	void (*free)(struct policy_dbs_info *policy_dbs);
-	int (*init)(struct dbs_data *dbs_data, bool notify);
-	void (*exit)(struct dbs_data *dbs_data, bool notify);
+	int (*init)(struct dbs_data *dbs_data);
+	void (*exit)(struct dbs_data *dbs_data);
 	void (*start)(struct cpufreq_policy *policy);
 };
 
Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -361,7 +361,7 @@ static void od_free(struct policy_dbs_in
 	kfree(to_dbs_info(policy_dbs));
 }
 
-static int od_init(struct dbs_data *dbs_data, bool notify)
+static int od_init(struct dbs_data *dbs_data)
 {
 	struct od_dbs_tuners *tuners;
 	u64 idle_time;
@@ -402,7 +402,7 @@ static int od_init(struct dbs_data *dbs_
 	return 0;
 }
 
-static void od_exit(struct dbs_data *dbs_data, bool notify)
+static void od_exit(struct dbs_data *dbs_data)
 {
 	kfree(dbs_data->tuners);
 }
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -457,7 +457,6 @@ static inline unsigned long cpufreq_scal
 
 struct cpufreq_governor {
 	char	name[CPUFREQ_NAME_LEN];
-	int	initialized;
 	int	(*init)(struct cpufreq_policy *policy);
 	void	(*exit)(struct cpufreq_policy *policy);
 	int	(*start)(struct cpufreq_policy *policy);

