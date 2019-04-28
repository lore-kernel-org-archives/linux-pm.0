From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH - resend 3/3] thermal/drivers/cpu_cooling: Remove pointless field
Date: Sun, 28 Apr 2019 11:51:05 +0200
Message-ID: <20190428095106.5171-3-daniel.lezcano@linaro.org>
References: <20190428095106.5171-1-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190428095106.5171-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>
List-Id: linux-pm@vger.kernel.org

The structure cpufreq_cooling_device provides a backpointer to the thermal
device but this one is used for a trace and to unregister. For the trace,
we don't really need this field and the unregister function as the same
pointer passed as parameter. Remove it.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index b9d152a5f7ba..9b014d0e8e70 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -87,7 +87,6 @@ struct cpufreq_cooling_device {
 	unsigned int clipped_freq;
 	unsigned int max_level;
 	struct freq_table *freq_table;	/* In descending order */
-	struct thermal_cooling_device *cdev;
 	struct cpufreq_policy *policy;
 	struct list_head node;
 	struct time_in_idle *idle_time;
@@ -195,8 +194,7 @@ static int update_freq_table(struct cpufreq_cooling_device *cpufreq_cdev,
 
 	dev = get_cpu_device(cpu);
 	if (unlikely(!dev)) {
-		dev_warn(&cpufreq_cdev->cdev->device,
-			 "No cpu device for cpu %d\n", cpu);
+		pr_warn("No cpu device for cpu %d\n", cpu);
 		return -ENODEV;
 	}
 
@@ -679,7 +677,6 @@ __cpufreq_cooling_register(struct device_node *np,
 		goto remove_ida;
 
 	cpufreq_cdev->clipped_freq = cpufreq_cdev->freq_table[0].frequency;
-	cpufreq_cdev->cdev = cdev;
 
 	mutex_lock(&cooling_list_lock);
 	/* Register the notifier for first cpufreq cooling device */
@@ -797,7 +794,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 		cpufreq_unregister_notifier(&thermal_cpufreq_notifier_block,
 					    CPUFREQ_POLICY_NOTIFIER);
 
-	thermal_cooling_device_unregister(cpufreq_cdev->cdev);
+	thermal_cooling_device_unregister(cdev);
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
 	kfree(cpufreq_cdev->idle_time);
 	kfree(cpufreq_cdev->freq_table);
-- 
2.17.1
