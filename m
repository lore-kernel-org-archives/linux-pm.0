From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/3] cpufreq: governor: register notifier from cs_init()
Date: Wed,  3 Jun 2015 15:57:11 +0530
Message-ID: <7c79b6ede0407a940da2076f562360990ef0061a.1433326032.git.viresh.kumar@linaro.org>
References: <cover.1433326032.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35684 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432AbbFCK1w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2015 06:27:52 -0400
Received: by pdbnf5 with SMTP id nf5so4605731pdb.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2015 03:27:52 -0700 (PDT)
In-Reply-To: <cover.1433326032.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1433326032.git.viresh.kumar@linaro.org>
References: <cover.1433326032.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Notifiers are required only for conservative governor and the common
governor code is unnecessarily polluted with that. Handle that from
cs_init/exit() instead of cpufreq_governor_dbs().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 26 +++++++++++++++-----------
 drivers/cpufreq/cpufreq_governor.c     | 22 +++-------------------
 drivers/cpufreq/cpufreq_governor.h     |  8 ++------
 drivers/cpufreq/cpufreq_ondemand.c     |  4 ++--
 4 files changed, 22 insertions(+), 38 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 25a70d06c5bf..75f875bb155e 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -148,6 +148,10 @@ static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
 	return 0;
 }
 
+static struct notifier_block cs_cpufreq_notifier_block = {
+	.notifier_call = dbs_cpufreq_notifier,
+};
+
 /************************** sysfs interface ************************/
 static struct common_dbs_data cs_dbs_cdata;
 
@@ -317,7 +321,7 @@ static struct attribute_group cs_attr_group_gov_pol = {
 
 /************************** sysfs end ************************/
 
-static int cs_init(struct dbs_data *dbs_data)
+static int cs_init(struct dbs_data *dbs_data, bool notify)
 {
 	struct cs_dbs_tuners *tuners;
 
@@ -336,25 +340,26 @@ static int cs_init(struct dbs_data *dbs_data)
 	dbs_data->tuners = tuners;
 	dbs_data->min_sampling_rate = MIN_SAMPLING_RATE_RATIO *
 		jiffies_to_usecs(10);
+
+	if (notify)
+		cpufreq_register_notifier(&cs_cpufreq_notifier_block,
+					  CPUFREQ_TRANSITION_NOTIFIER);
+
 	mutex_init(&dbs_data->mutex);
 	return 0;
 }
 
-static void cs_exit(struct dbs_data *dbs_data)
+static void cs_exit(struct dbs_data *dbs_data, bool notify)
 {
+	if (notify)
+		cpufreq_unregister_notifier(&cs_cpufreq_notifier_block,
+					    CPUFREQ_TRANSITION_NOTIFIER);
+
 	kfree(dbs_data->tuners);
 }
 
 define_get_cpu_dbs_routines(cs_cpu_dbs_info);
 
-static struct notifier_block cs_cpufreq_notifier_block = {
-	.notifier_call = dbs_cpufreq_notifier,
-};
-
-static struct cs_ops cs_ops = {
-	.notifier_block = &cs_cpufreq_notifier_block,
-};
-
 static struct common_dbs_data cs_dbs_cdata = {
 	.governor = GOV_CONSERVATIVE,
 	.attr_group_gov_sys = &cs_attr_group_gov_sys,
@@ -363,7 +368,6 @@ static struct common_dbs_data cs_dbs_cdata = {
 	.get_cpu_dbs_info_s = get_cpu_dbs_info_s,
 	.gov_dbs_timer = cs_dbs_timer,
 	.gov_check_cpu = cs_check_cpu,
-	.gov_ops = &cs_ops,
 	.init = cs_init,
 	.exit = cs_exit,
 };
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 1b44496b2d2b..d64a82e6481a 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -278,7 +278,7 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 
 		dbs_data->cdata = cdata;
 		dbs_data->usage_count = 1;
-		rc = cdata->init(dbs_data);
+		rc = cdata->init(dbs_data, !policy->governor->initialized);
 		if (rc) {
 			pr_err("%s: POLICY_INIT: init() failed\n", __func__);
 			kfree(dbs_data);
@@ -291,7 +291,7 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 		rc = sysfs_create_group(get_governor_parent_kobj(policy),
 				get_sysfs_attr(dbs_data));
 		if (rc) {
-			cdata->exit(dbs_data);
+			cdata->exit(dbs_data, !policy->governor->initialized);
 			kfree(dbs_data);
 			return rc;
 		}
@@ -309,14 +309,6 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 		set_sampling_rate(dbs_data, max(dbs_data->min_sampling_rate,
 					latency * LATENCY_MULTIPLIER));
 
-		if ((cdata->governor == GOV_CONSERVATIVE) &&
-				(!policy->governor->initialized)) {
-			struct cs_ops *cs_ops = dbs_data->cdata->gov_ops;
-
-			cpufreq_register_notifier(cs_ops->notifier_block,
-					CPUFREQ_TRANSITION_NOTIFIER);
-		}
-
 		if (!have_governor_per_policy())
 			cdata->gdbs_data = dbs_data;
 
@@ -329,15 +321,7 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 			if (!have_governor_per_policy())
 				cpufreq_put_global_kobject();
 
-			if ((dbs_data->cdata->governor == GOV_CONSERVATIVE) &&
-				(policy->governor->initialized == 1)) {
-				struct cs_ops *cs_ops = dbs_data->cdata->gov_ops;
-
-				cpufreq_unregister_notifier(cs_ops->notifier_block,
-						CPUFREQ_TRANSITION_NOTIFIER);
-			}
-
-			cdata->exit(dbs_data);
+			cdata->exit(dbs_data, policy->governor->initialized == 1);
 			kfree(dbs_data);
 			cdata->gdbs_data = NULL;
 		}
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index cc401d147e72..1690120df487 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -208,8 +208,8 @@ struct common_dbs_data {
 	void *(*get_cpu_dbs_info_s)(int cpu);
 	void (*gov_dbs_timer)(struct work_struct *work);
 	void (*gov_check_cpu)(int cpu, unsigned int load);
-	int (*init)(struct dbs_data *dbs_data);
-	void (*exit)(struct dbs_data *dbs_data);
+	int (*init)(struct dbs_data *dbs_data, bool notify);
+	void (*exit)(struct dbs_data *dbs_data, bool notify);
 
 	/* Governor specific ops, see below */
 	void *gov_ops;
@@ -234,10 +234,6 @@ struct od_ops {
 	void (*freq_increase)(struct cpufreq_policy *policy, unsigned int freq);
 };
 
-struct cs_ops {
-	struct notifier_block *notifier_block;
-};
-
 static inline int delay_for_sampling_rate(unsigned int sampling_rate)
 {
 	int delay = usecs_to_jiffies(sampling_rate);
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index ad3f38fd3eb9..4fe78a9caa04 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -475,7 +475,7 @@ static struct attribute_group od_attr_group_gov_pol = {
 
 /************************** sysfs end ************************/
 
-static int od_init(struct dbs_data *dbs_data)
+static int od_init(struct dbs_data *dbs_data, bool notify)
 {
 	struct od_dbs_tuners *tuners;
 	u64 idle_time;
@@ -517,7 +517,7 @@ static int od_init(struct dbs_data *dbs_data)
 	return 0;
 }
 
-static void od_exit(struct dbs_data *dbs_data)
+static void od_exit(struct dbs_data *dbs_data, bool notify)
 {
 	kfree(dbs_data->tuners);
 }
-- 
2.4.0

