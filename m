From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 7/7] cpufreq: drop !cpufreq_driver check from cpufreq_parse_governor()
Date: Mon,  3 Aug 2015 08:36:20 +0530
Message-ID: <0e4db9528298798f7fcbec4ea79fe6f6e5518784.1438571116.git.viresh.kumar@linaro.org>
References: <cover.1438571116.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1438571116.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1438571116.git.viresh.kumar@linaro.org>
References: <cover.1438571116.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Driver is guaranteed to be present on a call to cpufreq_parse_governor()
and there is no need to check for !cpufreq_driver. Drop it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a80bd68bbd74..a05cc75cc45d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -520,9 +520,6 @@ static int cpufreq_parse_governor(char *str_governor, unsigned int *policy,
 {
 	int err = -EINVAL;
 
-	if (!cpufreq_driver)
-		goto out;
-
 	if (cpufreq_driver->setpolicy) {
 		if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
 			*policy = CPUFREQ_POLICY_PERFORMANCE;
@@ -557,7 +554,6 @@ static int cpufreq_parse_governor(char *str_governor, unsigned int *policy,
 
 		mutex_unlock(&cpufreq_governor_mutex);
 	}
-out:
 	return err;
 }
 
-- 
2.4.0
