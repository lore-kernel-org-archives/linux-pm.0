From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 13/18] cpufreq: Keep a single path for adding managed CPUs
Date: Tue, 27 Jan 2015 14:06:19 +0530
Message-ID: <9e01ff84016534936c02b96ecf7f40b2a41cf26d.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44005 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074AbbA0Iha (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 03:37:30 -0500
Received: by mail-pa0-f46.google.com with SMTP id lj1so17155217pab.5
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2015 00:37:30 -0800 (PST)
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

There are two cases when we may try to add already managed CPUs:
- On boot, the first cpu has marked all policy->cpus managed and so we will find
  policy for all other policy->cpus later on.
- When a managed cpu is hotplugged out and later brought back in.

Currently we manage these two with separate paths and checks. While the first
one is detected by testing cpu against 'policy->cpus', the other one is detected
by testing cpu against 'policy->related_cpus'.

We can manage both these via a single path and there is no need to do special
checking for the first one.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0e33c63b4a0e..8b110a50c22e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1014,6 +1014,10 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
 {
 	int ret = 0;
 
+	/* Is cpu already managed ? */
+	if (cpumask_test_cpu(cpu, policy->cpus))
+		return 0;
+
 	if (has_target()) {
 		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
 		if (ret) {
@@ -1149,16 +1153,10 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 
 	pr_debug("adding CPU %u\n", cpu);
 
-	/* check whether a different CPU already registered this
-	 * CPU because it is in the same boat. */
-	policy = cpufreq_cpu_get_raw(cpu);
-	if (unlikely(policy))
-		return 0;
-
 	if (!down_read_trylock(&cpufreq_rwsem))
 		return 0;
 
-	/* Check if this cpu was hot-unplugged earlier and has siblings */
+	/* Check if this cpu already has a policy to manage it */
 	read_lock_irqsave(&cpufreq_driver_lock, flags);
 	for_each_policy(policy) {
 		if (cpumask_test_cpu(cpu, policy->related_cpus)) {
-- 
2.3.0.rc0.44.ga94655d

