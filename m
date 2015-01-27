From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 02/18] cpufreq: Create for_each_policy()
Date: Tue, 27 Jan 2015 14:06:08 +0530
Message-ID: <c2b93a536c452b13a09434c3dfaf9725ee8ff95a.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36817 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757810AbbA0Igt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 03:36:49 -0500
Received: by mail-pa0-f42.google.com with SMTP id bj1so17200061pad.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2015 00:36:48 -0800 (PST)
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

To make code more readable and less error prone, lets create a helper macro for
iterating over all active policies.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 72990ba59fad..9dfefb8ece6d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -31,6 +31,12 @@
 #include <linux/tick.h>
 #include <trace/events/power.h>
 
+/* Macros to iterate over lists */
+/* Iterate over online CPUs policies */
+static LIST_HEAD(cpufreq_policy_list);
+#define for_each_policy(__policy)				\
+	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list)
+
 /**
  * The "cpufreq driver" - the arch- or hardware-dependent low
  * level driver of CPUFreq support, and its spinlock. This lock
@@ -41,7 +47,6 @@ static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
 static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data_fallback);
 static DEFINE_RWLOCK(cpufreq_driver_lock);
 DEFINE_MUTEX(cpufreq_governor_lock);
-static LIST_HEAD(cpufreq_policy_list);
 
 /* This one keeps track of the previously set governor of a removed CPU */
 static DEFINE_PER_CPU(char[CPUFREQ_NAME_LEN], cpufreq_cpu_governor);
@@ -1113,7 +1118,7 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 
 	/* Check if this cpu was hot-unplugged earlier and has siblings */
 	read_lock_irqsave(&cpufreq_driver_lock, flags);
-	list_for_each_entry(policy, &cpufreq_policy_list, policy_list) {
+	for_each_policy(policy) {
 		if (cpumask_test_cpu(cpu, policy->related_cpus)) {
 			read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 			ret = cpufreq_add_policy_cpu(policy, cpu, dev);
@@ -1647,7 +1652,7 @@ void cpufreq_suspend(void)
 
 	pr_debug("%s: Suspending Governors\n", __func__);
 
-	list_for_each_entry(policy, &cpufreq_policy_list, policy_list) {
+	for_each_policy(policy) {
 		if (__cpufreq_governor(policy, CPUFREQ_GOV_STOP))
 			pr_err("%s: Failed to stop governor for policy: %p\n",
 				__func__, policy);
@@ -1681,7 +1686,7 @@ void cpufreq_resume(void)
 
 	pr_debug("%s: Resuming Governors\n", __func__);
 
-	list_for_each_entry(policy, &cpufreq_policy_list, policy_list) {
+	for_each_policy(policy) {
 		if (cpufreq_driver->resume && cpufreq_driver->resume(policy))
 			pr_err("%s: Failed to resume driver: %p\n", __func__,
 				policy);
@@ -2324,7 +2329,7 @@ static int cpufreq_boost_set_sw(int state)
 	struct cpufreq_policy *policy;
 	int ret = -EINVAL;
 
-	list_for_each_entry(policy, &cpufreq_policy_list, policy_list) {
+	for_each_policy(policy) {
 		freq_table = cpufreq_frequency_get_table(policy->cpu);
 		if (freq_table) {
 			ret = cpufreq_frequency_table_cpuinfo(policy,
-- 
2.3.0.rc0.44.ga94655d

