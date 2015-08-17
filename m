From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH 1/2] thermal: cpu_cooling: don't call kcalloc() under rcu_read_lock
Date: Mon, 17 Aug 2015 19:21:42 +0100
Message-ID: <1439835703-16470-2-git-send-email-javi.merino@arm.com>
References: <1439835703-16470-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439835703-16470-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

build_dyn_power_table() allocates the power table while holding
rcu_read_lock.  kcalloc using GFP_KERNEL may sleep, so it can't be
called in an RCU read-side path.

Move the rcu protection to the part of the function that really needs
it: the part that handles the dev_pm_opp pointer received from
dev_pm_opp_find_freq_ceil().  In the unlikely case that there is an OPP
added to the cpu while this function is running, return -EAGAIN.

Fixes: c36cf0717631 ("thermal: cpu_cooling: implement the power cooling device API")
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/thermal/cpu_cooling.c | 47 +++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 6509c61b9648..b6c0f93ea5c2 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -253,7 +253,9 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
  * efficiently.  Power is stored in mW, frequency in KHz.  The
  * resulting table is in ascending order.
  *
- * Return: 0 on success, -E* on error.
+ * Return: 0 on success, -EINVAL if there are no OPPs for any CPUs,
+ * -ENOMEM if we run out of memory or -EAGAIN if an OPP was
+ * added/enabled while the function was executing.
  */
 static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_device,
 				 u32 capacitance)
@@ -261,11 +263,9 @@ static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_device,
 	struct power_table *power_table;
 	struct dev_pm_opp *opp;
 	struct device *dev = NULL;
-	int num_opps = 0, cpu, i, ret = 0;
+	int num_opps = 0, cpu, i;
 	unsigned long freq;
 
-	rcu_read_lock();
-
 	for_each_cpu(cpu, &cpufreq_device->allowed_cpus) {
 		dev = get_cpu_device(cpu);
 		if (!dev) {
@@ -275,24 +275,20 @@ static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_device,
 		}
 
 		num_opps = dev_pm_opp_get_opp_count(dev);
-		if (num_opps > 0) {
+		if (num_opps > 0)
 			break;
-		} else if (num_opps < 0) {
-			ret = num_opps;
-			goto unlock;
-		}
+		else if (num_opps < 0)
+			return num_opps;
 	}
 
-	if (num_opps == 0) {
-		ret = -EINVAL;
-		goto unlock;
-	}
+	if (num_opps == 0)
+		return -EINVAL;
 
 	power_table = kcalloc(num_opps, sizeof(*power_table), GFP_KERNEL);
-	if (!power_table) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
+	if (!power_table)
+		return -ENOMEM;
+
+	rcu_read_lock();
 
 	for (freq = 0, i = 0;
 	     opp = dev_pm_opp_find_freq_ceil(dev, &freq), !IS_ERR(opp);
@@ -300,6 +296,11 @@ static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_device,
 		u32 freq_mhz, voltage_mv;
 		u64 power;
 
+		if (i >= num_opps) {
+			rcu_read_unlock();
+			return -EAGAIN;
+		}
+
 		freq_mhz = freq / 1000000;
 		voltage_mv = dev_pm_opp_get_voltage(opp) / 1000;
 
@@ -317,18 +318,16 @@ static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_device,
 		power_table[i].power = power;
 	}
 
-	if (i == 0) {
-		ret = PTR_ERR(opp);
-		goto unlock;
-	}
+	rcu_read_unlock();
+
+	if (i != num_opps)
+		return PTR_ERR(opp);
 
 	cpufreq_device->cpu_dev = dev;
 	cpufreq_device->dyn_power_table = power_table;
 	cpufreq_device->dyn_power_table_entries = i;
 
-unlock:
-	rcu_read_unlock();
-	return ret;
+	return 0;
 }
 
 static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_device,
-- 
1.9.1
