From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v3 10/10] cpufreq: governor: Drop cpu argument from dbs_check_cpu()
Date: Sat, 06 Feb 2016 13:50:24 +0100
Message-ID: <3908268.r5qEEZP0qG@vostro.rjw.lan>
References: <3705929.bslqXH980s@vostro.rjw.lan> <9008098.QDD8C89zDx@vostro.rjw.lan> <2367498.ClbHvSsNAg@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44724 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752154AbcBFMtS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 6 Feb 2016 07:49:18 -0500
In-Reply-To: <2367498.ClbHvSsNAg@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since policy->cpu is always passed as the second argument to
dbs_check_cpu(), it is not really necessary to pass it, because
the function can obtain that value via its first argument just fine.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Changes from v2:
- Rebase on top of https://patchwork.kernel.org/patch/8241231/
  and on the v3 of [8/10] without [9/10].

---
 drivers/cpufreq/cpufreq_conservative.c |    2 +-
 drivers/cpufreq/cpufreq_governor.c     |    8 ++++----
 drivers/cpufreq/cpufreq_governor.h     |    2 +-
 drivers/cpufreq/cpufreq_ondemand.c     |    6 ++----
 4 files changed, 8 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -279,7 +279,7 @@ static ssize_t show_sampling_rate_min_go
 
 extern struct mutex dbs_data_mutex;
 extern struct mutex cpufreq_governor_lock;
-void dbs_check_cpu(struct cpufreq_policy *policy, int cpu);
+void dbs_check_cpu(struct cpufreq_policy *policy);
 int cpufreq_governor_dbs(struct cpufreq_policy *policy, unsigned int event);
 void od_register_powersave_bias_handler(unsigned int (*f)
 		(struct cpufreq_policy *, unsigned int, unsigned int),
Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -190,9 +190,7 @@ static void od_check_cpu(int cpu, unsign
 static unsigned int od_dbs_timer(struct cpufreq_policy *policy)
 {
 	struct dbs_data *dbs_data = policy->governor_data;
-	unsigned int cpu = policy->cpu;
-	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info,
-			cpu);
+	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info, policy->cpu);
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	int delay = 0, sample_type = dbs_info->sample_type;
 
@@ -203,7 +201,7 @@ static unsigned int od_dbs_timer(struct
 		__cpufreq_driver_target(policy, dbs_info->freq_lo,
 					CPUFREQ_RELATION_H);
 	} else {
-		dbs_check_cpu(policy, cpu);
+		dbs_check_cpu(policy);
 		if (dbs_info->freq_lo) {
 			/* Setup timer for SUB_SAMPLE */
 			dbs_info->sample_type = OD_SUB_SAMPLE;
Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
@@ -107,7 +107,7 @@ static unsigned int cs_dbs_timer(struct
 	struct dbs_data *dbs_data = policy->governor_data;
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 
-	dbs_check_cpu(policy, policy->cpu);
+	dbs_check_cpu(policy);
 	return delay_for_sampling_rate(cs_tuners->sampling_rate);
 }
 
Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -31,8 +31,9 @@ static struct attribute_group *get_sysfs
 		gov->attr_group_gov_pol : gov->attr_group_gov_sys;
 }
 
-void dbs_check_cpu(struct cpufreq_policy *policy, int cpu)
+void dbs_check_cpu(struct cpufreq_policy *policy)
 {
+	int cpu = policy->cpu;
 	struct dbs_governor *gov = dbs_governor_of(policy);
 	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(cpu);
 	struct dbs_data *dbs_data = policy->governor_data;
@@ -516,8 +517,7 @@ static int cpufreq_governor_stop(struct
 static int cpufreq_governor_limits(struct cpufreq_policy *policy)
 {
 	struct dbs_governor *gov = dbs_governor_of(policy);
-	unsigned int cpu = policy->cpu;
-	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(cpu);
+	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(policy->cpu);
 
 	/* State should be equivalent to START */
 	if (!cdbs->policy_dbs || !cdbs->policy_dbs->policy)
@@ -530,7 +530,7 @@ static int cpufreq_governor_limits(struc
 	else if (policy->min > cdbs->policy_dbs->policy->cur)
 		__cpufreq_driver_target(cdbs->policy_dbs->policy, policy->min,
 					CPUFREQ_RELATION_L);
-	dbs_check_cpu(policy, cpu);
+	dbs_check_cpu(policy);
 	mutex_unlock(&cdbs->policy_dbs->timer_mutex);
 
 	return 0;

