From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 4/5] cpufreq: create cpu/cpufreq/policyX directories
Date: Thu, 15 Oct 2015 21:35:24 +0530
Message-ID: <594e7c8e74ca56cef58d29327518f5223e89e208.1444924623.git.viresh.kumar@linaro.org>
References: <cover.1444924623.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1444924623.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1444924623.git.viresh.kumar@linaro.org>
References: <cover.1444924623.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The cpufreq sysfs interface had been a bit inconsistent as one of the
CPUs for a policy had a real directory within its sysfs 'cpuX' directory
and all other CPUs had links to it. That also made the code a bit
complex as we need to take care of moving the sysfs directory if the CPU
containing the real directory is getting physically hot-unplugged.

Solve this by creating 'policyX' directories (per-policy) in
/sys/devices/system/cpu/cpufreq/ directory, where X is the CPU for which
the policy was first created.

This also removes the need of keeping kobj_cpu and we can remove it now.

Suggested-by: Saravana Kannan <skannan@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 34 ++++------------------------------
 include/linux/cpufreq.h   |  1 -
 2 files changed, 4 insertions(+), 31 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 04222e7bbc73..4fa2215cc6ec 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -910,9 +910,6 @@ static int cpufreq_add_dev_symlink(struct cpufreq_policy *policy)
 
 	/* Some related CPUs might not be present (physically hotplugged) */
 	for_each_cpu(j, policy->real_cpus) {
-		if (j == policy->kobj_cpu)
-			continue;
-
 		ret = add_cpu_dev_symlink(policy, j);
 		if (ret)
 			break;
@@ -926,12 +923,8 @@ static void cpufreq_remove_dev_symlink(struct cpufreq_policy *policy)
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
@@ -1047,8 +1040,8 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	if (!zalloc_cpumask_var(&policy->real_cpus, GFP_KERNEL))
 		goto err_free_rcpumask;
 
-	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq, &dev->kobj,
-				   "cpufreq");
+	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
+				   cpufreq_global_kobject, "policy%u", cpu);
 	if (ret) {
 		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
 		goto err_free_real_cpus;
@@ -1062,10 +1055,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	INIT_WORK(&policy->update, handle_update);
 
 	policy->cpu = cpu;
-
-	/* Set this once on allocation */
-	policy->kobj_cpu = cpu;
-
 	return policy;
 
 err_free_real_cpus:
@@ -1417,22 +1406,7 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
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
