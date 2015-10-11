From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/5] cpufreq: create cpu/cpufreq at boot time
Date: Sun, 11 Oct 2015 22:51:11 +0530
Message-ID: <6085eff28ecfa9af572739844cce24e4e7f190a2.1444583718.git.viresh.kumar@linaro.org>
References: <cover.1444583718.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:32977 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839AbbJKRVd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 11 Oct 2015 13:21:33 -0400
Received: by pacex6 with SMTP id ex6so4411054pac.0
        for <linux-pm@vger.kernel.org>; Sun, 11 Oct 2015 10:21:33 -0700 (PDT)
In-Reply-To: <cover.1444583718.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1444583718.git.viresh.kumar@linaro.org>
References: <cover.1444583718.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>

Later patches will need to create policy specific directories in
/sys/devices/system/cpu/cpufreq/ directory and so the cpufreq directory
wouldn't be ever empty.

And so no fun creating/destroying it on need basis anymore. Create it
once on system boot.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c          | 32 ++------------------------------
 drivers/cpufreq/cpufreq_governor.c | 20 +++++---------------
 include/linux/cpufreq.h            |  2 --
 3 files changed, 7 insertions(+), 47 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b32521432db4..db688d18a189 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -883,43 +883,15 @@ static struct kobj_type ktype_cpufreq = {
 struct kobject *cpufreq_global_kobject;
 EXPORT_SYMBOL(cpufreq_global_kobject);
 
-static int cpufreq_global_kobject_usage;
-
-int cpufreq_get_global_kobject(void)
-{
-	if (!cpufreq_global_kobject_usage++)
-		return kobject_add(cpufreq_global_kobject,
-				&cpu_subsys.dev_root->kobj, "%s", "cpufreq");
-
-	return 0;
-}
-EXPORT_SYMBOL(cpufreq_get_global_kobject);
-
-void cpufreq_put_global_kobject(void)
-{
-	if (!--cpufreq_global_kobject_usage)
-		kobject_del(cpufreq_global_kobject);
-}
-EXPORT_SYMBOL(cpufreq_put_global_kobject);
-
 int cpufreq_sysfs_create_file(const struct attribute *attr)
 {
-	int ret = cpufreq_get_global_kobject();
-
-	if (!ret) {
-		ret = sysfs_create_file(cpufreq_global_kobject, attr);
-		if (ret)
-			cpufreq_put_global_kobject();
-	}
-
-	return ret;
+	return sysfs_create_file(cpufreq_global_kobject, attr);
 }
 EXPORT_SYMBOL(cpufreq_sysfs_create_file);
 
 void cpufreq_sysfs_remove_file(const struct attribute *attr)
 {
 	sysfs_remove_file(cpufreq_global_kobject, attr);
-	cpufreq_put_global_kobject();
 }
 EXPORT_SYMBOL(cpufreq_sysfs_remove_file);
 
@@ -2589,7 +2561,7 @@ static int __init cpufreq_core_init(void)
 	if (cpufreq_disabled())
 		return -ENODEV;
 
-	cpufreq_global_kobject = kobject_create();
+	cpufreq_global_kobject = kobject_create_and_add("cpufreq", &cpu_subsys.dev_root->kobj);
 	BUG_ON(!cpufreq_global_kobject);
 
 	register_syscore_ops(&cpufreq_syscore_ops);
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 750626d8fb03..11258c4c1b17 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -348,29 +348,21 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy,
 	set_sampling_rate(dbs_data, max(dbs_data->min_sampling_rate,
 					latency * LATENCY_MULTIPLIER));
 
-	if (!have_governor_per_policy()) {
-		if (WARN_ON(cpufreq_get_global_kobject())) {
-			ret = -EINVAL;
-			goto cdata_exit;
-		}
+	if (!have_governor_per_policy())
 		cdata->gdbs_data = dbs_data;
-	}
 
 	ret = sysfs_create_group(get_governor_parent_kobj(policy),
 				 get_sysfs_attr(dbs_data));
 	if (ret)
-		goto put_kobj;
+		goto reset_gdbs_data;
 
 	policy->governor_data = dbs_data;
 
 	return 0;
 
-put_kobj:
-	if (!have_governor_per_policy()) {
+reset_gdbs_data:
+	if (!have_governor_per_policy())
 		cdata->gdbs_data = NULL;
-		cpufreq_put_global_kobject();
-	}
-cdata_exit:
 	cdata->exit(dbs_data, !policy->governor->initialized);
 free_common_dbs_info:
 	free_common_dbs_info(policy, cdata);
@@ -394,10 +386,8 @@ static int cpufreq_governor_exit(struct cpufreq_policy *policy,
 		sysfs_remove_group(get_governor_parent_kobj(policy),
 				   get_sysfs_attr(dbs_data));
 
-		if (!have_governor_per_policy()) {
+		if (!have_governor_per_policy())
 			cdata->gdbs_data = NULL;
-			cpufreq_put_global_kobject();
-		}
 
 		cdata->exit(dbs_data, policy->governor->initialized == 1);
 		kfree(dbs_data);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index dca22de98d94..338bf0e59bb8 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -149,8 +149,6 @@ static inline bool policy_is_shared(struct cpufreq_policy *policy)
 
 /* /sys/devices/system/cpu/cpufreq: entry point for global variables */
 extern struct kobject *cpufreq_global_kobject;
-int cpufreq_get_global_kobject(void);
-void cpufreq_put_global_kobject(void);
 int cpufreq_sysfs_create_file(const struct attribute *attr);
 void cpufreq_sysfs_remove_file(const struct attribute *attr);
 
-- 
2.4.0

