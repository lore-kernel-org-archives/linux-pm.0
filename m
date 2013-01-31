From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/2] cpufreq: governors: Remove code redundancy between
	governors
Date: Thu, 31 Jan 2013 22:58:02 +0530
Message-ID: <118c59263751862b1750ed9f96639a4e70069e66.1359653181.git.viresh.kumar@linaro.org>
References: <09a94ff044ff6a6f7a5d953c3b1f3102c1dc50cf.1359653181.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <09a94ff044ff6a6f7a5d953c3b1f3102c1dc50cf.1359653181.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <09a94ff044ff6a6f7a5d953c3b1f3102c1dc50cf.1359653181.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <09a94ff044ff6a6f7a5d953c3b1f3102c1dc50cf.1359653181.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: rjw-KKrjLPT3xs0@public.gmane.org, fabio.baltieri-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: Steve.Bannister-5wv7dgnIgG8@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

With the inclusion of following patches:

9f4eb10 cpufreq: conservative: call dbs_check_cpu only when necessary
772b4b1 cpufreq: ondemand: call dbs_check_cpu only when necessary

code redundancy is introduced again. Get rid of it.

Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 52 ++++-------------------
 drivers/cpufreq/cpufreq_governor.c     | 18 ++++++++
 drivers/cpufreq/cpufreq_governor.h     |  2 +
 drivers/cpufreq/cpufreq_ondemand.c     | 77 ++++++++++------------------------
 4 files changed, 52 insertions(+), 97 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index c18a304..e8bb915 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -111,58 +111,24 @@ static void cs_check_cpu(int cpu, unsigned int load)
 	}
 }
 
-static void cs_timer_update(struct cs_cpu_dbs_info_s *dbs_info, bool sample,
-			    struct delayed_work *dw)
+static void cs_dbs_timer(struct work_struct *work)
 {
+	struct delayed_work *dw = to_delayed_work(work);
+	struct cs_cpu_dbs_info_s *dbs_info = container_of(work,
+			struct cs_cpu_dbs_info_s, cdbs.work.work);
 	unsigned int cpu = dbs_info->cdbs.cur_policy->cpu;
+	struct cs_cpu_dbs_info_s *core_dbs_info = &per_cpu(cs_cpu_dbs_info,
+			cpu);
 	int delay = delay_for_sampling_rate(cs_tuners.sampling_rate);
 
-	if (sample)
+	mutex_lock(&core_dbs_info->cdbs.timer_mutex);
+	if (need_load_eval(&core_dbs_info->cdbs, cs_tuners.sampling_rate))
 		dbs_check_cpu(&cs_dbs_data, cpu);
 
 	schedule_delayed_work_on(smp_processor_id(), dw, delay);
+	mutex_unlock(&core_dbs_info->cdbs.timer_mutex);
 }
 
-static void cs_timer_coordinated(struct cs_cpu_dbs_info_s *dbs_info_local,
-				 struct delayed_work *dw)
-{
-	struct cs_cpu_dbs_info_s *dbs_info;
-	ktime_t time_now;
-	s64 delta_us;
-	bool sample = true;
-
-	/* use leader CPU's dbs_info */
-	dbs_info = &per_cpu(cs_cpu_dbs_info,
-			    dbs_info_local->cdbs.cur_policy->cpu);
-	mutex_lock(&dbs_info->cdbs.timer_mutex);
-
-	time_now = ktime_get();
-	delta_us = ktime_us_delta(time_now, dbs_info->cdbs.time_stamp);
-
-	/* Do nothing if we recently have sampled */
-	if (delta_us < (s64)(cs_tuners.sampling_rate / 2))
-		sample = false;
-	else
-		dbs_info->cdbs.time_stamp = time_now;
-
-	cs_timer_update(dbs_info, sample, dw);
-	mutex_unlock(&dbs_info->cdbs.timer_mutex);
-}
-
-static void cs_dbs_timer(struct work_struct *work)
-{
-	struct delayed_work *dw = to_delayed_work(work);
-	struct cs_cpu_dbs_info_s *dbs_info = container_of(work,
-			struct cs_cpu_dbs_info_s, cdbs.work.work);
-
-	if (policy_is_shared(dbs_info->cdbs.cur_policy)) {
-		cs_timer_coordinated(dbs_info, dw);
-	} else {
-		mutex_lock(&dbs_info->cdbs.timer_mutex);
-		cs_timer_update(dbs_info, true, dw);
-		mutex_unlock(&dbs_info->cdbs.timer_mutex);
-	}
-}
 static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
 		void *data)
 {
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 29d6a59..dc99472 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -177,6 +177,24 @@ static inline void dbs_timer_exit(struct dbs_data *dbs_data, int cpu)
 	cancel_delayed_work_sync(&cdbs->work);
 }
 
