From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 2/6] cpufreq: ondemand: Work is guaranteed to be pending
Date: Thu,  3 Dec 2015 09:37:50 +0530
Message-ID: <62e9df1d973c51ae5abd64e1667a261616a4ad87.1449115453.git.viresh.kumar@linaro.org>
References: <cover.1449115453.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1449115453.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1449115453.git.viresh.kumar@linaro.org>
References: <cover.1449115453.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ashwin.chaugule@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

We are guaranteed to have works scheduled for policy->cpus, as the
policy isn't stopped yet. And so there is no need to check that again.
Drop it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_ondemand.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 089ca6a6ca02..08f2aa602f9e 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -286,9 +286,6 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 		if (dbs_data != policy->governor_data)
 			continue;
 
-		if (!delayed_work_pending(&dbs_info->cdbs.dwork))
-			continue;
-
 		next_sampling = jiffies + usecs_to_jiffies(new_rate);
 		appointed_at = dbs_info->cdbs.dwork.timer.expires;
 
-- 
2.6.2.198.g614a2ac
