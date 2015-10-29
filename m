From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 6/6] cpufreq: ondemand: update update_sampling_rate() to make it more efficient
Date: Thu, 29 Oct 2015 17:57:25 +0530
Message-ID: <a15399b18a06bbe3e22e9e7b01e8e4a7a61a044f.1446121217.git.viresh.kumar@linaro.org>
References: <cover.1446121217.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35706 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756895AbbJ2M1x (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2015 08:27:53 -0400
Received: by pasz6 with SMTP id z6so39966537pas.2
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2015 05:27:52 -0700 (PDT)
In-Reply-To: <cover.1446121217.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1446121217.git.viresh.kumar@linaro.org>
References: <cover.1446121217.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>

Currently update_sampling_rate() runs over each online CPU and
cancels/queues timers on all policy->cpus every time. This should be
done just once for any cpu belonging to a policy.

Create a cpumask and keep on clearing it as and when we process
policies, so that we don't have to traverse through all CPUs of the same
policy.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_ondemand.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 9e0293c23285..6eac39124894 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -251,6 +251,7 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 	struct cpufreq_policy *policy;
 	struct cpu_common_dbs_info *shared;
 	unsigned long next_sampling, appointed_at;
+	struct cpumask cpumask;
 	int cpu;
 
 	od_tuners->sampling_rate = new_rate = max(new_rate,
@@ -261,7 +262,9 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 	 */
 	mutex_lock(&od_dbs_cdata.mutex);
 
-	for_each_online_cpu(cpu) {
+	cpumask_copy(&cpumask, cpu_online_mask);
+
+	for_each_cpu(cpu, &cpumask) {
 		dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
 		cdbs = &dbs_info->cdbs;
 		shared = cdbs->shared;
@@ -275,6 +278,9 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 
 		policy = shared->policy;
 
+		/* clear all CPUs of this policy */
+		cpumask_andnot(&cpumask, &cpumask, policy->cpus);
+
 		/*
 		 * Update sampling rate for CPUs whose policy is governed by
 		 * dbs_data. In case of governor_per_policy, only a single
@@ -284,6 +290,10 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 		if (dbs_data != policy->governor_data)
 			continue;
 
+		/*
+		 * Checking this for any CPU should be fine, timers for all of
+		 * them are scheduled together.
+		 */
 		next_sampling = jiffies + usecs_to_jiffies(new_rate);
 		appointed_at = dbs_info->cdbs.timer.expires;
 
-- 
2.6.2.198.g614a2ac

