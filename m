From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/2] cpufreq: Add android's 'interactive' governor
Date: Fri, 20 May 2016 12:09:37 +0530
Message-ID: <477837a5e9872749e95635b443f78ccbbed36c9c.1463723328.git.viresh.kumar@linaro.org>
References: <cover.1463723328.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36528 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946AbcETGkU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2016 02:40:20 -0400
Received: by mail-pa0-f52.google.com with SMTP id bt5so36573209pac.3
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2016 23:40:20 -0700 (PDT)
In-Reply-To: <cover.1463723328.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1463723328.git.viresh.kumar@linaro.org>
References: <cover.1463723328.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, peterz@infradead.org, mike@android.com, toddpoynor@google.com, linux-kernel@vger.kernel.org, kandoiruchi@google.com, juri.lelli@arm.com, steve.muckle@linaro.org, vincent.guittot@linaro.org

Interactive governor has lived in Android sources for a very long time
and this commit is based on the code present in following branch:

https://android.googlesource.com/kernel/common android-4.4

The Interactive governor is designed for latency-sensitive workloads,
such as interactive user interfaces like the mobile phones and tablets.
The interactive governor aims to be significantly more responsive to
ramp CPU quickly up when CPU-intensive activity begins.

Existing governors sample CPU load at a particular rate, typically every
X ms and then update the frequency from a work-handler.  This can lead
to under-powering UI threads for the period of time during which the
user begins interacting with a previously-idle system until the next
sample period happens.

The 'interactive' governor uses a different approach.

A real-time thread is used for scaling up, giving the remaining tasks
the CPU performance benefit, unlike existing governors which are more
likely to schedule ramp-up work to occur after your performance starved
tasks have completed.

The Android version of interactive governor also checks whether to scale
the CPU frequency up soon after coming out of idle.  When the CPU comes
out of idle, the governor check if the CPU sampling is overdue or not.
If yes, it immediately starts the sampling.  Otherwise, the utilization
hooks from the scheduler handle the sampling later.  If the CPU is very
busy from exiting idle to when the evaluation happens, then it assumes
that the CPU is under-powered and ramps it to MAX speed.

If the CPU was not sufficiently busy to immediately ramp to MAX speed,
then the governor evaluates the CPU load since the last speed
adjustment, choosing the highest value between that longer-term load or
the short-term load since idle exit to determine the CPU speed to ramp
to.

Idle notifiers will be be handled later and are not included for now.

The core of this code is written and maintained (in Android
repositories) by Mike Chan and Todd Poyner over a long period of time.

Vireshk has made changes to the governor to align it with the current
practices followed with mainline governors, like using utilization hooks
from the scheduler and handling kobject (for governor's sysfs directory)
in a race free manner. And of course this included general cleanup of
the governor as well.

Signed-off-by: Mike Chan <mike@android.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/cpu-freq/governors.txt       |   86 ++
 drivers/cpufreq/Kconfig                    |   27 +
 drivers/cpufreq/Makefile                   |    1 +
 drivers/cpufreq/cpufreq_interactive.c      | 1371 ++++++++++++++++++++++++++++
 include/trace/events/cpufreq_interactive.h |  112 +++
 5 files changed, 1597 insertions(+)
 create mode 100644 drivers/cpufreq/cpufreq_interactive.c
 create mode 100644 include/trace/events/cpufreq_interactive.h

diff --git a/Documentation/cpu-freq/governors.txt b/Documentation/cpu-freq/governors.txt
index c15aa75f5227..1969ee1e6c14 100644
--- a/Documentation/cpu-freq/governors.txt
+++ b/Documentation/cpu-freq/governors.txt
@@ -28,6 +28,7 @@
 2.3  Userspace
 2.4  Ondemand
 2.5  Conservative
+2.6  Interactive
 
 3.   The Governor Interface in the CPUfreq Core
 
@@ -218,6 +219,91 @@ a decision on when to decrease the frequency while running in any
 speed. Load for frequency increase is still evaluated every
 sampling rate.
 
+2.6 Interactive
+---------------
+
+The CPUfreq governor "interactive" is designed for latency-sensitive,
+interactive workloads. This governor sets the CPU speed depending on
+usage, similar to "ondemand" and "conservative" governors, but with a
+different set of configurable behaviors.
+
+The tunable values for this governor are:
+
+above_hispeed_delay: When speed is at or above hispeed_freq, wait for
+this long before raising speed in response to continued high load.
+The format is a single delay value, optionally followed by pairs of
+CPU speeds and the delay to use at or above those speeds.  Colons can
+be used between the speeds and associated delays for readability.  For
+example:
+
+   80000 1300000:200000 1500000:40000
+
+uses delay 80000 uS until CPU speed 1.3 GHz, at which speed delay
+200000 uS is used until speed 1.5 GHz, at which speed (and above)
+delay 40000 uS is used.  If speeds are specified these must appear in
+ascending order.  Default is 20000 uS.
+
+boost: If non-zero, immediately boost speed of all CPUs to at least
+hispeed_freq until zero is written to this attribute.  If zero, allow
+CPU speeds to drop below hispeed_freq according to load as usual.
+Default is zero.
+
+boostpulse: On each write, immediately boost speed of all CPUs to
+hispeed_freq for at least the period of time specified by
+boostpulse_duration, after which speeds are allowed to drop below
+hispeed_freq according to load as usual.
+
+boostpulse_duration: Length of time to hold CPU speed at hispeed_freq
+on a write to boostpulse, before allowing speed to drop according to
+load as usual.  Default is 80000 uS.
+
+go_hispeed_load: The CPU load at which to ramp to hispeed_freq.
+Default is 99%.
+
+hispeed_freq: An intermediate "high speed" at which to initially ramp
+when CPU load hits the value specified in go_hispeed_load.  If load
+stays high for the amount of time specified in above_hispeed_delay,
+then speed may be bumped higher.  Default is the maximum speed allowed
+by the policy at governor initialization time.
+
+io_is_busy: If set, the governor accounts IO time as CPU busy time.
+
+min_sample_time: The minimum amount of time to spend at the current
+frequency before ramping down. Default is 80000 uS.
+
+target_loads: CPU load values used to adjust speed to influence the
+current CPU load toward that value.  In general, the lower the target
+load, the more often the governor will raise CPU speeds to bring load
+below the target.  The format is a single target load, optionally
+followed by pairs of CPU speeds and CPU loads to target at or above
+those speeds.  Colons can be used between the speeds and associated
+target loads for readability.  For example:
+
+   85 1000000:90 1700000:99
+
+targets CPU load 85% below speed 1GHz, 90% at or above 1GHz, until
+1.7GHz and above, at which load 99% is targeted.  If speeds are
+specified these must appear in ascending order.  Higher target load
+values are typically specified for higher speeds, that is, target load
+values also usually appear in an ascending order. The default is
+target load 90% for all speeds.
+
+timer_rate: Sample rate for reevaluating CPU load when the CPU is not
+idle.  A deferrable timer is used, such that the CPU will not be woken
+from idle to service this timer until something else needs to run.
+(The maximum time to allow deferring this timer when not running at
+minimum speed is configurable via timer_slack.)  Default is 20000 uS.
+
+timer_slack: Maximum additional time to defer handling the governor
+sampling timer beyond timer_rate when running at speeds above the
+minimum.  For platforms that consume additional power at idle when
+CPUs are running at speeds greater than minimum, this places an upper
+bound on how long the timer will be deferred prior to re-evaluating
+load and dropping speed.  For example, if timer_rate is 20000uS and
+timer_slack is 10000uS then timers will be deferred for up to 30msec
+when not at lowest speed.  A value of -1 means defer timers
+indefinitely at all speeds.  Default is 80000 uS.
+
 3. The Governor Interface in the CPUfreq Core
 =============================================
 
diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index b7445b6ae5a4..49de5c3e1211 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -118,6 +118,16 @@ config CPU_FREQ_DEFAULT_GOV_SCHEDUTIL
 	  have a look at the help section of that governor. The fallback
 	  governor will be 'performance'.
 
+config CPU_FREQ_DEFAULT_GOV_INTERACTIVE
+	bool "interactive"
+	select CPU_FREQ_GOV_INTERACTIVE
+	select CPU_FREQ_GOV_PERFORMANCE
+	help
+	  Use the CPUFreq governor 'interactive' as default. This allows
+	  you to get a full dynamic cpu frequency capable system by simply
+	  loading your cpufreq low-level hardware driver, using the
+	  'interactive' governor for latency-sensitive workloads.
+
 endchoice
 
 config CPU_FREQ_GOV_PERFORMANCE
@@ -219,6 +229,23 @@ config CPU_FREQ_GOV_SCHEDUTIL
 
 	  If in doubt, say N.
 
+config CPU_FREQ_GOV_INTERACTIVE
+	tristate "'interactive' cpufreq policy governor"
+	help
+	  'interactive' - This driver adds a dynamic cpufreq policy governor
+	  designed for latency-sensitive workloads.
+
+	  This governor attempts to reduce the latency of clock
+	  increases so that the system is more responsive to
+	  interactive workloads.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cpufreq_interactive.
+
+	  For details, take a look at linux/Documentation/cpu-freq.
+
+	  If in doubt, say N.
+
 comment "CPU frequency scaling drivers"
 
 config CPUFREQ_DT
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index e1eb11ee3570..0b3a8dac98ec 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_CPU_FREQ_GOV_POWERSAVE)	+= cpufreq_powersave.o
 obj-$(CONFIG_CPU_FREQ_GOV_USERSPACE)	+= cpufreq_userspace.o
 obj-$(CONFIG_CPU_FREQ_GOV_ONDEMAND)	+= cpufreq_ondemand.o
 obj-$(CONFIG_CPU_FREQ_GOV_CONSERVATIVE)	+= cpufreq_conservative.o
