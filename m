From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 06/17] thermal: cpu_cooling: get rid of a variable in cpufreq_set_cur_state()
Date: Thu, 16 Mar 2017 10:59:41 +0530
Message-ID: <587728c8bc2173c5d742a24ec14ade8bdc5d6e92.1489640000.git.viresh.kumar@linaro.org>
References: <be952dc502195304ddecfe4eefa7043eb71d0c6b.1489639999.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <be952dc502195304ddecfe4eefa7043eb71d0c6b.1489639999.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1489639999.git.viresh.kumar@linaro.org>
References: <cover.1489639999.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

'cpu' is used at only one place and there is no need to keep a separate
variable for it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 99dc6833de75..46e90122b746 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -457,7 +457,6 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long state)
 {
 	struct cpufreq_cooling_device *cpufreq_dev = cdev->devdata;
-	unsigned int cpu = cpumask_any(&cpufreq_dev->allowed_cpus);
 	unsigned int clip_freq;
 
 	/* Request state should be less than max_level */
@@ -472,7 +471,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	cpufreq_dev->cpufreq_state = state;
 	cpufreq_dev->clipped_freq = clip_freq;
 
-	cpufreq_update_policy(cpu);
+	cpufreq_update_policy(cpumask_any(&cpufreq_dev->allowed_cpus));
 
 	return 0;
 }
-- 
2.7.1.410.g6faf27b
