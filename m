From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 07/10] cpufreq: ondemand: queue work for policy->cpus together
Date: Mon, 22 Jun 2015 13:32:54 +0530
Message-ID: <66980e2b51a83bf34f6fd18ee55155b6c667aa6a.1434959517.git.viresh.kumar@linaro.org>
References: <cover.1434959517.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36596 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756129AbbFVIDc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 04:03:32 -0400
Received: by pdcu2 with SMTP id u2so7354763pdc.3
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2015 01:03:32 -0700 (PDT)
In-Reply-To: <cover.1434959517.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434959517.git.viresh.kumar@linaro.org>
References: <cover.1434959517.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Currently update_sampling_rate() runs over each online CPU and
cancels/queues work on it. Its very inefficient for the case where a
single policy manages multiple CPUs, as they can be processed together.

Also drop the unnecessary cancel_delayed_work_sync() as we are doing a
mod_delayed_work_on() in gov_queue_work(), which will take care of
pending works for us.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_ondemand.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 841e1fa96ee7..cfecd3b67cb3 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -247,40 +247,48 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 		unsigned int new_rate)
 {
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
+	struct cpufreq_policy *policy;
+	struct od_cpu_dbs_info_s *dbs_info;
+	unsigned long next_sampling, appointed_at;
+	struct cpumask cpumask;
 	int cpu;
 
+	cpumask_copy(&cpumask, cpu_online_mask);
+
 	od_tuners->sampling_rate = new_rate = max(new_rate,
 			dbs_data->min_sampling_rate);
 
-	for_each_online_cpu(cpu) {
-		struct cpufreq_policy *policy;
-		struct od_cpu_dbs_info_s *dbs_info;
-		unsigned long next_sampling, appointed_at;
-
+	for_each_cpu(cpu, &cpumask) {
 		policy = cpufreq_cpu_get(cpu);
 		if (!policy)
 			continue;
+
+		/* clear all CPUs of this policy */
+		cpumask_andnot(&cpumask, &cpumask, policy->cpus);
+
 		if (policy->governor != &cpufreq_gov_ondemand) {
 			cpufreq_cpu_put(policy);
 			continue;
 		}
+
 		dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
 		cpufreq_cpu_put(policy);
 
+		/*
+		 * Checking this for any CPU of the policy is fine. As either
+		 * all would have queued work or none.
+		 */
 		if (!delayed_work_pending(&dbs_info->cdbs.dwork))
 			continue;
 
 		next_sampling = jiffies + usecs_to_jiffies(new_rate);
 		appointed_at = dbs_info->cdbs.dwork.timer.expires;
 
-		if (time_before(next_sampling, appointed_at)) {
-			cancel_delayed_work_sync(&dbs_info->cdbs.dwork);
-
-			gov_queue_work(dbs_data, policy,
-				       usecs_to_jiffies(new_rate),
-				       cpumask_of(cpu));
+		if (!time_before(next_sampling, appointed_at))
+			continue;
 
-		}
+		gov_queue_work(dbs_data, policy, usecs_to_jiffies(new_rate),
+			       policy->cpus);
 	}
 }
 
-- 
2.4.0

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
