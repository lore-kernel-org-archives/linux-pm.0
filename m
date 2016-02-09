From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 7/7] cpufreq: ondemand: Rearrange od_dbs_timer() to void updating delay
Date: Tue,  9 Feb 2016 09:16:19 +0530
Message-ID: <853c8f6925a75e3750d3f0a0facd0d1d3f4325ba.1454988792.git.viresh.kumar@linaro.org>
References: <cover.1454988792.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35610 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755884AbcBIDr4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 22:47:56 -0500
Received: by mail-pf0-f179.google.com with SMTP id c10so53706552pfc.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2016 19:47:56 -0800 (PST)
In-Reply-To: <cover.1454988792.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454988792.git.viresh.kumar@linaro.org>
References: <cover.1454988792.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

'delay' is updated properly in all paths of the routine od_dbs_timer(),
leaving just one. And can be 0 only in that case.

Move the update to 'delay' as an else part of the if block.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_ondemand.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index d9f323f150c4..388ae07ce413 100644
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

