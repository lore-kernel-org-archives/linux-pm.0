From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH 2/2] thermal: cpu_cooling: free power table on error or when unregistering
Date: Mon, 17 Aug 2015 19:21:43 +0100
Message-ID: <1439835703-16470-3-git-send-email-javi.merino@arm.com>
References: <1439835703-16470-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439835703-16470-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

The power table is not being freed on error from cpufreq_cooling
register or when unregistering.  Free it.

Fixes: c36cf0717631 ("thermal: cpu_cooling: implement the power cooling device API")
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/thermal/cpu_cooling.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index b6c0f93ea5c2..4fecc34545c3 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -263,7 +263,7 @@ static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_device,
 	struct power_table *power_table;
 	struct dev_pm_opp *opp;
 	struct device *dev = NULL;
-	int num_opps = 0, cpu, i;
+	int num_opps = 0, cpu, i, ret = 0;
 	unsigned long freq;
 
 	for_each_cpu(cpu, &cpufreq_device->allowed_cpus) {
@@ -298,7 +298,8 @@ static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_device,
 
 		if (i >= num_opps) {
 			rcu_read_unlock();
-			return -EAGAIN;
+			ret = -EAGAIN;
+			goto free_power_table;
 		}
 
 		freq_mhz = freq / 1000000;
@@ -320,14 +321,21 @@ static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_device,
 
 	rcu_read_unlock();
 
-	if (i != num_opps)
-		return PTR_ERR(opp);
+	if (i != num_opps) {
+		ret = PTR_ERR(opp);
+		goto free_power_table;
+	}
 
 	cpufreq_device->cpu_dev = dev;
 	cpufreq_device->dyn_power_table = power_table;
 	cpufreq_device->dyn_power_table_entries = i;
 
 	return 0;
+
+free_power_table:
+	kfree(power_table);
+
+	return ret;
 }
 
 static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_device,
@@ -837,7 +845,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	ret = get_idr(&cpufreq_idr, &cpufreq_dev->id);
 	if (ret) {
 		cool_dev = ERR_PTR(ret);
-		goto free_table;
+		goto free_power_table;
 	}
 
 	snprintf(dev_name, sizeof(dev_name), "thermal-cpufreq-%d",
@@ -877,6 +885,8 @@ __cpufreq_cooling_register(struct device_node *np,
 
 remove_idr:
 	release_idr(&cpufreq_idr, cpufreq_dev->id);
+free_power_table:
+	kfree(cpufreq_dev->dyn_power_table);
 free_table:
 	kfree(cpufreq_dev->freq_table);
 free_time_in_idle_timestamp:
@@ -1023,6 +1033,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 
 	thermal_cooling_device_unregister(cpufreq_dev->cool_dev);
 	release_idr(&cpufreq_idr, cpufreq_dev->id);
+	kfree(cpufreq_dev->dyn_power_table);
 	kfree(cpufreq_dev->time_in_idle_timestamp);
 	kfree(cpufreq_dev->time_in_idle);
 	kfree(cpufreq_dev->freq_table);
-- 
1.9.1
