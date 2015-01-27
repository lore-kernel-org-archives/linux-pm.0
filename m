From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 11/18] cpufreq: Track cpu managing sysfs kobjects separately
Date: Tue, 27 Jan 2015 14:06:17 +0530
Message-ID: <0e27bdf1275b50c03051a289f75b9bcc68947639.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:55532 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074AbbA0IhW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 03:37:22 -0500
Received: by mail-pa0-f45.google.com with SMTP id et14so17162226pad.4
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2015 00:37:22 -0800 (PST)
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

In order to prepare for the next few commits, that will stop migrating sysfs
files on cpu hotplug, this patch starts managing sysfs-cpu separately.

The behavior is still the same as we are still migrating sysfs files on hotplug,
later commits would change that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 11 +++++++----
 include/linux/cpufreq.h   |  4 +++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index fffa37136b7b..4476471c594e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -921,7 +921,7 @@ static int cpufreq_add_dev_symlink(struct cpufreq_policy *policy)
 	for_each_cpu(j, policy->cpus) {
 		struct device *cpu_dev;
 
-		if (j == policy->cpu)
+		if (j == policy->kobj_cpu)
 			continue;
 
 		pr_debug("Adding link for CPU: %u\n", j);
@@ -1126,6 +1126,7 @@ static int update_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu,
 
 	down_write(&policy->rwsem);
 	policy->cpu = cpu;
+	policy->kobj_cpu = cpu;
 	up_write(&policy->rwsem);
 
 	return 0;
@@ -1188,10 +1189,12 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
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
 
@@ -1393,7 +1396,7 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 				CPUFREQ_NAME_LEN);
 	}
 
-	if (cpu != policy->cpu) {
+	if (cpu != policy->kobj_cpu) {
 		sysfs_remove_link(&dev->kobj, "cpufreq");
 	} else if (cpus > 1) {
 		/* Nominate new CPU */
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index e326cddef6db..9b8937f027fb 100644
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

