From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 01/14] cpufreq: Create for_each_{in}active_policy()
Date: Fri,  8 May 2015 11:53:44 +0530
Message-ID: <79f880aba9ad5159e070f2ca172139cb2c254430.1431065963.git.viresh.kumar@linaro.org>
References: <cover.1431065963.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36163 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbbEHGYe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 02:24:34 -0400
Received: by pdea3 with SMTP id a3so67111822pde.3
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2015 23:24:33 -0700 (PDT)
In-Reply-To: <cover.1431065963.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1431065963.git.viresh.kumar@linaro.org>
References: <cover.1431065963.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>, Viresh Kumar <viresh.kumar@linaro.org>

policy->cpus is cleared unconditionally now on hotplug-out of a CPU and
it can be checked to know if a policy is active or not. Create helper
routines to iterate over all active/inactive policies, based on
policy->cpus field.

Replace all instances of for_each_policy() with for_each_active_policy()
to make them iterate only for active policies. (We haven't made changes
yet to keep inactive policies in the same list, but that will be
followed in a later patch).

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 82 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 73 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8cf0c0e7aea8..9229e7f81673 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -32,11 +32,75 @@
 #include <trace/events/power.h>
 
 /* Macros to iterate over lists */
-/* Iterate over online CPUs policies */
 static LIST_HEAD(cpufreq_policy_list);
+
+static inline bool policy_is_inactive(struct cpufreq_policy *policy)
+{
+	return cpumask_empty(policy->cpus);
+}
+
+/*
+ * Finds Next Acive/Inactive policy
+ *
+ * policy: Previous policy.
+ * active: Looking for active policy (true) or Inactive policy (false).
+ */
+static struct cpufreq_policy *next_policy(struct cpufreq_policy *policy,
+					  bool active)
+{
+	do {
+		if (likely(policy))
+			policy = list_next_entry(policy, policy_list);
+		else
+			policy = list_first_entry(&cpufreq_policy_list,
+						  typeof(*policy), policy_list);
+
+		/* No more policies */
+		if (&policy->policy_list == &cpufreq_policy_list)
+			return policy;
+
+		/*
+		 * Table to explains logic behind following expression:
+		 *
+		 *	Active		policy_is_inactive	Result
+		 *						(policy or next)
+		 *
+		 *	0		0			next
+		 *	0		1			policy
+		 *	1		0			policy
+		 *	1		1			next
+		 */
+	} while (!(active ^ policy_is_inactive(policy)));
+
+	return policy;
+}
+
+/*
+ * Iterate over online CPUs policies
+ *
+ * Explanation:
+ * - expr1: marks __temp NULL and gets the first __active policy.
+ * - expr2: checks if list is finished, if yes then it sets __policy to the last
+ *	    __active policy and returns 0 to end the loop.
+ * - expr3: preserves last __active policy and gets the next one.
+ */
+#define __for_each_active_policy(__policy, __temp, __active)		\
+	for (__temp = NULL, __policy = next_policy(NULL, __active);	\
+	     &__policy->policy_list != &cpufreq_policy_list ||		\
+	     ((__policy = __temp) && 0);				\
+	     __temp = __policy, __policy = next_policy(__policy, __active))
+
 #define for_each_policy(__policy)				\
 	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list)
 
+/*
+ * Routines to iterate over active or inactive policies
+ * __policy: next active/inactive policy will be returned in this.
+ * __temp: for internal purpose, not to be used by caller.
+ */
+#define for_each_active_policy(__policy, __temp) __for_each_active_policy(__policy, __temp, true)
+#define for_each_inactive_policy(__policy, __temp) __for_each_active_policy(__policy, __temp, false)
+
 /* Iterate over governors */
 static LIST_HEAD(cpufreq_governor_list);
 #define for_each_governor(__governor)				\
@@ -1142,7 +1206,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 {
 	unsigned int j, cpu = dev->id;
 	int ret = -ENOMEM;
-	struct cpufreq_policy *policy;
+	struct cpufreq_policy *policy, *tpolicy;
 	unsigned long flags;
 	bool recover_policy = cpufreq_suspended;
 
@@ -1156,7 +1220,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 
 	/* Check if this CPU already has a policy to manage it */
 	read_lock_irqsave(&cpufreq_driver_lock, flags);
-	for_each_policy(policy) {
+	for_each_active_policy(policy, tpolicy) {
 		if (cpumask_test_cpu(cpu, policy->related_cpus)) {
 			read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 			ret = cpufreq_add_policy_cpu(policy, cpu, dev);
@@ -1664,7 +1728,7 @@ EXPORT_SYMBOL(cpufreq_generic_suspend);
  */
 void cpufreq_suspend(void)
 {
-	struct cpufreq_policy *policy;
+	struct cpufreq_policy *policy, *tpolicy;
 
 	if (!cpufreq_driver)
 		return;
@@ -1674,7 +1738,7 @@ void cpufreq_suspend(void)
 
 	pr_debug("%s: Suspending Governors\n", __func__);
 
-	for_each_policy(policy) {
+	for_each_active_policy(policy, tpolicy) {
 		if (__cpufreq_governor(policy, CPUFREQ_GOV_STOP))
 			pr_err("%s: Failed to stop governor for policy: %p\n",
 				__func__, policy);
@@ -1696,7 +1760,7 @@ void cpufreq_suspend(void)
  */
 void cpufreq_resume(void)
 {
-	struct cpufreq_policy *policy;
+	struct cpufreq_policy *policy, *tpolicy;
 
 	if (!cpufreq_driver)
 		return;
@@ -1708,7 +1772,7 @@ void cpufreq_resume(void)
 
 	pr_debug("%s: Resuming Governors\n", __func__);
 
-	for_each_policy(policy) {
+	for_each_active_policy(policy, tpolicy) {
 		if (cpufreq_driver->resume && cpufreq_driver->resume(policy))
 			pr_err("%s: Failed to resume driver: %p\n", __func__,
 				policy);
@@ -2351,10 +2415,10 @@ static struct notifier_block __refdata cpufreq_cpu_notifier = {
 static int cpufreq_boost_set_sw(int state)
 {
 	struct cpufreq_frequency_table *freq_table;
-	struct cpufreq_policy *policy;
+	struct cpufreq_policy *policy, *tpolicy;
 	int ret = -EINVAL;
 
-	for_each_policy(policy) {
+	for_each_active_policy(policy, tpolicy) {
 		freq_table = cpufreq_frequency_get_table(policy->cpu);
 		if (freq_table) {
 			ret = cpufreq_frequency_table_cpuinfo(policy,
-- 
2.4.0

