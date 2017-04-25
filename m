From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 06/17] thermal: cpu_cooling: get rid of a variable in cpufreq_set_cur_state()
Date: Tue, 25 Apr 2017 15:57:13 +0530
Message-ID: <fdbebb513bf636f412d301a4e293e157e73b16ce.1493115651.git.viresh.kumar@linaro.org>
References: <cover.1493115651.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1493115651.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1493115651.git.viresh.kumar@linaro.org>
References: <cover.1493115651.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Punit Agrawal <punit.agrawal@arm.com>
List-Id: linux-pm@vger.kernel.org

'cpu' is used at only one place and there is no need to keep a separate
variable for it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/cpu_cooling.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 1f4b6a719d05..002b48dc6bea 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -456,7 +456,6 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long state)
 {
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
-	unsigned int cpu = cpumask_any(&cpufreq_cdev->allowed_cpus);
 	unsigned int clip_freq;
 
 	/* Request state should be less than max_level */
@@ -471,7 +470,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	cpufreq_cdev->cpufreq_state = state;
 	cpufreq_cdev->clipped_freq = clip_freq;
 
-	cpufreq_update_policy(cpu);
+	cpufreq_update_policy(cpumask_any(&cpufreq_cdev->allowed_cpus));
 
 	return 0;
 }
-- 
2.12.0.432.g71c3a4f4ba37
