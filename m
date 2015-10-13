From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 3/5] cpufreq: ondemand: queue work for policy->cpus together
Date: Tue, 13 Oct 2015 13:39:03 +0530
Message-ID: <b98689db34097553ee142bbb2efda2612af553e5.1444723240.git.viresh.kumar@linaro.org>
References: <cover.1444723240.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1444723240.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1444723240.git.viresh.kumar@linaro.org>
References: <cover.1444723240.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Currently update_sampling_rate() runs over each online CPU and
cancels/queues work on it. Its very inefficient for the case where a
single policy manages multiple CPUs, as they can be processed together.

Also drop the unnecessary cancel_delayed_work_sync() as we are doing a
mod_delayed_work_on() in gov_queue_work(), which will take care of
pending works for us.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_ondemand.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index bf0511a9735c..4677c7e9d534 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -238,29 +238,36 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 		unsigned int new_rate)
 {
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
+	struct cpufreq_policy *policy;
+	struct od_cpu_dbs_info_s *dbs_info;
+	struct cpumask cpumask;
 	int cpu;
 
+	cpumask_copy(&cpumask, cpu_online_mask);
+
 	od_tuners->sampling_rate = new_rate = max(new_rate,
 			dbs_data->min_sampling_rate);
 
-	for_each_online_cpu(cpu) {
-		struct cpufreq_policy *policy;
-		struct od_cpu_dbs_info_s *dbs_info;
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
 
-		if (!delayed_work_pending(&dbs_info->cdbs.dwork))
+		/* Make sure the work is not canceled on policy->cpus */
+		if (!dbs_info->cdbs.shared->policy)
 			continue;
 
-		cancel_delayed_work_sync(&dbs_info->cdbs.dwork);
 		gov_queue_work(dbs_data, policy, usecs_to_jiffies(new_rate),
 			       true);
 	}
-- 
2.4.0
