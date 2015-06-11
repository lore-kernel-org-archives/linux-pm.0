From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 04/12] cpufreq: governor: name pointer to cpu_dbs_info as 'cdbs'
Date: Thu, 11 Jun 2015 16:21:47 +0530
Message-ID: <20b096728a41a719bf8e45f99a0aadf142f60a03.1434019473.git.viresh.kumar@linaro.org>
References: <cover.1434019473.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:32885 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbbFKKw1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2015 06:52:27 -0400
Received: by pdjn11 with SMTP id n11so2506204pdj.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2015 03:52:26 -0700 (PDT)
In-Reply-To: <cover.1434019473.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434019473.git.viresh.kumar@linaro.org>
References: <cover.1434019473.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

It is called as 'cdbs' at most of the places and 'cpu_dbs' at others.
Lets use 'cdbs' consistently for better readability.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 529f236f2d05..4ea13f182154 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -329,7 +329,7 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 {
 	struct common_dbs_data *cdata = dbs_data->cdata;
 	unsigned int sampling_rate, ignore_nice, j, cpu = policy->cpu;
-	struct cpu_dbs_info *cpu_cdbs = cdata->get_cpu_cdbs(cpu);
+	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
 	int io_busy = 0;
 
 	if (!policy->cur)
@@ -385,7 +385,7 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 	}
 
 	/* Initiate timer time stamp */
-	cpu_cdbs->time_stamp = ktime_get();
+	cdbs->time_stamp = ktime_get();
 
 	gov_queue_work(dbs_data, policy, delay_for_sampling_rate(sampling_rate),
 		       true);
@@ -397,7 +397,7 @@ static void cpufreq_governor_stop(struct cpufreq_policy *policy,
 {
 	struct common_dbs_data *cdata = dbs_data->cdata;
 	unsigned int cpu = policy->cpu;
-	struct cpu_dbs_info *cpu_cdbs = cdata->get_cpu_cdbs(cpu);
+	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
 
 	if (cdata->governor == GOV_CONSERVATIVE) {
 		struct cs_cpu_dbs_info_s *cs_dbs_info =
@@ -408,8 +408,8 @@ static void cpufreq_governor_stop(struct cpufreq_policy *policy,
 
 	gov_cancel_work(dbs_data, policy);
 
-	mutex_destroy(&cpu_cdbs->timer_mutex);
-	cpu_cdbs->cur_policy = NULL;
+	mutex_destroy(&cdbs->timer_mutex);
+	cdbs->cur_policy = NULL;
 }
 
 static void cpufreq_governor_limits(struct cpufreq_policy *policy,
@@ -417,20 +417,20 @@ static void cpufreq_governor_limits(struct cpufreq_policy *policy,
 {
 	struct common_dbs_data *cdata = dbs_data->cdata;
 	unsigned int cpu = policy->cpu;
-	struct cpu_dbs_info *cpu_cdbs = cdata->get_cpu_cdbs(cpu);
+	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
 
-	if (!cpu_cdbs->cur_policy)
+	if (!cdbs->cur_policy)
 		return;
 
-	mutex_lock(&cpu_cdbs->timer_mutex);
-	if (policy->max < cpu_cdbs->cur_policy->cur)
-		__cpufreq_driver_target(cpu_cdbs->cur_policy, policy->max,
+	mutex_lock(&cdbs->timer_mutex);
+	if (policy->max < cdbs->cur_policy->cur)
+		__cpufreq_driver_target(cdbs->cur_policy, policy->max,
 					CPUFREQ_RELATION_H);
-	else if (policy->min > cpu_cdbs->cur_policy->cur)
-		__cpufreq_driver_target(cpu_cdbs->cur_policy, policy->min,
+	else if (policy->min > cdbs->cur_policy->cur)
+		__cpufreq_driver_target(cdbs->cur_policy, policy->min,
 					CPUFREQ_RELATION_L);
 	dbs_check_cpu(dbs_data, cpu);
-	mutex_unlock(&cpu_cdbs->timer_mutex);
+	mutex_unlock(&cdbs->timer_mutex);
 }
 
 int cpufreq_governor_dbs(struct cpufreq_policy *policy,
-- 
2.4.0

