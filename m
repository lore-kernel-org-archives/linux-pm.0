From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: [PATCH v2 5/8] cpufreq: Enforce PM QoS minimum limit
Date: Mon, 16 Jan 2012 08:59:58 +0200
Message-ID: <1326697201-32406-6-git-send-email-amiettinen@nvidia.com>
References: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Observe PM QoS CPU frequency minimum in addition
to policy settings.

Signed-off-by: Antti P Miettinen <amiettinen@nvidia.com>
---
 drivers/cpufreq/cpufreq.c |   41 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 127e37a..c2c1c62 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -29,6 +29,7 @@
 #include <linux/completion.h>
 #include <linux/mutex.h>
 #include <linux/syscore_ops.h>
+#include <linux/pm_qos.h>
 
 #include <trace/events/power.h>
 
@@ -1633,9 +1634,16 @@ static int __cpufreq_set_policy(struct cpufreq_policy *data,
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
@@ -1710,6 +1718,9 @@ static int __cpufreq_set_policy(struct cpufreq_policy *data,
 	}
 
 error_out:
+	/* restore the limits that the policy requested */
+	policy->min = pmin;
+	policy->max = pmax;
 	return ret;
 }
 
@@ -1903,9 +1914,32 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
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
@@ -1915,6 +1949,9 @@ static int __init cpufreq_core_init(void)
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
