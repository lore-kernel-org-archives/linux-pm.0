From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: [PATCH v3 3/3] cpufreq: Enforce PM QoS minimum limit
Date: Thu, 19 Jan 2012 14:34:52 +0200
Message-ID: <1326976492-3970-4-git-send-email-amiettinen@nvidia.com>
References: <1326976492-3970-1-git-send-email-amiettinen@nvidia.com>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1326976492-3970-1-git-send-email-amiettinen@nvidia.com>
Sender: cpufreq-owner@vger.kernel.org
To: davej@redhat.com, pavel@ucw.cz, rjw@sisk.pl, len.brown@intel.com, khilman@ti.com, j-pihet@ti.com, markgross@thegnar.org, cpufreq@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Observe PM QoS CPU frequency minimum in addition
to policy settings. This includes storing the value
received via sysfs as the user_policy
min/max value instead of the currently enforced min/max.
This allows restoring the user min/max values when
constraints on enforced min/max change.

Signed-off-by: Antti P Miettinen <amiettinen@nvidia.com>
---
 drivers/cpufreq/cpufreq.c |   43 ++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 622013f..f2c7fc2 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -29,6 +29,7 @@
 #include <linux/completion.h>
 #include <linux/mutex.h>
 #include <linux/syscore_ops.h>
+#include <linux/pm_qos.h>
 
 #include <trace/events/power.h>
 
@@ -386,7 +387,7 @@ static ssize_t store_##file_name					\
 		return -EINVAL;						\
 									\
 	ret = __cpufreq_set_policy(policy, &new_policy);		\
-	policy->user_policy.object = policy->object;			\
+	policy->user_policy.object = new_policy.object;			\
 									\
 	return ret ? ret : count;					\
 }
@@ -1627,9 +1628,16 @@ static int __cpufreq_set_policy(struct cpufreq_policy *data,
 				struct cpufreq_policy *policy)
 {
 	int ret = 0;
+	unsigned int pmin = policy->min;
+	unsigned int pmax = policy->max;
+	unsigned int qmin = min(pm_qos_request(PM_QOS_CPU_FREQ_MIN),
+				data->max);
 
-	pr_debug("setting new policy for CPU %u: %u - %u kHz\n", policy->cpu,
-		policy->min, policy->max);
+	pr_debug("setting new policy for CPU %u: %u/%u - %u kHz\n",
+		 policy->cpu, pmin, qmin, pmax);
+
+	/* clamp the new policy to PM QoS limits */
+	policy->min = max(pmin, qmin);
 
 	memcpy(&policy->cpuinfo, &data->cpuinfo,
 				sizeof(struct cpufreq_cpuinfo));
@@ -1704,6 +1712,9 @@ static int __cpufreq_set_policy(struct cpufreq_policy *data,
 	}
 
 error_out:
+	/* restore the limits that the policy requested */
+	policy->min = pmin;
+	policy->max = pmax;
 	return ret;
 }
 
@@ -1897,9 +1908,32 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
 }
 EXPORT_SYMBOL_GPL(cpufreq_unregister_driver);
 
+static int cpu_freq_notify(struct notifier_block *b,
+			   unsigned long l, void *v);
+
+static struct notifier_block min_freq_notifier = {
+	.notifier_call = cpu_freq_notify,
+};
+
+static int cpu_freq_notify(struct notifier_block *b,
+			   unsigned long l, void *v)
+{
+	int cpu;
+	pr_debug("PM QoS min %lu\n", l);
+	for_each_online_cpu(cpu) {
+		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+		if (policy) {
+			cpufreq_update_policy(policy->cpu);
+			cpufreq_cpu_put(policy);
+		}
+	}
+	return NOTIFY_OK;
+}
+
 static int __init cpufreq_core_init(void)
 {
 	int cpu;
+	int rc;
 
 	for_each_possible_cpu(cpu) {
 		per_cpu(cpufreq_policy_cpu, cpu) = -1;
@@ -1909,6 +1943,9 @@ static int __init cpufreq_core_init(void)
 	cpufreq_global_kobject = kobject_create_and_add("cpufreq", &cpu_subsys.dev_root->kobj);
 	BUG_ON(!cpufreq_global_kobject);
 	register_syscore_ops(&cpufreq_syscore_ops);
+	rc = pm_qos_add_notifier(PM_QOS_CPU_FREQ_MIN,
+				 &min_freq_notifier);
+	BUG_ON(rc);
 
 	return 0;
 }
-- 
1.7.4.1

