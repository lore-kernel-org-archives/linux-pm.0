From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/6] cpufreq: ondemand: Work is guaranteed to be pending
Date: Thu, 29 Oct 2015 17:57:21 +0530
Message-ID: <a030626f2fdf853cd06c50a87b9da667ff7154b8.1446121217.git.viresh.kumar@linaro.org>
References: <cover.1446121217.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1446121217.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1446121217.git.viresh.kumar@linaro.org>
References: <cover.1446121217.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

We are guaranteed to have works scheduled for policy->cpus, as the
policy isn't stopped yet. And so there is no need to check that again.
Drop it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_ondemand.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 0800a937607b..edab71528b8b 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -285,9 +285,6 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 		if (dbs_data != policy->governor_data)
 			continue;
 
-		if (!delayed_work_pending(&dbs_info->cdbs.dwork))
-			continue;
-
 		next_sampling = jiffies + usecs_to_jiffies(new_rate);
 		appointed_at = dbs_info->cdbs.dwork.timer.expires;
 
-- 
2.6.2.198.g614a2ac
