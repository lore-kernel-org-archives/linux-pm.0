From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/2] cpufreq: don't pass cpu to cpufreq_add_dev_{symlink|interface}
Date: Tue, 30 Jul 2013 19:06:34 +0530
Message-ID: <a7c7222e0dd9d1d0ff4e139ca0f39673f96c04e0.1375191318.git.viresh.kumar@linaro.org>
References: <2095cb9de80d87867dbfa42f8433f766891c93ab.1375191318.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2095cb9de80d87867dbfa42f8433f766891c93ab.1375191318.git.viresh.kumar@linaro.org>
In-Reply-To: <2095cb9de80d87867dbfa42f8433f766891c93ab.1375191318.git.viresh.kumar@linaro.org>
References: <2095cb9de80d87867dbfa42f8433f766891c93ab.1375191318.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Pointer to struct cpufreq_policy is already passed to these routines and so we
don't need to send policy->cpu to them as well. So, get rid of this extra
argument and use policy->cpu everywhere.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 35e1a03..80c0e20 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -806,8 +806,7 @@ void cpufreq_sysfs_remove_file(const struct attribute *attr)
 EXPORT_SYMBOL(cpufreq_sysfs_remove_file);
 
 /* symlink affected CPUs */
-static int cpufreq_add_dev_symlink(unsigned int cpu,
-				   struct cpufreq_policy *policy)
+static int cpufreq_add_dev_symlink(struct cpufreq_policy *policy)
 {
 	unsigned int j;
 	int ret = 0;
@@ -815,11 +814,11 @@ static int cpufreq_add_dev_symlink(unsigned int cpu,
 	for_each_cpu(j, policy->cpus) {
 		struct device *cpu_dev;
 
-		if (j == cpu)
+		if (j == policy->cpu)
 			continue;
 
 		pr_debug("Adding link for CPU: %u\n", j);
-		cpufreq_cpu_get(cpu);
+		cpufreq_cpu_get(policy->cpu);
 		cpu_dev = get_cpu_device(j);
 		ret = sysfs_create_link(&cpu_dev->kobj, &policy->kobj,
 					"cpufreq");
@@ -831,8 +830,7 @@ static int cpufreq_add_dev_symlink(unsigned int cpu,
 	return ret;
 }
 
-static int cpufreq_add_dev_interface(unsigned int cpu,
-				     struct cpufreq_policy *policy,
+static int cpufreq_add_dev_interface(struct cpufreq_policy *policy,
 				     struct device *dev)
 {
 	struct freq_attr **drv_attr;
@@ -868,7 +866,7 @@ static int cpufreq_add_dev_interface(unsigned int cpu,
 			goto err_out_kobj_put;
 	}
 
-	ret = cpufreq_add_dev_symlink(cpu, policy);
+	ret = cpufreq_add_dev_symlink(policy);
 	if (ret)
 		goto err_out_kobj_put;
 
@@ -1097,7 +1095,7 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif,
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 	if (!frozen) {
-		ret = cpufreq_add_dev_interface(cpu, policy, dev);
+		ret = cpufreq_add_dev_interface(policy, dev);
 		if (ret)
 			goto err_out_unregister;
 	}
-- 
1.7.12.rc2.18.g61b472e
