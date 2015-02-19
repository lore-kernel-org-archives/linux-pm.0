From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 14/20] cpufreq: Track cpu managing sysfs kobjects separately
Date: Thu, 19 Feb 2015 17:02:16 +0530
Message-ID: <58ae61a8e5c09f94140d68f3c081559823fa885f.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:45020 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449AbbBSLeQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Feb 2015 06:34:16 -0500
Received: by pdbnh10 with SMTP id nh10so8247287pdb.11
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2015 03:34:15 -0800 (PST)
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

From: Saravana Kannan <skannan@codeaurora.org>

In order to prepare for the next few commits, that will stop migrating sysfs
files on cpu hotplug, this patch starts managing sysfs-cpu separately.

The behavior is still the same as we are still migrating sysfs files on hotplug,
later commits would change that.

Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 11 +++++++----
 include/linux/cpufreq.h   |  4 +++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 155e6ff2fa85..fff08145d9ff 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -981,7 +981,7 @@ static int cpufreq_add_dev_symlink(struct cpufreq_policy *policy)
 	for_each_cpu(j, policy->cpus) {
 		struct device *cpu_dev;
 
-		if (j == policy->cpu)
+		if (j == policy->kobj_cpu)
 			continue;
 
 		pr_debug("Adding link for CPU: %u\n", j);
@@ -1200,6 +1200,7 @@ static int update_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu,
 
 	down_write(&policy->rwsem);
 	policy->cpu = cpu;
+	policy->kobj_cpu = cpu;
 	up_write(&policy->rwsem);
 
 	return 0;
@@ -1257,10 +1258,12 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	 * the creation of a brand new one. So we need to perform this update
 	 * by invoking update_policy_cpu().
 	 */
-	if (recover_policy && cpu != policy->cpu)
+	if (recover_policy && cpu != policy->cpu) {
 		WARN_ON(update_policy_cpu(policy, cpu, dev));
-	else
+	} else {
 		policy->cpu = cpu;
+		policy->kobj_cpu = cpu;
+	}
 
 	cpumask_copy(policy->cpus, cpumask_of(cpu));
 
@@ -1439,7 +1442,7 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 			CPUFREQ_NAME_LEN);
 	up_write(&policy->rwsem);
 
-	if (cpu != policy->cpu) {
+	if (cpu != policy->kobj_cpu) {
 		sysfs_remove_link(&dev->kobj, "cpufreq");
 	} else if (cpus > 1) {
 		/* Nominate new CPU */
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 48e37c07eb84..29ad97c34fd5 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -65,7 +65,9 @@ struct cpufreq_policy {
 
 	unsigned int		shared_type; /* ACPI: ANY or ALL affected CPUs
 						should set cpufreq */
-	unsigned int		cpu;    /* cpu nr of CPU managing this policy */
+	unsigned int		cpu;    /* cpu managing this policy, must be online */
+	unsigned int		kobj_cpu; /* cpu managing sysfs files, can be offline */
+
 	struct clk		*clk;
 	struct cpufreq_cpuinfo	cpuinfo;/* see above */
 
-- 
2.3.0.rc0.44.ga94655d

