From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 16/17] thermal: cpu_cooling: 'freq' can't be zero in cpufreq_state2power()
Date: Tue, 25 Apr 2017 15:57:23 +0530
Message-ID: <98df049ab5f1d13ebb497e922229f0e8b8160606.1493115651.git.viresh.kumar@linaro.org>
References: <cover.1493115651.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1493115651.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1493115651.git.viresh.kumar@linaro.org>
References: <cover.1493115651.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Punit Agrawal <punit.agrawal@arm.com>
List-Id: linux-pm@vger.kernel.org

The frequency table shouldn't have any zero frequency entries and so
such a check isn't required. Though it would be better to make sure
'state' is within limits.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/cpu_cooling.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index bfa9731e7cdb..9cbf7bdbeb7a 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -564,12 +564,13 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 	int ret;
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
 
+	/* Request state should be less than max_level */
+	if (WARN_ON(state > cpufreq_cdev->max_level))
+		return -EINVAL;
+
 	num_cpus = cpumask_weight(cpufreq_cdev->policy->cpus);
 
 	freq = cpufreq_cdev->freq_table[state].frequency;
-	if (!freq)
-		return -EINVAL;
-
 	dynamic_power = cpu_freq_to_power(cpufreq_cdev, freq) * num_cpus;
 	ret = get_static_power(cpufreq_cdev, tz, freq, &static_power);
 	if (ret)
-- 
2.12.0.432.g71c3a4f4ba37
