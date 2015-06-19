From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 01/10] cpufreq: governor: Name delayed-work as dwork
Date: Fri, 19 Jun 2015 17:18:01 +0530
Message-ID: <26f3e30c0be8c55d61b9348b1ff29ec1d9ef6c93.1434713657.git.viresh.kumar@linaro.org>
References: <cover.1434713657.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34198 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbbFSLsd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2015 07:48:33 -0400
Received: by pabvl15 with SMTP id vl15so37737252pab.1
        for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2015 04:48:32 -0700 (PDT)
In-Reply-To: <cover.1434713657.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434713657.git.viresh.kumar@linaro.org>
References: <cover.1434713657.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Delayed work was named as 'work' and to access work within it we do
work.work. Not much readable. Rename delayed_work as 'dwork'.

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 2 +-
 drivers/cpufreq/cpufreq_governor.c     | 6 +++---
 drivers/cpufreq/cpufreq_governor.h     | 2 +-
 drivers/cpufreq/cpufreq_ondemand.c     | 8 ++++----
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index c86a10c30912..0e3ec1d968d9 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -105,7 +105,7 @@ static void cs_check_cpu(int cpu, unsigned int load)
 static void cs_dbs_timer(struct work_struct *work)
 {
 	struct cs_cpu_dbs_info_s *dbs_info = container_of(work,
-			struct cs_cpu_dbs_info_s, cdbs.work.work);
+			struct cs_cpu_dbs_info_s, cdbs.dwork.work);
 	unsigned int cpu = dbs_info->cdbs.cur_policy->cpu;
 	struct cs_cpu_dbs_info_s *core_dbs_info = &per_cpu(cs_cpu_dbs_info,
 			cpu);
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 57a39f8a92b7..6024bbc782c0 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -165,7 +165,7 @@ static inline void __gov_queue_work(int cpu, struct dbs_data *dbs_data,
 {
 	struct cpu_dbs_common_info *cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
 
-	mod_delayed_work_on(cpu, system_wq, &cdbs->work, delay);
+	mod_delayed_work_on(cpu, system_wq, &cdbs->dwork, delay);
 }
 
 void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
@@ -204,7 +204,7 @@ static inline void gov_cancel_work(struct dbs_data *dbs_data,
 
 	for_each_cpu(i, policy->cpus) {
 		cdbs = dbs_data->cdata->get_cpu_cdbs(i);
-		cancel_delayed_work_sync(&cdbs->work);
+		cancel_delayed_work_sync(&cdbs->dwork);
 	}
 }
 
@@ -367,7 +367,7 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 			j_cdbs->prev_cpu_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
 
 		mutex_init(&j_cdbs->timer_mutex);
-		INIT_DEFERRABLE_WORK(&j_cdbs->work, cdata->gov_dbs_timer);
+		INIT_DEFERRABLE_WORK(&j_cdbs->dwork, cdata->gov_dbs_timer);
 	}
 
 	if (cdata->governor == GOV_CONSERVATIVE) {
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 34736f5e869d..352eecaae789 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -142,7 +142,7 @@ struct cpu_dbs_common_info {
 	 */
 	unsigned int prev_load;
 	struct cpufreq_policy *cur_policy;
-	struct delayed_work work;
+	struct delayed_work dwork;
 	/*
 	 * percpu mutex that serializes governor limit change with gov_dbs_timer
 	 * invocation. We do not want gov_dbs_timer to run when user is changing
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 3c1e10f2304c..830aef1db8c3 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -194,7 +194,7 @@ static void od_check_cpu(int cpu, unsigned int load)
 static void od_dbs_timer(struct work_struct *work)
 {
 	struct od_cpu_dbs_info_s *dbs_info =
-		container_of(work, struct od_cpu_dbs_info_s, cdbs.work.work);
+		container_of(work, struct od_cpu_dbs_info_s, cdbs.dwork.work);
 	unsigned int cpu = dbs_info->cdbs.cur_policy->cpu;
 	struct od_cpu_dbs_info_s *core_dbs_info = &per_cpu(od_cpu_dbs_info,
 			cpu);
@@ -275,18 +275,18 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 
 		mutex_lock(&dbs_info->cdbs.timer_mutex);
 
-		if (!delayed_work_pending(&dbs_info->cdbs.work)) {
+		if (!delayed_work_pending(&dbs_info->cdbs.dwork)) {
 			mutex_unlock(&dbs_info->cdbs.timer_mutex);
 			continue;
 		}
 
 		next_sampling = jiffies + usecs_to_jiffies(new_rate);
-		appointed_at = dbs_info->cdbs.work.timer.expires;
+		appointed_at = dbs_info->cdbs.dwork.timer.expires;
 
 		if (time_before(next_sampling, appointed_at)) {
 
 			mutex_unlock(&dbs_info->cdbs.timer_mutex);
-			cancel_delayed_work_sync(&dbs_info->cdbs.work);
+			cancel_delayed_work_sync(&dbs_info->cdbs.dwork);
 			mutex_lock(&dbs_info->cdbs.timer_mutex);
 
 			gov_queue_work(dbs_data, dbs_info->cdbs.cur_policy,
-- 
2.4.0

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
