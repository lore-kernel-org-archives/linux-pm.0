From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 08/14] cpufreq: Track cpu managing sysfs kobjects separately
Date: Mon, 18 May 2015 10:43:31 +0530
Message-ID: <84aa63d8a244c2c7095ff41a2bd0013d8b95f290.1431924457.git.viresh.kumar@linaro.org>
References: <cover.1431924457.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35887 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbbERFOV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 01:14:21 -0400
Received: by pdfh10 with SMTP id h10so133410985pdf.3
        for <linux-pm@vger.kernel.org>; Sun, 17 May 2015 22:14:20 -0700 (PDT)
In-Reply-To: <cover.1431924457.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1431924457.git.viresh.kumar@linaro.org>
References: <cover.1431924457.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>, Viresh Kumar <viresh.kumar@linaro.org>

From: Saravana Kannan <skannan@codeaurora.org>

In order to prepare for the next few commits, that will stop migrating
sysfs files on cpu hotplug, this patch starts managing sysfs-cpu
separately.

The behavior is still the same as we are still migrating sysfs files on
hotplug, later commits would change that.

Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 11 +++++++----
 include/linux/cpufreq.h   |  4 +++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 983961ba2f72..d7fc3d9294f8 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -966,7 +966,7 @@ static int cpufreq_add_dev_symlink(struct cpufreq_policy *policy)
 	for_each_cpu(j, policy->cpus) {
 		struct device *cpu_dev;
 
-		if (j == policy->cpu)
+		if (j == policy->kobj_cpu)
 			continue;
 
 		pr_debug("Adding link for CPU: %u\n", j);
@@ -1185,6 +1185,7 @@ static int update_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu,
 
 	down_write(&policy->rwsem);
 	policy->cpu = cpu;
+	policy->kobj_cpu = cpu;
 	up_write(&policy->rwsem);
 
 	return 0;
@@ -1242,10 +1243,12 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
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
 
@@ -1424,7 +1427,7 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
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
2.4.0

