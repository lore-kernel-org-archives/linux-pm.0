From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/7] cpufreq: Rework two functions related to CPU offline
Date: Mon, 27 Jul 2015 16:03:11 +0200
Message-ID: <31290788.SNH4WFh3YK@vostro.rjw.lan>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan> <3874727.Jpay9zgokc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3874727.Jpay9zgokc@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since __cpufreq_remove_dev_prepare() and __cpufreq_remove_dev_finish()
are about CPU offline rather than about CPU removal, rename them to
cpufreq_offline_prepare() and cpufreq_offline_finish(), respectively.

Also change their argument from a struct device pointer to a CPU
number, because they use the CPU number only internally anyway
and make them void as their return values are ignored.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1398,10 +1398,8 @@ out_release_rwsem:
 	return ret;
 }
 
-static int __cpufreq_remove_dev_prepare(struct device *dev)
+static void cpufreq_offline_prepare(unsigned int cpu)
 {
-	unsigned int cpu = dev->id;
-	int ret = 0;
 	struct cpufreq_policy *policy;
 
 	pr_debug("%s: unregistering CPU %u\n", __func__, cpu);
@@ -1409,11 +1407,11 @@ static int __cpufreq_remove_dev_prepare(
 	policy = cpufreq_cpu_get_raw(cpu);
 	if (!policy) {
 		pr_debug("%s: No cpu_data found\n", __func__);
-		return -EINVAL;
+		return;
 	}
 
 	if (has_target()) {
-		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
+		int ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
 		if (ret)
 			pr_err("%s: Failed to stop governor\n", __func__);
 	}
@@ -1434,7 +1432,7 @@ static int __cpufreq_remove_dev_prepare(
 	/* Start governor again for active policy */
 	if (!policy_is_inactive(policy)) {
 		if (has_target()) {
-			ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
+			int ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
 			if (!ret)
 				ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
 
@@ -1444,28 +1442,24 @@ static int __cpufreq_remove_dev_prepare(
 	} else if (cpufreq_driver->stop_cpu) {
 		cpufreq_driver->stop_cpu(policy);
 	}
-
-	return ret;
 }
 
-static int __cpufreq_remove_dev_finish(struct device *dev)
+static void cpufreq_offline_finish(unsigned int cpu)
 {
-	unsigned int cpu = dev->id;
-	int ret;
 	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
 
 	if (!policy) {
 		pr_debug("%s: No cpu_data found\n", __func__);
-		return -EINVAL;
+		return;
 	}
 
 	/* Only proceed for inactive policies */
 	if (!policy_is_inactive(policy))
-		return 0;
+		return;
 
 	/* If cpu is last user of policy, free policy */
 	if (has_target()) {
-		ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
+		int ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
 		if (ret)
 			pr_err("%s: Failed to exit governor\n", __func__);
 	}
@@ -1477,8 +1471,6 @@ static int __cpufreq_remove_dev_finish(s
 	 */
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
-
-	return 0;
 }
 
 /**
@@ -1495,8 +1487,8 @@ static int cpufreq_remove_dev(struct dev
 		return 0;
 
 	if (cpu_online(cpu)) {
-		__cpufreq_remove_dev_prepare(dev);
-		__cpufreq_remove_dev_finish(dev);
+		cpufreq_offline_prepare(cpu);
+		cpufreq_offline_finish(cpu);
 	}
 
 	cpumask_clear_cpu(cpu, policy->real_cpus);
@@ -2379,11 +2371,11 @@ static int cpufreq_cpu_callback(struct n
 			break;
 
 		case CPU_DOWN_PREPARE:
-			__cpufreq_remove_dev_prepare(dev);
+			cpufreq_offline_prepare(cpu);
 			break;
 
 		case CPU_POST_DEAD:
-			__cpufreq_remove_dev_finish(dev);
+			cpufreq_offline_finish(cpu);
 			break;
 
 		case CPU_DOWN_FAILED:
