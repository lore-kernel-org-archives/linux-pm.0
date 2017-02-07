From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 4/5] thermal: cpu_cooling: Replace dev_warn with dev_err
Date: Tue,  7 Feb 2017 09:40:04 +0530
Message-ID: <89f2241a0059167d6e6b333854fe654c86de07ab.1486440448.git.viresh.kumar@linaro.org>
References: <79611a51240c83504c35a8739fe8e1837e903671.1486440448.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <79611a51240c83504c35a8739fe8e1837e903671.1486440448.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1486440448.git.viresh.kumar@linaro.org>
References: <cover.1486440448.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rui.zhang@intel.com, edubezval@gmail.com, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Javi Merino <javi.merino@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dan.carpenter@oracle.com
List-Id: linux-pm@vger.kernel.org

There isn't much the user can do on seeing these warnings, as the
hardware is actually okay. dev_err suits much better here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 85fdbf762fa0..caaaeb3ac0f0 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -435,9 +435,9 @@ static int get_static_power(struct cpufreq_cooling_device *cpufreq_device,
 	dev_pm_opp_put(opp);
 
 	if (voltage == 0) {
-		dev_warn_ratelimited(cpufreq_device->cpu_dev,
-				     "Failed to get voltage for frequency %lu: %ld\n",
-				     freq_hz, IS_ERR(opp) ? PTR_ERR(opp) : 0);
+		dev_err_ratelimited(cpufreq_device->cpu_dev,
+				    "Failed to get voltage for frequency %lu: %ld\n",
+				    freq_hz, IS_ERR(opp) ? PTR_ERR(opp) : 0);
 		return -EINVAL;
 	}
 
@@ -721,9 +721,9 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
 
 	*state = cpufreq_cooling_get_level(cpu, target_freq);
 	if (*state == THERMAL_CSTATE_INVALID) {
-		dev_warn_ratelimited(&cdev->device,
-				     "Failed to convert %dKHz for cpu %d into a cdev state\n",
-				     target_freq, cpu);
+		dev_err_ratelimited(&cdev->device,
+				    "Failed to convert %dKHz for cpu %d into a cdev state\n",
+				    target_freq, cpu);
 		return -EINVAL;
 	}
 
-- 
2.7.1.410.g6faf27b
