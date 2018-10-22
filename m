From: Ross Zwisler <zwisler@google.com>
Subject: [PATCH] thermal: add ratelimited thermal and power logging
Date: Mon, 22 Oct 2018 14:29:01 -0600
Message-ID: <20181022202901.1654-1-zwisler@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Ricky Liang <jcliang@chromium.org>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Stephen Barber <smbarber@chromium.org>, Ross Zwisler <zwisler@google.com>
List-Id: linux-pm@vger.kernel.org

From: Ricky Liang <jcliang@chromium.org>

Add thermal logs in devfreq_cooling and cpu_cooling.  Also add logging to
power_allocator when it starts to control power.

These changes can lead to excessive log spam when running up against
thermal limits, so have this logging ratelimited to allow only 1 log each
30 seconds from each of those subsystems.

Signed-off-by: Ricky Liang <jcliang@chromium.org>
Co-authored-by: Stephen Barber <smbarber@chromium.org>
Signed-off-by: Stephen Barber <smbarber@chromium.org>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
[ rez: squashed initial implementation & fixes, updated changelog for
  upstream. ]
Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 drivers/thermal/cpu_cooling.c     | 16 ++++++++++++++++
 drivers/thermal/devfreq_cooling.c | 12 ++++++++++++
 drivers/thermal/power_allocator.c | 17 +++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index dfd23245f778a..d8d1855d7d991 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -31,9 +31,17 @@
 #include <linux/slab.h>
 #include <linux/cpu.h>
 #include <linux/cpu_cooling.h>
+#include <linux/ratelimit.h>
 
 #include <trace/events/thermal.h>
 
+static DEFINE_RATELIMIT_STATE(cpu_cooling_ratelimit_state, 30 * HZ, 1);
+
+static int cpu_cooling_ratelimit(void)
+{
+	return __ratelimit(&cpu_cooling_ratelimit_state);
+}
+
 /*
  * Cooling state <-> CPUFreq frequency
  *
@@ -389,6 +397,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 {
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
 	unsigned int clip_freq;
+	struct device *cpu_dev;
 
 	/* Request state should be less than max_level */
 	if (WARN_ON(state > cpufreq_cdev->max_level))
@@ -404,6 +413,13 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 
 	cpufreq_update_policy(cpufreq_cdev->policy->cpu);
 
+	if (cpu_cooling_ratelimit()) {
+		cpu_dev = get_cpu_device(cpufreq_cdev->policy->cpu);
+		dev_info(cpu_dev,
+			 "Cooling state set to %lu. New max freq = %u\n",
+			 state, clip_freq);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index ef59256887ff6..f95c7f513f05a 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/pm_opp.h>
 #include <linux/thermal.h>
+#include <linux/ratelimit.h>
 
 #include <trace/events/thermal.h>
 
@@ -32,6 +33,13 @@
 
 static DEFINE_IDA(devfreq_ida);
 
+static DEFINE_RATELIMIT_STATE(devfreq_cooling_ratelimit_state, 30 * HZ, 1);
+
+static int devfreq_cooling_ratelimit(void)
+{
+	return __ratelimit(&devfreq_cooling_ratelimit_state);
+}
+
 /**
  * struct devfreq_cooling_device - Devfreq cooling device
  * @id:		unique integer value corresponding to each
@@ -150,6 +158,10 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 
 	dfc->cooling_state = state;
 
+	if (devfreq_cooling_ratelimit())
+		dev_info(dev, "Cooling state set to %lu. New max freq = %u\n",
+			 state, dfc->freq_table[state]);
+
 	return 0;
 }
 
diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
index 3055f9a12a170..5140a07fe60aa 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -15,6 +15,7 @@
 
 #define pr_fmt(fmt) "Power allocator: " fmt
 
+#include <linux/ratelimit.h>
 #include <linux/rculist.h>
 #include <linux/slab.h>
 #include <linux/thermal.h>
@@ -30,6 +31,13 @@
 #define int_to_frac(x) ((x) << FRAC_BITS)
 #define frac_to_int(x) ((x) >> FRAC_BITS)
 
+static DEFINE_RATELIMIT_STATE(power_allocator_ratelimit_state, 30 * HZ, 1);
+
+static int power_allocator_ratelimit(void)
+{
+	return __ratelimit(&power_allocator_ratelimit_state);
+}
+
 /**
  * mul_frac() - multiply two fixed-point numbers
  * @x:	first multiplicand
@@ -443,6 +451,15 @@ static int allocate_power(struct thermal_zone_device *tz,
 				      max_allocatable_power, tz->temperature,
 				      control_temp - tz->temperature);
 
+	if (total_granted_power < total_req_power &&
+			power_allocator_ratelimit()) {
+		dev_info(&tz->device, "Controlling power: control_temp=%d "
+			 "last_temp=%d, curr_temp=%d total_requested_power=%d "
+			 "total_granted_power=%d\n", control_temp,
+			 tz->last_temperature, tz->temperature,
+			 total_req_power, total_granted_power);
+	}
+
 	kfree(req_power);
 unlock:
 	mutex_unlock(&tz->lock);
-- 
2.19.1.568.g152ad8e336-goog
