From: Tao Wang <kevin.wangtao@hisilicon.com>
Subject: [PATCH RFC 2/2] thermal/cpu idle cooling: cpu idle cooling cooperate with cpu cooling
Date: Mon, 5 Jun 2017 17:03:19 +0800
Message-ID: <1496653399-19655-2-git-send-email-kevin.wangtao@hisilicon.com>
References: <1496653399-19655-1-git-send-email-kevin.wangtao@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([45.249.212.187]:7309 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbdFEJIL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jun 2017 05:08:11 -0400
In-Reply-To: <1496653399-19655-1-git-send-email-kevin.wangtao@hisilicon.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, amit.kachhap@gmail.com, viresh.kumar@linaro.org, javi.merino@kernel.org
Cc: inux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sunzhaosheng@hisilicon.com, vincent.guittot@linaro.org, jean.wangtao@linaro.org, Tao Wang <kevin.wangtao@hisilicon.com>

This implements precise cpu thermal control through the cooperation
between cpu idle cooling and cpu cooling, avoid frequency decrease
if idle injection can achieve the target power limit.
This can bring a smoother temperature curve and performance
improvement in some case when there are big power gaps between cpu
OPPs.

Signed-off-by: Tao Wang <kevin.wangtao@hisilicon.com>
---
 drivers/thermal/Kconfig            |   17 ++++++++++++++++
 drivers/thermal/cpu_cooling.c      |   31 +++++++++++++++++++++++++++++
 drivers/thermal/cpu_idle_cooling.c |    5 +++++
 include/linux/cpu_idle_cooling.h   |   38 ++++++++++++++++++++++++++++++++++++
 4 files changed, 91 insertions(+)
 create mode 100644 include/linux/cpu_idle_cooling.h

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index f78e85c..ef43d15 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -167,6 +167,23 @@ config CPU_IDLE_THERMAL
 
 	  If you want this support, you should say Y here.
 
+config CPU_THERMAL_COMBO
+	bool "precise cpu cooling support"
+	depends on CPU_THERMAL
+	depends on CPU_IDLE_THERMAL
+	help
+	  This implements precise cpu thermal control through the cooperation
+	  between idle cooling and cpu cooling.
+
+	  This will prevent cpu cooling scaling down cpu frequency when idle
+	  injection can meet the power budget.
+
+	  This can bring a smoother temperature curve and performance
+	  improvement in some case when there are big power gaps between cpu
+	  OPPs.
+
+	  If you want this support, you should say Y here.
+
 config CLOCK_THERMAL
 	bool "Generic clock cooling support"
 	depends on COMMON_CLK
diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 69d0f43..a81cd92 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -31,6 +31,7 @@
 #include <linux/slab.h>
 #include <linux/cpu.h>
 #include <linux/cpu_cooling.h>
+#include <linux/cpu_idle_cooling.h>
 
 #include <trace/events/thermal.h>
 
@@ -649,6 +650,31 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 	return ret;
 }
 
+#ifdef CONFIG_CPU_THERMAL_COMBO
+static void idle_cooling_freq_adjust(
+			struct cpufreq_cooling_device *cpufreq_device,
+			u32 power, unsigned int *target_freq)
+{
+	unsigned long target_load, max_idle_ratio;
+	unsigned int idle_freq;
+	s32 cur_dyn_power;
+
+	max_idle_ratio = get_max_idle_state(&cpufreq_device->allowed_cpus);
+	cur_dyn_power = power * 100 / (100 - max_idle_ratio);
+	idle_freq = cpu_power_to_freq(cpufreq_device, cur_dyn_power);
+
+	cur_dyn_power = cpu_freq_to_power(cpufreq_device, idle_freq);
+	target_load = (power * 100) / cur_dyn_power;
+	if (target_load < 100
+		&& ((idle_freq * target_load) >= ((*target_freq) * 100))) {
+		*target_freq = idle_freq;
+	} else {
+		target_load = 100;
+	}
+	set_idle_state(&cpufreq_device->allowed_cpus, 100 - target_load);
+}
+#endif
+
 /**
  * cpufreq_power2state() - convert power to a cooling device state
  * @cdev:	&thermal_cooling_device pointer
@@ -696,6 +722,11 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
 	normalised_power = (dyn_power * 100) / last_load;
 	target_freq = cpu_power_to_freq(cpufreq_device, normalised_power);
 
+#ifdef CONFIG_CPU_THERMAL_COMBO
+	idle_cooling_freq_adjust(cpufreq_device,
+			normalised_power, &target_freq);
+#endif
+
 	*state = cpufreq_cooling_get_level(cpu, target_freq);
 	if (*state == THERMAL_CSTATE_INVALID) {
 		dev_err_ratelimited(&cdev->device,
diff --git a/drivers/thermal/cpu_idle_cooling.c b/drivers/thermal/cpu_idle_cooling.c
index 89a15c5..4a1844d 100644
--- a/drivers/thermal/cpu_idle_cooling.c
+++ b/drivers/thermal/cpu_idle_cooling.c
@@ -28,6 +28,7 @@
 #include <linux/cpumask.h>
 #include <linux/cpuidle.h>
 #include <linux/thermal.h>
+#include <linux/cpu_idle_cooling.h>
 #include <linux/sched.h>
 #include <uapi/linux/sched/types.h>
 #include <linux/slab.h>
@@ -35,7 +36,11 @@
 #include <linux/wait.h>
 #include <linux/sched/rt.h>
 
+#ifdef CONFIG_CPU_THERMAL_COMBO
+#define MAX_TARGET_RATIO		(20U)
+#else
 #define MAX_TARGET_RATIO		(50U)
+#endif
 
 #define DEFAULT_WINDOW_SIZE		(1)
 #define DEFAULT_DURATION_JIFFIES	(20)
diff --git a/include/linux/cpu_idle_cooling.h b/include/linux/cpu_idle_cooling.h
new file mode 100644
index 0000000..da5f19a
--- /dev/null
+++ b/include/linux/cpu_idle_cooling.h
@@ -0,0 +1,38 @@
+/*
+ *  linux/drivers/thermal/cpu_idle_cooling.h
+ *
+ *  Copyright (C) 2017  Tao Wang <kevin.wangtao@hisilicon.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __CPU_IDLE_COOLING_H__
+#define __CPU_IDLE_COOLING_H__
+
+#include <linux/cpumask.h>
+
+#ifdef CONFIG_CPU_IDLE_THERMAL
+unsigned long get_max_idle_state(const struct cpumask *clip_cpus);
+void set_idle_state(const struct cpumask *clip_cpus,
+			unsigned long idle_ratio);
+#else
+static inline unsigned long get_max_idle_state(const struct cpumask *clip_cpus)
+{
+	return 0;
+}
+
+static inline void set_idle_state(const struct cpumask *clip_cpus,
+			unsigned long idle_ratio) {}
+#endif	/* CONFIG_CPU_IDLE_THERMAL */
+
+#endif /* __CPU_IDLE_COOLING_H__ */
-- 
1.7.9.5
