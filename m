From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 03/12] cpufreq: governor: Rename 'cpu_dbs_common_info' to 'cpu_dbs_info'
Date: Thu, 11 Jun 2015 16:21:46 +0530
Message-ID: <09b68d7545c05abf8f1fb485ddb0f4b2cd5a821f.1434019473.git.viresh.kumar@linaro.org>
References: <cover.1434019473.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34141 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbbFKKwW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2015 06:52:22 -0400
Received: by pdbki1 with SMTP id ki1so2462272pdb.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2015 03:52:22 -0700 (PDT)
In-Reply-To: <cover.1434019473.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434019473.git.viresh.kumar@linaro.org>
References: <cover.1434019473.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Its not common info to all CPUs, but a structure representing common
type of cpu info to both governor types. Lets drop 'common_' from its
name.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 19 +++++++++----------
 drivers/cpufreq/cpufreq_governor.h | 13 ++++++-------
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 2149ba7d32a8..529f236f2d05 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -32,7 +32,7 @@ static struct attribute_group *get_sysfs_attr(struct dbs_data *dbs_data)
 
 void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
 {
-	struct cpu_dbs_common_info *cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
+	struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 	struct cpufreq_policy *policy;
@@ -64,7 +64,7 @@ void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
 
 	/* Get Absolute Load */
 	for_each_cpu(j, policy->cpus) {
-		struct cpu_dbs_common_info *j_cdbs;
+		struct cpu_dbs_info *j_cdbs;
 		u64 cur_wall_time, cur_idle_time;
 		unsigned int idle_time, wall_time;
 		unsigned int load;
@@ -163,7 +163,7 @@ EXPORT_SYMBOL_GPL(dbs_check_cpu);
 static inline void __gov_queue_work(int cpu, struct dbs_data *dbs_data,
 		unsigned int delay)
 {
-	struct cpu_dbs_common_info *cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
+	struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
 
 	mod_delayed_work_on(cpu, system_wq, &cdbs->dwork, delay);
 }
@@ -199,7 +199,7 @@ EXPORT_SYMBOL_GPL(gov_queue_work);
 static inline void gov_cancel_work(struct dbs_data *dbs_data,
 		struct cpufreq_policy *policy)
 {
-	struct cpu_dbs_common_info *cdbs;
+	struct cpu_dbs_info *cdbs;
 	int i;
 
 	for_each_cpu(i, policy->cpus) {
@@ -209,8 +209,7 @@ static inline void gov_cancel_work(struct dbs_data *dbs_data,
 }
 
 /* Will return if we need to evaluate cpu load again or not */
-bool need_load_eval(struct cpu_dbs_common_info *cdbs,
-		unsigned int sampling_rate)
+bool need_load_eval(struct cpu_dbs_info *cdbs, unsigned int sampling_rate)
 {
 	if (policy_is_shared(cdbs->cur_policy)) {
 		ktime_t time_now = ktime_get();
@@ -330,7 +329,7 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 {
 	struct common_dbs_data *cdata = dbs_data->cdata;
 	unsigned int sampling_rate, ignore_nice, j, cpu = policy->cpu;
-	struct cpu_dbs_common_info *cpu_cdbs = cdata->get_cpu_cdbs(cpu);
+	struct cpu_dbs_info *cpu_cdbs = cdata->get_cpu_cdbs(cpu);
 	int io_busy = 0;
 
 	if (!policy->cur)
@@ -350,7 +349,7 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 	}
 
 	for_each_cpu(j, policy->cpus) {
-		struct cpu_dbs_common_info *j_cdbs = cdata->get_cpu_cdbs(j);
+		struct cpu_dbs_info *j_cdbs = cdata->get_cpu_cdbs(j);
 		unsigned int prev_load;
 
 		j_cdbs->cur_policy = policy;
@@ -398,7 +397,7 @@ static void cpufreq_governor_stop(struct cpufreq_policy *policy,
 {
 	struct common_dbs_data *cdata = dbs_data->cdata;
 	unsigned int cpu = policy->cpu;
-	struct cpu_dbs_common_info *cpu_cdbs = cdata->get_cpu_cdbs(cpu);
+	struct cpu_dbs_info *cpu_cdbs = cdata->get_cpu_cdbs(cpu);
 
 	if (cdata->governor == GOV_CONSERVATIVE) {
 		struct cs_cpu_dbs_info_s *cs_dbs_info =
@@ -418,7 +417,7 @@ static void cpufreq_governor_limits(struct cpufreq_policy *policy,
 {
 	struct common_dbs_data *cdata = dbs_data->cdata;
 	unsigned int cpu = policy->cpu;
-	struct cpu_dbs_common_info *cpu_cdbs = cdata->get_cpu_cdbs(cpu);
+	struct cpu_dbs_info *cpu_cdbs = cdata->get_cpu_cdbs(cpu);
 
 	if (!cpu_cdbs->cur_policy)
 		return;
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 1bbf8c87fdd5..6b5e33f68064 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -109,7 +109,7 @@ store_one(_gov, file_name)
 
 /* create helper routines */
 #define define_get_cpu_dbs_routines(_dbs_info)				\
-static struct cpu_dbs_common_info *get_cpu_cdbs(int cpu)		\
+static struct cpu_dbs_info *get_cpu_cdbs(int cpu)			\
 {									\
 	return &per_cpu(_dbs_info, cpu).cdbs;				\
 }									\
@@ -129,7 +129,7 @@ static void *get_cpu_dbs_info_s(int cpu)				\
  */
 
 /* Per cpu structures */
-struct cpu_dbs_common_info {
+struct cpu_dbs_info {
 	u64 prev_cpu_idle;
 	u64 prev_cpu_wall;
 	u64 prev_cpu_nice;
@@ -152,7 +152,7 @@ struct cpu_dbs_common_info {
 };
 
 struct od_cpu_dbs_info_s {
-	struct cpu_dbs_common_info cdbs;
+	struct cpu_dbs_info cdbs;
 	struct cpufreq_frequency_table *freq_table;
 	unsigned int freq_lo;
 	unsigned int freq_lo_jiffies;
@@ -162,7 +162,7 @@ struct od_cpu_dbs_info_s {
 };
 
 struct cs_cpu_dbs_info_s {
-	struct cpu_dbs_common_info cdbs;
+	struct cpu_dbs_info cdbs;
 	unsigned int down_skip;
 	unsigned int requested_freq;
 	unsigned int enable:1;
@@ -203,7 +203,7 @@ struct common_dbs_data {
 	 */
 	struct dbs_data *gdbs_data;
 
-	struct cpu_dbs_common_info *(*get_cpu_cdbs)(int cpu);
+	struct cpu_dbs_info *(*get_cpu_cdbs)(int cpu);
 	void *(*get_cpu_dbs_info_s)(int cpu);
 	void (*gov_dbs_timer)(struct work_struct *work);
 	void (*gov_check_cpu)(int cpu, unsigned int load);
@@ -264,8 +264,7 @@ static ssize_t show_sampling_rate_min_gov_pol				\
 extern struct mutex cpufreq_governor_lock;
 
 void dbs_check_cpu(struct dbs_data *dbs_data, int cpu);
-bool need_load_eval(struct cpu_dbs_common_info *cdbs,
-		unsigned int sampling_rate);
+bool need_load_eval(struct cpu_dbs_info *cdbs, unsigned int sampling_rate);
 int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 		struct common_dbs_data *cdata, unsigned int event);
 void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
-- 
2.4.0

