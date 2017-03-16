From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 16/17] thermal: cpu_cooling: 'freq' can't be zero in cpufreq_state2power()
Date: Thu, 16 Mar 2017 10:59:51 +0530
Message-ID: <252aef1977bab800768c5144e907f8d0696323a9.1489640000.git.viresh.kumar@linaro.org>
References: <be952dc502195304ddecfe4eefa7043eb71d0c6b.1489639999.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <be952dc502195304ddecfe4eefa7043eb71d0c6b.1489639999.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1489639999.git.viresh.kumar@linaro.org>
References: <cover.1489639999.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

The frequency table shouldn't have any zero frequency entries and so
such a check isn't required. Though it would be better to make sure
'state' is within limits.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index fb535fd5aa12..768a95bcc392 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -561,12 +561,13 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 	int ret;
 	struct cpufreq_cooling_device *cpufreq_dev = cdev->devdata;
 
+	/* Request state should be less than max_level */
+	if (WARN_ON(state > cpufreq_dev->max_level))
+		return -EINVAL;
+
 	num_cpus = cpumask_weight(cpufreq_dev->policy->cpus);
 
 	freq = cpufreq_dev->freq_table[state].frequency;
-	if (!freq)
-		return -EINVAL;
-
 	dynamic_power = cpu_freq_to_power(cpufreq_dev, freq) * num_cpus;
 	ret = get_static_power(cpufreq_dev, tz, freq, &static_power);
 	if (ret)
-- 
2.7.1.410.g6faf27b
