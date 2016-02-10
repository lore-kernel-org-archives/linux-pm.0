From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 3/3] cpufreq: ondemand: Rearrange od_dbs_timer() to avoid updating delay
Date: Wed, 10 Feb 2016 12:30:13 +0530
Message-ID: <bc26edcf43dbd23132ef96c1facd39ae0ed9e257.1455087379.git.viresh.kumar@linaro.org>
References: <8ddf5eb44eebba01062234d9aed931e3b6882a2b.1455087379.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36313 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbcBJHAc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2016 02:00:32 -0500
Received: by mail-pa0-f53.google.com with SMTP id yy13so7266024pab.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Feb 2016 23:00:31 -0800 (PST)
In-Reply-To: <8ddf5eb44eebba01062234d9aed931e3b6882a2b.1455087379.git.viresh.kumar@linaro.org>
In-Reply-To: <8ddf5eb44eebba01062234d9aed931e3b6882a2b.1455087379.git.viresh.kumar@linaro.org>
References: <8ddf5eb44eebba01062234d9aed931e3b6882a2b.1455087379.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>

'delay' is updated properly in all paths of the routine od_dbs_timer(),
leaving just one. And can be 0 only in that case.

Move the update to 'delay' as an else part of the if block.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_ondemand.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 12213823cc93..0b79f1488be4 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -194,7 +194,7 @@ static unsigned int od_dbs_timer(struct cpufreq_policy *policy)
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info, policy->cpu);
-	int delay = 0, sample_type = dbs_info->sample_type;
+	int delay, sample_type = dbs_info->sample_type;
 
 	/* Common NORMAL_SAMPLE setup */
 	dbs_info->sample_type = OD_NORMAL_SAMPLE;
@@ -208,13 +208,12 @@ static unsigned int od_dbs_timer(struct cpufreq_policy *policy)
 			/* Setup timer for SUB_SAMPLE */
 			dbs_info->sample_type = OD_SUB_SAMPLE;
 			delay = dbs_info->freq_hi_jiffies;
+		} else {
+			delay = delay_for_sampling_rate(dbs_data->sampling_rate
+							* dbs_info->rate_mult);
 		}
 	}
 
-	if (!delay)
-		delay = delay_for_sampling_rate(dbs_data->sampling_rate
-				* dbs_info->rate_mult);
-
 	return delay;
 }
 
-- 
2.7.1.370.gb2aa7f8

