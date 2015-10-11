From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4/5] cpufreq: create cpu/cpufreq/policyX directories
Date: Sun, 11 Oct 2015 22:51:13 +0530
Message-ID: <dd7e6cab3e879e94305c0fca1ea6033e79d166ca.1444583718.git.viresh.kumar@linaro.org>
References: <cover.1444583718.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35153 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbbJKRVn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 11 Oct 2015 13:21:43 -0400
Received: by pabve7 with SMTP id ve7so74364210pab.2
        for <linux-pm@vger.kernel.org>; Sun, 11 Oct 2015 10:21:42 -0700 (PDT)
In-Reply-To: <cover.1444583718.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1444583718.git.viresh.kumar@linaro.org>
References: <cover.1444583718.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>

The cpufreq sysfs interface had been a bit inconsistent as one of the
CPUs for a policy had a real directory within its sysfs 'cpuX' directory
and all other CPUs had links to it. That also made the code a bit
complex as we need to take care of moving the sysfs directory if the CPU
containing the real directory is getting physically hot-unplugged.

Solve this by creating 'policyX' directories (per-policy) in
/sys/devices/system/cpu/cpufreq/ directory, where X is the CPU for which
the policy was first created.

This also removes the need of keeping kobj_cpu and we can remove it now.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 34 ++++------------------------------
 include/linux/cpufreq.h   |  1 -
 2 files changed, 4 insertions(+), 31 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 2cb0e3b8170e..58aabe0f2d2c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -917,9 +917,6 @@ static int cpufreq_add_dev_symlink(struct cpufreq_policy *policy)
 
 	/* Some related CPUs might not be present (physically hotplugged) */
 	for_each_cpu(j, policy->real_cpus) {
-		if (j == policy->kobj_cpu)
-			continue;
-
 		ret = add_cpu_dev_symlink(policy, j);
 		if (ret)
 			break;
@@ -933,12 +930,8 @@ static void cpufreq_remove_dev_symlink(struct cpufreq_policy *policy)
 	unsigned int j;
 
 	/* Some related CPUs might not be present (physically hotplugged) */
-	for_each_cpu(j, policy->real_cpus) {
-		if (j == policy->kobj_cpu)
-			continue;
-
+	for_each_cpu(j, policy->real_cpus)
 		remove_cpu_dev_symlink(policy, j);
-	}
 }
 
 static int cpufreq_add_dev_interface(struct cpufreq_policy *policy)
@@ -1054,8 +1047,8 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	if (!zalloc_cpumask_var(&policy->real_cpus, GFP_KERNEL))
 		goto err_free_rcpumask;
 
-	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq, &dev->kobj,
-				   "cpufreq");
+	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
+				   cpufreq_global_kobject, "policy%u", cpu);
 	if (ret) {
 		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
 		goto err_free_real_cpus;
@@ -1069,10 +1062,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	INIT_WORK(&policy->update, handle_update);
 
 	policy->cpu = cpu;
-
-	/* Set this once on allocation */
-	policy->kobj_cpu = cpu;
-
 	return policy;
 
 err_free_real_cpus:
@@ -1424,22 +1413,7 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 		return;
 	}
 
-	if (cpu != policy->kobj_cpu) {
-		remove_cpu_dev_symlink(policy, cpu);
-	} else {
-		/*
-		 * The CPU owning the policy object is going away.  Move it to
-		 * another suitable CPU.
-		 */
-		unsigned int new_cpu = cpumask_first(policy->real_cpus);
-		struct device *new_dev = get_cpu_device(new_cpu);
-
-		dev_dbg(dev, "%s: Moving policy object to CPU%u\n", __func__, new_cpu);
-
-		sysfs_remove_link(&new_dev->kobj, "cpufreq");
-		policy->kobj_cpu = new_cpu;
-		WARN_ON(kobject_move(&policy->kobj, &new_dev->kobj));
-	}
+	remove_cpu_dev_symlink(policy, cpu);
 }
 
 static void handle_update(struct work_struct *work)
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 9623218d996a..ef4c5b1a860f 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -65,7 +65,6 @@ struct cpufreq_policy {
 	unsigned int		shared_type; /* ACPI: ANY or ALL affected CPUs
 						should set cpufreq */
 	unsigned int		cpu;    /* cpu managing this policy, must be online */
-	unsigned int		kobj_cpu; /* cpu managing sysfs files, can be offline */
 
 	struct clk		*clk;
 	struct cpufreq_cpuinfo	cpuinfo;/* see above */
-- 
2.4.0