+/* Will return if we need to evaluate cpu load again or not */
+bool need_load_eval(struct cpu_dbs_common_info *cdbs,
+		unsigned int sampling_rate)
+{
+	if (policy_is_shared(cdbs->cur_policy)) {
+		ktime_t time_now = ktime_get();
+		s64 delta_us = ktime_us_delta(time_now, cdbs->time_stamp);
+
+		/* Do nothing if we recently have sampled */
+		if (delta_us < (s64)(sampling_rate / 2))
+			return false;
+		else
+			cdbs->time_stamp = time_now;
+	}
+
+	return true;
+}
+
 int cpufreq_governor_dbs(struct dbs_data *dbs_data,
 		struct cpufreq_policy *policy, unsigned int event)
 {
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index c19a16c..16314b6 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -171,6 +171,8 @@ static inline int delay_for_sampling_rate(unsigned int sampling_rate)
 
 u64 get_cpu_idle_time(unsigned int cpu, u64 *wall);
 void dbs_check_cpu(struct dbs_data *dbs_data, int cpu);
+bool need_load_eval(struct cpu_dbs_common_info *cdbs,
+		unsigned int sampling_rate);
 int cpufreq_governor_dbs(struct dbs_data *dbs_data,
 		struct cpufreq_policy *policy, unsigned int event);
 #endif /* _CPUFREQ_GOVERNER_H */
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 75efd5e..f38b8da 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -216,75 +216,44 @@ static void od_check_cpu(int cpu, unsigned int load_freq)
 	}
 }
 
-static void od_timer_update(struct od_cpu_dbs_info_s *dbs_info, bool sample,
-			    struct delayed_work *dw)
+static void od_dbs_timer(struct work_struct *work)
 {
+	struct delayed_work *dw = to_delayed_work(work);
+	struct od_cpu_dbs_info_s *dbs_info =
+		container_of(work, struct od_cpu_dbs_info_s, cdbs.work.work);
 	unsigned int cpu = dbs_info->cdbs.cur_policy->cpu;
-	int delay, sample_type = dbs_info->sample_type;
+	struct od_cpu_dbs_info_s *core_dbs_info = &per_cpu(od_cpu_dbs_info,
+			cpu);
+	int delay, sample_type = core_dbs_info->sample_type;
+	bool eval_load;
+
+	mutex_lock(&core_dbs_info->cdbs.timer_mutex);
+	eval_load = need_load_eval(&core_dbs_info->cdbs,
+			od_tuners.sampling_rate);
 
 	/* Common NORMAL_SAMPLE setup */
-	dbs_info->sample_type = OD_NORMAL_SAMPLE;
+	core_dbs_info->sample_type = OD_NORMAL_SAMPLE;
 	if (sample_type == OD_SUB_SAMPLE) {
-		delay = dbs_info->freq_lo_jiffies;
-		if (sample)
-			__cpufreq_driver_target(dbs_info->cdbs.cur_policy,
-						dbs_info->freq_lo,
+		delay = core_dbs_info->freq_lo_jiffies;
+		if (eval_load)
+			__cpufreq_driver_target(core_dbs_info->cdbs.cur_policy,
+						core_dbs_info->freq_lo,
 						CPUFREQ_RELATION_H);
 	} else {
-		if (sample)
+		if (eval_load)
 			dbs_check_cpu(&od_dbs_data, cpu);
-		if (dbs_info->freq_lo) {
+		if (core_dbs_info->freq_lo) {
 			/* Setup timer for SUB_SAMPLE */
-			dbs_info->sample_type = OD_SUB_SAMPLE;
-			delay = dbs_info->freq_hi_jiffies;
+			core_dbs_info->sample_type = OD_SUB_SAMPLE;
+			delay = core_dbs_info->freq_hi_jiffies;
 		} else {
 			delay = delay_for_sampling_rate(od_tuners.sampling_rate
-						* dbs_info->rate_mult);
+						* core_dbs_info->rate_mult);
 		}
 	}
 
 	schedule_delayed_work_on(smp_processor_id(), dw, delay);
-}
-
-static void od_timer_coordinated(struct od_cpu_dbs_info_s *dbs_info_local,
-				 struct delayed_work *dw)
-{
-	struct od_cpu_dbs_info_s *dbs_info;
-	ktime_t time_now;
-	s64 delta_us;
-	bool sample = true;
-
-	/* use leader CPU's dbs_info */
-	dbs_info = &per_cpu(od_cpu_dbs_info,
-			    dbs_info_local->cdbs.cur_policy->cpu);
-	mutex_lock(&dbs_info->cdbs.timer_mutex);
-
-	time_now = ktime_get();
-	delta_us = ktime_us_delta(time_now, dbs_info->cdbs.time_stamp);
-
-	/* Do nothing if we recently have sampled */
-	if (delta_us < (s64)(od_tuners.sampling_rate / 2))
-		sample = false;
-	else
-		dbs_info->cdbs.time_stamp = time_now;
-
-	od_timer_update(dbs_info, sample, dw);
-	mutex_unlock(&dbs_info->cdbs.timer_mutex);
-}
-
-static void od_dbs_timer(struct work_struct *work)
-{
-	struct delayed_work *dw = to_delayed_work(work);
-	struct od_cpu_dbs_info_s *dbs_info =
-		container_of(work, struct od_cpu_dbs_info_s, cdbs.work.work);
-
-	if (policy_is_shared(dbs_info->cdbs.cur_policy)) {
-		od_timer_coordinated(dbs_info, dw);
-	} else {
-		mutex_lock(&dbs_info->cdbs.timer_mutex);
-		od_timer_update(dbs_info, true, dw);
-		mutex_unlock(&dbs_info->cdbs.timer_mutex);
-	}
+	mutex_unlock(&core_dbs_info->cdbs.timer_mutex);
 }
 
 /************************** sysfs interface ************************/
-- 
1.7.12.rc2.18.g61b472e
