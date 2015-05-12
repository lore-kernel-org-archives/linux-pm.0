From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 01/14] cpufreq: Create for_each_{in}active_policy()
Date: Tue, 12 May 2015 12:20:11 +0530
Message-ID: <2f5c97eddb463e27fa4b83b5f3ed2bd87b2ece6b.1431412012.git.viresh.kumar@linaro.org>
References: <cover.1431065963.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35873 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354AbbELGu3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2015 02:50:29 -0400
Received: by pdea3 with SMTP id a3so173562958pde.3
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2015 23:50:29 -0700 (PDT)
In-Reply-To: <79f880aba9ad5159e070f2ca172139cb2c254430.1431065963.git.viresh.kumar@linaro.org>
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
Hi Rafael,

I have changed this patch based on your suggestions. Because of this, 3
more patches had rebase conflicts and am sending them again as well
(In-reply-to the original messages).

Because only 4 patches were affected, I am no sending the whole series
again, please let me know if you want the whole series to be sent again.

V3-V4:
- Remove __temp from the arguments of for_each_[in]active_policies.
- Simplified macros/next_policy, etc.
- Other patches sent with this one, rebased on top of this one:
  - [PATCH V4 04/14] cpufreq: Don't traverse all active policies to find
  - [PATCH V4 05/14] cpufreq: Manage governor usage history with
  - [PATCH V4 06/14] cpufreq: Mark policy->governor = NULL for inactive

 drivers/cpufreq/cpufreq.c | 66 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8cf0c0e7aea8..74d9fcbbe4f9 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -31,10 +31,62 @@
 #include <linux/tick.h>
 #include <trace/events/power.h>
 
-/* Macros to iterate over lists */
-/* Iterate over online CPUs policies */
 static LIST_HEAD(cpufreq_policy_list);
-#define for_each_policy(__policy)				\
+
+static inline bool policy_is_inactive(struct cpufreq_policy *policy)
+{
+	return cpumask_empty(policy->cpus);
+}
+
+static bool suitable_policy(struct cpufreq_policy *policy, bool active)
+{
+	return active == !policy_is_inactive(policy);
+}
+
+/* Finds Next Acive/Inactive policy */
+static struct cpufreq_policy *next_policy(struct cpufreq_policy *policy,
+					  bool active)
+{
+	do {
+		policy = list_next_entry(policy, policy_list);
+
+		/* No more policies in the list */
+		if (&policy->policy_list == &cpufreq_policy_list)
+			return NULL;
+	} while (!suitable_policy(policy, active));
+
+	return policy;
+}
+
+static struct cpufreq_policy *first_policy(bool active)
+{
+	struct cpufreq_policy *policy;
+
+	/* No policies in the list */
+	if (list_empty(&cpufreq_policy_list))
+		return NULL;
+
+	policy = list_first_entry(&cpufreq_policy_list, typeof(*policy),
+				  policy_list);
+
+	if (!suitable_policy(policy, active))
+		policy = next_policy(policy, active);
+
+	return policy;
+}
+
+/* Macros to iterate over CPU policies */
+#define for_each_suitable_policy(__policy, __active)	\
+	for (__policy = first_policy(__active);		\
+	     __policy;					\
+	     __policy = next_policy(__policy, __active))
+
+#define for_each_active_policy(__policy)		\
+	for_each_suitable_policy(__policy, true)
+#define for_each_inactive_policy(__policy)		\
+	for_each_suitable_policy(__policy, false)
+
+#define for_each_policy(__policy)			\
 	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list)
 
 /* Iterate over governors */
@@ -1156,7 +1208,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 
 	/* Check if this CPU already has a policy to manage it */
 	read_lock_irqsave(&cpufreq_driver_lock, flags);
-	for_each_policy(policy) {
+	for_each_active_policy(policy) {
 		if (cpumask_test_cpu(cpu, policy->related_cpus)) {
 			read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 			ret = cpufreq_add_policy_cpu(policy, cpu, dev);
@@ -1674,7 +1726,7 @@ void cpufreq_suspend(void)
 
 	pr_debug("%s: Suspending Governors\n", __func__);
 
-	for_each_policy(policy) {
+	for_each_active_policy(policy) {
 		if (__cpufreq_governor(policy, CPUFREQ_GOV_STOP))
 			pr_err("%s: Failed to stop governor for policy: %p\n",
 				__func__, policy);
@@ -1708,7 +1760,7 @@ void cpufreq_resume(void)
 
 	pr_debug("%s: Resuming Governors\n", __func__);
 
-	for_each_policy(policy) {
+	for_each_active_policy(policy) {
 		if (cpufreq_driver->resume && cpufreq_driver->resume(policy))
 			pr_err("%s: Failed to resume driver: %p\n", __func__,
 				policy);
@@ -2354,7 +2406,7 @@ static int cpufreq_boost_set_sw(int state)
 	struct cpufreq_policy *policy;
 	int ret = -EINVAL;
 
-	for_each_policy(policy) {
+	for_each_active_policy(policy) {
 		freq_table = cpufreq_frequency_get_table(policy->cpu);
 		if (freq_table) {
 			ret = cpufreq_frequency_table_cpuinfo(policy,
-- 
2.4.0

