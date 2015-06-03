From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/3] cpufreq: governor: Serialize governor callbacks
Date: Wed,  3 Jun 2015 15:57:13 +0530
Message-ID: <ddd3ef47ef3ce88674139f9070650939477881ba.1433326032.git.viresh.kumar@linaro.org>
References: <cover.1433326032.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:32875 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbbFCK2T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2015 06:28:19 -0400
Received: by pdbqa5 with SMTP id qa5so4669468pdb.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2015 03:28:19 -0700 (PDT)
In-Reply-To: <cover.1433326032.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1433326032.git.viresh.kumar@linaro.org>
References: <cover.1433326032.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

There are several races reported in cpufreq core around governors (only
ondemand and conservative) by different people.

There are at least two race scenarios present in governor code:
 (a) Concurrent access/updates of governor internal structures.

 It is possible that fields such as 'dbs_data->usage_count', etc.  are
 accessed simultaneously for different policies using same governor
 structure (i.e. CPUFREQ_HAVE_GOVERNOR_PER_POLICY flag unset). And
 because of this we can dereference bad pointers.

 For example consider a system with two CPUs with separate 'struct
 cpufreq_policy' instances. CPU0 governor: ondemand and CPU1: powersave.
 CPU0 switching to powersave and CPU1 to ondemand:
	CPU0				CPU1

	store*				store*

	cpufreq_governor_exit()		cpufreq_governor_init()
					dbs_data = cdata->gdbs_data;

	if (!--dbs_data->usage_count)
		kfree(dbs_data);

					dbs_data->usage_count++;
					*Bad pointer dereference*

 There are other races possible between EXIT and START/STOP/LIMIT as
 well. Its really complicated.

 (b) Switching governor state in bad sequence:

 For example trying to switch a governor to START state, when the
 governor is in EXIT state. There are some checks present in
 __cpufreq_governor() but they aren't sufficient as they compare events
 against 'policy->governor_enabled', where as we need to take governor's
 state into account, which can be used by multiple policies.

These two issues need to be solved separately and the responsibility
should be properly divided between cpufreq and governor core.

The first problem is more about the governor core, as it needs to
protect its structures properly. And the second problem should be fixed
in cpufreq core instead of governor, as its all about sequence of
events.

This patch is trying to solve only the first problem.

There are two types of data we need to protect,
- 'struct common_dbs_data': No matter what, there is going to be a
  single copy of this per governor.
- 'struct dbs_data': With CPUFREQ_HAVE_GOVERNOR_PER_POLICY flag set, we
  will have per-policy copy of this data, otherwise a single copy.

Because of such complexities, the mutex present in 'struct dbs_data' is
insufficient to solve our problem. For example we need to protect
fetching of 'dbs_data' from different structures at the beginning of
cpufreq_governor_dbs(), to make sure it isn't currently being updated.

This can be fixed if we can guarantee serialization of event parsing
code for an individual governor. This is best solved with a mutex per
governor, and the placeholder for that is 'struct common_dbs_data'.

And so this patch moves the mutex from 'struct dbs_data' to 'struct
common_dbs_data' and takes it at the beginning and drops it at the end
of cpufreq_governor_dbs().

Tested with and without following configuration options:

CONFIG_LOCKDEP_SUPPORT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_PI_LIST=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c |  2 +-
 drivers/cpufreq/cpufreq_governor.c     | 24 +++++++++++-------------
 drivers/cpufreq/cpufreq_governor.h     |  8 +++++---
 drivers/cpufreq/cpufreq_ondemand.c     |  2 +-
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 75f875bb155e..c86a10c30912 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -345,7 +345,6 @@ static int cs_init(struct dbs_data *dbs_data, bool notify)
 		cpufreq_register_notifier(&cs_cpufreq_notifier_block,
 					  CPUFREQ_TRANSITION_NOTIFIER);
 
-	mutex_init(&dbs_data->mutex);
 	return 0;
 }
 
@@ -370,6 +369,7 @@ static struct common_dbs_data cs_dbs_cdata = {
 	.gov_check_cpu = cs_check_cpu,
 	.init = cs_init,
 	.exit = cs_exit,
+	.mutex = __MUTEX_INITIALIZER(cs_dbs_cdata.mutex),
 };
 
 static int cs_cpufreq_governor_dbs(struct cpufreq_policy *policy,
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index dc382a5a2158..ed849a8777dd 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -344,8 +344,6 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 		io_busy = od_tuners->io_is_busy;
 	}
 
