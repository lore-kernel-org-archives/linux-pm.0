From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 7/9] cpufreq: ondemand: update sampling rate immidiately
Date: Mon, 27 Jul 2015 17:58:12 +0530
Message-ID: <d6363924f02d389ce50ed1a08450d2ff2d1800c1.1437999691.git.viresh.kumar@linaro.org>
References: <cover.1437999691.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437999691.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437999691.git.viresh.kumar@linaro.org>
References: <cover.1437999691.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, preeti.lkml@gmail.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

We are immediately updating sampling rate for already queued-works, only
if the new expiry is lesser than the old one.

But what about the case, where the user doesn't want frequent events and
want to increase sampling time? Shouldn't we cancel the works (and so
their interrupts) on all policy->cpus (which might occur very shortly).

This patch removes this special case and simplifies code by immediately
updating the expiry.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_ondemand.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index a6f579e40ce2..1a6f84b42441 100644
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
@@ -249,7 +240,6 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	struct cpufreq_policy *policy;
 	struct od_cpu_dbs_info_s *dbs_info;
-	unsigned long next_sampling, appointed_at;
 	struct cpumask cpumask;
 	int cpu;
 
@@ -278,12 +268,6 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 		if (!dbs_info->cdbs.shared->policy)
 			continue;
 
-		next_sampling = jiffies + usecs_to_jiffies(new_rate);
-		appointed_at = dbs_info->cdbs.dwork.timer.expires;
-
-		if (!time_before(next_sampling, appointed_at))
-			continue;
-
 		gov_queue_work(dbs_data, policy, usecs_to_jiffies(new_rate),
 			       policy->cpus);
 	}
-- 
2.4.0
