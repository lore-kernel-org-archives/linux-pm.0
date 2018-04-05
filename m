From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v3 3/7] thermal/drivers/cpu_cooling: Remove pointless field
Date: Thu,  5 Apr 2018 18:16:40 +0200
Message-ID: <1522945005-7165-4-git-send-email-daniel.lezcano@linaro.org>
References: <1522945005-7165-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522945005-7165-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: viresh.kumar@linaro.org, edubezval@gmail.com
Cc: kevin.wangtao@linaro.org, leo.yan@linaro.org, vincent.guittot@linaro.org, linux-kernel@vger.kernel.org, javi.merino@kernel.org, rui.zhang@intel.com, daniel.thompson@linaro.org, linux-pm@vger.kernel.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>
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
index d7528bc..7bdc19f 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -88,7 +88,6 @@ struct cpufreq_cooling_device {
 	unsigned int clipped_freq;
 	unsigned int max_level;
 	struct freq_table *freq_table;	/* In descending order */
-	struct thermal_cooling_device *cdev;
 	struct cpufreq_policy *policy;
 	struct list_head node;
 	struct time_in_idle *idle_time;
@@ -197,8 +196,7 @@ static int update_freq_table(struct cpufreq_cooling_device *cpufreq_cdev,
 
 	dev = get_cpu_device(cpu);
 	if (unlikely(!dev)) {
-		dev_warn(&cpufreq_cdev->cdev->device,
-			 "No cpu device for cpu %d\n", cpu);
+		pr_warn("No cpu device for cpu %d\n", cpu);
 		return -ENODEV;
 	}
 
@@ -762,7 +760,6 @@ __cpufreq_cooling_register(struct device_node *np,
 		goto remove_ida;
 
 	cpufreq_cdev->clipped_freq = cpufreq_cdev->freq_table[0].frequency;
-	cpufreq_cdev->cdev = cdev;
 
 	mutex_lock(&cooling_list_lock);
 	/* Register the notifier for first cpufreq cooling device */
@@ -922,7 +919,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 		cpufreq_unregister_notifier(&thermal_cpufreq_notifier_block,
 					    CPUFREQ_POLICY_NOTIFIER);
 
-	thermal_cooling_device_unregister(cpufreq_cdev->cdev);
+	thermal_cooling_device_unregister(cdev);
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
 	kfree(cpufreq_cdev->idle_time);
 	kfree(cpufreq_cdev->freq_table);
-- 
2.7.4
