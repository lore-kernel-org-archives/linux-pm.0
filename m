From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 04/10] cpufreq: ondemand: only queue canceled works from update_sampling_rate()
Date: Mon, 22 Jun 2015 13:32:51 +0530
Message-ID: <4a478b21805d9454ce48e115ab1b7bc61f06cabb.1434959517.git.viresh.kumar@linaro.org>
References: <cover.1434959517.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34725 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755999AbbFVIDW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 04:03:22 -0400
Received: by pabvl15 with SMTP id vl15so82800614pab.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2015 01:03:21 -0700 (PDT)
In-Reply-To: <cover.1434959517.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434959517.git.viresh.kumar@linaro.org>
References: <cover.1434959517.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

The sampling rate is updated with a call to update_sampling_rate(), and
we process CPUs one by one here. While the work is canceled on per-cpu
basis, it is getting enqueued (by mistake) for all policy->cpus.

That would result in wasting cpu cycles for queuing works which are
already queued and never canceled.

This patch is about queuing work only on the cpu for which it was
canceled earlier.

gov_queue_work() was missing the CPU parameter and it's better to club
'modify_all' and the new 'cpu' parameter to a 'cpus' mask. And so this
patch also changes the prototype of gov_queue_work() and fixes its
caller sites.

Fixes: 031299b3be30 ("cpufreq: governors: Avoid unnecessary per cpu
timer interrupts")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c |  4 ++--
 drivers/cpufreq/cpufreq_governor.c     | 30 ++++++++++--------------------
 drivers/cpufreq/cpufreq_governor.h     |  2 +-
 drivers/cpufreq/cpufreq_ondemand.c     |  7 ++++---
 4 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index f53719e5bed9..2ab53d96c078 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -116,11 +116,11 @@ static void cs_check_cpu(int cpu, unsigned int load)
 }
 
 static unsigned int cs_dbs_timer(struct cpu_dbs_info *cdbs,
-				 struct dbs_data *dbs_data, bool modify_all)
+				 struct dbs_data *dbs_data, bool load_eval)
 {
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 
-	if (modify_all)
+	if (load_eval)
 		dbs_check_cpu(dbs_data, cdbs->ccdbs->policy->cpu);
 
 	return delay_for_sampling_rate(cs_tuners->sampling_rate);
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 836aefd03c1b..416a8c5665dd 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -167,7 +167,7 @@ static inline void __gov_queue_work(int cpu, struct dbs_data *dbs_data,
 }
 
 void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
-		unsigned int delay, bool all_cpus)
+		    unsigned int delay, const struct cpumask *cpus)
 {
 	int i;
 
@@ -175,19 +175,8 @@ void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
 	if (!policy->governor_enabled)
 		goto out_unlock;
 
-	if (!all_cpus) {
-		/*
-		 * Use raw_smp_processor_id() to avoid preemptible warnings.
-		 * We know that this is only called with all_cpus == false from
-		 * works that have been queued with *_work_on() functions and
-		 * those works are canceled during CPU_DOWN_PREPARE so they
-		 * can't possibly run on any other CPU.
-		 */
-		__gov_queue_work(raw_smp_processor_id(), dbs_data, delay);
-	} else {
-		for_each_cpu(i, policy->cpus)
-			__gov_queue_work(i, dbs_data, delay);
-	}
+	for_each_cpu(i, cpus)
+		__gov_queue_work(i, dbs_data, delay);
 
 out_unlock:
 	mutex_unlock(&cpufreq_governor_lock);
@@ -232,7 +221,8 @@ static void dbs_timer(struct work_struct *work)
 	struct cpufreq_policy *policy = ccdbs->policy;
 	struct dbs_data *dbs_data = policy->governor_data;
 	unsigned int sampling_rate, delay;
-	bool modify_all = true;
+	const struct cpumask *cpus;
+	bool load_eval;
 
 	mutex_lock(&ccdbs->timer_mutex);
 
@@ -246,11 +236,11 @@ static void dbs_timer(struct work_struct *work)
 		sampling_rate = od_tuners->sampling_rate;
 	}
 
-	if (!need_load_eval(cdbs->ccdbs, sampling_rate))
-		modify_all = false;
+	load_eval = need_load_eval(cdbs->ccdbs, sampling_rate);
+	cpus = load_eval ? policy->cpus : cpumask_of(raw_smp_processor_id());
 
-	delay = dbs_data->cdata->gov_dbs_timer(cdbs, dbs_data, modify_all);
-	gov_queue_work(dbs_data, policy, delay, modify_all);
+	delay = dbs_data->cdata->gov_dbs_timer(cdbs, dbs_data, load_eval);
+	gov_queue_work(dbs_data, policy, delay, cpus);
 
 	mutex_unlock(&ccdbs->timer_mutex);
 }
@@ -474,7 +464,7 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 	}
 
 	gov_queue_work(dbs_data, policy, delay_for_sampling_rate(sampling_rate),
-		       true);
+		       policy->cpus);
 	return 0;
 }
 
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index a0d24149f18c..dc2ad8a427f3 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -273,7 +273,7 @@ void dbs_check_cpu(struct dbs_data *dbs_data, int cpu);
 int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 		struct common_dbs_data *cdata, unsigned int event);
 void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
-		unsigned int delay, bool all_cpus);
+		    unsigned int delay, const struct cpumask *cpus);
 void od_register_powersave_bias_handler(unsigned int (*f)
 		(struct cpufreq_policy *, unsigned int, unsigned int),
 		unsigned int powersave_bias);
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 11db20079fc6..774bbddae2c9 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -192,7 +192,7 @@ static void od_check_cpu(int cpu, unsigned int load)
 }
 
 static unsigned int od_dbs_timer(struct cpu_dbs_info *cdbs,
-				 struct dbs_data *dbs_data, bool modify_all)
+				 struct dbs_data *dbs_data, bool load_eval)
 {
 	struct cpufreq_policy *policy = cdbs->ccdbs->policy;
 	unsigned int cpu = policy->cpu;
@@ -201,7 +201,7 @@ static unsigned int od_dbs_timer(struct cpu_dbs_info *cdbs,
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	int delay = 0, sample_type = dbs_info->sample_type;
 
-	if (!modify_all)
+	if (!load_eval)
 		goto max_delay;
 
 	/* Common NORMAL_SAMPLE setup */
@@ -284,7 +284,8 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 			mutex_lock(&dbs_info->cdbs.ccdbs->timer_mutex);
 
 			gov_queue_work(dbs_data, policy,
-				       usecs_to_jiffies(new_rate), true);
+				       usecs_to_jiffies(new_rate),
+				       cpumask_of(cpu));
 
 		}
 		mutex_unlock(&dbs_info->cdbs.ccdbs->timer_mutex);
-- 
2.4.0

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
