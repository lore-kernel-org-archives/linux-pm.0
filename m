From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 3/9] cpufreq: ondemand: only queue canceled works from update_sampling_rate()
Date: Mon, 27 Jul 2015 17:58:08 +0530
Message-ID: <5b568d732469de1a902e0aa1034ea24e863aa524.1437999691.git.viresh.kumar@linaro.org>
References: <cover.1437999691.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437999691.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437999691.git.viresh.kumar@linaro.org>
References: <cover.1437999691.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, preeti.lkml@gmail.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The sampling rate is updated with a call to update_sampling_rate(), and
we process CPUs one by one here. While the work is canceled on per-cpu
basis, it is getting queued (by mistake) for all policy->cpus.

This would result in wasting cpu cycles for queuing works which are
already queued and never canceled.

This patch changes this behavior to queue work only on the cpu, for
which it was canceled earlier.

To do that, replace 'modify_all' parameter to gov_queue_work() with a
mask of CPUs. Also the last parameter to ->gov_dbs_timer() was named
'modify_all' earlier, but its purpose was to decide if load has to be
evaluated again or not. Lets rename that to load_eval.

Fixes: 031299b3be30 ("cpufreq: governors: Avoid unnecessary per cpu timer interrupts")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c |  4 ++--
 drivers/cpufreq/cpufreq_governor.c     | 30 ++++++++++--------------------
 drivers/cpufreq/cpufreq_governor.h     |  4 ++--
 drivers/cpufreq/cpufreq_ondemand.c     |  7 ++++---
 4 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 18bfbc313e48..1aa3bd46cea3 100644
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
 		dbs_check_cpu(dbs_data, cdbs->shared->policy->cpu);
 
 	return delay_for_sampling_rate(cs_tuners->sampling_rate);
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 750626d8fb03..a890450711bb 100644
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
 	struct cpufreq_policy *policy = shared->policy;
 	struct dbs_data *dbs_data = policy->governor_data;
 	unsigned int sampling_rate, delay;
-	bool modify_all = true;
+	const struct cpumask *cpus;
+	bool load_eval;
 
 	mutex_lock(&shared->timer_mutex);
 
@@ -246,11 +236,11 @@ static void dbs_timer(struct work_struct *work)
 		sampling_rate = od_tuners->sampling_rate;
 	}
 
-	if (!need_load_eval(cdbs->shared, sampling_rate))
-		modify_all = false;
+	load_eval = need_load_eval(cdbs->shared, sampling_rate);
+	cpus = load_eval ? policy->cpus : cpumask_of(raw_smp_processor_id());
 
-	delay = dbs_data->cdata->gov_dbs_timer(cdbs, dbs_data, modify_all);
-	gov_queue_work(dbs_data, policy, delay, modify_all);
+	delay = dbs_data->cdata->gov_dbs_timer(cdbs, dbs_data, load_eval);
+	gov_queue_work(dbs_data, policy, delay, cpus);
 
 	mutex_unlock(&shared->timer_mutex);
 }
@@ -474,7 +464,7 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 	}
 
 	gov_queue_work(dbs_data, policy, delay_for_sampling_rate(sampling_rate),
-		       true);
+		       policy->cpus);
 	return 0;
 }
 
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 5621bb03e874..52665a0624b2 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -211,7 +211,7 @@ struct common_dbs_data {
 	void *(*get_cpu_dbs_info_s)(int cpu);
 	unsigned int (*gov_dbs_timer)(struct cpu_dbs_info *cdbs,
 				      struct dbs_data *dbs_data,
-				      bool modify_all);
+				      bool load_eval);
 	void (*gov_check_cpu)(int cpu, unsigned int load);
 	int (*init)(struct dbs_data *dbs_data, bool notify);
 	void (*exit)(struct dbs_data *dbs_data, bool notify);
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
index 1fa9088c84a8..2474c9c34022 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -192,7 +192,7 @@ static void od_check_cpu(int cpu, unsigned int load)
 }
 
 static unsigned int od_dbs_timer(struct cpu_dbs_info *cdbs,
-				 struct dbs_data *dbs_data, bool modify_all)
+				 struct dbs_data *dbs_data, bool load_eval)
 {
 	struct cpufreq_policy *policy = cdbs->shared->policy;
 	unsigned int cpu = policy->cpu;
@@ -201,7 +201,7 @@ static unsigned int od_dbs_timer(struct cpu_dbs_info *cdbs,
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	int delay = 0, sample_type = dbs_info->sample_type;
 
-	if (!modify_all)
+	if (!load_eval)
 		goto max_delay;
 
 	/* Common NORMAL_SAMPLE setup */
@@ -284,7 +284,8 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 			mutex_lock(&dbs_info->cdbs.shared->timer_mutex);
 
 			gov_queue_work(dbs_data, policy,
-				       usecs_to_jiffies(new_rate), true);
+				       usecs_to_jiffies(new_rate),
+				       cpumask_of(cpu));
 
 		}
 		mutex_unlock(&dbs_info->cdbs.shared->timer_mutex);
-- 
2.4.0