-	mutex_lock(&dbs_data->mutex);
-
 	for_each_cpu(j, policy->cpus) {
 		struct cpu_dbs_common_info *j_cdbs = cdata->get_cpu_cdbs(j);
 		unsigned int prev_load;
@@ -383,8 +381,6 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 		od_ops->powersave_bias_init_cpu(cpu);
 	}
 
-	mutex_unlock(&dbs_data->mutex);
-
 	/* Initiate timer time stamp */
 	cpu_cdbs->time_stamp = ktime_get();
 
@@ -409,10 +405,8 @@ static void cpufreq_governor_stop(struct cpufreq_policy *policy,
 
 	gov_cancel_work(dbs_data, policy);
 
-	mutex_lock(&dbs_data->mutex);
 	mutex_destroy(&cpu_cdbs->timer_mutex);
 	cpu_cdbs->cur_policy = NULL;
-	mutex_unlock(&dbs_data->mutex);
 }
 
 static void cpufreq_governor_limits(struct cpufreq_policy *policy,
@@ -422,11 +416,8 @@ static void cpufreq_governor_limits(struct cpufreq_policy *policy,
 	unsigned int cpu = policy->cpu;
 	struct cpu_dbs_common_info *cpu_cdbs = cdata->get_cpu_cdbs(cpu);
 
-	mutex_lock(&dbs_data->mutex);
-	if (!cpu_cdbs->cur_policy) {
-		mutex_unlock(&dbs_data->mutex);
+	if (!cpu_cdbs->cur_policy)
 		return;
-	}
 
 	mutex_lock(&cpu_cdbs->timer_mutex);
 	if (policy->max < cpu_cdbs->cur_policy->cur)
@@ -437,8 +428,6 @@ static void cpufreq_governor_limits(struct cpufreq_policy *policy,
 					CPUFREQ_RELATION_L);
 	dbs_check_cpu(dbs_data, cpu);
 	mutex_unlock(&cpu_cdbs->timer_mutex);
-
-	mutex_unlock(&dbs_data->mutex);
 }
 
 int cpufreq_governor_dbs(struct cpufreq_policy *policy,
@@ -447,12 +436,18 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 	struct dbs_data *dbs_data;
 	int ret = 0;
 
+	/* Lock governor to block concurrent initialization of governor */
+	mutex_lock(&cdata->mutex);
+
 	if (have_governor_per_policy())
 		dbs_data = policy->governor_data;
 	else
 		dbs_data = cdata->gdbs_data;
 
-	WARN_ON(!dbs_data && (event != CPUFREQ_GOV_POLICY_INIT));
+	if (WARN_ON(!dbs_data && (event != CPUFREQ_GOV_POLICY_INIT))) {
+		ret = -EINVAL;
+		goto unlock;
+	}
 
 	switch (event) {
 	case CPUFREQ_GOV_POLICY_INIT:
@@ -472,6 +467,9 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 		break;
 	}
 
+unlock:
+	mutex_unlock(&cdata->mutex);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cpufreq_governor_dbs);
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 1690120df487..34736f5e869d 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -213,6 +213,11 @@ struct common_dbs_data {
 
 	/* Governor specific ops, see below */
 	void *gov_ops;
+
+	/*
+	 * Protects governor's data (struct dbs_data and struct common_dbs_data)
+	 */
+	struct mutex mutex;
 };
 
 /* Governor Per policy data */
@@ -221,9 +226,6 @@ struct dbs_data {
 	unsigned int min_sampling_rate;
 	int usage_count;
 	void *tuners;
-
-	/* dbs_mutex protects dbs_enable in governor start/stop */
-	struct mutex mutex;
 };
 
 /* Governor specific ops, will be passed to dbs_data->gov_ops */
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 4fe78a9caa04..3c1e10f2304c 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -513,7 +513,6 @@ static int od_init(struct dbs_data *dbs_data, bool notify)
 	tuners->io_is_busy = should_io_be_busy();
 
 	dbs_data->tuners = tuners;
-	mutex_init(&dbs_data->mutex);
 	return 0;
 }
 
@@ -541,6 +540,7 @@ static struct common_dbs_data od_dbs_cdata = {
 	.gov_ops = &od_ops,
 	.init = od_init,
 	.exit = od_exit,
+	.mutex = __MUTEX_INITIALIZER(od_dbs_cdata.mutex),
 };
 
 static void od_set_powersave_bias(unsigned int powersave_bias)
-- 
2.4.0