+obj-$(CONFIG_CPU_FREQ_GOV_INTERACTIVE)	+= cpufreq_interactive.o
 obj-$(CONFIG_CPU_FREQ_GOV_COMMON)		+= cpufreq_governor.o
 obj-$(CONFIG_CPU_FREQ_GOV_ATTR_SET)	+= cpufreq_governor_attr_set.o
 
diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cpufreq_interactive.c
new file mode 100644
index 000000000000..3ef4a8c01d11
--- /dev/null
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -0,0 +1,1371 @@
+/*
+ * drivers/cpufreq/cpufreq_interactive.c
+ *
+ * Copyright (C) 2010-2016 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Author: Mike Chan (mike@android.com)
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/cpufreq.h>
+#include <linux/irq_work.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/rwsem.h>
+#include <linux/sched.h>
+#include <linux/sched/rt.h>
+#include <linux/tick.h>
+#include <linux/time.h>
+#include <linux/timer.h>
+#include <linux/kthread.h>
+#include <linux/slab.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/cpufreq_interactive.h>
+
+/* Separate instance required for each 'interactive' directory in sysfs */
+struct interactive_tunables {
+	struct gov_attr_set attr_set;
+
+	/* Hi speed to bump to from lo speed when load burst (default max) */
+	unsigned int hispeed_freq;
+
+	/* Go to hi speed when CPU load at or above this value. */
+#define DEFAULT_GO_HISPEED_LOAD 99
+	unsigned long go_hispeed_load;
+
+	/* Target load. Lower values result in higher CPU speeds. */
+	spinlock_t target_loads_lock;
+	unsigned int *target_loads;
+	int ntarget_loads;
+
+	/*
+	 * The minimum amount of time to spend at a frequency before we can ramp
+	 * down.
+	 */
+#define DEFAULT_MIN_SAMPLE_TIME (80 * USEC_PER_MSEC)
+	unsigned long min_sample_time;
+
+	/* The sample rate of the timer used to increase frequency */
+	unsigned long sampling_rate;
+
+	/*
+	 * Wait this long before raising speed above hispeed, by default a
+	 * single timer interval.
+	 */
+	spinlock_t above_hispeed_delay_lock;
+	unsigned int *above_hispeed_delay;
+	int nabove_hispeed_delay;
+
+	/* Non-zero means indefinite speed boost active */
+	int boost;
+	/* Duration of a boot pulse in usecs */
+	int boostpulse_duration;
+	/* End time of boost pulse in ktime converted to usecs */
+	u64 boostpulse_endtime;
+	bool boosted;
+
+	/*
+	 * Max additional time to wait in idle, beyond sampling_rate, at speeds
+	 * above minimum before wakeup to reduce speed, or -1 if unnecessary.
+	 */
+#define DEFAULT_TIMER_SLACK (4 * DEFAULT_SAMPLING_RATE)
+	unsigned long timer_slack_delay;
+	unsigned long timer_slack;
+	bool io_is_busy;
+};
+
+/* Separate instance required for each 'struct cpufreq_policy' */
+struct interactive_policy {
+	struct cpufreq_policy *policy;
+	struct interactive_tunables *tunables;
+	struct list_head tunables_hook;
+};
+
+/* Separate instance required for each CPU */
+struct interactive_cpu {
+	struct update_util_data update_util;
+	struct interactive_policy *ipolicy;
+
+	struct irq_work irq_work;
+	u64 last_sample_time;
+	bool work_in_progress;
+
+	struct rw_semaphore enable_sem;
+	struct timer_list slack_timer;
+
+	spinlock_t load_lock; /* protects the next 4 fields */
+	u64 time_in_idle;
+	u64 time_in_idle_timestamp;
+	u64 cputime_speedadj;
+	u64 cputime_speedadj_timestamp;
+
+	spinlock_t target_freq_lock; /*protects target freq */
+	unsigned int target_freq;
+
+	unsigned int floor_freq;
+	u64 pol_floor_val_time; /* policy floor_validate_time */
+	u64 loc_floor_val_time; /* per-cpu floor_validate_time */
+	u64 pol_hispeed_val_time; /* policy hispeed_validate_time */
+	u64 loc_hispeed_val_time; /* per-cpu hispeed_validate_time */
+};
+
+static DEFINE_PER_CPU(struct interactive_cpu, interactive_cpu);
+
+/* Realtime thread handles frequency scaling */
+static struct task_struct *speedchange_task;
+static cpumask_t speedchange_cpumask;
+static spinlock_t speedchange_cpumask_lock;
+
+/* Target load. Lower values result in higher CPU speeds. */
+#define DEFAULT_TARGET_LOAD 90
+static unsigned int default_target_loads[] = {DEFAULT_TARGET_LOAD};
+
+#define DEFAULT_SAMPLING_RATE (20 * USEC_PER_MSEC)
+#define DEFAULT_ABOVE_HISPEED_DELAY DEFAULT_SAMPLING_RATE
+static unsigned int default_above_hispeed_delay[] = {
+	DEFAULT_ABOVE_HISPEED_DELAY
+};
+
+/* Iterate over interactive policies for tunables */
+#define for_each_ipolicy(__ip)	\
+	list_for_each_entry(__ip, &tunables->attr_set.policy_list, tunables_hook)
+
+static struct interactive_tunables *global_tunables;
+static DEFINE_MUTEX(global_tunables_lock);
+
+static inline void update_slack_delay(struct interactive_tunables *tunables)
+{
+	tunables->timer_slack_delay = usecs_to_jiffies(tunables->timer_slack +
+						       tunables->sampling_rate);
+}
+
+static bool timer_slack_required(struct interactive_cpu *icpu)
+{
+	struct interactive_policy *ipolicy = icpu->ipolicy;
+	struct interactive_tunables *tunables = ipolicy->tunables;
+
+	if (tunables->timer_slack < 0)
+		return false;
+
+	if (icpu->target_freq > ipolicy->policy->min)
+		return true;
+
+	return false;
+}
+
+static void gov_slack_timer_start(struct interactive_cpu *icpu, int cpu)
+{
+	struct interactive_tunables *tunables = icpu->ipolicy->tunables;
+
+	icpu->slack_timer.expires = jiffies + tunables->timer_slack_delay;
+	add_timer_on(&icpu->slack_timer, cpu);
+}
+
+static void gov_slack_timer_modify(struct interactive_cpu *icpu)
+{
+	struct interactive_tunables *tunables = icpu->ipolicy->tunables;
+
+	mod_timer_pinned(&icpu->slack_timer,
+			 jiffies + tunables->timer_slack_delay);
+}
+
+static void slack_timer_resched(struct interactive_cpu *icpu, int cpu,
+				bool modify)
+{
+	struct interactive_tunables *tunables = icpu->ipolicy->tunables;
+	unsigned long flags;
+
+	spin_lock_irqsave(&icpu->load_lock, flags);
+
+	icpu->time_in_idle = get_cpu_idle_time(cpu,
+					       &icpu->time_in_idle_timestamp,
+					       tunables->io_is_busy);
+	icpu->cputime_speedadj = 0;
+	icpu->cputime_speedadj_timestamp = icpu->time_in_idle_timestamp;
+
+	if (timer_slack_required(icpu)) {
+		if (modify)
+			gov_slack_timer_modify(icpu);
+		else
+			gov_slack_timer_start(icpu, cpu);
+	}
+
+	spin_unlock_irqrestore(&icpu->load_lock, flags);
+}
+
+static unsigned int
+freq_to_above_hispeed_delay(struct interactive_tunables *tunables,
+			    unsigned int freq)
+{
+	unsigned long flags;
+	unsigned int ret;
+	int i;
+
+	spin_lock_irqsave(&tunables->above_hispeed_delay_lock, flags);
+
+	for (i = 0; i < tunables->nabove_hispeed_delay - 1 &&
+	     freq >= tunables->above_hispeed_delay[i + 1]; i += 2)
+		;
+
+	ret = tunables->above_hispeed_delay[i];
+	spin_unlock_irqrestore(&tunables->above_hispeed_delay_lock, flags);
+
+	return ret;
+}
+
+static unsigned int freq_to_targetload(struct interactive_tunables *tunables,
+				       unsigned int freq)
+{
+	unsigned long flags;
+	unsigned int ret;
+	int i;
+
+	spin_lock_irqsave(&tunables->target_loads_lock, flags);
+
+	for (i = 0; i < tunables->ntarget_loads - 1 &&
+	     freq >= tunables->target_loads[i + 1]; i += 2)
+		;
+
+	ret = tunables->target_loads[i];
+	spin_unlock_irqrestore(&tunables->target_loads_lock, flags);
+	return ret;
+}
+
+/*
+ * If increasing frequencies never map to a lower target load then
+ * choose_freq() will find the minimum frequency that does not exceed its
+ * target load given the current load.
+ */
+static unsigned int choose_freq(struct interactive_cpu *icpu,
+				unsigned int loadadjfreq)
+{
+	struct cpufreq_policy *policy = icpu->ipolicy->policy;
+	struct cpufreq_frequency_table *freq_table = policy->freq_table;
+	unsigned int prevfreq, freqmin = 0, freqmax = UINT_MAX, tl;
+	unsigned int freq = policy->cur;
+	int index, ret;
+
+	do {
+		prevfreq = freq;
+		tl = freq_to_targetload(icpu->ipolicy->tunables, freq);
+
+		/*
+		 * Find the lowest frequency where the computed load is less
+		 * than or equal to the target load.
+		 */
+
+		ret = cpufreq_frequency_table_target(policy, freq_table,
+				loadadjfreq / tl, CPUFREQ_RELATION_L, &index);
+		if (ret)
+			break;
+
+		freq = freq_table[index].frequency;
+
+		if (freq > prevfreq) {
+			/* The previous frequency is too low */
+			freqmin = prevfreq;
+
+			if (freq < freqmax)
+				continue;
+
+			/* Find highest frequency that is less than freqmax */
+			ret = cpufreq_frequency_table_target(policy, freq_table,
+					freqmax - 1, CPUFREQ_RELATION_H,
+					&index);
+			if (ret)
+				break;
+
+			freq = freq_table[index].frequency;
+
+			if (freq == freqmin) {
+				/*
+				 * The first frequency below freqmax has already
+				 * been found to be too low. freqmax is the
+				 * lowest speed we found that is fast enough.
+				 */
+				freq = freqmax;
+				break;
+			}
+		} else if (freq < prevfreq) {
+			/* The previous frequency is high enough. */
+			freqmax = prevfreq;
+
+			if (freq > freqmin)
+				continue;
+
+			/* Find lowest frequency that is higher than freqmin */
+			ret = cpufreq_frequency_table_target(policy, freq_table,
+					freqmin + 1, CPUFREQ_RELATION_L,
+					&index);
+			if (ret)
+				break;
+
+			freq = freq_table[index].frequency;
+
+			/*
+			 * If freqmax is the first frequency above
+			 * freqmin then we have already found that
+			 * this speed is fast enough.
+			 */
+			if (freq == freqmax)
+				break;
+		}
+
+		/* If same frequency chosen as previous then done. */
+	} while (freq != prevfreq);
+
+	return freq;
+}
+
+static u64 update_load(struct interactive_cpu *icpu, int cpu)
+{
+	struct interactive_tunables *tunables = icpu->ipolicy->tunables;
+	unsigned int delta_idle, delta_time;
+	u64 now_idle, now, active_time;
+
+	now_idle = get_cpu_idle_time(cpu, &now, tunables->io_is_busy);
+	delta_idle = (unsigned int)(now_idle - icpu->time_in_idle);
+	delta_time = (unsigned int)(now - icpu->time_in_idle_timestamp);
+
+	if (delta_time <= delta_idle)
+		active_time = 0;
+	else
+		active_time = delta_time - delta_idle;
+
+	icpu->cputime_speedadj += active_time * icpu->ipolicy->policy->cur;
+
+	icpu->time_in_idle = now_idle;
+	icpu->time_in_idle_timestamp = now;
+
+	return now;
+}
+
+/* Re-evaluate load to see if a frequency change is required or not */
+static void eval_target_freq(struct interactive_cpu *icpu)
+{
+	struct interactive_tunables *tunables = icpu->ipolicy->tunables;
+	struct cpufreq_policy *policy = icpu->ipolicy->policy;
+	struct cpufreq_frequency_table *freq_table = policy->freq_table;
+	u64 cputime_speedadj, now, max_fvtime;
+	unsigned int new_freq, loadadjfreq, index, delta_time;
+	unsigned long flags;
+	int cpu_load;
+	int cpu = smp_processor_id();
+
+	spin_lock_irqsave(&icpu->load_lock, flags);
+	now = update_load(icpu, smp_processor_id());
+	delta_time = (unsigned int)(now - icpu->cputime_speedadj_timestamp);
+	cputime_speedadj = icpu->cputime_speedadj;
+	spin_unlock_irqrestore(&icpu->load_lock, flags);
+
+	if (WARN_ON_ONCE(!delta_time))
+		return;
+
+	spin_lock_irqsave(&icpu->target_freq_lock, flags);
+	do_div(cputime_speedadj, delta_time);
+	loadadjfreq = (unsigned int)cputime_speedadj * 100;
+	cpu_load = loadadjfreq / policy->cur;
+	tunables->boosted = tunables->boost ||
+			    now < tunables->boostpulse_endtime;
+
+	if (cpu_load >= tunables->go_hispeed_load || tunables->boosted) {
+		if (policy->cur < tunables->hispeed_freq) {
+			new_freq = tunables->hispeed_freq;
+		} else {
+			new_freq = choose_freq(icpu, loadadjfreq);
+
+			if (new_freq < tunables->hispeed_freq)
+				new_freq = tunables->hispeed_freq;
+		}
+	} else {
+		new_freq = choose_freq(icpu, loadadjfreq);
+		if (new_freq > tunables->hispeed_freq &&
+		    policy->cur < tunables->hispeed_freq)
+			new_freq = tunables->hispeed_freq;
+	}
+
+	if (policy->cur >= tunables->hispeed_freq &&
+	    new_freq > policy->cur &&
+	    now - icpu->pol_hispeed_val_time < freq_to_above_hispeed_delay(tunables, policy->cur)) {
+		trace_cpufreq_interactive_notyet(cpu, cpu_load,
+				icpu->target_freq, policy->cur, new_freq);
+		goto exit;
+	}
+
+	icpu->loc_hispeed_val_time = now;
+
+	if (cpufreq_frequency_table_target(policy, freq_table, new_freq,
+					   CPUFREQ_RELATION_L, &index)) {
+		goto exit;
+	}
+
+	new_freq = freq_table[index].frequency;
+
+	/*
+	 * Do not scale below floor_freq unless we have been at or above the
+	 * floor frequency for the minimum sample time since last validated.
+	 */
+	max_fvtime = max(icpu->pol_floor_val_time, icpu->loc_floor_val_time);
+	if (new_freq < icpu->floor_freq && icpu->target_freq >= policy->cur) {
+		if (now - max_fvtime < tunables->min_sample_time) {
+			trace_cpufreq_interactive_notyet(cpu, cpu_load,
+				icpu->target_freq, policy->cur, new_freq);
+			goto exit;
+		}
+	}
+
+	/*
+	 * Update the timestamp for checking whether speed has been held at
+	 * or above the selected frequency for a minimum of min_sample_time,
+	 * if not boosted to hispeed_freq.  If boosted to hispeed_freq then we
+	 * allow the speed to drop as soon as the boostpulse duration expires
+	 * (or the indefinite boost is turned off).
+	 */
+
+	if (!tunables->boosted || new_freq > tunables->hispeed_freq) {
+		icpu->floor_freq = new_freq;
+		if (icpu->target_freq >= policy->cur || new_freq >= policy->cur)
+			icpu->loc_floor_val_time = now;
+	}
+
+	if (icpu->target_freq == new_freq &&
+	    icpu->target_freq <= policy->cur) {
+		trace_cpufreq_interactive_already(cpu, cpu_load,
+			icpu->target_freq, policy->cur, new_freq);
+		goto exit;
+	}
+
+	trace_cpufreq_interactive_target(cpu, cpu_load, icpu->target_freq,
+					 policy->cur, new_freq);
+
+	icpu->target_freq = new_freq;
+	spin_unlock_irqrestore(&icpu->target_freq_lock, flags);
+
+	spin_lock_irqsave(&speedchange_cpumask_lock, flags);
+	cpumask_set_cpu(cpu, &speedchange_cpumask);
+	spin_unlock_irqrestore(&speedchange_cpumask_lock, flags);
+
+	wake_up_process(speedchange_task);
+	return;
+
+exit:
+	spin_unlock_irqrestore(&icpu->target_freq_lock, flags);
+}
+
+static void cpufreq_interactive_update(struct interactive_cpu *icpu)
+{
+	eval_target_freq(icpu);
+	slack_timer_resched(icpu, smp_processor_id(), true);
+}
+
+static void cpufreq_interactive_get_policy_info(struct cpufreq_policy *policy,
+						unsigned int *pmax_freq,
+						u64 *phvt, u64 *pfvt)
+{
+	struct interactive_cpu *icpu;
+	u64 hvt = ~0ULL, fvt = 0;
+	unsigned int max_freq = 0, i;
+
+	for_each_cpu(i, policy->cpus) {
+		icpu = &per_cpu(interactive_cpu, i);
+
+		fvt = max(fvt, icpu->loc_floor_val_time);
+		if (icpu->target_freq > max_freq) {
+			max_freq = icpu->target_freq;
+			hvt = icpu->loc_hispeed_val_time;
+		} else if (icpu->target_freq == max_freq) {
+			hvt = min(hvt, icpu->loc_hispeed_val_time);
+		}
+	}
+
+	*pmax_freq = max_freq;
+	*phvt = hvt;
+	*pfvt = fvt;
+}
+
+static void cpufreq_interactive_adjust_cpu(unsigned int cpu,
+					   struct cpufreq_policy *policy)
+{
+	struct interactive_cpu *icpu;
+	u64 hvt, fvt;
+	unsigned int max_freq;
+	int i;
+
+	cpufreq_interactive_get_policy_info(policy, &max_freq, &hvt, &fvt);
+
+	for_each_cpu(i, policy->cpus) {
+		icpu = &per_cpu(interactive_cpu, i);
+		icpu->pol_floor_val_time = fvt;
+	}
+
+	if (max_freq != policy->cur) {
+		__cpufreq_driver_target(policy, max_freq, CPUFREQ_RELATION_H);
+		for_each_cpu(i, policy->cpus) {
+			icpu = &per_cpu(interactive_cpu, i);
+			icpu->pol_hispeed_val_time = hvt;
+		}
+	}
+
+	trace_cpufreq_interactive_setspeed(cpu, max_freq, policy->cur);
+}
+
+static int cpufreq_interactive_speedchange_task(void *data)
+{
+	unsigned int cpu;
+	cpumask_t tmp_mask;
+	unsigned long flags;
+
+again:
+	set_current_state(TASK_INTERRUPTIBLE);
+	spin_lock_irqsave(&speedchange_cpumask_lock, flags);
+
+	if (cpumask_empty(&speedchange_cpumask)) {
+		spin_unlock_irqrestore(&speedchange_cpumask_lock, flags);
+		schedule();
+
+		if (kthread_should_stop())
+			return 0;
+
+		spin_lock_irqsave(&speedchange_cpumask_lock, flags);
+	}
+
+	set_current_state(TASK_RUNNING);
+	tmp_mask = speedchange_cpumask;
+	cpumask_clear(&speedchange_cpumask);
+	spin_unlock_irqrestore(&speedchange_cpumask_lock, flags);
+
+	for_each_cpu(cpu, &tmp_mask) {
+		struct interactive_cpu *icpu = &per_cpu(interactive_cpu, cpu);
+		struct cpufreq_policy *policy = icpu->ipolicy->policy;
+
+		if (unlikely(!down_read_trylock(&icpu->enable_sem)))
+			continue;
+
+		if (likely(icpu->ipolicy))
+			cpufreq_interactive_adjust_cpu(cpu, policy);
+
+		up_read(&icpu->enable_sem);
+	}
+
+	goto again;
+}
+
+static void cpufreq_interactive_boost(struct interactive_tunables *tunables)
+{
+	struct interactive_policy *ipolicy;
+	struct cpufreq_policy *policy;
+	struct interactive_cpu *icpu;
+	unsigned long flags[2];
+	bool wakeup = false;
+	int i;
+
+	tunables->boosted = true;
+
+	spin_lock_irqsave(&speedchange_cpumask_lock, flags[0]);
+
+	for_each_ipolicy(ipolicy) {
+		policy = ipolicy->policy;
+
+		for_each_cpu(i, policy->cpus) {
+			icpu = &per_cpu(interactive_cpu, i);
+
+			if (!down_read_trylock(&icpu->enable_sem))
+				continue;
+
+			if (!icpu->ipolicy) {
+				up_read(&icpu->enable_sem);
+				continue;
+			}
+
+			spin_lock_irqsave(&icpu->target_freq_lock, flags[1]);
+			if (icpu->target_freq < tunables->hispeed_freq) {
+				icpu->target_freq = tunables->hispeed_freq;
+				cpumask_set_cpu(i, &speedchange_cpumask);
+				icpu->pol_hispeed_val_time = ktime_to_us(ktime_get());
+				wakeup = true;
+			}
+			spin_unlock_irqrestore(&icpu->target_freq_lock, flags[1]);
+
+			up_read(&icpu->enable_sem);
+		}
+	}
+
+	spin_unlock_irqrestore(&speedchange_cpumask_lock, flags[0]);
+
+	if (wakeup)
+		wake_up_process(speedchange_task);
+}
+
+static int cpufreq_interactive_notifier(struct notifier_block *nb,
+					unsigned long val, void *data)
+{
+	struct cpufreq_freqs *freq = data;
+	struct interactive_cpu *icpu = &per_cpu(interactive_cpu, freq->cpu);
+	unsigned long flags;
+
+	if (val != CPUFREQ_POSTCHANGE)
+		return 0;
+
+	if (!down_read_trylock(&icpu->enable_sem))
+		return 0;
+
+	if (!icpu->ipolicy) {
+		up_read(&icpu->enable_sem);
+		return 0;
+	}
+
+	spin_lock_irqsave(&icpu->load_lock, flags);
+	update_load(icpu, freq->cpu);
+	spin_unlock_irqrestore(&icpu->load_lock, flags);
+
+	up_read(&icpu->enable_sem);
+
+	return 0;
+}
+
+static struct notifier_block cpufreq_notifier_block = {
+	.notifier_call = cpufreq_interactive_notifier,
+};
+
+static unsigned int *get_tokenized_data(const char *buf, int *num_tokens)
+{
+	const char *cp = buf;
+	int ntokens = 1, i = 0;
+	unsigned int *tokenized_data;
+	int err = -EINVAL;
+
+	while ((cp = strpbrk(cp + 1, " :")))
+		ntokens++;
+
+	if (!(ntokens & 0x1))
+		goto err;
+
+	tokenized_data = kcalloc(ntokens, sizeof(*tokenized_data), GFP_KERNEL);
+	if (!tokenized_data) {
+		err = -ENOMEM;
+		goto err;
+	}
+
+	cp = buf;
+	while (i < ntokens) {
+		if (kstrtouint(cp, 0, &tokenized_data[i++]) < 0)
+			goto err_kfree;
+
+		cp = strpbrk(cp, " :");
+		if (!cp)
+			break;
+		cp++;
+	}
+
+	if (i != ntokens)
+		goto err_kfree;
+
+	*num_tokens = ntokens;
+	return tokenized_data;
+
+err_kfree:
+	kfree(tokenized_data);
+err:
+	return ERR_PTR(err);
+}
+
+/* Interactive governor sysfs interface */
+static struct interactive_tunables *to_tunables(struct gov_attr_set *attr_set)
+{
+	return container_of(attr_set, struct interactive_tunables, attr_set);
+}
+
+#define show_one(file_name, type)					\
+static ssize_t show_##file_name(struct gov_attr_set *attr_set, char *buf) \
+{									\
+	struct interactive_tunables *tunables = to_tunables(attr_set);	\
+	return sprintf(buf, type "\n", tunables->file_name);		\
+}
+
+static ssize_t show_target_loads(struct gov_attr_set *attr_set, char *buf)
+{
+	struct interactive_tunables *tunables = to_tunables(attr_set);
+	unsigned long flags;
+	ssize_t ret = 0;
+	int i;
+
+	spin_lock_irqsave(&tunables->target_loads_lock, flags);
+
+	for (i = 0; i < tunables->ntarget_loads; i++)
+		ret += sprintf(buf + ret, "%u%s", tunables->target_loads[i],
+			       i & 0x1 ? ":" : " ");
+
+	sprintf(buf + ret - 1, "\n");
+	spin_unlock_irqrestore(&tunables->target_loads_lock, flags);
+
+	return ret;
+}
+
+static ssize_t store_target_loads(struct gov_attr_set *attr_set,
+				  const char *buf, size_t count)
+{
+	struct interactive_tunables *tunables = to_tunables(attr_set);
+	unsigned int *new_target_loads;
+	unsigned long flags;
+	int ntokens;
+
+	new_target_loads = get_tokenized_data(buf, &ntokens);
+	if (IS_ERR(new_target_loads))
+		return PTR_ERR(new_target_loads);
+
+	spin_lock_irqsave(&tunables->target_loads_lock, flags);
+	if (tunables->target_loads != default_target_loads)
+		kfree(tunables->target_loads);
+	tunables->target_loads = new_target_loads;
+	tunables->ntarget_loads = ntokens;
+	spin_unlock_irqrestore(&tunables->target_loads_lock, flags);
+
+	return count;
+}
+
+static ssize_t show_above_hispeed_delay(struct gov_attr_set *attr_set,
+					char *buf)
+{
+	struct interactive_tunables *tunables = to_tunables(attr_set);
+	unsigned long flags;
+	ssize_t ret = 0;
+	int i;
+
+	spin_lock_irqsave(&tunables->above_hispeed_delay_lock, flags);
+
+	for (i = 0; i < tunables->nabove_hispeed_delay; i++)
+		ret += sprintf(buf + ret, "%u%s",
+			       tunables->above_hispeed_delay[i],
+			       i & 0x1 ? ":" : " ");
+
+	sprintf(buf + ret - 1, "\n");
+	spin_unlock_irqrestore(&tunables->above_hispeed_delay_lock, flags);
+
+	return ret;
+}
+
+static ssize_t store_above_hispeed_delay(struct gov_attr_set *attr_set,
+					 const char *buf, size_t count)
+{
+	struct interactive_tunables *tunables = to_tunables(attr_set);
+	unsigned int *new_above_hispeed_delay = NULL;
+	unsigned long flags;
+	int ntokens;
+
+	new_above_hispeed_delay = get_tokenized_data(buf, &ntokens);
+	if (IS_ERR(new_above_hispeed_delay))
+		return PTR_ERR(new_above_hispeed_delay);
+
+	spin_lock_irqsave(&tunables->above_hispeed_delay_lock, flags);
+	if (tunables->above_hispeed_delay != default_above_hispeed_delay)
+		kfree(tunables->above_hispeed_delay);
+	tunables->above_hispeed_delay = new_above_hispeed_delay;
+	tunables->nabove_hispeed_delay = ntokens;
+	spin_unlock_irqrestore(&tunables->above_hispeed_delay_lock, flags);
+
+	return count;
+}
+
+static ssize_t store_hispeed_freq(struct gov_attr_set *attr_set,
+				  const char *buf, size_t count)
+{
+	struct interactive_tunables *tunables = to_tunables(attr_set);
+	unsigned long int val;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	tunables->hispeed_freq = val;
+
+	return count;
+}
+
+static ssize_t store_go_hispeed_load(struct gov_attr_set *attr_set,
+				     const char *buf, size_t count)
+{
+	struct interactive_tunables *tunables = to_tunables(attr_set);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	tunables->go_hispeed_load = val;
+
+	return count;
+}
+
+static ssize_t store_min_sample_time(struct gov_attr_set *attr_set,
+				     const char *buf, size_t count)
+{
+	struct interactive_tunables *tunables = to_tunables(attr_set);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	tunables->min_sample_time = val;
+
+	return count;
+}
+
+static ssize_t show_timer_rate(struct gov_attr_set *attr_set, char *buf)
+{
+	struct interactive_tunables *tunables = to_tunables(attr_set);
+
+	return sprintf(buf, "%lu\n", tunables->sampling_rate);
+}
+
+static ssize_t store_timer_rate(struct gov_attr_set *attr_set, const char *buf,
+				size_t count)
+{
+	struct interactive_tunables *tunables = to_tunables(attr_set);
+	unsigned long val, val_round;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	val_round = jiffies_to_usecs(usecs_to_jiffies(val));
+	if (val != val_round)
+		pr_warn("timer_rate not aligned to jiffy. Rounded up to %lu\n",
+			val_round);
+
+	tunables->sampling_rate = val_round;
+
+	return count;
+}
+
+static ssize_t store_timer_slack(struct gov_attr_set *attr_set, const char *buf,
+				 size_t count)
+{
+	struct interactive_tunables *tunables = to_tunables(attr_set);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtol(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+
+	tunables->timer_slack = val;
+	update_slack_delay(tunables);
+
+	return count;
+}
+
+static ssize_t store_boost(struct gov_attr_set *attr_set, const char *buf,
+			   size_t count)
+{
+	struct interactive_tunables *tunables = to_tunables(attr_set);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	tunables->boost = val;
+
+	if (tunables->boost) {
+		trace_cpufreq_interactive_boost("on");
+		if (!tunables->boosted)
+			cpufreq_interactive_boost(tunables);
+	} else {
+		tunables->boostpulse_endtime = ktime_to_us(ktime_get());
+		trace_cpufreq_interactive_unboost("off");
+	}
+
+	return count;
+}
+
+static ssize_t store_boostpulse(struct gov_attr_set *attr_set, const char *buf,
+				size_t count)
+{
+	struct interactive_tunables *tunables = to_tunables(attr_set);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	tunables->boostpulse_endtime = ktime_to_us(ktime_get()) +
+					tunables->boostpulse_duration;
+	trace_cpufreq_interactive_boost("pulse");
+	if (!tunables->boosted)
+		cpufreq_interactive_boost(tunables);
+
+	return count;
+}
+
+static ssize_t store_boostpulse_duration(struct gov_attr_set *attr_set,
+					 const char *buf, size_t count)
+{
+	struct interactive_tunables *tunables = to_tunables(attr_set);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	tunables->boostpulse_duration = val;
+
+	return count;
+}
+
+static ssize_t store_io_is_busy(struct gov_attr_set *attr_set, const char *buf,
+				size_t count)
+{
+	struct interactive_tunables *tunables = to_tunables(attr_set);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	tunables->io_is_busy = val;
+
+	return count;
+}
+
+show_one(hispeed_freq, "%u");
+show_one(go_hispeed_load, "%lu");
+show_one(min_sample_time, "%lu");
+show_one(timer_slack, "%lu");
+show_one(boost, "%u");
+show_one(boostpulse_duration, "%u");
+show_one(io_is_busy, "%u");
+
+gov_attr_rw(target_loads);
+gov_attr_rw(above_hispeed_delay);
+gov_attr_rw(hispeed_freq);
+gov_attr_rw(go_hispeed_load);
+gov_attr_rw(min_sample_time);
+gov_attr_rw(timer_rate);
+gov_attr_rw(timer_slack);
+gov_attr_rw(boost);
+gov_attr_wo(boostpulse);
+gov_attr_rw(boostpulse_duration);
+gov_attr_rw(io_is_busy);
+
+static struct attribute *interactive_attributes[] = {
+	&target_loads.attr,
+	&above_hispeed_delay.attr,
+	&hispeed_freq.attr,
+	&go_hispeed_load.attr,
+	&min_sample_time.attr,
+	&timer_rate.attr,
+	&timer_slack.attr,
+	&boost.attr,
+	&boostpulse.attr,
+	&boostpulse_duration.attr,
+	&io_is_busy.attr,
+	NULL
+};
+
+static struct kobj_type interactive_tunables_ktype = {
+	.default_attrs = interactive_attributes,
+	.sysfs_ops = &governor_sysfs_ops,
+};
+
+/* Interactive Governor callbacks */
+struct interactive_governor {
+	struct cpufreq_governor gov;
+	unsigned int usage_count;
+};
+
+static struct interactive_governor interactive_gov;
+
+#define CPU_FREQ_GOV_INTERACTIVE	(&interactive_gov.gov)
+
+static void irq_work(struct irq_work *irq_work)
+{
+	struct interactive_cpu *icpu = container_of(irq_work, struct
+						    interactive_cpu, irq_work);
+
+	cpufreq_interactive_update(icpu);
+	icpu->work_in_progress = false;
+}
+
+static void update_util_handler(struct update_util_data *data, u64 time,
+				unsigned long util, unsigned long max)
+{
+	struct interactive_cpu *icpu = container_of(data,
+					struct interactive_cpu, update_util);
+	struct interactive_policy *ipolicy = icpu->ipolicy;
+	struct interactive_tunables *tunables = ipolicy->tunables;
+	u64 delta_ns;
+
+	/*
+	 * The irq-work may not be allowed to be queued up right now.
+	 * Possible reasons:
+	 * - Work has already been queued up or is in progress.
+	 * - It is too early (too little time from the previous sample).
+	 */
+	if (icpu->work_in_progress)
+		return;
+
+	delta_ns = time - icpu->last_sample_time;
+	if ((s64)delta_ns < tunables->sampling_rate * NSEC_PER_USEC)
+		return;
+
+	icpu->last_sample_time = time;
+
+	icpu->work_in_progress = true;
+	irq_work_queue(&icpu->irq_work);
+}
+
+static void gov_set_update_util(struct interactive_policy *ipolicy)
+{
+	struct cpufreq_policy *policy = ipolicy->policy;
+	struct interactive_cpu *icpu;
+	int cpu;
+
+	for_each_cpu(cpu, policy->cpus) {
+		icpu = &per_cpu(interactive_cpu, cpu);
+
+		icpu->last_sample_time = 0;
+		cpufreq_add_update_util_hook(cpu, &icpu->update_util,
+					     update_util_handler);
+	}
+}
+
+static inline void gov_clear_update_util(struct cpufreq_policy *policy)
+{
+	int i;
+
+	for_each_cpu(i, policy->cpus)
+		cpufreq_remove_update_util_hook(i);
+
+	synchronize_sched();
+}
+
+static void icpu_cancel_work(struct interactive_cpu *icpu)
+{
+	irq_work_sync(&icpu->irq_work);
+	icpu->work_in_progress = false;
+	del_timer_sync(&icpu->slack_timer);
+}
+
+static struct interactive_policy *
+interactive_policy_alloc(struct cpufreq_policy *policy)
+{
+	struct interactive_policy *ipolicy;
+
+	ipolicy = kzalloc(sizeof(*ipolicy), GFP_KERNEL);
+	if (!ipolicy)
+		return NULL;
+
+	ipolicy->policy = policy;
+
+	return ipolicy;
+}
+
+static void interactive_policy_free(struct interactive_policy *ipolicy)
+{
+	kfree(ipolicy);
+}
+
+static struct interactive_tunables *
+interactive_tunables_alloc(struct interactive_policy *ipolicy)
+{
+	struct interactive_tunables *tunables;
+
+	tunables = kzalloc(sizeof(*tunables), GFP_KERNEL);
+	if (!tunables)
+		return NULL;
+
+	gov_attr_set_init(&tunables->attr_set, &ipolicy->tunables_hook);
+	if (!have_governor_per_policy())
+		global_tunables = tunables;
+
+	ipolicy->tunables = tunables;
+
+	return tunables;
+}
+
+static void interactive_tunables_free(struct interactive_tunables *tunables)
+{
+	if (!have_governor_per_policy())
+		global_tunables = NULL;
+
+	kfree(tunables);
+}
+
+int cpufreq_interactive_init(struct cpufreq_policy *policy)
+{
+	struct interactive_policy *ipolicy;
+	struct interactive_tunables *tunables;
+	int ret;
+
+	/* State should be equivalent to EXIT */
+	if (policy->governor_data)
+		return -EBUSY;
+
+	ipolicy = interactive_policy_alloc(policy);
+	if (!ipolicy)
+		return -ENOMEM;
+
+	mutex_lock(&global_tunables_lock);
+
+	if (global_tunables) {
+		if (WARN_ON(have_governor_per_policy())) {
+			ret = -EINVAL;
+			goto free_int_policy;
+		}
+
+		policy->governor_data = ipolicy;
+		ipolicy->tunables = global_tunables;
+
+		gov_attr_set_get(&global_tunables->attr_set,
+				 &ipolicy->tunables_hook);
+		goto out;
+	}
+
+	tunables = interactive_tunables_alloc(ipolicy);
+	if (!tunables) {
+		ret = -ENOMEM;
+		goto free_int_policy;
+	}
+
+	tunables->hispeed_freq = policy->max;
+	tunables->above_hispeed_delay = default_above_hispeed_delay;
+	tunables->nabove_hispeed_delay =
+		ARRAY_SIZE(default_above_hispeed_delay);
+	tunables->go_hispeed_load = DEFAULT_GO_HISPEED_LOAD;
+	tunables->target_loads = default_target_loads;
+	tunables->ntarget_loads = ARRAY_SIZE(default_target_loads);
+	tunables->min_sample_time = DEFAULT_MIN_SAMPLE_TIME;
+	tunables->boostpulse_duration = DEFAULT_MIN_SAMPLE_TIME;
+	tunables->sampling_rate = DEFAULT_SAMPLING_RATE;
+	tunables->timer_slack = DEFAULT_TIMER_SLACK;
+	update_slack_delay(tunables);
+
+	spin_lock_init(&tunables->target_loads_lock);
+	spin_lock_init(&tunables->above_hispeed_delay_lock);
+
+	policy->governor_data = ipolicy;
+
+	ret = kobject_init_and_add(&tunables->attr_set.kobj,
+				   &interactive_tunables_ktype,
+				   get_governor_parent_kobj(policy), "%s",
+				   interactive_gov.gov.name);
+	if (ret)
+		goto fail;
+
+	/* One time initialization for governor */
+	if (!interactive_gov.usage_count++) {
+		cpufreq_register_notifier(&cpufreq_notifier_block,
+					  CPUFREQ_TRANSITION_NOTIFIER);
+	}
+
+ out:
+	mutex_unlock(&global_tunables_lock);
+	return 0;
+
+ fail:
+	policy->governor_data = NULL;
+	interactive_tunables_free(tunables);
+
+ free_int_policy:
+	mutex_unlock(&global_tunables_lock);
+
+	interactive_policy_free(ipolicy);
+	pr_err("governor initialization failed (%d)\n", ret);
+
+	return ret;
+}
+
+void cpufreq_interactive_exit(struct cpufreq_policy *policy)
+{
+	struct interactive_policy *ipolicy = policy->governor_data;
+	struct interactive_tunables *tunables = ipolicy->tunables;
+	unsigned int count;
+
+	mutex_lock(&global_tunables_lock);
+
+	/* Last policy using the governor ? */
+	if (!--interactive_gov.usage_count) {
+		cpufreq_unregister_notifier(&cpufreq_notifier_block,
+					    CPUFREQ_TRANSITION_NOTIFIER);
+	}
+
+	count = gov_attr_set_put(&tunables->attr_set, &ipolicy->tunables_hook);
+	policy->governor_data = NULL;
+	if (!count)
+		interactive_tunables_free(tunables);
+
+	mutex_unlock(&global_tunables_lock);
+
+	interactive_policy_free(ipolicy);
+}
+
+int cpufreq_interactive_start(struct cpufreq_policy *policy)
+{
+	struct interactive_policy *ipolicy = policy->governor_data;
+	struct interactive_cpu *icpu;
+	unsigned int cpu;
+
+	for_each_cpu(cpu, policy->cpus) {
+		icpu = &per_cpu(interactive_cpu, cpu);
+
+		icpu->target_freq = policy->cur;
+		icpu->floor_freq = icpu->target_freq;
+		icpu->pol_floor_val_time = ktime_to_us(ktime_get());
+		icpu->loc_floor_val_time = icpu->pol_floor_val_time;
+		icpu->pol_hispeed_val_time = icpu->pol_floor_val_time;
+		icpu->loc_hispeed_val_time = icpu->pol_floor_val_time;
+
+		down_write(&icpu->enable_sem);
+		icpu->ipolicy = ipolicy;
+		up_write(&icpu->enable_sem);
+
+		slack_timer_resched(icpu, cpu, false);
+	}
+
+	gov_set_update_util(ipolicy);
+	return 0;
+}
+
+void cpufreq_interactive_stop(struct cpufreq_policy *policy)
+{
+	struct interactive_policy *ipolicy = policy->governor_data;
+	struct interactive_cpu *icpu;
+	unsigned int cpu;
+
+	gov_clear_update_util(ipolicy->policy);
+
+	for_each_cpu(cpu, policy->cpus) {
+		icpu = &per_cpu(interactive_cpu, cpu);
+
+		icpu_cancel_work(icpu);
+
+		down_write(&icpu->enable_sem);
+		icpu->ipolicy = NULL;
+		up_write(&icpu->enable_sem);
+	}
+}
+
+void cpufreq_interactive_limits(struct cpufreq_policy *policy)
+{
+	struct interactive_cpu *icpu;
+	unsigned int cpu;
+	unsigned long flags;
+
+	cpufreq_policy_apply_limits(policy);
+
+	for_each_cpu(cpu, policy->cpus) {
+		icpu = &per_cpu(interactive_cpu, cpu);
+
+		spin_lock_irqsave(&icpu->target_freq_lock, flags);
+
+		if (policy->max < icpu->target_freq)
+			icpu->target_freq = policy->max;
+		else if (policy->min > icpu->target_freq)
+			icpu->target_freq = policy->min;
+
+		spin_unlock_irqrestore(&icpu->target_freq_lock, flags);
+	}
+}
+
+static struct interactive_governor interactive_gov = {
+	.gov = {
+		.name			= "interactive",
+		.max_transition_latency	= TRANSITION_LATENCY_LIMIT,
+		.owner			= THIS_MODULE,
+		.init			= cpufreq_interactive_init,
+		.exit			= cpufreq_interactive_exit,
+		.start			= cpufreq_interactive_start,
+		.stop			= cpufreq_interactive_stop,
+		.limits			= cpufreq_interactive_limits,
+	}
+};
+
+static void cpufreq_interactive_nop_timer(unsigned long data)
+{
+	/*
+	 * The purpose of slack-timer is to wake up the CPU from IDLE, in order
+	 * to decrease its frequency if it is not set to minimum already.
+	 *
+	 * This is important for platforms where CPU with higher frequencies
+	 * consume higher power even at IDLE.
+	 */
+}
+
+static int __init cpufreq_interactive_gov_init(void)
+{
+	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
+	struct interactive_cpu *icpu;
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu) {
+		icpu = &per_cpu(interactive_cpu, cpu);
+
+		init_irq_work(&icpu->irq_work, irq_work);
+		spin_lock_init(&icpu->load_lock);
+		spin_lock_init(&icpu->target_freq_lock);
+		init_rwsem(&icpu->enable_sem);
+
+		/* Initialize per-cpu slack-timer */
+		init_timer(&icpu->slack_timer);
+		icpu->slack_timer.function = cpufreq_interactive_nop_timer;
+	}
+
+	spin_lock_init(&speedchange_cpumask_lock);
+	speedchange_task = kthread_create(cpufreq_interactive_speedchange_task,
+					  NULL, "cfinteractive");
+	if (IS_ERR(speedchange_task))
+		return PTR_ERR(speedchange_task);
+
+	sched_setscheduler_nocheck(speedchange_task, SCHED_FIFO, &param);
+	get_task_struct(speedchange_task);
+
+	/* wake up so the thread does not look hung to the freezer */
+	wake_up_process(speedchange_task);
+
+	return cpufreq_register_governor(CPU_FREQ_GOV_INTERACTIVE);
+}
+
+#ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_INTERACTIVE
+struct cpufreq_governor *cpufreq_default_governor(void)
+{
+	return CPU_FREQ_GOV_INTERACTIVE;
+}
+
+fs_initcall(cpufreq_interactive_gov_init);
+#else
+module_init(cpufreq_interactive_gov_init);
+#endif
+
+static void __exit cpufreq_interactive_gov_exit(void)
+{
+	cpufreq_unregister_governor(CPU_FREQ_GOV_INTERACTIVE);
+	kthread_stop(speedchange_task);
+	put_task_struct(speedchange_task);
+}
+module_exit(cpufreq_interactive_gov_exit);
+
+MODULE_AUTHOR("Mike Chan <mike@android.com>");
+MODULE_DESCRIPTION("'cpufreq_interactive' - A dynamic cpufreq governor for Latency sensitive workloads");
+MODULE_LICENSE("GPL");
diff --git a/include/trace/events/cpufreq_interactive.h b/include/trace/events/cpufreq_interactive.h
new file mode 100644
index 000000000000..faecc0bfdeff
--- /dev/null
+++ b/include/trace/events/cpufreq_interactive.h
@@ -0,0 +1,112 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM cpufreq_interactive
+
+#if !defined(_TRACE_CPUFREQ_INTERACTIVE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_CPUFREQ_INTERACTIVE_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(set,
+	TP_PROTO(u32 cpu_id, unsigned long targfreq,
+		 unsigned long actualfreq),
+	TP_ARGS(cpu_id, targfreq, actualfreq),
+
+	TP_STRUCT__entry(
+		__field(u32, cpu_id)
+		__field(unsigned long, targfreq)
+		__field(unsigned long, actualfreq)
+	),
+
+	TP_fast_assign(
+		__entry->cpu_id = (u32)cpu_id;
+		__entry->targfreq = targfreq;
+		__entry->actualfreq = actualfreq;
+	),
+
+	TP_printk("cpu=%u targ=%lu actual=%lu",
+		__entry->cpu_id, __entry->targfreq,
+		__entry->actualfreq)
+);
+
+DEFINE_EVENT(set, cpufreq_interactive_setspeed,
+	TP_PROTO(u32 cpu_id, unsigned long targfreq,
+		 unsigned long actualfreq),
+	TP_ARGS(cpu_id, targfreq, actualfreq)
+);
+
+DECLARE_EVENT_CLASS(loadeval,
+	TP_PROTO(unsigned long cpu_id, unsigned long load,
+		 unsigned long curtarg, unsigned long curactual,
+		 unsigned long newtarg),
+	TP_ARGS(cpu_id, load, curtarg, curactual, newtarg),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, cpu_id)
+		__field(unsigned long, load)
+		__field(unsigned long, curtarg)
+		__field(unsigned long, curactual)
+		__field(unsigned long, newtarg)
+	),
+
+	TP_fast_assign(
+		__entry->cpu_id = cpu_id;
+		__entry->load = load;
+		__entry->curtarg = curtarg;
+		__entry->curactual = curactual;
+		__entry->newtarg = newtarg;
+	),
+
+	TP_printk("cpu=%lu load=%lu cur=%lu actual=%lu targ=%lu",
+		  __entry->cpu_id, __entry->load, __entry->curtarg,
+		  __entry->curactual, __entry->newtarg)
+);
+
+DEFINE_EVENT(loadeval, cpufreq_interactive_target,
+	TP_PROTO(unsigned long cpu_id, unsigned long load,
+		 unsigned long curtarg, unsigned long curactual,
+		 unsigned long newtarg),
+	TP_ARGS(cpu_id, load, curtarg, curactual, newtarg)
+);
+
+DEFINE_EVENT(loadeval, cpufreq_interactive_already,
+	TP_PROTO(unsigned long cpu_id, unsigned long load,
+		 unsigned long curtarg, unsigned long curactual,
+		 unsigned long newtarg),
+	TP_ARGS(cpu_id, load, curtarg, curactual, newtarg)
+);
+
+DEFINE_EVENT(loadeval, cpufreq_interactive_notyet,
+	TP_PROTO(unsigned long cpu_id, unsigned long load,
+		 unsigned long curtarg, unsigned long curactual,
+		 unsigned long newtarg),
+	TP_ARGS(cpu_id, load, curtarg, curactual, newtarg)
+);
+
+TRACE_EVENT(cpufreq_interactive_boost,
+	TP_PROTO(const char *s),
+	TP_ARGS(s),
+	TP_STRUCT__entry(
+		__string(s, s)
+	),
+	TP_fast_assign(
+		__assign_str(s, s);
+	),
+	TP_printk("%s", __get_str(s))
+);
+
+TRACE_EVENT(cpufreq_interactive_unboost,
+	TP_PROTO(const char *s),
+	TP_ARGS(s),
+	TP_STRUCT__entry(
+		__string(s, s)
+	),
+	TP_fast_assign(
+		__assign_str(s, s);
+	),
+	TP_printk("%s", __get_str(s))
+);
+
+#endif /* _TRACE_CPUFREQ_INTERACTIVE_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.7.1.410.g6faf27b

