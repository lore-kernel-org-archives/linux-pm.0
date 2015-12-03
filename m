From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 6/6] cpufreq: ondemand: update update_sampling_rate() to make it more efficient
Date: Thu,  3 Dec 2015 09:37:54 +0530
Message-ID: <5b9fffd163d07be79943615d069147e801975e0c.1449115453.git.viresh.kumar@linaro.org>
References: <cover.1449115453.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1449115453.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1449115453.git.viresh.kumar@linaro.org>
References: <cover.1449115453.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ashwin.chaugule@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

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
index f879012cf849..eae51070c034 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -246,6 +246,7 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 		unsigned int new_rate)
 {
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
+	struct cpumask cpumask;
 	int cpu;
 
 	od_tuners->sampling_rate = new_rate = max(new_rate,
@@ -256,7 +257,9 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 	 */
 	mutex_lock(&od_dbs_cdata.mutex);
 
-	for_each_online_cpu(cpu) {
+	cpumask_copy(&cpumask, cpu_online_mask);
+
+	for_each_cpu(cpu, &cpumask) {
 		struct cpufreq_policy *policy;
 		struct od_cpu_dbs_info_s *dbs_info;
 		struct cpu_dbs_info *cdbs;
@@ -276,6 +279,9 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 
 		policy = shared->policy;
 
+		/* clear all CPUs of this policy */
+		cpumask_andnot(&cpumask, &cpumask, policy->cpus);
+
 		/*
 		 * Update sampling rate for CPUs whose policy is governed by
 		 * dbs_data. In case of governor_per_policy, only a single
@@ -285,6 +291,10 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
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
