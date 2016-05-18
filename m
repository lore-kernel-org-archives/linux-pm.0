From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4/6] cpufreq: conservative: Remove declaration of cs_dbs_gov
Date: Wed, 18 May 2016 17:55:29 +0530
Message-ID: <f51606d0f2c04852b7b5c2f1137238bbc1fe1828.1463574213.git.viresh.kumar@linaro.org>
References: <cover.1463574213.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1463574213.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1463574213.git.viresh.kumar@linaro.org>
References: <cover.1463574213.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The code doesn't use 'cs_dbs_gov' anymore before it is defined and the
extra line for declaring it can be removed.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 5a15f649602c..904839171d94 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -127,8 +127,6 @@ static struct notifier_block cs_cpufreq_notifier_block = {
 };
 
 /************************** sysfs interface ************************/
-static struct dbs_governor cs_dbs_gov;
-
 static ssize_t store_sampling_down_factor(struct gov_attr_set *attr_set,
 					  const char *buf, size_t count)
 {
-- 
2.7.1.410.g6faf27b
