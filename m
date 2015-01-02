From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 08/17] cpufreq: pass policy to __cpufreq_get()
Date: Fri,  2 Jan 2015 12:34:29 +0530
Message-ID: <a3ae04ac7744462ab749901218229b76f8cd3527.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:56469 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbABHFZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 02:05:25 -0500
Received: by mail-pd0-f178.google.com with SMTP id r10so23255742pdi.37
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 23:05:24 -0800 (PST)
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

There is no point finding out the 'policy' again within __cpufreq_get() when all
the callers already have it. Just make them pass policy instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 3e80b97d64b8..35d4734ce856 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -62,7 +62,7 @@ static DECLARE_RWSEM(cpufreq_rwsem);
 /* internal prototypes */
 static int __cpufreq_governor(struct cpufreq_policy *policy,
 		unsigned int event);
-static unsigned int __cpufreq_get(unsigned int cpu);
+static unsigned int __cpufreq_get(struct cpufreq_policy *policy);
 static void handle_update(struct work_struct *work);
 
 /**
@@ -562,7 +562,7 @@ store_one(scaling_max_freq, max);
 static ssize_t show_cpuinfo_cur_freq(struct cpufreq_policy *policy,
 					char *buf)
 {
-	unsigned int cur_freq = __cpufreq_get(policy->cpu);
+	unsigned int cur_freq = __cpufreq_get(policy);
 	if (!cur_freq)
 		return sprintf(buf, "<unknown>");
 	return sprintf(buf, "%u\n", cur_freq);
@@ -1568,15 +1568,14 @@ unsigned int cpufreq_quick_get_max(unsigned int cpu)
 }
 EXPORT_SYMBOL(cpufreq_quick_get_max);
 
-static unsigned int __cpufreq_get(unsigned int cpu)
+static unsigned int __cpufreq_get(struct cpufreq_policy *policy)
 {
-	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
 	unsigned int ret_freq = 0;
 
 	if (!cpufreq_driver->get)
 		return ret_freq;
 
-	ret_freq = cpufreq_driver->get(cpu);
+	ret_freq = cpufreq_driver->get(policy->cpu);
 
 	if (ret_freq && policy->cur &&
 		!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
@@ -1604,7 +1603,7 @@ unsigned int cpufreq_get(unsigned int cpu)
 
 	if (policy) {
 		down_read(&policy->rwsem);
-		ret_freq = __cpufreq_get(cpu);
+		ret_freq = __cpufreq_get(policy);
 		up_read(&policy->rwsem);
 
 		cpufreq_cpu_put(policy);
-- 
2.2.0

