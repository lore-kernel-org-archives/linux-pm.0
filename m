From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 3/6] cpufreq: Update governor core to support all governors
Date: Fri, 05 Jul 2013 17:46:38 +0900
Message-ID: <1373014001-17746-4-git-send-email-cw00.choi@samsung.com>
References: <1373014001-17746-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:14120 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757047Ab3GEIqz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jul 2013 04:46:55 -0400
In-reply-to: <1373014001-17746-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh.kumar@linaro.org, rjw@sisk.pl, linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com

The cpufreq_governor.c only support ondemand and conservative governor.
So, this patch update governor core to support all governors.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
---
 drivers/cpufreq/cpufreq_governor.c | 24 +++++++++++++++++++-----
 drivers/cpufreq/cpufreq_governor.h |  9 +++++++++
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 3e73107..ea282f8 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -86,6 +86,7 @@ void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
 	struct cpu_dbs_common_info *cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
+	struct cs_dbs_tuners *tuners = dbs_data->tuners;
 	struct cpufreq_policy *policy;
 #ifdef CONFIG_CPU_FREQ_STAT
 	struct cpufreq_freqs freq = {0};
@@ -96,8 +97,10 @@ void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
 
 	if (dbs_data->cdata->governor == GOV_ONDEMAND)
 		ignore_nice = od_tuners->ignore_nice;
-	else
+	else if (dbs_data->cdata->governor == GOV_CONSERVATIVE)
 		ignore_nice = cs_tuners->ignore_nice;
+	else
+		ignore_nice = tuners->ignore_nice;
 
 	policy = cdbs->cur_policy;
 
@@ -174,7 +177,8 @@ void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
 	cpufreq_notify_transition(policy, &freq, CPUFREQ_LOADCHECK);
 #endif
 
-	dbs_data->cdata->gov_check_cpu(cpu, max_load);
+	if (dbs_data->cdata->gov_check_cpu)
+		dbs_data->cdata->gov_check_cpu(cpu, max_load);
 }
 EXPORT_SYMBOL_GPL(dbs_check_cpu);
 
@@ -239,9 +243,12 @@ static void set_sampling_rate(struct dbs_data *dbs_data,
 	if (dbs_data->cdata->governor == GOV_CONSERVATIVE) {
 		struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 		cs_tuners->sampling_rate = sampling_rate;
-	} else {
+	} else if (dbs_data->cdata->governor == GOV_ONDEMAND) {
 		struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 		od_tuners->sampling_rate = sampling_rate;
+	} else {
+		struct dbs_tuners *tuners = dbs_data->tuners;
+		tuners->sampling_rate = sampling_rate;
 	}
 }
 
@@ -251,9 +258,11 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 	struct dbs_data *dbs_data;
 	struct od_cpu_dbs_info_s *od_dbs_info = NULL;
 	struct cs_cpu_dbs_info_s *cs_dbs_info = NULL;
+	struct cpu_dbs_info_s *dbs_info = NULL;
 	struct od_ops *od_ops = NULL;
 	struct od_dbs_tuners *od_tuners = NULL;
 	struct cs_dbs_tuners *cs_tuners = NULL;
+	struct dbs_tuners *tuners = NULL;
 	struct cpu_dbs_common_info *cpu_cdbs;
 	unsigned int sampling_rate, latency, ignore_nice, j, cpu = policy->cpu;
 	int io_busy = 0;
@@ -353,13 +362,18 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 		cs_dbs_info = dbs_data->cdata->get_cpu_dbs_info_s(cpu);
 		sampling_rate = cs_tuners->sampling_rate;
 		ignore_nice = cs_tuners->ignore_nice;
-	} else {
+	} else if (dbs_data->cdata->governor == GOV_ONDEMAND) {
 		od_tuners = dbs_data->tuners;
 		od_dbs_info = dbs_data->cdata->get_cpu_dbs_info_s(cpu);
 		sampling_rate = od_tuners->sampling_rate;
 		ignore_nice = od_tuners->ignore_nice;
 		od_ops = dbs_data->cdata->gov_ops;
 		io_busy = od_tuners->io_is_busy;
+	} else {
+		tuners = dbs_data->tuners;
+		dbs_info = dbs_data->cdata->get_cpu_dbs_info_s(cpu);
+		sampling_rate = tuners->sampling_rate;
+		ignore_nice = tuners->ignore_nice;
 	}
 
 	switch (event) {
@@ -394,7 +408,7 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 			cs_dbs_info->down_skip = 0;
 			cs_dbs_info->enable = 1;
 			cs_dbs_info->requested_freq = policy->cur;
-		} else {
+		} else if (dbs_data->cdata->governor == GOV_ONDEMAND) {
 			od_dbs_info->rate_mult = 1;
 			od_dbs_info->sample_type = OD_NORMAL_SAMPLE;
 			od_ops->powersave_bias_init_cpu(cpu);
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index e16a961..55ef8c6 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -163,6 +163,10 @@ struct cs_cpu_dbs_info_s {
 	unsigned int enable:1;
 };
 
+struct cpu_dbs_info_s {
+	struct cpu_dbs_common_info cdbs;
+};
+
 /* Per policy Governers sysfs tunables */
 struct od_dbs_tuners {
 	unsigned int ignore_nice;
@@ -183,6 +187,11 @@ struct cs_dbs_tuners {
 	unsigned int freq_step;
 };
 
+struct dbs_tuners {
+	unsigned int ignore_nice;
+	unsigned int sampling_rate;
+};
+
 /* Common Governer data across policies */
 struct dbs_data;
 struct common_dbs_data {
-- 
1.8.0

