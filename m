From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 1/1] cpufreq: interactive: New 'interactive' governor
Date: Wed, 28 Oct 2015 23:05:52 +0100
Message-ID: <1446069953-9701-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37740 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498AbbJ1WGH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 18:06:07 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Mike Chan <mike@android.com>, Todd Poynor <toddpoynor@google.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>

=46rom: Mike Chan <mike@android.com>

This governor is designed for latency-sensitive workloads, such as
interactive user interfaces.  The interactive governor aims to be
significantly more responsive to ramp CPU quickly up when CPU-intensive
activity begins.

Existing governors sample CPU load at a particular rate, typically
every X ms.  This can lead to under-powering UI threads for the period =
of
time during which the user begins interacting with a previously-idle sy=
stem
until the next sample period happens.

The 'interactive' governor uses a different approach. Instead of sampli=
ng
the CPU at a specified rate, the governor will check whether to scale t=
he
CPU frequency up soon after coming out of idle.  When the CPU comes out=
 of
idle, a timer is configured to fire within 1-2 ticks.  If the CPU is ve=
ry
busy from exiting idle to when the timer fires then we assume the CPU i=
s
underpowered and ramp to MAX speed.

If the CPU was not sufficiently busy to immediately ramp to MAX speed, =
then
the governor evaluates the CPU load since the last speed adjustment,
choosing the highest value between that longer-term load or the short-t=
erm
load since idle exit to determine the CPU speed to ramp to.

A realtime thread is used for scaling up, giving the remaining tasks th=
e
CPU performance benefit, unlike existing governors which are more likel=
y to
schedule rampup work to occur after your performance starved tasks have
completed.

The tuneables for this governor are:
/sys/devices/system/cpu/cpufreq/interactive/min_sample_time:
	The minimum amount of time to spend at the current frequency before
	ramping down. This is to ensure that the governor has seen enough
	historic CPU load data to determine the appropriate workload.
	Default is 80000 uS.
/sys/devices/system/cpu/cpufreq/interactive/go_maxspeed_load
	The CPU load at which to ramp to max speed.  Default is 85.

Signed-off-by: Mike Chan <mike@android.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 Documentation/cpu-freq/governors.txt       |   37 +
 drivers/cpufreq/Kconfig                    |   27 +
 drivers/cpufreq/Makefile                   |    1 +
 drivers/cpufreq/cpufreq_interactive.c      | 1338 ++++++++++++++++++++=
++++++++
 include/linux/cpufreq.h                    |    3 +
 include/trace/events/cpufreq_interactive.h |  112 +++
 6 files changed, 1518 insertions(+)
 create mode 100644 drivers/cpufreq/cpufreq_interactive.c
 create mode 100644 include/trace/events/cpufreq_interactive.h

diff --git a/Documentation/cpu-freq/governors.txt b/Documentation/cpu-f=
req/governors.txt
index c15aa75..b262c53 100644
--- a/Documentation/cpu-freq/governors.txt
+++ b/Documentation/cpu-freq/governors.txt
@@ -28,6 +28,7 @@ Contents:
 2.3  Userspace
 2.4  Ondemand
 2.5  Conservative
+2.6  Interactive
=20
 3.   The Governor Interface in the CPUfreq Core
=20
@@ -218,6 +219,42 @@ a decision on when to decrease the frequency while=
 running in any
 speed. Load for frequency increase is still evaluated every
 sampling rate.
=20
+2.6 Interactive
+---------------
+
+The CPUfreq governor "interactive" is designed for latency-sensitive,
+interactive workloads. This governor sets the CPU speed depending on
+usage, similar to "ondemand" and "conservative" governors.  However,
+the governor is more aggressive about scaling the CPU speed up in
+response to CPU-intensive activity.
+
+Sampling the CPU load every X ms can lead to under-powering the CPU
+for X ms, leading to dropped frames, stuttering UI, etc.  Instead of
+sampling the cpu at a specified rate, the interactive governor will
+check whether to scale the cpu frequency up soon after coming out of
+idle.  When the cpu comes out of idle, a timer is configured to fire
+within 1-2 ticks.  If the cpu is very busy between exiting idle and
+when the timer fires then we assume the cpu is underpowered and ramp
+to MAX speed.
+
+If the cpu was not sufficiently busy to immediately ramp to MAX speed,
+then governor evaluates the cpu load since the last speed adjustment,
+choosing the highest value between that longer-term load or the
+short-term load since idle exit to determine the cpu speed to ramp to.
+
+The tuneable values for this governor are:
+
+min_sample_time: The minimum amount of time to spend at the current
+frequency before ramping down. This is to ensure that the governor has
+seen enough historic cpu load data to determine the appropriate
+workload.  Default is 80000 uS.
+
+go_maxspeed_load: The CPU load at which to ramp to max speed.  Default
+is 85.
+
+timer_rate: Sample rate for reevaluating cpu load when the system is
+not idle.  Default is 30000 uS.
+
 3. The Governor Interface in the CPUfreq Core
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 659879a..6e099e5 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -102,6 +102,16 @@ config CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
 	  Be aware that not all cpufreq drivers support the conservative
 	  governor. If unsure have a look at the help section of the
 	  driver. Fallback governor will be the performance governor.
+
+config CPU_FREQ_DEFAULT_GOV_INTERACTIVE
+	bool "interactive"
+	select CPU_FREQ_GOV_INTERACTIVE
+	help
+	  Use the CPUFreq governor 'interactive' as default. This allows
+	  you to get a full dynamic cpu frequency capable system by simply
+	  loading your cpufreq low-level hardware driver, using the
+	  'interactive' governor for latency-sensitive workloads.
+
 endchoice
=20
 config CPU_FREQ_GOV_PERFORMANCE
@@ -159,6 +169,23 @@ config CPU_FREQ_GOV_ONDEMAND
=20
 	  If in doubt, say N.
=20
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
 config CPU_FREQ_GOV_CONSERVATIVE
 	tristate "'conservative' cpufreq governor"
 	depends on CPU_FREQ
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 4134038..98667c8 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_CPU_FREQ_GOV_POWERSAVE)	+=3D cpufreq_pow=
ersave.o
 obj-$(CONFIG_CPU_FREQ_GOV_USERSPACE)	+=3D cpufreq_userspace.o
 obj-$(CONFIG_CPU_FREQ_GOV_ONDEMAND)	+=3D cpufreq_ondemand.o
 obj-$(CONFIG_CPU_FREQ_GOV_CONSERVATIVE)	+=3D cpufreq_conservative.o
+obj-$(CONFIG_CPU_FREQ_GOV_INTERACTIVE)	+=3D cpufreq_interactive.o
 obj-$(CONFIG_CPU_FREQ_GOV_COMMON)		+=3D cpufreq_governor.o
=20
 obj-$(CONFIG_CPUFREQ_DT)		+=3D cpufreq-dt.o
diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
new file mode 100644
index 0000000..e569e0b
--- /dev/null
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -0,0 +1,1338 @@
+/*
+ * drivers/cpufreq/cpufreq_interactive.c
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, an=
d
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Author: Mike Chan (mike@android.com)
+ *
+ */
+
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/cpufreq.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/rwsem.h>
+#include <linux/sched.h>
+#include <linux/sched/rt.h>
+#include <linux/tick.h>
+#include <linux/time.h>
+#include <linux/timer.h>
+#include <linux/workqueue.h>
+#include <linux/kthread.h>
+#include <linux/slab.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/cpufreq_interactive.h>
+
+struct cpufreq_interactive_cpuinfo {
+	struct timer_list cpu_timer;
+	struct timer_list cpu_slack_timer;
+	spinlock_t load_lock; /* protects the next 4 fields */
+	u64 time_in_idle;
+	u64 time_in_idle_timestamp;
+	u64 cputime_speedadj;
+	u64 cputime_speedadj_timestamp;
+	struct cpufreq_policy *policy;
+	struct cpufreq_frequency_table *freq_table;
+	spinlock_t target_freq_lock; /*protects target freq */
+	unsigned int target_freq;
+	unsigned int floor_freq;
+	u64 pol_floor_val_time; /* policy floor_validate_time */
+	u64 loc_floor_val_time; /* per-cpu floor_validate_time */
+	u64 pol_hispeed_val_time; /* policy hispeed_validate_time */
+	u64 loc_hispeed_val_time; /* per-cpu hispeed_validate_time */
+	struct rw_semaphore enable_sem;
+	int governor_enabled;
+};
+
+static DEFINE_PER_CPU(struct cpufreq_interactive_cpuinfo, cpuinfo);
+
+/* realtime thread handles frequency scaling */
+static struct task_struct *speedchange_task;
+static cpumask_t speedchange_cpumask;
+static spinlock_t speedchange_cpumask_lock;
+static struct mutex gov_lock;
+
+/* Target load.  Lower values result in higher CPU speeds. */
+#define DEFAULT_TARGET_LOAD 90
+static unsigned int default_target_loads[] =3D {DEFAULT_TARGET_LOAD};
+
+#define DEFAULT_TIMER_RATE (20 * USEC_PER_MSEC)
+#define DEFAULT_ABOVE_HISPEED_DELAY DEFAULT_TIMER_RATE
+static unsigned int default_above_hispeed_delay[] =3D {
+	DEFAULT_ABOVE_HISPEED_DELAY };
+
+struct cpufreq_interactive_tunables {
+	int usage_count;
+	/* Hi speed to bump to from lo speed when load burst (default max) */
+	unsigned int hispeed_freq;
+	/* Go to hi speed when CPU load at or above this value. */
+#define DEFAULT_GO_HISPEED_LOAD 99
+	unsigned long go_hispeed_load;
+	/* Target load. Lower values result in higher CPU speeds. */
+	spinlock_t target_loads_lock;
+	unsigned int *target_loads;
+	int ntarget_loads;
+	/*
+	 * The minimum amount of time to spend at a frequency before we can r=
amp
+	 * down.
+	 */
+#define DEFAULT_MIN_SAMPLE_TIME (80 * USEC_PER_MSEC)
+	unsigned long min_sample_time;
+	/*
+	 * The sample rate of the timer used to increase frequency
+	 */
+	unsigned long timer_rate;
+	/*
+	 * Wait this long before raising speed above hispeed, by default a
+	 * single timer interval.
+	 */
+	spinlock_t above_hispeed_delay_lock;
+	unsigned int *above_hispeed_delay;
+	int nabove_hispeed_delay;
+	/* Non-zero means indefinite speed boost active */
+	int boost_val;
+	/* Duration of a boot pulse in usecs */
+	int boostpulse_duration_val;
+	/* End time of boost pulse in ktime converted to usecs */
+	u64 boostpulse_endtime;
+	bool boosted;
+	/*
+	 * Max additional time to wait in idle, beyond timer_rate, at speeds
+	 * above minimum before wakeup to reduce speed, or -1 if unnecessary.
+	 */
+#define DEFAULT_TIMER_SLACK (4 * DEFAULT_TIMER_RATE)
+	int timer_slack_val;
+	bool io_is_busy;
+};
+
+/* For cases where we have single governor instance for system */
+static struct cpufreq_interactive_tunables *common_tunables;
+
+static struct attribute_group *get_sysfs_attr(void);
+
+static void cpufreq_interactive_timer_resched(
+	struct cpufreq_interactive_cpuinfo *pcpu)
+{
+	struct cpufreq_interactive_tunables *tunables =3D
+		pcpu->policy->governor_data;
+	unsigned long expires;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pcpu->load_lock, flags);
+	pcpu->time_in_idle =3D
+		get_cpu_idle_time(smp_processor_id(),
+				  &pcpu->time_in_idle_timestamp,
+				  tunables->io_is_busy);
+	pcpu->cputime_speedadj =3D 0;
+	pcpu->cputime_speedadj_timestamp =3D pcpu->time_in_idle_timestamp;
+	expires =3D jiffies + usecs_to_jiffies(tunables->timer_rate);
+	mod_timer_pinned(&pcpu->cpu_timer, expires);
+
+	if (tunables->timer_slack_val >=3D 0 &&
+	    pcpu->target_freq > pcpu->policy->min) {
+		expires +=3D usecs_to_jiffies(tunables->timer_slack_val);
+		mod_timer_pinned(&pcpu->cpu_slack_timer, expires);
+	}
+
+	spin_unlock_irqrestore(&pcpu->load_lock, flags);
+}
+
+/* The caller shall take enable_sem write semaphore to avoid any timer=
 race.
+ * The cpu_timer and cpu_slack_timer must be deactivated when calling =
this
+ * function.
+ */
+static void cpufreq_interactive_timer_start(
+	struct cpufreq_interactive_tunables *tunables, int cpu)
+{
+	struct cpufreq_interactive_cpuinfo *pcpu =3D &per_cpu(cpuinfo, cpu);
+	unsigned long expires =3D jiffies +
+		usecs_to_jiffies(tunables->timer_rate);
+	unsigned long flags;
+
+	pcpu->cpu_timer.expires =3D expires;
+	add_timer_on(&pcpu->cpu_timer, cpu);
+	if (tunables->timer_slack_val >=3D 0 &&
+	    pcpu->target_freq > pcpu->policy->min) {
+		expires +=3D usecs_to_jiffies(tunables->timer_slack_val);
+		pcpu->cpu_slack_timer.expires =3D expires;
+		add_timer_on(&pcpu->cpu_slack_timer, cpu);
+	}
+
+	spin_lock_irqsave(&pcpu->load_lock, flags);
+	pcpu->time_in_idle =3D
+		get_cpu_idle_time(cpu, &pcpu->time_in_idle_timestamp,
+				  tunables->io_is_busy);
+	pcpu->cputime_speedadj =3D 0;
+	pcpu->cputime_speedadj_timestamp =3D pcpu->time_in_idle_timestamp;
+	spin_unlock_irqrestore(&pcpu->load_lock, flags);
+}
+
+static unsigned int freq_to_above_hispeed_delay(
+	struct cpufreq_interactive_tunables *tunables,
+	unsigned int freq)
+{
+	int i;
+	unsigned int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tunables->above_hispeed_delay_lock, flags);
+
+	for (i =3D 0; i < tunables->nabove_hispeed_delay - 1 &&
+			freq >=3D tunables->above_hispeed_delay[i+1]; i +=3D 2)
+		;
+
+	ret =3D tunables->above_hispeed_delay[i];
+	spin_unlock_irqrestore(&tunables->above_hispeed_delay_lock, flags);
+	return ret;
+}
+
+static unsigned int freq_to_targetload(
+	struct cpufreq_interactive_tunables *tunables, unsigned int freq)
+{
+	int i;
+	unsigned int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tunables->target_loads_lock, flags);
+
+	for (i =3D 0; i < tunables->ntarget_loads - 1 &&
+		    freq >=3D tunables->target_loads[i+1]; i +=3D 2)
+		;
+
+	ret =3D tunables->target_loads[i];
+	spin_unlock_irqrestore(&tunables->target_loads_lock, flags);
+	return ret;
+}
+
+/*
+ * If increasing frequencies never map to a lower target load then
+ * choose_freq() will find the minimum frequency that does not exceed =
its
+ * target load given the current load.
+ */
+static unsigned int choose_freq(struct cpufreq_interactive_cpuinfo *pc=
pu,
+		unsigned int loadadjfreq)
+{
+	unsigned int freq =3D pcpu->policy->cur;
+	unsigned int prevfreq, freqmin, freqmax;
+	unsigned int tl;
+	int index;
+
+	freqmin =3D 0;
+	freqmax =3D UINT_MAX;
+
+	do {
+		prevfreq =3D freq;
+		tl =3D freq_to_targetload(pcpu->policy->governor_data, freq);
+
+		/*
+		 * Find the lowest frequency where the computed load is less
+		 * than or equal to the target load.
+		 */
+
+		if (cpufreq_frequency_table_target(
+			    pcpu->policy, pcpu->freq_table, loadadjfreq / tl,
+			    CPUFREQ_RELATION_L, &index))
+			break;
+		freq =3D pcpu->freq_table[index].frequency;
+
+		if (freq > prevfreq) {
+			/* The previous frequency is too low. */
+			freqmin =3D prevfreq;
+
+			if (freq >=3D freqmax) {
+				/*
+				 * Find the highest frequency that is less
+				 * than freqmax.
+				 */
+				if (cpufreq_frequency_table_target(
+					    pcpu->policy, pcpu->freq_table,
+					    freqmax - 1, CPUFREQ_RELATION_H,
+					    &index))
+					break;
+				freq =3D pcpu->freq_table[index].frequency;
+
+				if (freq =3D=3D freqmin) {
+					/*
+					 * The first frequency below freqmax
+					 * has already been found to be too
+					 * low.  freqmax is the lowest speed
+					 * we found that is fast enough.
+					 */
+					freq =3D freqmax;
+					break;
+				}
+			}
+		} else if (freq < prevfreq) {
+			/* The previous frequency is high enough. */
+			freqmax =3D prevfreq;
+
+			if (freq <=3D freqmin) {
+				/*
+				 * Find the lowest frequency that is higher
+				 * than freqmin.
+				 */
+				if (cpufreq_frequency_table_target(
+					    pcpu->policy, pcpu->freq_table,
+					    freqmin + 1, CPUFREQ_RELATION_L,
+					    &index))
+					break;
+				freq =3D pcpu->freq_table[index].frequency;
+
+				/*
+				 * If freqmax is the first frequency above
+				 * freqmin then we have already found that
+				 * this speed is fast enough.
+				 */
+				if (freq =3D=3D freqmax)
+					break;
+			}
+		}
+
+		/* If same frequency chosen as previous then done. */
+	} while (freq !=3D prevfreq);
+
+	return freq;
+}
+
+static u64 update_load(int cpu)
+{
+	struct cpufreq_interactive_cpuinfo *pcpu =3D &per_cpu(cpuinfo, cpu);
+	struct cpufreq_interactive_tunables *tunables =3D
+		pcpu->policy->governor_data;
+	u64 now;
+	u64 now_idle;
+	unsigned int delta_idle;
+	unsigned int delta_time;
+	u64 active_time;
+
+	now_idle =3D get_cpu_idle_time(cpu, &now, tunables->io_is_busy);
+	delta_idle =3D (unsigned int)(now_idle - pcpu->time_in_idle);
+	delta_time =3D (unsigned int)(now - pcpu->time_in_idle_timestamp);
+
+	if (delta_time <=3D delta_idle)
+		active_time =3D 0;
+	else
+		active_time =3D delta_time - delta_idle;
+
+	pcpu->cputime_speedadj +=3D active_time * pcpu->policy->cur;
+
+	pcpu->time_in_idle =3D now_idle;
+	pcpu->time_in_idle_timestamp =3D now;
+	return now;
+}
+
+static void cpufreq_interactive_timer(unsigned long data)
+{
+	u64 now;
+	unsigned int delta_time;
+	u64 cputime_speedadj;
+	int cpu_load;
+	struct cpufreq_interactive_cpuinfo *pcpu =3D
+		&per_cpu(cpuinfo, data);
+	struct cpufreq_interactive_tunables *tunables =3D
+		pcpu->policy->governor_data;
+	unsigned int new_freq;
+	unsigned int loadadjfreq;
+	unsigned int index;
+	unsigned long flags;
+	u64 max_fvtime;
+
+	if (!down_read_trylock(&pcpu->enable_sem))
+		return;
+	if (!pcpu->governor_enabled)
+		goto exit;
+
+	spin_lock_irqsave(&pcpu->load_lock, flags);
+	now =3D update_load(data);
+	delta_time =3D (unsigned int)(now - pcpu->cputime_speedadj_timestamp)=
;
+	cputime_speedadj =3D pcpu->cputime_speedadj;
+	spin_unlock_irqrestore(&pcpu->load_lock, flags);
+
+	if (WARN_ON_ONCE(!delta_time))
+		goto rearm;
+
+	spin_lock_irqsave(&pcpu->target_freq_lock, flags);
+	do_div(cputime_speedadj, delta_time);
+	loadadjfreq =3D (unsigned int)cputime_speedadj * 100;
+	cpu_load =3D loadadjfreq / pcpu->policy->cur;
+	tunables->boosted =3D tunables->boost_val || now < tunables->boostpul=
se_endtime;
+
+	if (cpu_load >=3D tunables->go_hispeed_load || tunables->boosted) {
+		if (pcpu->policy->cur < tunables->hispeed_freq) {
+			new_freq =3D tunables->hispeed_freq;
+		} else {
+			new_freq =3D choose_freq(pcpu, loadadjfreq);
+
+			if (new_freq < tunables->hispeed_freq)
+				new_freq =3D tunables->hispeed_freq;
+		}
+	} else {
+		new_freq =3D choose_freq(pcpu, loadadjfreq);
+		if (new_freq > tunables->hispeed_freq &&
+				pcpu->policy->cur < tunables->hispeed_freq)
+			new_freq =3D tunables->hispeed_freq;
+	}
+
+	if (pcpu->policy->cur >=3D tunables->hispeed_freq &&
+	    new_freq > pcpu->policy->cur &&
+	    now - pcpu->pol_hispeed_val_time <
+	    freq_to_above_hispeed_delay(tunables, pcpu->policy->cur)) {
+		trace_cpufreq_interactive_notyet(
+			data, cpu_load, pcpu->target_freq,
+			pcpu->policy->cur, new_freq);
+		spin_unlock_irqrestore(&pcpu->target_freq_lock, flags);
+		goto rearm;
+	}
+
+	pcpu->loc_hispeed_val_time =3D now;
+
+	if (cpufreq_frequency_table_target(pcpu->policy, pcpu->freq_table,
+					   new_freq, CPUFREQ_RELATION_L,
+					   &index)) {
+		spin_unlock_irqrestore(&pcpu->target_freq_lock, flags);
+		goto rearm;
+	}
+
+	new_freq =3D pcpu->freq_table[index].frequency;
+
+	/*
+	 * Do not scale below floor_freq unless we have been at or above the
+	 * floor frequency for the minimum sample time since last validated.
+	 */
+	max_fvtime =3D max(pcpu->pol_floor_val_time, pcpu->loc_floor_val_time=
);
+	if (new_freq < pcpu->floor_freq &&
+	    pcpu->target_freq >=3D pcpu->policy->cur) {
+		if (now - max_fvtime < tunables->min_sample_time) {
+			trace_cpufreq_interactive_notyet(
+				data, cpu_load, pcpu->target_freq,
+				pcpu->policy->cur, new_freq);
+			spin_unlock_irqrestore(&pcpu->target_freq_lock, flags);
+			goto rearm;
+		}
+	}
+
+	/*
+	 * Update the timestamp for checking whether speed has been held at
+	 * or above the selected frequency for a minimum of min_sample_time,
+	 * if not boosted to hispeed_freq.  If boosted to hispeed_freq then w=
e
+	 * allow the speed to drop as soon as the boostpulse duration expires
+	 * (or the indefinite boost is turned off).
+	 */
+
+	if (!tunables->boosted || new_freq > tunables->hispeed_freq) {
+		pcpu->floor_freq =3D new_freq;
+		if (pcpu->target_freq >=3D pcpu->policy->cur ||
+		    new_freq >=3D pcpu->policy->cur)
+			pcpu->loc_floor_val_time =3D now;
+	}
+
+	if (pcpu->target_freq =3D=3D new_freq &&
+			pcpu->target_freq <=3D pcpu->policy->cur) {
+		trace_cpufreq_interactive_already(
+			data, cpu_load, pcpu->target_freq,
+			pcpu->policy->cur, new_freq);
+		spin_unlock_irqrestore(&pcpu->target_freq_lock, flags);
+		goto rearm;
+	}
+
+	trace_cpufreq_interactive_target(data, cpu_load, pcpu->target_freq,
+					 pcpu->policy->cur, new_freq);
+
+	pcpu->target_freq =3D new_freq;
+	spin_unlock_irqrestore(&pcpu->target_freq_lock, flags);
+	spin_lock_irqsave(&speedchange_cpumask_lock, flags);
+	cpumask_set_cpu(data, &speedchange_cpumask);
+	spin_unlock_irqrestore(&speedchange_cpumask_lock, flags);
+	wake_up_process(speedchange_task);
+
+rearm:
+	if (!timer_pending(&pcpu->cpu_timer))
+		cpufreq_interactive_timer_resched(pcpu);
+
+exit:
+	up_read(&pcpu->enable_sem);
+	return;
+}
+
+static void cpufreq_interactive_idle_end(void)
+{
+	struct cpufreq_interactive_cpuinfo *pcpu =3D
+		&per_cpu(cpuinfo, smp_processor_id());
+
+	if (!down_read_trylock(&pcpu->enable_sem))
+		return;
+	if (!pcpu->governor_enabled) {
+		up_read(&pcpu->enable_sem);
+		return;
+	}
+
+	/* Arm the timer for 1-2 ticks later if not already. */
+	if (!timer_pending(&pcpu->cpu_timer)) {
+		cpufreq_interactive_timer_resched(pcpu);
+	} else if (time_after_eq(jiffies, pcpu->cpu_timer.expires)) {
+		del_timer(&pcpu->cpu_timer);
+		del_timer(&pcpu->cpu_slack_timer);
+		cpufreq_interactive_timer(smp_processor_id());
+	}
+
+	up_read(&pcpu->enable_sem);
+}
+
+static int cpufreq_interactive_speedchange_task(void *data)
+{
+	unsigned int cpu;
+	cpumask_t tmp_mask;
+	unsigned long flags;
+	struct cpufreq_interactive_cpuinfo *pcpu;
+
+	while (1) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		spin_lock_irqsave(&speedchange_cpumask_lock, flags);
+
+		if (cpumask_empty(&speedchange_cpumask)) {
+			spin_unlock_irqrestore(&speedchange_cpumask_lock,
+					       flags);
+			schedule();
+
+			if (kthread_should_stop())
+				break;
+
+			spin_lock_irqsave(&speedchange_cpumask_lock, flags);
+		}
+
+		set_current_state(TASK_RUNNING);
+		tmp_mask =3D speedchange_cpumask;
+		cpumask_clear(&speedchange_cpumask);
+		spin_unlock_irqrestore(&speedchange_cpumask_lock, flags);
+
+		for_each_cpu(cpu, &tmp_mask) {
+			unsigned int j;
+			unsigned int max_freq =3D 0;
+			struct cpufreq_interactive_cpuinfo *pjcpu;
+			u64 hvt =3D ~0ULL, fvt =3D 0;
+
+			pcpu =3D &per_cpu(cpuinfo, cpu);
+			if (!down_read_trylock(&pcpu->enable_sem))
+				continue;
+			if (!pcpu->governor_enabled) {
+				up_read(&pcpu->enable_sem);
+				continue;
+			}
+
+			for_each_cpu(j, pcpu->policy->cpus) {
+				pjcpu =3D &per_cpu(cpuinfo, j);
+
+				fvt =3D max(fvt, pjcpu->loc_floor_val_time);
+				if (pjcpu->target_freq > max_freq) {
+					max_freq =3D pjcpu->target_freq;
+					hvt =3D pjcpu->loc_hispeed_val_time;
+				} else if (pjcpu->target_freq =3D=3D max_freq) {
+					hvt =3D min(hvt, pjcpu->loc_hispeed_val_time);
+				}
+			}
+			for_each_cpu(j, pcpu->policy->cpus) {
+				pjcpu =3D &per_cpu(cpuinfo, j);
+				pjcpu->pol_floor_val_time =3D fvt;
+			}
+
+			if (max_freq !=3D pcpu->policy->cur) {
+				__cpufreq_driver_target(pcpu->policy,
+							max_freq,
+							CPUFREQ_RELATION_H);
+				for_each_cpu(j, pcpu->policy->cpus) {
+					pjcpu =3D &per_cpu(cpuinfo, j);
+					pjcpu->pol_hispeed_val_time =3D hvt;
+				}
+			}
+			trace_cpufreq_interactive_setspeed(cpu,
+						     pcpu->target_freq,
+						     pcpu->policy->cur);
+
+			up_read(&pcpu->enable_sem);
+		}
+	}
+
+	return 0;
+}
+
+static void cpufreq_interactive_boost(struct cpufreq_interactive_tunab=
les *tunables)
+{
+	int i;
+	int anyboost =3D 0;
+	unsigned long flags[2];
+	struct cpufreq_interactive_cpuinfo *pcpu;
+
+	tunables->boosted =3D true;
+
+	spin_lock_irqsave(&speedchange_cpumask_lock, flags[0]);
+
+	for_each_online_cpu(i) {
+		pcpu =3D &per_cpu(cpuinfo, i);
+		if (tunables !=3D pcpu->policy->governor_data)
+			continue;
+
+		spin_lock_irqsave(&pcpu->target_freq_lock, flags[1]);
+		if (pcpu->target_freq < tunables->hispeed_freq) {
+			pcpu->target_freq =3D tunables->hispeed_freq;
+			cpumask_set_cpu(i, &speedchange_cpumask);
+			pcpu->pol_hispeed_val_time =3D
+				ktime_to_us(ktime_get());
+			anyboost =3D 1;
+		}
+		spin_unlock_irqrestore(&pcpu->target_freq_lock, flags[1]);
+	}
+
+	spin_unlock_irqrestore(&speedchange_cpumask_lock, flags[0]);
+
+	if (anyboost)
+		wake_up_process(speedchange_task);
+}
+
+static int cpufreq_interactive_notifier(
+	struct notifier_block *nb, unsigned long val, void *data)
+{
+	struct cpufreq_freqs *freq =3D data;
+	struct cpufreq_interactive_cpuinfo *pcpu;
+	int cpu;
+	unsigned long flags;
+
+	if (val =3D=3D CPUFREQ_POSTCHANGE) {
+		pcpu =3D &per_cpu(cpuinfo, freq->cpu);
+		if (!down_read_trylock(&pcpu->enable_sem))
+			return 0;
+		if (!pcpu->governor_enabled) {
+			up_read(&pcpu->enable_sem);
+			return 0;
+		}
+
+		for_each_cpu(cpu, pcpu->policy->cpus) {
+			struct cpufreq_interactive_cpuinfo *pjcpu =3D
+				&per_cpu(cpuinfo, cpu);
+			if (cpu !=3D freq->cpu) {
+				if (!down_read_trylock(&pjcpu->enable_sem))
+					continue;
+				if (!pjcpu->governor_enabled) {
+					up_read(&pjcpu->enable_sem);
+					continue;
+				}
+			}
+			spin_lock_irqsave(&pjcpu->load_lock, flags);
+			update_load(cpu);
+			spin_unlock_irqrestore(&pjcpu->load_lock, flags);
+			if (cpu !=3D freq->cpu)
+				up_read(&pjcpu->enable_sem);
+		}
+
+		up_read(&pcpu->enable_sem);
+	}
+	return 0;
+}
+
+static struct notifier_block cpufreq_notifier_block =3D {
+	.notifier_call =3D cpufreq_interactive_notifier,
+};
+
+static unsigned int *get_tokenized_data(const char *buf, int *num_toke=
ns)
+{
+	const char *cp;
+	int i;
+	int ntokens =3D 1;
+	unsigned int *tokenized_data;
+	int err =3D -EINVAL;
+
+	cp =3D buf;
+	while ((cp =3D strpbrk(cp + 1, " :")))
+		ntokens++;
+
+	if (!(ntokens & 0x1))
+		goto err;
+
+	tokenized_data =3D kmalloc(ntokens * sizeof(unsigned int), GFP_KERNEL=
);
+	if (!tokenized_data) {
+		err =3D -ENOMEM;
+		goto err;
+	}
+
+	cp =3D buf;
+	i =3D 0;
+	while (i < ntokens) {
+		if (sscanf(cp, "%u", &tokenized_data[i++]) !=3D 1)
+			goto err_kfree;
+
+		cp =3D strpbrk(cp, " :");
+		if (!cp)
+			break;
+		cp++;
+	}
+
+	if (i !=3D ntokens)
+		goto err_kfree;
+
+	*num_tokens =3D ntokens;
+	return tokenized_data;
+
+err_kfree:
+	kfree(tokenized_data);
+err:
+	return ERR_PTR(err);
+}
+
+static ssize_t show_target_loads(
+	struct cpufreq_interactive_tunables *tunables,
+	char *buf)
+{
+	int i;
+	ssize_t ret =3D 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tunables->target_loads_lock, flags);
+
+	for (i =3D 0; i < tunables->ntarget_loads; i++)
+		ret +=3D sprintf(buf + ret, "%u%s", tunables->target_loads[i],
+			       i & 0x1 ? ":" : " ");
+
+	sprintf(buf + ret - 1, "\n");
+	spin_unlock_irqrestore(&tunables->target_loads_lock, flags);
+	return ret;
+}
+
+static ssize_t store_target_loads(
+	struct cpufreq_interactive_tunables *tunables,
+	const char *buf, size_t count)
+{
+	int ntokens;
+	unsigned int *new_target_loads =3D NULL;
+	unsigned long flags;
+
+	new_target_loads =3D get_tokenized_data(buf, &ntokens);
+	if (IS_ERR(new_target_loads))
+		return PTR_RET(new_target_loads);
+
+	spin_lock_irqsave(&tunables->target_loads_lock, flags);
+	if (tunables->target_loads !=3D default_target_loads)
+		kfree(tunables->target_loads);
+	tunables->target_loads =3D new_target_loads;
+	tunables->ntarget_loads =3D ntokens;
+	spin_unlock_irqrestore(&tunables->target_loads_lock, flags);
+	return count;
+}
+
+static ssize_t show_above_hispeed_delay(
+	struct cpufreq_interactive_tunables *tunables, char *buf)
+{
+	int i;
+	ssize_t ret =3D 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tunables->above_hispeed_delay_lock, flags);
+
+	for (i =3D 0; i < tunables->nabove_hispeed_delay; i++)
+		ret +=3D sprintf(buf + ret, "%u%s",
+			       tunables->above_hispeed_delay[i],
+			       i & 0x1 ? ":" : " ");
+
+	sprintf(buf + ret - 1, "\n");
+	spin_unlock_irqrestore(&tunables->above_hispeed_delay_lock, flags);
+	return ret;
+}
+
+static ssize_t store_above_hispeed_delay(
+	struct cpufreq_interactive_tunables *tunables,
+	const char *buf, size_t count)
+{
+	int ntokens;
+	unsigned int *new_above_hispeed_delay =3D NULL;
+	unsigned long flags;
+
+	new_above_hispeed_delay =3D get_tokenized_data(buf, &ntokens);
+	if (IS_ERR(new_above_hispeed_delay))
+		return PTR_RET(new_above_hispeed_delay);
+
+	spin_lock_irqsave(&tunables->above_hispeed_delay_lock, flags);
+	if (tunables->above_hispeed_delay !=3D default_above_hispeed_delay)
+		kfree(tunables->above_hispeed_delay);
+	tunables->above_hispeed_delay =3D new_above_hispeed_delay;
+	tunables->nabove_hispeed_delay =3D ntokens;
+	spin_unlock_irqrestore(&tunables->above_hispeed_delay_lock, flags);
+	return count;
+
+}
+
+static ssize_t show_hispeed_freq(struct cpufreq_interactive_tunables *=
tunables,
+		char *buf)
+{
+	return sprintf(buf, "%u\n", tunables->hispeed_freq);
+}
+
+static ssize_t store_hispeed_freq(struct cpufreq_interactive_tunables =
*tunables,
+		const char *buf, size_t count)
+{
+	int ret;
+	long unsigned int val;
+
+	ret =3D kstrtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+	tunables->hispeed_freq =3D val;
+	return count;
+}
+
+static ssize_t show_go_hispeed_load(struct cpufreq_interactive_tunable=
s
+		*tunables, char *buf)
+{
+	return sprintf(buf, "%lu\n", tunables->go_hispeed_load);
+}
+
+static ssize_t store_go_hispeed_load(struct cpufreq_interactive_tunabl=
es
+		*tunables, const char *buf, size_t count)
+{
+	int ret;
+	unsigned long val;
+
+	ret =3D kstrtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+	tunables->go_hispeed_load =3D val;
+	return count;
+}
+
+static ssize_t show_min_sample_time(struct cpufreq_interactive_tunable=
s
+		*tunables, char *buf)
+{
+	return sprintf(buf, "%lu\n", tunables->min_sample_time);
+}
+
+static ssize_t store_min_sample_time(struct cpufreq_interactive_tunabl=
es
+		*tunables, const char *buf, size_t count)
+{
+	int ret;
+	unsigned long val;
+
+	ret =3D kstrtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+	tunables->min_sample_time =3D val;
+	return count;
+}
+
+static ssize_t show_timer_rate(struct cpufreq_interactive_tunables *tu=
nables,
+		char *buf)
+{
+	return sprintf(buf, "%lu\n", tunables->timer_rate);
+}
+
+static ssize_t store_timer_rate(struct cpufreq_interactive_tunables *t=
unables,
+		const char *buf, size_t count)
+{
+	int ret;
+	unsigned long val, val_round;
+
+	ret =3D kstrtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	val_round =3D jiffies_to_usecs(usecs_to_jiffies(val));
+	if (val !=3D val_round)
+		pr_warn("timer_rate not aligned to jiffy. Rounded up to %lu\n",
+			val_round);
+
+	tunables->timer_rate =3D val_round;
+	return count;
+}
+
+static ssize_t show_timer_slack(struct cpufreq_interactive_tunables *t=
unables,
+		char *buf)
+{
+	return sprintf(buf, "%d\n", tunables->timer_slack_val);
+}
+
+static ssize_t store_timer_slack(struct cpufreq_interactive_tunables *=
tunables,
+		const char *buf, size_t count)
+{
+	int ret;
+	unsigned long val;
+
+	ret =3D kstrtol(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+
+	tunables->timer_slack_val =3D val;
+	return count;
+}
+
+static ssize_t show_boost(struct cpufreq_interactive_tunables *tunable=
s,
+			  char *buf)
+{
+	return sprintf(buf, "%d\n", tunables->boost_val);
+}
+
+static ssize_t store_boost(struct cpufreq_interactive_tunables *tunabl=
es,
+			   const char *buf, size_t count)
+{
+	int ret;
+	unsigned long val;
+
+	ret =3D kstrtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	tunables->boost_val =3D val;
+
+	if (tunables->boost_val) {
+		trace_cpufreq_interactive_boost("on");
+		if (!tunables->boosted)
+			cpufreq_interactive_boost(tunables);
+	} else {
+		tunables->boostpulse_endtime =3D ktime_to_us(ktime_get());
+		trace_cpufreq_interactive_unboost("off");
+	}
+
+	return count;
+}
+
+static ssize_t store_boostpulse(struct cpufreq_interactive_tunables *t=
unables,
+				const char *buf, size_t count)
+{
+	int ret;
+	unsigned long val;
+
+	ret =3D kstrtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	tunables->boostpulse_endtime =3D ktime_to_us(ktime_get()) +
+		tunables->boostpulse_duration_val;
+	trace_cpufreq_interactive_boost("pulse");
+	if (!tunables->boosted)
+		cpufreq_interactive_boost(tunables);
+	return count;
+}
+
+static ssize_t show_boostpulse_duration(struct cpufreq_interactive_tun=
ables
+		*tunables, char *buf)
+{
+	return sprintf(buf, "%d\n", tunables->boostpulse_duration_val);
+}
+
+static ssize_t store_boostpulse_duration(struct cpufreq_interactive_tu=
nables
+		*tunables, const char *buf, size_t count)
+{
+	int ret;
+	unsigned long val;
+
+	ret =3D kstrtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	tunables->boostpulse_duration_val =3D val;
+	return count;
+}
+
+static ssize_t show_io_is_busy(struct cpufreq_interactive_tunables *tu=
nables,
+		char *buf)
+{
+	return sprintf(buf, "%u\n", tunables->io_is_busy);
+}
+
+static ssize_t store_io_is_busy(struct cpufreq_interactive_tunables *t=
unables,
+		const char *buf, size_t count)
+{
+	int ret;
+	unsigned long val;
+
+	ret =3D kstrtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+	tunables->io_is_busy =3D val;
+	return count;
+}
+
+/*
+ * Create show/store routines
+ * - sys: One governor instance for complete SYSTEM
+ * - pol: One governor instance per struct cpufreq_policy
+ */
+#define show_gov_pol_sys(file_name)					\
+static ssize_t show_##file_name##_gov_sys				\
+(struct kobject *kobj, struct attribute *attr, char *buf)		\
+{									\
+	return show_##file_name(common_tunables, buf);			\
+}									\
+									\
+static ssize_t show_##file_name##_gov_pol				\
+(struct cpufreq_policy *policy, char *buf)				\
+{									\
+	return show_##file_name(policy->governor_data, buf);		\
+}
+
+#define store_gov_pol_sys(file_name)					\
+static ssize_t store_##file_name##_gov_sys				\
+(struct kobject *kobj, struct attribute *attr, const char *buf,		\
+	size_t count)							\
+{									\
+	return store_##file_name(common_tunables, buf, count);		\
+}									\
+									\
+static ssize_t store_##file_name##_gov_pol				\
+(struct cpufreq_policy *policy, const char *buf, size_t count)		\
+{									\
+	return store_##file_name(policy->governor_data, buf, count);	\
+}
+
+#define show_store_gov_pol_sys(file_name)				\
+show_gov_pol_sys(file_name);						\
+store_gov_pol_sys(file_name)
+
+show_store_gov_pol_sys(target_loads);
+show_store_gov_pol_sys(above_hispeed_delay);
+show_store_gov_pol_sys(hispeed_freq);
+show_store_gov_pol_sys(go_hispeed_load);
+show_store_gov_pol_sys(min_sample_time);
+show_store_gov_pol_sys(timer_rate);
+show_store_gov_pol_sys(timer_slack);
+show_store_gov_pol_sys(boost);
+store_gov_pol_sys(boostpulse);
+show_store_gov_pol_sys(boostpulse_duration);
+show_store_gov_pol_sys(io_is_busy);
+
+#define gov_sys_attr_rw(_name)						\
+static struct global_attr _name##_gov_sys =3D				\
+__ATTR(_name, 0644, show_##_name##_gov_sys, store_##_name##_gov_sys)
+
+#define gov_pol_attr_rw(_name)						\
+static struct freq_attr _name##_gov_pol =3D				\
+__ATTR(_name, 0644, show_##_name##_gov_pol, store_##_name##_gov_pol)
+
+#define gov_sys_pol_attr_rw(_name)					\
+	gov_sys_attr_rw(_name);						\
+	gov_pol_attr_rw(_name)
+
+gov_sys_pol_attr_rw(target_loads);
+gov_sys_pol_attr_rw(above_hispeed_delay);
+gov_sys_pol_attr_rw(hispeed_freq);
+gov_sys_pol_attr_rw(go_hispeed_load);
+gov_sys_pol_attr_rw(min_sample_time);
+gov_sys_pol_attr_rw(timer_rate);
+gov_sys_pol_attr_rw(timer_slack);
+gov_sys_pol_attr_rw(boost);
+gov_sys_pol_attr_rw(boostpulse_duration);
+gov_sys_pol_attr_rw(io_is_busy);
+
+static struct global_attr boostpulse_gov_sys =3D
+	__ATTR(boostpulse, 0200, NULL, store_boostpulse_gov_sys);
+
+static struct freq_attr boostpulse_gov_pol =3D
+	__ATTR(boostpulse, 0200, NULL, store_boostpulse_gov_pol);
+
+/* One Governor instance for entire system */
+static struct attribute *interactive_attributes_gov_sys[] =3D {
+	&target_loads_gov_sys.attr,
+	&above_hispeed_delay_gov_sys.attr,
+	&hispeed_freq_gov_sys.attr,
+	&go_hispeed_load_gov_sys.attr,
+	&min_sample_time_gov_sys.attr,
+	&timer_rate_gov_sys.attr,
+	&timer_slack_gov_sys.attr,
+	&boost_gov_sys.attr,
+	&boostpulse_gov_sys.attr,
+	&boostpulse_duration_gov_sys.attr,
+	&io_is_busy_gov_sys.attr,
+	NULL,
+};
+
+static struct attribute_group interactive_attr_group_gov_sys =3D {
+	.attrs =3D interactive_attributes_gov_sys,
+	.name =3D "interactive",
+};
+
+/* Per policy governor instance */
+static struct attribute *interactive_attributes_gov_pol[] =3D {
+	&target_loads_gov_pol.attr,
+	&above_hispeed_delay_gov_pol.attr,
+	&hispeed_freq_gov_pol.attr,
+	&go_hispeed_load_gov_pol.attr,
+	&min_sample_time_gov_pol.attr,
+	&timer_rate_gov_pol.attr,
+	&timer_slack_gov_pol.attr,
+	&boost_gov_pol.attr,
+	&boostpulse_gov_pol.attr,
+	&boostpulse_duration_gov_pol.attr,
+	&io_is_busy_gov_pol.attr,
+	NULL,
+};
+
+static struct attribute_group interactive_attr_group_gov_pol =3D {
+	.attrs =3D interactive_attributes_gov_pol,
+	.name =3D "interactive",
+};
+
+static struct attribute_group *get_sysfs_attr(void)
+{
+	if (have_governor_per_policy())
+		return &interactive_attr_group_gov_pol;
+	else
+		return &interactive_attr_group_gov_sys;
+}
+
+static int cpufreq_interactive_idle_notifier(struct notifier_block *nb=
,
+					     unsigned long val,
+					     void *data)
+{
+	if (val =3D=3D IDLE_END)
+		cpufreq_interactive_idle_end();
+
+	return 0;
+}
+
+static struct notifier_block cpufreq_interactive_idle_nb =3D {
+	.notifier_call =3D cpufreq_interactive_idle_notifier,
+};
+
+static int cpufreq_governor_interactive(struct cpufreq_policy *policy,
+		unsigned int event)
+{
+	int rc;
+	unsigned int j;
+	struct cpufreq_interactive_cpuinfo *pcpu;
+	struct cpufreq_frequency_table *freq_table;
+	struct cpufreq_interactive_tunables *tunables;
+	unsigned long flags;
+
+	if (have_governor_per_policy())
+		tunables =3D policy->governor_data;
+	else
+		tunables =3D common_tunables;
+
+	WARN_ON(!tunables && (event !=3D CPUFREQ_GOV_POLICY_INIT));
+
+	switch (event) {
+	case CPUFREQ_GOV_POLICY_INIT:
+		if (have_governor_per_policy()) {
+			WARN_ON(tunables);
+		} else if (tunables) {
+			tunables->usage_count++;
+			policy->governor_data =3D tunables;
+			return 0;
+		}
+
+		tunables =3D kzalloc(sizeof(*tunables), GFP_KERNEL);
+		if (!tunables) {
+			pr_err("%s: POLICY_INIT: kzalloc failed\n", __func__);
+			return -ENOMEM;
+		}
+
+		tunables->usage_count =3D 1;
+		tunables->above_hispeed_delay =3D default_above_hispeed_delay;
+		tunables->nabove_hispeed_delay =3D
+			ARRAY_SIZE(default_above_hispeed_delay);
+		tunables->go_hispeed_load =3D DEFAULT_GO_HISPEED_LOAD;
+		tunables->target_loads =3D default_target_loads;
+		tunables->ntarget_loads =3D ARRAY_SIZE(default_target_loads);
+		tunables->min_sample_time =3D DEFAULT_MIN_SAMPLE_TIME;
+		tunables->timer_rate =3D DEFAULT_TIMER_RATE;
+		tunables->boostpulse_duration_val =3D DEFAULT_MIN_SAMPLE_TIME;
+		tunables->timer_slack_val =3D DEFAULT_TIMER_SLACK;
+
+		spin_lock_init(&tunables->target_loads_lock);
+		spin_lock_init(&tunables->above_hispeed_delay_lock);
+
+		policy->governor_data =3D tunables;
+		if (!have_governor_per_policy()) {
+			common_tunables =3D tunables;
+			WARN_ON(cpufreq_get_global_kobject());
+		}
+
+		rc =3D sysfs_create_group(get_governor_parent_kobj(policy),
+				get_sysfs_attr());
+		if (rc) {
+			kfree(tunables);
+			policy->governor_data =3D NULL;
+			if (!have_governor_per_policy()) {
+				common_tunables =3D NULL;
+				cpufreq_put_global_kobject();
+			}
+			return rc;
+		}
+
+		if (!policy->governor->initialized) {
+			idle_notifier_register(&cpufreq_interactive_idle_nb);
+			cpufreq_register_notifier(&cpufreq_notifier_block,
+					CPUFREQ_TRANSITION_NOTIFIER);
+		}
+
+		break;
+
+	case CPUFREQ_GOV_POLICY_EXIT:
+		if (!--tunables->usage_count) {
+			if (policy->governor->initialized =3D=3D 1) {
+				cpufreq_unregister_notifier(&cpufreq_notifier_block,
+						CPUFREQ_TRANSITION_NOTIFIER);
+				idle_notifier_unregister(&cpufreq_interactive_idle_nb);
+			}
+
+			sysfs_remove_group(get_governor_parent_kobj(policy),
+					get_sysfs_attr());
+
+			if (!have_governor_per_policy())
+				cpufreq_put_global_kobject();
+
+			kfree(tunables);
+			common_tunables =3D NULL;
+		}
+
+		policy->governor_data =3D NULL;
+		break;
+
+	case CPUFREQ_GOV_START:
+		mutex_lock(&gov_lock);
+
+		freq_table =3D cpufreq_frequency_get_table(policy->cpu);
+		if (!tunables->hispeed_freq)
+			tunables->hispeed_freq =3D policy->max;
+
+		for_each_cpu(j, policy->cpus) {
+			pcpu =3D &per_cpu(cpuinfo, j);
+			pcpu->policy =3D policy;
+			pcpu->target_freq =3D policy->cur;
+			pcpu->freq_table =3D freq_table;
+			pcpu->floor_freq =3D pcpu->target_freq;
+			pcpu->pol_floor_val_time =3D
+				ktime_to_us(ktime_get());
+			pcpu->loc_floor_val_time =3D pcpu->pol_floor_val_time;
+			pcpu->pol_hispeed_val_time =3D pcpu->pol_floor_val_time;
+			pcpu->loc_hispeed_val_time =3D pcpu->pol_floor_val_time;
+			down_write(&pcpu->enable_sem);
+			del_timer_sync(&pcpu->cpu_timer);
+			del_timer_sync(&pcpu->cpu_slack_timer);
+			cpufreq_interactive_timer_start(tunables, j);
+			pcpu->governor_enabled =3D 1;
+			up_write(&pcpu->enable_sem);
+		}
+
+		mutex_unlock(&gov_lock);
+		break;
+
+	case CPUFREQ_GOV_STOP:
+		mutex_lock(&gov_lock);
+		for_each_cpu(j, policy->cpus) {
+			pcpu =3D &per_cpu(cpuinfo, j);
+			down_write(&pcpu->enable_sem);
+			pcpu->governor_enabled =3D 0;
+			del_timer_sync(&pcpu->cpu_timer);
+			del_timer_sync(&pcpu->cpu_slack_timer);
+			up_write(&pcpu->enable_sem);
+		}
+
+		mutex_unlock(&gov_lock);
+		break;
+
+	case CPUFREQ_GOV_LIMITS:
+		if (policy->max < policy->cur)
+			__cpufreq_driver_target(policy,
+					policy->max, CPUFREQ_RELATION_H);
+		else if (policy->min > policy->cur)
+			__cpufreq_driver_target(policy,
+					policy->min, CPUFREQ_RELATION_L);
+		for_each_cpu(j, policy->cpus) {
+			pcpu =3D &per_cpu(cpuinfo, j);
+
+			down_read(&pcpu->enable_sem);
+			if (pcpu->governor_enabled =3D=3D 0) {
+				up_read(&pcpu->enable_sem);
+				continue;
+			}
+
+			spin_lock_irqsave(&pcpu->target_freq_lock, flags);
+			if (policy->max < pcpu->target_freq)
+				pcpu->target_freq =3D policy->max;
+			else if (policy->min > pcpu->target_freq)
+				pcpu->target_freq =3D policy->min;
+
+			spin_unlock_irqrestore(&pcpu->target_freq_lock, flags);
+			up_read(&pcpu->enable_sem);
+		}
+		break;
+	}
+	return 0;
+}
+
+#ifndef CONFIG_CPU_FREQ_DEFAULT_GOV_INTERACTIVE
+static
+#endif
+struct cpufreq_governor cpufreq_gov_interactive =3D {
+	.name =3D "interactive",
+	.governor =3D cpufreq_governor_interactive,
+	.max_transition_latency =3D 10000000,
+	.owner =3D THIS_MODULE,
+};
+
+static void cpufreq_interactive_nop_timer(unsigned long data)
+{
+}
+
+static int __init cpufreq_interactive_init(void)
+{
+	unsigned int i;
+	struct cpufreq_interactive_cpuinfo *pcpu;
+	struct sched_param param =3D { .sched_priority =3D MAX_RT_PRIO-1 };
+
+	/* Initalize per-cpu timers */
+	for_each_possible_cpu(i) {
+		pcpu =3D &per_cpu(cpuinfo, i);
+		init_timer_deferrable(&pcpu->cpu_timer);
+		pcpu->cpu_timer.function =3D cpufreq_interactive_timer;
+		pcpu->cpu_timer.data =3D i;
+		init_timer(&pcpu->cpu_slack_timer);
+		pcpu->cpu_slack_timer.function =3D cpufreq_interactive_nop_timer;
+		spin_lock_init(&pcpu->load_lock);
+		spin_lock_init(&pcpu->target_freq_lock);
+		init_rwsem(&pcpu->enable_sem);
+	}
+
+	spin_lock_init(&speedchange_cpumask_lock);
+	mutex_init(&gov_lock);
+	speedchange_task =3D
+		kthread_create(cpufreq_interactive_speedchange_task, NULL,
+			       "cfinteractive");
+	if (IS_ERR(speedchange_task))
+		return PTR_ERR(speedchange_task);
+
+	sched_setscheduler_nocheck(speedchange_task, SCHED_FIFO, &param);
+	get_task_struct(speedchange_task);
+
+	/* NB: wake up so the thread does not look hung to the freezer */
+	wake_up_process(speedchange_task);
+
+	return cpufreq_register_governor(&cpufreq_gov_interactive);
+}
+
+#ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_INTERACTIVE
+fs_initcall(cpufreq_interactive_init);
+#else
+module_init(cpufreq_interactive_init);
+#endif
+
+static void __exit cpufreq_interactive_exit(void)
+{
+	cpufreq_unregister_governor(&cpufreq_gov_interactive);
+	kthread_stop(speedchange_task);
+	put_task_struct(speedchange_task);
+}
+
+module_exit(cpufreq_interactive_exit);
+
+MODULE_AUTHOR("Mike Chan <mike@android.com>");
+MODULE_DESCRIPTION("'cpufreq_interactive' - A cpufreq governor for "
+	"Latency sensitive workloads");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index dca22de..2ea8ab5 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -491,6 +491,9 @@ extern struct cpufreq_governor cpufreq_gov_ondemand=
;
 #elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE)
 extern struct cpufreq_governor cpufreq_gov_conservative;
 #define CPUFREQ_DEFAULT_GOVERNOR	(&cpufreq_gov_conservative)
+#elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_INTERACTIVE)
+extern struct cpufreq_governor cpufreq_gov_interactive;
+#define CPUFREQ_DEFAULT_GOVERNOR	(&cpufreq_gov_interactive)
 #endif
=20
 /*********************************************************************
diff --git a/include/trace/events/cpufreq_interactive.h b/include/trace=
/events/cpufreq_interactive.h
new file mode 100644
index 0000000..951e6ca
--- /dev/null
+++ b/include/trace/events/cpufreq_interactive.h
@@ -0,0 +1,112 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM cpufreq_interactive
+
+#if !defined(_TRACE_CPUFREQ_INTERACTIVE_H) || defined(TRACE_HEADER_MUL=
TI_READ)
+#define _TRACE_CPUFREQ_INTERACTIVE_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(set,
+	TP_PROTO(u32 cpu_id, unsigned long targfreq,
+	         unsigned long actualfreq),
+	TP_ARGS(cpu_id, targfreq, actualfreq),
+
+	TP_STRUCT__entry(
+	    __field(          u32, cpu_id    )
+	    __field(unsigned long, targfreq   )
+	    __field(unsigned long, actualfreq )
+	   ),
+
+	TP_fast_assign(
+	    __entry->cpu_id =3D (u32) cpu_id;
+	    __entry->targfreq =3D targfreq;
+	    __entry->actualfreq =3D actualfreq;
+	),
+
+	TP_printk("cpu=3D%u targ=3D%lu actual=3D%lu",
+	      __entry->cpu_id, __entry->targfreq,
+	      __entry->actualfreq)
+);
+
+DEFINE_EVENT(set, cpufreq_interactive_setspeed,
+	TP_PROTO(u32 cpu_id, unsigned long targfreq,
+	     unsigned long actualfreq),
+	TP_ARGS(cpu_id, targfreq, actualfreq)
+);
+
+DECLARE_EVENT_CLASS(loadeval,
+	    TP_PROTO(unsigned long cpu_id, unsigned long load,
+		     unsigned long curtarg, unsigned long curactual,
+		     unsigned long newtarg),
+		    TP_ARGS(cpu_id, load, curtarg, curactual, newtarg),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned long, cpu_id    )
+		    __field(unsigned long, load      )
+		    __field(unsigned long, curtarg   )
+		    __field(unsigned long, curactual )
+		    __field(unsigned long, newtarg   )
+	    ),
+
+	    TP_fast_assign(
+		    __entry->cpu_id =3D cpu_id;
+		    __entry->load =3D load;
+		    __entry->curtarg =3D curtarg;
+		    __entry->curactual =3D curactual;
+		    __entry->newtarg =3D newtarg;
+	    ),
+
+	    TP_printk("cpu=3D%lu load=3D%lu cur=3D%lu actual=3D%lu targ=3D%lu=
",
+		      __entry->cpu_id, __entry->load, __entry->curtarg,
+		      __entry->curactual, __entry->newtarg)
+);
+
+DEFINE_EVENT(loadeval, cpufreq_interactive_target,
+	    TP_PROTO(unsigned long cpu_id, unsigned long load,
+		     unsigned long curtarg, unsigned long curactual,
+		     unsigned long newtarg),
+	    TP_ARGS(cpu_id, load, curtarg, curactual, newtarg)
+);
+
+DEFINE_EVENT(loadeval, cpufreq_interactive_already,
+	    TP_PROTO(unsigned long cpu_id, unsigned long load,
+		     unsigned long curtarg, unsigned long curactual,
+		     unsigned long newtarg),
+	    TP_ARGS(cpu_id, load, curtarg, curactual, newtarg)
+);
+
+DEFINE_EVENT(loadeval, cpufreq_interactive_notyet,
+	    TP_PROTO(unsigned long cpu_id, unsigned long load,
+		     unsigned long curtarg, unsigned long curactual,
+		     unsigned long newtarg),
+	    TP_ARGS(cpu_id, load, curtarg, curactual, newtarg)
+);
+
+TRACE_EVENT(cpufreq_interactive_boost,
+	    TP_PROTO(const char *s),
+	    TP_ARGS(s),
+	    TP_STRUCT__entry(
+		    __string(s, s)
+	    ),
+	    TP_fast_assign(
+		    __assign_str(s, s);
+	    ),
+	    TP_printk("%s", __get_str(s))
+);
+
+TRACE_EVENT(cpufreq_interactive_unboost,
+	    TP_PROTO(const char *s),
+	    TP_ARGS(s),
+	    TP_STRUCT__entry(
+		    __string(s, s)
+	    ),
+	    TP_fast_assign(
+		    __assign_str(s, s);
+	    ),
+	    TP_printk("%s", __get_str(s))
+);
+
+#endif /* _TRACE_CPUFREQ_INTERACTIVE_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
--=20
1.7.9.5

