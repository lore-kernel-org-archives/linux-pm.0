From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH] thermal: cpu_cooling: fix out of bounds access in time_in_idle
Date: Thu, 11 Feb 2016 12:00:51 +0000
Message-ID: <1455192051-6430-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, drinkcat@chromium.org, Javi Merino <javi.merino@arm.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>
List-Id: linux-pm@vger.kernel.org

In __cpufreq_cooling_register() we allocate the arrays for time_in_idle
and time_in_idle_timestamp to be as big as the number of cpus in this
cpufreq device.  However, in get_load() we access this array using the
cpu number as index, which can result in an out of bound access.

Index time_in_idle{,_timestamp} using the index in the cpufreq_device's
allowed_cpus mask, as we do for the load_cpu array in
cpufreq_get_requested_power()

Reported-by: Nicolas Boichat <drinkcat@chromium.org>
Cc: Amit Daniel Kachhap <amit.kachhap@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Tested-by: Nicolas Boichat <drinkcat@chromium.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
Hi Andrew,

This patch fixes an out of bounds access found by Nicolas Boichat
using KASAN.  It is acked by Viresh, comaintainer of the cpu cooling
device and tested by the reporter.  It's been in the list[0] for more
than a month, I've pinged the thermal maintainers three times but they
haven't replied.

Can you merge it via your tree?  Thanks,
Javi

 drivers/thermal/cpu_cooling.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index e3fbc5a5d88f..bd1bab9eade0 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -377,26 +377,28 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_device,
  * get_load() - get load for a cpu since last updated
  * @cpufreq_device:	&struct cpufreq_cooling_device for this cpu
  * @cpu:	cpu number
+ * @cpu_idx:	index of the cpu in cpufreq_device->allowed_cpus
  *
  * Return: The average load of cpu @cpu in percentage since this
  * function was last called.
  */
-static u32 get_load(struct cpufreq_cooling_device *cpufreq_device, int cpu)
+static u32 get_load(struct cpufreq_cooling_device *cpufreq_device, int cpu,
+                    int cpu_idx)
 {
 	u32 load;
 	u64 now, now_idle, delta_time, delta_idle;
 
 	now_idle = get_cpu_idle_time(cpu, &now, 0);
-	delta_idle = now_idle - cpufreq_device->time_in_idle[cpu];
-	delta_time = now - cpufreq_device->time_in_idle_timestamp[cpu];
+	delta_idle = now_idle - cpufreq_device->time_in_idle[cpu_idx];
+	delta_time = now - cpufreq_device->time_in_idle_timestamp[cpu_idx];
 
 	if (delta_time <= delta_idle)
 		load = 0;
 	else
 		load = div64_u64(100 * (delta_time - delta_idle), delta_time);
 
-	cpufreq_device->time_in_idle[cpu] = now_idle;
-	cpufreq_device->time_in_idle_timestamp[cpu] = now;
+	cpufreq_device->time_in_idle[cpu_idx] = now_idle;
+	cpufreq_device->time_in_idle_timestamp[cpu_idx] = now;
 
 	return load;
 }
@@ -598,7 +600,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 		u32 load;
 
 		if (cpu_online(cpu))
-			load = get_load(cpufreq_device, cpu);
+			load = get_load(cpufreq_device, cpu, i);
 		else
 			load = 0;
 
-- 
1.9.1
