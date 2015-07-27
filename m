From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4/7] cpufreq: Drop unused dev argument from two functions
Date: Mon, 27 Jul 2015 16:05:21 +0200
Message-ID: <1650994.NqTPmayJcx@vostro.rjw.lan>
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

The dev argument of cpufreq_add_policy_cpu() and
cpufreq_add_dev_interface() is not used by any of them,
so drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -999,8 +999,7 @@ static void cpufreq_remove_dev_symlink(s
 	}
 }
 
-static int cpufreq_add_dev_interface(struct cpufreq_policy *policy,
-				     struct device *dev)
+static int cpufreq_add_dev_interface(struct cpufreq_policy *policy)
 {
 	struct freq_attr **drv_attr;
 	int ret = 0;
@@ -1057,8 +1056,7 @@ static int cpufreq_init_policy(struct cp
 	return cpufreq_set_policy(policy, &new_policy);
 }
 
-static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
-				  unsigned int cpu, struct device *dev)
+static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu)
 {
 	int ret = 0;
 
@@ -1225,7 +1223,7 @@ static int cpufreq_add_dev(struct device
 	if (policy) {
 		WARN_ON(!cpumask_test_cpu(cpu, policy->related_cpus));
 		if (!policy_is_inactive(policy))
-			return cpufreq_add_policy_cpu(policy, cpu, dev);
+			return cpufreq_add_policy_cpu(policy, cpu);
 
 		/* This is the only online CPU for the policy.  Start over. */
 		recover_policy = true;
@@ -1328,7 +1326,7 @@ static int cpufreq_add_dev(struct device
 				     CPUFREQ_START, policy);
 
 	if (!recover_policy) {
-		ret = cpufreq_add_dev_interface(policy, dev);
+		ret = cpufreq_add_dev_interface(policy);
 		if (ret)
 			goto out_exit_policy;
 		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
