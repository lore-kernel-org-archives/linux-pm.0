From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 5/5] cpufreq: governor: Get rid of governor events
Date: Sat, 14 May 2016 01:02:21 +0200
Message-ID: <2126576.ycyxhAHC04@vostro.rjw.lan>
References: <10707470.yIcqGAzuFY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53675 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751201AbcEMW7G (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 May 2016 18:59:06 -0400
In-Reply-To: <10707470.yIcqGAzuFY@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The design of the cpufreq governor API is not very straightforward,
as struct cpufreq_governor provides only one callback to be invoked
from different code paths for different purposes.  The purpose it is
invoked for is determined by its second "event" argument, causing it
to act as a "callback multiplexer" of sorts.

Unfortunately, that leads to extra complexity in governors, some of
which implement the ->governor() callback as a switch statement
that simply checks the event argument and invokes a separate function
to handle that specific event.

That extra complexity can be eliminated by replacing the all-purpose
->governor() callback with a family of callbacks to carry out specific
governor operations: initialization and exit, start and stop and policy
limits updates.  That also turns out to reduce the code size too, so
do it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c              |   31 ++++++----
 drivers/cpufreq/cpufreq_conservative.c |    7 --
 drivers/cpufreq/cpufreq_governor.c     |   39 +++---------
 drivers/cpufreq/cpufreq_governor.h     |   20 ++++++
 drivers/cpufreq/cpufreq_ondemand.c     |    7 --
 drivers/cpufreq/cpufreq_performance.c  |   17 +----
 drivers/cpufreq/cpufreq_powersave.c    |   17 +----
 drivers/cpufreq/cpufreq_userspace.c    |  102 ++++++++++++++++-----------------
 include/linux/cpufreq.h                |   14 +---
 kernel/sched/cpufreq_schedutil.c       |   34 ++---------
 10 files changed, 123 insertions(+), 165 deletions(-)

Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -455,18 +455,14 @@ static inline unsigned long cpufreq_scal
 #define MIN_LATENCY_MULTIPLIER		(20)
 #define TRANSITION_LATENCY_LIMIT	(10 * 1000 * 1000)
 
-/* Governor Events */
-#define CPUFREQ_GOV_START	1
-#define CPUFREQ_GOV_STOP	2
-#define CPUFREQ_GOV_LIMITS	3
-#define CPUFREQ_GOV_POLICY_INIT	4
-#define CPUFREQ_GOV_POLICY_EXIT	5
-
 struct cpufreq_governor {
 	char	name[CPUFREQ_NAME_LEN];
 	int	initialized;
-	int	(*governor)	(struct cpufreq_policy *policy,
-				 unsigned int event);
+	int	(*init)(struct cpufreq_policy *policy);
+	void	(*exit)(struct cpufreq_policy *policy);
+	int	(*start)(struct cpufreq_policy *policy);
+	void	(*stop)(struct cpufreq_policy *policy);
+	void	(*limits)(struct cpufreq_policy *policy);
 	ssize_t	(*show_setspeed)	(struct cpufreq_policy *policy,
 					 char *buf);
 	int	(*store_setspeed)	(struct cpufreq_policy *policy,
Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -389,7 +389,7 @@ static void free_policy_dbs_info(struct
 	gov->free(policy_dbs);
 }
 
-static int cpufreq_governor_init(struct cpufreq_policy *policy)
+int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 {
 	struct dbs_governor *gov = dbs_governor_of(policy);
 	struct dbs_data *dbs_data;
@@ -474,8 +474,9 @@ out:
 	mutex_unlock(&gov_dbs_data_mutex);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_init);
 
-static int cpufreq_governor_exit(struct cpufreq_policy *policy)
+void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy)
 {
 	struct dbs_governor *gov = dbs_governor_of(policy);
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
@@ -500,10 +501,10 @@ static int cpufreq_governor_exit(struct
 	free_policy_dbs_info(policy_dbs, gov);
 
 	mutex_unlock(&gov_dbs_data_mutex);
-	return 0;
 }
+EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_exit);
 
-static int cpufreq_governor_start(struct cpufreq_policy *policy)
+int cpufreq_dbs_governor_start(struct cpufreq_policy *policy)
 {
 	struct dbs_governor *gov = dbs_governor_of(policy);
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
@@ -539,14 +540,15 @@ static int cpufreq_governor_start(struct
 	gov_set_update_util(policy_dbs, sampling_rate);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_start);
 
-static int cpufreq_governor_stop(struct cpufreq_policy *policy)
+void cpufreq_dbs_governor_stop(struct cpufreq_policy *policy)
 {
 	gov_cancel_work(policy);
-	return 0;
 }
+EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_stop);
 
-static int cpufreq_governor_limits(struct cpufreq_policy *policy)
+void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
 {
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 
@@ -560,26 +562,5 @@ static int cpufreq_governor_limits(struc
 	gov_update_sample_delay(policy_dbs, 0);
 
 	mutex_unlock(&policy_dbs->timer_mutex);
-
-	return 0;
-}
-
-int cpufreq_governor_dbs(struct cpufreq_policy *policy, unsigned int event)
-{
-	if (event == CPUFREQ_GOV_POLICY_INIT) {
-		return cpufreq_governor_init(policy);
-	} else if (policy->governor_data) {
-		switch (event) {
-		case CPUFREQ_GOV_POLICY_EXIT:
-			return cpufreq_governor_exit(policy);
-		case CPUFREQ_GOV_START:
-			return cpufreq_governor_start(policy);
-		case CPUFREQ_GOV_STOP:
-			return cpufreq_governor_stop(policy);
-		case CPUFREQ_GOV_LIMITS:
-			return cpufreq_governor_limits(policy);
-		}
-	}
-	return -EINVAL;
 }
-EXPORT_SYMBOL_GPL(cpufreq_governor_dbs);
+EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_limits);
Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -148,6 +148,25 @@ static inline struct dbs_governor *dbs_g
 	return container_of(policy->governor, struct dbs_governor, gov);
 }
 
+/* Governor callback routines */
+int cpufreq_dbs_governor_init(struct cpufreq_policy *policy);
+void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy);
+int cpufreq_dbs_governor_start(struct cpufreq_policy *policy);
+void cpufreq_dbs_governor_stop(struct cpufreq_policy *policy);
+void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy);
+
+#define CPUFREQ_DBS_GOVERNOR_INITIALIZER(_name_)			\
+	{								\
+		.name = _name_,						\
+		.max_transition_latency	= TRANSITION_LATENCY_LIMIT,	\
+		.owner = THIS_MODULE,					\
+		.init = cpufreq_dbs_governor_init,			\
+		.exit = cpufreq_dbs_governor_exit,			\
+		.start = cpufreq_dbs_governor_start,			\
+		.stop = cpufreq_dbs_governor_stop,			\
+		.limits = cpufreq_dbs_governor_limits,			\
+	}
+
 /* Governor specific operations */
 struct od_ops {
 	unsigned int (*powersave_bias_target)(struct cpufreq_policy *policy,
@@ -155,7 +174,6 @@ struct od_ops {
 };
 
 unsigned int dbs_update(struct cpufreq_policy *policy);
-int cpufreq_governor_dbs(struct cpufreq_policy *policy, unsigned int event);
 void od_register_powersave_bias_handler(unsigned int (*f)
 		(struct cpufreq_policy *, unsigned int, unsigned int),
 		unsigned int powersave_bias);
Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -420,12 +420,7 @@ static struct od_ops od_ops = {
 };
 
 static struct dbs_governor od_dbs_gov = {
-	.gov = {
-		.name = "ondemand",
-		.governor = cpufreq_governor_dbs,
-		.max_transition_latency	= TRANSITION_LATENCY_LIMIT,
-		.owner = THIS_MODULE,
-	},
+	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
 	.kobj_type = { .default_attrs = od_attributes },
 	.gov_dbs_timer = od_dbs_timer,
 	.alloc = od_alloc,
Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
@@ -313,12 +313,7 @@ static void cs_start(struct cpufreq_poli
 }
 
 static struct dbs_governor cs_dbs_gov = {
-	.gov = {
-		.name = "conservative",
-		.governor = cpufreq_governor_dbs,
-		.max_transition_latency = TRANSITION_LATENCY_LIMIT,
-		.owner = THIS_MODULE,
-	},
+	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
 	.kobj_type = { .default_attrs = cs_attributes },
 	.gov_dbs_timer = cs_dbs_timer,
 	.alloc = cs_alloc,
Index: linux-pm/drivers/cpufreq/cpufreq_performance.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_performance.c
+++ linux-pm/drivers/cpufreq/cpufreq_performance.c
@@ -16,25 +16,16 @@
 #include <linux/init.h>
 #include <linux/module.h>
 
-static int cpufreq_governor_performance(struct cpufreq_policy *policy,
-					unsigned int event)
+static void cpufreq_gov_performance_limits(struct cpufreq_policy *policy)
 {
-	switch (event) {
-	case CPUFREQ_GOV_LIMITS:
-		pr_debug("setting to %u kHz\n", policy->max);
-		__cpufreq_driver_target(policy, policy->max,
-						CPUFREQ_RELATION_H);
-		break;
-	default:
-		break;
-	}
-	return 0;
+	pr_debug("setting to %u kHz\n", policy->max);
+	__cpufreq_driver_target(policy, policy->max, CPUFREQ_RELATION_H);
 }
 
 static struct cpufreq_governor cpufreq_gov_performance = {
 	.name		= "performance",
-	.governor	= cpufreq_governor_performance,
 	.owner		= THIS_MODULE,
+	.limits		= cpufreq_gov_performance_limits,
 };
 
 static int __init cpufreq_gov_performance_init(void)
Index: linux-pm/drivers/cpufreq/cpufreq_powersave.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_powersave.c
+++ linux-pm/drivers/cpufreq/cpufreq_powersave.c
@@ -16,24 +16,15 @@
 #include <linux/init.h>
 #include <linux/module.h>
 
-static int cpufreq_governor_powersave(struct cpufreq_policy *policy,
-					unsigned int event)
+static void cpufreq_gov_powersave_limits(struct cpufreq_policy *policy)
 {
-	switch (event) {
-	case CPUFREQ_GOV_LIMITS:
-		pr_debug("setting to %u kHz\n", policy->min);
-		__cpufreq_driver_target(policy, policy->min,
-						CPUFREQ_RELATION_L);
-		break;
-	default:
-		break;
-	}
-	return 0;
+	pr_debug("setting to %u kHz\n", policy->min);
+	__cpufreq_driver_target(policy, policy->min, CPUFREQ_RELATION_L);
 }
 
 static struct cpufreq_governor cpufreq_gov_powersave = {
 	.name		= "powersave",
-	.governor	= cpufreq_governor_powersave,
+	.limits		= cpufreq_gov_powersave_limits,
 	.owner		= THIS_MODULE,
 };
 
Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2023,10 +2023,12 @@ static int cpufreq_init_governor(struct
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
 
-	ret = policy->governor->governor(policy, CPUFREQ_GOV_POLICY_INIT);
-	if (ret) {
-		module_put(policy->governor->owner);
-		return ret;
+	if (policy->governor->init) {
+		ret = policy->governor->init(policy);
+		if (ret) {
+			module_put(policy->governor->owner);
+			return ret;
+		}
 	}
 
 	policy->governor->initialized++;
@@ -2040,7 +2042,8 @@ static void cpufreq_exit_governor(struct
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
 
-	policy->governor->governor(policy, CPUFREQ_GOV_POLICY_EXIT);
+	if (policy->governor->exit)
+		policy->governor->exit(policy);
 
 	policy->governor->initialized--;
 	module_put(policy->governor->owner);
@@ -2061,11 +2064,15 @@ static int cpufreq_start_governor(struct
 	if (cpufreq_driver->get && !cpufreq_driver->setpolicy)
 		cpufreq_update_current_freq(policy);
 
-	ret = policy->governor->governor(policy, CPUFREQ_GOV_START);
-	if (ret)
-		return ret;
+	if (policy->governor->start) {
+		ret = policy->governor->start(policy);
+		if (ret)
+			return ret;
+	}
+
+	if (policy->governor->limits)
+		policy->governor->limits(policy);
 
-	policy->governor->governor(policy, CPUFREQ_GOV_LIMITS);
 	return 0;
 }
 
@@ -2076,7 +2083,8 @@ static void cpufreq_stop_governor(struct
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
 
-	policy->governor->governor(policy, CPUFREQ_GOV_STOP);
+	if (policy->governor->stop)
+		policy->governor->stop(policy);
 }
 
 static void cpufreq_governor_limits(struct cpufreq_policy *policy)
@@ -2086,7 +2094,8 @@ static void cpufreq_governor_limits(stru
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
 
-	policy->governor->governor(policy, CPUFREQ_GOV_LIMITS);
+	if (policy->governor->limits)
+		policy->governor->limits(policy);
 }
 
 int cpufreq_register_governor(struct cpufreq_governor *governor)
Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -392,7 +392,7 @@ static int sugov_init(struct cpufreq_pol
 	return ret;
 }
 
-static int sugov_exit(struct cpufreq_policy *policy)
+static void sugov_exit(struct cpufreq_policy *policy)
 {
 	struct sugov_policy *sg_policy = policy->governor_data;
 	struct sugov_tunables *tunables = sg_policy->tunables;
@@ -410,7 +410,6 @@ static int sugov_exit(struct cpufreq_pol
 	mutex_unlock(&global_tunables_lock);
 
 	sugov_policy_free(sg_policy);
-	return 0;
 }
 
 static int sugov_start(struct cpufreq_policy *policy)
@@ -442,7 +441,7 @@ static int sugov_start(struct cpufreq_po
 	return 0;
 }
 
-static int sugov_stop(struct cpufreq_policy *policy)
+static void sugov_stop(struct cpufreq_policy *policy)
 {
 	struct sugov_policy *sg_policy = policy->governor_data;
 	unsigned int cpu;
@@ -454,10 +453,9 @@ static int sugov_stop(struct cpufreq_pol
 
 	irq_work_sync(&sg_policy->irq_work);
 	cancel_work_sync(&sg_policy->work);
-	return 0;
 }
 
-static int sugov_limits(struct cpufreq_policy *policy)
+static void sugov_limits(struct cpufreq_policy *policy)
 {
 	struct sugov_policy *sg_policy = policy->governor_data;
 
@@ -475,32 +473,16 @@ static int sugov_limits(struct cpufreq_p
 	}
 
 	sg_policy->need_freq_update = true;
-	return 0;
-}
-
-int sugov_governor(struct cpufreq_policy *policy, unsigned int event)
-{
-	if (event == CPUFREQ_GOV_POLICY_INIT) {
-		return sugov_init(policy);
-	} else if (policy->governor_data) {
-		switch (event) {
-		case CPUFREQ_GOV_POLICY_EXIT:
-			return sugov_exit(policy);
-		case CPUFREQ_GOV_START:
-			return sugov_start(policy);
-		case CPUFREQ_GOV_STOP:
-			return sugov_stop(policy);
-		case CPUFREQ_GOV_LIMITS:
-			return sugov_limits(policy);
-		}
-	}
-	return -EINVAL;
 }
 
 static struct cpufreq_governor schedutil_gov = {
 	.name = "schedutil",
-	.governor = sugov_governor,
 	.owner = THIS_MODULE,
+	.init = sugov_init,
+	.exit = sugov_exit,
+	.start = sugov_start,
+	.stop = sugov_stop,
+	.limits = sugov_limits,
 };
 
 static int __init sugov_module_init(void)
Index: linux-pm/drivers/cpufreq/cpufreq_userspace.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_userspace.c
+++ linux-pm/drivers/cpufreq/cpufreq_userspace.c
@@ -65,66 +65,66 @@ static int cpufreq_userspace_policy_init
 	return 0;
 }
 
-static int cpufreq_governor_userspace(struct cpufreq_policy *policy,
-				   unsigned int event)
+static void cpufreq_userspace_policy_exit(struct cpufreq_policy *policy)
+{
+	mutex_lock(&userspace_mutex);
+	kfree(policy->governor_data);
+	policy->governor_data = NULL;
+	mutex_unlock(&userspace_mutex);
+}
+
+static int cpufreq_userspace_policy_start(struct cpufreq_policy *policy)
 {
 	unsigned int *setspeed = policy->governor_data;
-	unsigned int cpu = policy->cpu;
-	int rc = 0;
 
-	if (event == CPUFREQ_GOV_POLICY_INIT)
-		return cpufreq_userspace_policy_init(policy);
+	BUG_ON(!policy->cur);
+	pr_debug("started managing cpu %u\n", policy->cpu);
+
+	mutex_lock(&userspace_mutex);
+	per_cpu(cpu_is_managed, policy->cpu) = 1;
+	*setspeed = policy->cur;
+	mutex_unlock(&userspace_mutex);
+	return 0;
+}
+
+static void cpufreq_userspace_policy_stop(struct cpufreq_policy *policy)
+{
+	unsigned int *setspeed = policy->governor_data;
+
+	pr_debug("managing cpu %u stopped\n", policy->cpu);
+
+	mutex_lock(&userspace_mutex);
+	per_cpu(cpu_is_managed, policy->cpu) = 0;
+	*setspeed = 0;
+	mutex_unlock(&userspace_mutex);
+}
+
+static void cpufreq_userspace_policy_limits(struct cpufreq_policy *policy)
+{
+	unsigned int *setspeed = policy->governor_data;
+
+	mutex_lock(&userspace_mutex);
+
+	pr_debug("limit event for cpu %u: %u - %u kHz, currently %u kHz, last set to %u kHz\n",
+		 policy->cpu, policy->min, policy->max, policy->cur, *setspeed);
 
-	if (!setspeed)
-		return -EINVAL;
+	if (policy->max < *setspeed)
+		__cpufreq_driver_target(policy, policy->max, CPUFREQ_RELATION_H);
+	else if (policy->min > *setspeed)
+		__cpufreq_driver_target(policy, policy->min, CPUFREQ_RELATION_L);
+	else
+		__cpufreq_driver_target(policy, *setspeed, CPUFREQ_RELATION_L);
 
-	switch (event) {
-	case CPUFREQ_GOV_POLICY_EXIT:
-		mutex_lock(&userspace_mutex);
-		policy->governor_data = NULL;
-		kfree(setspeed);
-		mutex_unlock(&userspace_mutex);
-		break;
-	case CPUFREQ_GOV_START:
-		BUG_ON(!policy->cur);
-		pr_debug("started managing cpu %u\n", cpu);
-
-		mutex_lock(&userspace_mutex);
-		per_cpu(cpu_is_managed, cpu) = 1;
-		*setspeed = policy->cur;
-		mutex_unlock(&userspace_mutex);
-		break;
-	case CPUFREQ_GOV_STOP:
-		pr_debug("managing cpu %u stopped\n", cpu);
-
-		mutex_lock(&userspace_mutex);
-		per_cpu(cpu_is_managed, cpu) = 0;
-		*setspeed = 0;
-		mutex_unlock(&userspace_mutex);
-		break;
-	case CPUFREQ_GOV_LIMITS:
-		mutex_lock(&userspace_mutex);
-		pr_debug("limit event for cpu %u: %u - %u kHz, currently %u kHz, last set to %u kHz\n",
-			cpu, policy->min, policy->max, policy->cur, *setspeed);
-
-		if (policy->max < *setspeed)
-			__cpufreq_driver_target(policy, policy->max,
-						CPUFREQ_RELATION_H);
-		else if (policy->min > *setspeed)
-			__cpufreq_driver_target(policy, policy->min,
-						CPUFREQ_RELATION_L);
-		else
-			__cpufreq_driver_target(policy, *setspeed,
-						CPUFREQ_RELATION_L);
-		mutex_unlock(&userspace_mutex);
-		break;
-	}
-	return rc;
+	mutex_unlock(&userspace_mutex);
 }
 
 static struct cpufreq_governor cpufreq_gov_userspace = {
 	.name		= "userspace",
-	.governor	= cpufreq_governor_userspace,
+	.init		= cpufreq_userspace_policy_init,
+	.exit		= cpufreq_userspace_policy_exit,
+	.start		= cpufreq_userspace_policy_start,
+	.stop		= cpufreq_userspace_policy_stop,
+	.limits		= cpufreq_userspace_policy_limits,
 	.store_setspeed	= cpufreq_set,
 	.show_setspeed	= show_speed,
 	.owner		= THIS_MODULE,

