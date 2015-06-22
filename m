From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 03/10] cpufreq: conservative: remove 'enable' field
Date: Mon, 22 Jun 2015 13:32:50 +0530
Message-ID: <e5627369b56ae3dcd00d7243e00618992c457cce.1434959517.git.viresh.kumar@linaro.org>
References: <cover.1434959517.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35184 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755999AbbFVIDS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 04:03:18 -0400
Received: by pdbci14 with SMTP id ci14so75091533pdb.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2015 01:03:18 -0700 (PDT)
In-Reply-To: <cover.1434959517.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434959517.git.viresh.kumar@linaro.org>
References: <cover.1434959517.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Conservative governor has its own 'enable' field to check two things:
- If conservative governor is used for a CPU or not
- If governor is currently enabled or not, as there can be a race around
  the notifier being called while it was getting unregistered from
  cpufreq_governor_dbs().

The first one can be checked by comparing policy->governor with
'cpufreq_gov_conservative' and the second one isn't that important. In
the worst case, we will end up updating dbs_info->requested_freq. And
that wouldn't do any harm.

Lets get rid of this field.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 26 +++++++++++++++-----------
 drivers/cpufreq/cpufreq_governor.c     | 12 +-----------
 drivers/cpufreq/cpufreq_governor.h     |  1 -
 3 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 1e3cabfb2b57..f53719e5bed9 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -23,6 +23,19 @@
 
 static DEFINE_PER_CPU(struct cs_cpu_dbs_info_s, cs_cpu_dbs_info);
 
+static int cs_cpufreq_governor_dbs(struct cpufreq_policy *policy,
+				   unsigned int event);
+
+#ifndef CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
+static
+#endif
+struct cpufreq_governor cpufreq_gov_conservative = {
+	.name			= "conservative",
+	.governor		= cs_cpufreq_governor_dbs,
+	.max_transition_latency	= TRANSITION_LATENCY_LIMIT,
+	.owner			= THIS_MODULE,
+};
+
 static inline unsigned int get_freq_target(struct cs_dbs_tuners *cs_tuners,
 					   struct cpufreq_policy *policy)
 {
@@ -124,7 +137,8 @@ static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
 	if (!policy)
 		return 0;
 
-	if (!dbs_info->enable)
+	/* policy isn't governed by conservative governor */
+	if (policy->governor != &cpufreq_gov_conservative)
 		goto policy_put;
 
 	/*
@@ -371,16 +385,6 @@ static int cs_cpufreq_governor_dbs(struct cpufreq_policy *policy,
 	return cpufreq_governor_dbs(policy, &cs_dbs_cdata, event);
 }
 
-#ifndef CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
-static
-#endif
-struct cpufreq_governor cpufreq_gov_conservative = {
-	.name			= "conservative",
-	.governor		= cs_cpufreq_governor_dbs,
-	.max_transition_latency	= TRANSITION_LATENCY_LIMIT,
-	.owner			= THIS_MODULE,
-};
-
 static int __init cpufreq_gov_dbs_init(void)
 {
 	return cpufreq_register_governor(&cpufreq_gov_conservative);
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index af63402a94a9..836aefd03c1b 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -463,7 +463,6 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 			cdata->get_cpu_dbs_info_s(cpu);
 
 		cs_dbs_info->down_skip = 0;
-		cs_dbs_info->enable = 1;
 		cs_dbs_info->requested_freq = policy->cur;
 	} else {
 		struct od_ops *od_ops = cdata->gov_ops;
@@ -482,9 +481,7 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 static int cpufreq_governor_stop(struct cpufreq_policy *policy,
 				 struct dbs_data *dbs_data)
 {
-	struct common_dbs_data *cdata = dbs_data->cdata;
-	unsigned int cpu = policy->cpu;
-	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
+	struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(policy->cpu);
 	struct cpu_common_dbs_info *ccdbs = cdbs->ccdbs;
 
 	/* State should be equivalent to START */
@@ -493,13 +490,6 @@ static int cpufreq_governor_stop(struct cpufreq_policy *policy,
 
 	gov_cancel_work(dbs_data, policy);
 
-	if (cdata->governor == GOV_CONSERVATIVE) {
-		struct cs_cpu_dbs_info_s *cs_dbs_info =
-			cdata->get_cpu_dbs_info_s(cpu);
-
-		cs_dbs_info->enable = 0;
-	}
-
 	ccdbs->policy = NULL;
 	mutex_destroy(&ccdbs->timer_mutex);
 	return 0;
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 2125c299c602..a0d24149f18c 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -170,7 +170,6 @@ struct cs_cpu_dbs_info_s {
 	struct cpu_dbs_info cdbs;
 	unsigned int down_skip;
 	unsigned int requested_freq;
-	unsigned int enable:1;
 };
 
 /* Per policy Governors sysfs tunables */
-- 
2.4.0

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
