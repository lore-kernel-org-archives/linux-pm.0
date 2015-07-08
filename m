From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/2] cpufreq: cpufreq_add_dev: name goto labels based on what they do
Date: Wed,  8 Jul 2015 15:12:15 +0530
Message-ID: <276debea91831d86c34079f6a40d773ce258a62c.1436348436.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, tixy@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

These labels are are named in two ways normally:
- Based on what caused to jump to such labels
- Based on what we do under such labels

We follow the first naming convention today and that leads to multiple
labels for doing the same work. Fix it by switching to the second way of
naming them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Hi Rafael,

These can go in 4.3, I don't really mind :)

 drivers/cpufreq/cpufreq.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b612411655f9..b7aac8eec525 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1278,7 +1278,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 		recover_policy = false;
 		policy = cpufreq_policy_alloc(dev);
 		if (!policy)
-			goto nomem_out;
+			goto out_release_rwsem;
 	}
 
 	cpumask_copy(policy->cpus, cpumask_of(cpu));
@@ -1289,7 +1289,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	ret = cpufreq_driver->init(policy);
 	if (ret) {
 		pr_debug("initialization failed\n");
-		goto err_set_policy_cpu;
+		goto out_free_policy;
 	}
 
 	down_write(&policy->rwsem);
@@ -1317,7 +1317,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 		policy->cur = cpufreq_driver->get(policy->cpu);
 		if (!policy->cur) {
 			pr_err("%s: ->get() failed\n", __func__);
-			goto err_get_freq;
+			goto out_exit_policy;
 		}
 	}
 
@@ -1367,7 +1367,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	if (!recover_policy) {
 		ret = cpufreq_add_dev_interface(policy, dev);
 		if (ret)
-			goto err_out_unregister;
+			goto out_exit_policy;
 		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 				CPUFREQ_CREATE_POLICY, policy);
 
@@ -1396,15 +1396,14 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 
 	return 0;
 
-err_out_unregister:
-err_get_freq:
+out_exit_policy:
 	up_write(&policy->rwsem);
 
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
-err_set_policy_cpu:
+out_free_policy:
 	cpufreq_policy_free(policy, recover_policy);
-nomem_out:
+out_release_rwsem:
 	up_read(&cpufreq_rwsem);
 
 	return ret;
-- 
2.4.0
