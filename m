From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 6/6] cpufreq: ondemand: Rearrange od_dbs_timer() to avoid updating delay
Date: Thu, 11 Feb 2016 17:31:16 +0530
Message-ID: <6f5fb9de5d7e81fb9323b72352c16f658f03c351.1455191663.git.viresh.kumar@linaro.org>
References: <cover.1455191663.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1455191663.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1455191663.git.viresh.kumar@linaro.org>
References: <cover.1455191663.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

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
