From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 08/10] cpufreq: ondemand: update sampling rate immidiately
Date: Mon, 22 Jun 2015 13:32:55 +0530
Message-ID: <815b545c726fa214a4bc17db72306e78bf78b615.1434959517.git.viresh.kumar@linaro.org>
References: <cover.1434959517.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34902 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755999AbbFVIDg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 04:03:36 -0400
Received: by pacyo7 with SMTP id yo7so25723486pac.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2015 01:03:35 -0700 (PDT)
In-Reply-To: <cover.1434959517.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434959517.git.viresh.kumar@linaro.org>
References: <cover.1434959517.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

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
index cfecd3b67cb3..98ad38a350b2 100644
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
 
@@ -281,12 +271,6 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 		if (!delayed_work_pending(&dbs_info->cdbs.dwork))
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

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
