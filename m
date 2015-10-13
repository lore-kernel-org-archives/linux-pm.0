From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 2/5] cpufreq: ondemand: update sampling rate immediately
Date: Tue, 13 Oct 2015 13:39:02 +0530
Message-ID: <1746c301a8f0a94578f550026cf41e532e6e0f41.1444723240.git.viresh.kumar@linaro.org>
References: <cover.1444723240.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1444723240.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1444723240.git.viresh.kumar@linaro.org>
References: <cover.1444723240.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

We are immediately updating sampling rate for already queued-works, only
if the new expiry is lesser than the old one.

But what about the case, where the user doesn't want frequent events and
want to increase sampling time immediately? Shouldn't we cancel the
works (and so their interrupts) on all policy->cpus (which might occur
very shortly).

This patch removes this special case and simplifies code by immediately
updating the expiry.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_ondemand.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 03ac6ce54042..bf0511a9735c 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -231,17 +231,8 @@ static unsigned int od_dbs_timer(struct cpu_dbs_info *cdbs,
 static struct common_dbs_data od_dbs_cdata;
 
 /**
- * update_sampling_rate - update sampling rate effective immediately if needed.
+ * update_sampling_rate - update sampling rate immediately.
  * @new_rate: new sampling rate
- *
- * If new rate is smaller than the old, simply updating
- * dbs_tuners_int.sampling_rate might not be appropriate. For example, if the
- * original sampling_rate was 1 second and the requested new sampling rate is 10
- * ms because the user needs immediate reaction from ondemand governor, but not
- * sure if higher frequency will be required or not, then, the governor may
- * change the sampling rate too late; up to 1 second later. Thus, if we are
- * reducing the sampling rate, we need to make the new value effective
- * immediately.
  */
 static void update_sampling_rate(struct dbs_data *dbs_data,
 		unsigned int new_rate)
@@ -255,7 +246,6 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 	for_each_online_cpu(cpu) {
 		struct cpufreq_policy *policy;
 		struct od_cpu_dbs_info_s *dbs_info;
-		unsigned long next_sampling, appointed_at;
 
 		policy = cpufreq_cpu_get(cpu);
 		if (!policy)
@@ -270,16 +260,9 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 		if (!delayed_work_pending(&dbs_info->cdbs.dwork))
 			continue;
 
-		next_sampling = jiffies + usecs_to_jiffies(new_rate);
-		appointed_at = dbs_info->cdbs.dwork.timer.expires;
-
-		if (time_before(next_sampling, appointed_at)) {
-			cancel_delayed_work_sync(&dbs_info->cdbs.dwork);
-
-			gov_queue_work(dbs_data, policy,
-				       usecs_to_jiffies(new_rate), true);
-
-		}
+		cancel_delayed_work_sync(&dbs_info->cdbs.dwork);
+		gov_queue_work(dbs_data, policy, usecs_to_jiffies(new_rate),
+			       true);
 	}
 }
 
-- 
2.4.0
