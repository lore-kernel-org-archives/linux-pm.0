From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] thermal/drivers/cpu_cooling: Remove pointless test in power2state()
Date: Wed, 24 Apr 2019 22:56:09 +0200
Message-ID: <20190424205610.9376-1-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

When the static power computation was removed, the test with the power
being negative was not removed. However, the substraction which was
responsible of the negative value was removed and the variable is now
an u32. A double reason to remove the test which does not make sense.

Fixes: 84fe2cab48590 ("cpu_cooling: Drop static-power related stuff")
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index f7c1f49ec87f..ee8419a6390c 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -541,7 +541,6 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
 	struct cpufreq_policy *policy = cpufreq_cdev->policy;
 
-	power = power > 0 ? power : 0;
 	last_load = cpufreq_cdev->last_load ?: 1;
 	normalised_power = (power * 100) / last_load;
 	target_freq = cpu_power_to_freq(cpufreq_cdev, normalised_power);
-- 
2.17.1
