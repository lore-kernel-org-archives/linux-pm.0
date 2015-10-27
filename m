From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 01/70] cpufreq: interactive: New 'interactive' governor
Date: Tue, 27 Oct 2015 18:29:49 +0100
Message-ID: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33346 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932367AbbJ0Rb1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 13:31:27 -0400
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

Change-Id: Ib2b362607c62f7c56d35f44a9ef3280f98c17585
Signed-off-by: Mike Chan <mike@android.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Bug: 3152864
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 Documentation/cpu-freq/governors.txt  |   37 ++
 drivers/cpufreq/Kconfig               |   27 ++
 drivers/cpufreq/Makefile              |    1 +
 drivers/cpufreq/cpufreq_interactive.c |  706 +++++++++++++++++++++++++=
++++++++
 include/linux/cpufreq.h               |    3 +
 5 files changed, 774 insertions(+)
 create mode 100644 drivers/cpufreq/cpufreq_interactive.c

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
index 0000000..8fc147c
--- /dev/null
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -0,0 +1,706 @@
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
+#include <linux/mutex.h>
+#include <linux/sched.h>
+#include <linux/sched/rt.h>
+#include <linux/tick.h>
+#include <linux/time.h>
+#include <linux/timer.h>
+#include <linux/workqueue.h>
+#include <linux/kthread.h>
+#include <linux/mutex.h>
+
+#include <asm/cputime.h>
+
+static atomic_t active_count =3D ATOMIC_INIT(0);
+
+struct cpufreq_interactive_cpuinfo {
+	struct timer_list cpu_timer;
+	int timer_idlecancel;
+	u64 time_in_idle;
+	u64 idle_exit_time;
+	u64 timer_run_time;
+	int idling;
+	u64 freq_change_time;
+	u64 freq_change_time_in_idle;
+	struct cpufreq_policy *policy;
+	struct cpufreq_frequency_table *freq_table;
+	unsigned int target_freq;
+	int governor_enabled;
+};
+
+static DEFINE_PER_CPU(struct cpufreq_interactive_cpuinfo, cpuinfo);
+
+/* Workqueues handle frequency scaling */
+static struct task_struct *up_task;
+static struct workqueue_struct *down_wq;
+static struct work_struct freq_scale_down_work;
+static cpumask_t up_cpumask;
+static spinlock_t up_cpumask_lock;
+static cpumask_t down_cpumask;
+static spinlock_t down_cpumask_lock;
+static struct mutex set_speed_lock;
+
+/* Hi speed to bump to from lo speed when load burst (default max) */
+static u64 hispeed_freq;
+
+/* Go to hi speed when CPU load at or above this value. */
+#define DEFAULT_GO_HISPEED_LOAD 95
+static unsigned long go_hispeed_load;
+
+/*
+ * The minimum amount of time to spend at a frequency before we can ra=
mp down.
+ */
+#define DEFAULT_MIN_SAMPLE_TIME 20 * USEC_PER_MSEC
+static unsigned long min_sample_time;
+
+/*
+ * The sample rate of the timer used to increase frequency
+ */
+#define DEFAULT_TIMER_RATE 20 * USEC_PER_MSEC
+static unsigned long timer_rate;
+
+static int cpufreq_governor_interactive(struct cpufreq_policy *policy,
+		unsigned int event);
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
+static void cpufreq_interactive_timer(unsigned long data)
+{
+	unsigned int delta_idle;
+	unsigned int delta_time;
+	int cpu_load;
+	int load_since_change;
+	u64 time_in_idle;
+	u64 idle_exit_time;
+	struct cpufreq_interactive_cpuinfo *pcpu =3D
+		&per_cpu(cpuinfo, data);
+	u64 now_idle;
+	unsigned int new_freq;
+	unsigned int index;
+	unsigned long flags;
+
+	smp_rmb();
+
+	if (!pcpu->governor_enabled)
+		goto exit;
+
+	/*
+	 * Once pcpu->timer_run_time is updated to >=3D pcpu->idle_exit_time,
+	 * this lets idle exit know the current idle time sample has
+	 * been processed, and idle exit can generate a new sample and
+	 * re-arm the timer.  This prevents a concurrent idle
+	 * exit on that CPU from writing a new set of info at the same time
+	 * the timer function runs (the timer function can't use that info
+	 * until more time passes).
+	 */
+	time_in_idle =3D pcpu->time_in_idle;
+	idle_exit_time =3D pcpu->idle_exit_time;
+	now_idle =3D get_cpu_idle_time_us(data, &pcpu->timer_run_time);
+	smp_wmb();
+
+	/* If we raced with cancelling a timer, skip. */
+	if (!idle_exit_time)
+		goto exit;
+
+	delta_idle =3D (unsigned int)(now_idle - time_in_idle);
+	delta_time =3D (unsigned int)(pcpu->timer_run_time - idle_exit_time);
+
+	/*
+	 * If timer ran less than 1ms after short-term sample started, retry.
+	 */
+	if (delta_time < 1000)
+		goto rearm;
+
+	if (delta_idle > delta_time)
+		cpu_load =3D 0;
+	else
+		cpu_load =3D 100 * (delta_time - delta_idle) / delta_time;
+
+	delta_idle =3D (unsigned int)(now_idle - pcpu->freq_change_time_in_id=
le);
+	delta_time =3D (unsigned int)(pcpu->timer_run_time - pcpu->freq_chang=
e_time);
+
+	if ((delta_time =3D=3D 0) || (delta_idle > delta_time))
+		load_since_change =3D 0;
+	else
+		load_since_change =3D
+			100 * (delta_time - delta_idle) / delta_time;
+
+	/*
+	 * Choose greater of short-term load (since last idle timer
+	 * started or timer function re-armed itself) or long-term load
+	 * (since last frequency change).
+	 */
+	if (load_since_change > cpu_load)
+		cpu_load =3D load_since_change;
+
+	if (cpu_load >=3D go_hispeed_load) {
+		if (pcpu->policy->cur =3D=3D pcpu->policy->min)
+			new_freq =3D hispeed_freq;
+		else
+			new_freq =3D pcpu->policy->max * cpu_load / 100;
+	} else {
+		new_freq =3D pcpu->policy->cur * cpu_load / 100;
+	}
+
+	if (cpufreq_frequency_table_target(pcpu->policy, pcpu->freq_table,
+					   new_freq, CPUFREQ_RELATION_H,
+					   &index)) {
+		pr_warn_once("timer %d: cpufreq_frequency_table_target error\n",
+			     (int) data);
+		goto rearm;
+	}
+
+	new_freq =3D pcpu->freq_table[index].frequency;
+
+	if (pcpu->target_freq =3D=3D new_freq)
+		goto rearm_if_notmax;
+
+	/*
+	 * Do not scale down unless we have been at this frequency for the
+	 * minimum sample time.
+	 */
+	if (new_freq < pcpu->target_freq) {
+		if (pcpu->timer_run_time - pcpu->freq_change_time
+		    < min_sample_time)
+			goto rearm;
+	}
+
+	if (new_freq < pcpu->target_freq) {
+		pcpu->target_freq =3D new_freq;
+		spin_lock_irqsave(&down_cpumask_lock, flags);
+		cpumask_set_cpu(data, &down_cpumask);
+		spin_unlock_irqrestore(&down_cpumask_lock, flags);
+		queue_work(down_wq, &freq_scale_down_work);
+	} else {
+		pcpu->target_freq =3D new_freq;
+		spin_lock_irqsave(&up_cpumask_lock, flags);
+		cpumask_set_cpu(data, &up_cpumask);
+		spin_unlock_irqrestore(&up_cpumask_lock, flags);
+		wake_up_process(up_task);
+	}
+
+rearm_if_notmax:
+	/*
+	 * Already set max speed and don't see a need to change that,
+	 * wait until next idle to re-evaluate, don't need timer.
+	 */
+	if (pcpu->target_freq =3D=3D pcpu->policy->max)
+		goto exit;
+
+rearm:
+	if (!timer_pending(&pcpu->cpu_timer)) {
+		/*
+		 * If already at min: if that CPU is idle, don't set timer.
+		 * Else cancel the timer if that CPU goes idle.  We don't
+		 * need to re-evaluate speed until the next idle exit.
+		 */
+		if (pcpu->target_freq =3D=3D pcpu->policy->min) {
+			smp_rmb();
+
+			if (pcpu->idling)
+				goto exit;
+
+			pcpu->timer_idlecancel =3D 1;
+		}
+
+		pcpu->time_in_idle =3D get_cpu_idle_time_us(
+			data, &pcpu->idle_exit_time);
+		mod_timer(&pcpu->cpu_timer,
+			  jiffies + usecs_to_jiffies(timer_rate));
+	}
+
+exit:
+	return;
+}
+
+static void cpufreq_interactive_idle_start(void)
+{
+	struct cpufreq_interactive_cpuinfo *pcpu =3D
+		&per_cpu(cpuinfo, smp_processor_id());
+	int pending;
+
+	if (!pcpu->governor_enabled)
+		return;
+
+	pcpu->idling =3D 1;
+	smp_wmb();
+	pending =3D timer_pending(&pcpu->cpu_timer);
+
+	if (pcpu->target_freq !=3D pcpu->policy->min) {
+#ifdef CONFIG_SMP
+		/*
+		 * Entering idle while not at lowest speed.  On some
+		 * platforms this can hold the other CPU(s) at that speed
+		 * even though the CPU is idle. Set a timer to re-evaluate
+		 * speed so this idle CPU doesn't hold the other CPUs above
+		 * min indefinitely.  This should probably be a quirk of
+		 * the CPUFreq driver.
+		 */
+		if (!pending) {
+			pcpu->time_in_idle =3D get_cpu_idle_time_us(
+				smp_processor_id(), &pcpu->idle_exit_time);
+			pcpu->timer_idlecancel =3D 0;
+			mod_timer(&pcpu->cpu_timer,
+				  jiffies + usecs_to_jiffies(timer_rate));
+		}
+#endif
+	} else {
+		/*
+		 * If at min speed and entering idle after load has
+		 * already been evaluated, and a timer has been set just in
+		 * case the CPU suddenly goes busy, cancel that timer.  The
+		 * CPU didn't go busy; we'll recheck things upon idle exit.
+		 */
+		if (pending && pcpu->timer_idlecancel) {
+			del_timer(&pcpu->cpu_timer);
+			/*
+			 * Ensure last timer run time is after current idle
+			 * sample start time, so next idle exit will always
+			 * start a new idle sampling period.
+			 */
+			pcpu->idle_exit_time =3D 0;
+			pcpu->timer_idlecancel =3D 0;
+		}
+	}
+
+}
+
+static void cpufreq_interactive_idle_end(void)
+{
+	struct cpufreq_interactive_cpuinfo *pcpu =3D
+		&per_cpu(cpuinfo, smp_processor_id());
+
+	pcpu->idling =3D 0;
+	smp_wmb();
+
+	/*
+	 * Arm the timer for 1-2 ticks later if not already, and if the timer
+	 * function has already processed the previous load sampling
+	 * interval.  (If the timer is not pending but has not processed
+	 * the previous interval, it is probably racing with us on another
+	 * CPU.  Let it compute load based on the previous sample and then
+	 * re-arm the timer for another interval when it's done, rather
+	 * than updating the interval start time to be "now", which doesn't
+	 * give the timer function enough time to make a decision on this
+	 * run.)
+	 */
+	if (timer_pending(&pcpu->cpu_timer) =3D=3D 0 &&
+	    pcpu->timer_run_time >=3D pcpu->idle_exit_time &&
+	    pcpu->governor_enabled) {
+		pcpu->time_in_idle =3D
+			get_cpu_idle_time_us(smp_processor_id(),
+					     &pcpu->idle_exit_time);
+		pcpu->timer_idlecancel =3D 0;
+		mod_timer(&pcpu->cpu_timer,
+			  jiffies + usecs_to_jiffies(timer_rate));
+	}
+
+}
+
+static int cpufreq_interactive_up_task(void *data)
+{
+	unsigned int cpu;
+	cpumask_t tmp_mask;
+	unsigned long flags;
+	struct cpufreq_interactive_cpuinfo *pcpu;
+
+	while (1) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		spin_lock_irqsave(&up_cpumask_lock, flags);
+
+		if (cpumask_empty(&up_cpumask)) {
+			spin_unlock_irqrestore(&up_cpumask_lock, flags);
+			schedule();
+
+			if (kthread_should_stop())
+				break;
+
+			spin_lock_irqsave(&up_cpumask_lock, flags);
+		}
+
+		set_current_state(TASK_RUNNING);
+		tmp_mask =3D up_cpumask;
+		cpumask_clear(&up_cpumask);
+		spin_unlock_irqrestore(&up_cpumask_lock, flags);
+
+		for_each_cpu(cpu, &tmp_mask) {
+			unsigned int j;
+			unsigned int max_freq =3D 0;
+
+			pcpu =3D &per_cpu(cpuinfo, cpu);
+			smp_rmb();
+
+			if (!pcpu->governor_enabled)
+				continue;
+
+			mutex_lock(&set_speed_lock);
+
+			for_each_cpu(j, pcpu->policy->cpus) {
+				struct cpufreq_interactive_cpuinfo *pjcpu =3D
+					&per_cpu(cpuinfo, j);
+
+				if (pjcpu->target_freq > max_freq)
+					max_freq =3D pjcpu->target_freq;
+			}
+
+			if (max_freq !=3D pcpu->policy->cur)
+				__cpufreq_driver_target(pcpu->policy,
+							max_freq,
+							CPUFREQ_RELATION_H);
+			mutex_unlock(&set_speed_lock);
+
+			pcpu->freq_change_time_in_idle =3D
+				get_cpu_idle_time_us(cpu,
+						     &pcpu->freq_change_time);
+		}
+	}
+
+	return 0;
+}
+
+static void cpufreq_interactive_freq_down(struct work_struct *work)
+{
+	unsigned int cpu;
+	cpumask_t tmp_mask;
+	unsigned long flags;
+	struct cpufreq_interactive_cpuinfo *pcpu;
+
+	spin_lock_irqsave(&down_cpumask_lock, flags);
+	tmp_mask =3D down_cpumask;
+	cpumask_clear(&down_cpumask);
+	spin_unlock_irqrestore(&down_cpumask_lock, flags);
+
+	for_each_cpu(cpu, &tmp_mask) {
+		unsigned int j;
+		unsigned int max_freq =3D 0;
+
+		pcpu =3D &per_cpu(cpuinfo, cpu);
+		smp_rmb();
+
+		if (!pcpu->governor_enabled)
+			continue;
+
+		mutex_lock(&set_speed_lock);
+
+		for_each_cpu(j, pcpu->policy->cpus) {
+			struct cpufreq_interactive_cpuinfo *pjcpu =3D
+				&per_cpu(cpuinfo, j);
+
+			if (pjcpu->target_freq > max_freq)
+				max_freq =3D pjcpu->target_freq;
+		}
+
+		if (max_freq !=3D pcpu->policy->cur)
+			__cpufreq_driver_target(pcpu->policy, max_freq,
+						CPUFREQ_RELATION_H);
+
+		mutex_unlock(&set_speed_lock);
+		pcpu->freq_change_time_in_idle =3D
+			get_cpu_idle_time_us(cpu,
+					     &pcpu->freq_change_time);
+	}
+}
+
+static ssize_t show_hispeed_freq(struct kobject *kobj,
+				 struct attribute *attr, char *buf)
+{
+	return sprintf(buf, "%llu\n", hispeed_freq);
+}
+
+static ssize_t store_hispeed_freq(struct kobject *kobj,
+				  struct attribute *attr, const char *buf,
+				  size_t count)
+{
+	int ret;
+	u64 val;
+
+	ret =3D strict_strtoull(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+	hispeed_freq =3D val;
+	return count;
+}
+
+static struct global_attr hispeed_freq_attr =3D __ATTR(hispeed_freq, 0=
644,
+		show_hispeed_freq, store_hispeed_freq);
+
+
+static ssize_t show_go_hispeed_load(struct kobject *kobj,
+				     struct attribute *attr, char *buf)
+{
+	return sprintf(buf, "%lu\n", go_hispeed_load);
+}
+
+static ssize_t store_go_hispeed_load(struct kobject *kobj,
+			struct attribute *attr, const char *buf, size_t count)
+{
+	int ret;
+	unsigned long val;
+
+	ret =3D strict_strtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+	go_hispeed_load =3D val;
+	return count;
+}
+
+static struct global_attr go_hispeed_load_attr =3D __ATTR(go_hispeed_l=
oad, 0644,
+		show_go_hispeed_load, store_go_hispeed_load);
+
+static ssize_t show_min_sample_time(struct kobject *kobj,
+				struct attribute *attr, char *buf)
+{
+	return sprintf(buf, "%lu\n", min_sample_time);
+}
+
+static ssize_t store_min_sample_time(struct kobject *kobj,
+			struct attribute *attr, const char *buf, size_t count)
+{
+	int ret;
+	unsigned long val;
+
+	ret =3D strict_strtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+	min_sample_time =3D val;
+	return count;
+}
+
+static struct global_attr min_sample_time_attr =3D __ATTR(min_sample_t=
ime, 0644,
+		show_min_sample_time, store_min_sample_time);
+
+static ssize_t show_timer_rate(struct kobject *kobj,
+			struct attribute *attr, char *buf)
+{
+	return sprintf(buf, "%lu\n", timer_rate);
+}
+
+static ssize_t store_timer_rate(struct kobject *kobj,
+			struct attribute *attr, const char *buf, size_t count)
+{
+	int ret;
+	unsigned long val;
+
+	ret =3D strict_strtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+	timer_rate =3D val;
+	return count;
+}
+
+static struct global_attr timer_rate_attr =3D __ATTR(timer_rate, 0644,
+		show_timer_rate, store_timer_rate);
+
+static struct attribute *interactive_attributes[] =3D {
+	&hispeed_freq_attr.attr,
+	&go_hispeed_load_attr.attr,
+	&min_sample_time_attr.attr,
+	&timer_rate_attr.attr,
+	NULL,
+};
+
+static struct attribute_group interactive_attr_group =3D {
+	.attrs =3D interactive_attributes,
+	.name =3D "interactive",
+};
+
+static int cpufreq_governor_interactive(struct cpufreq_policy *policy,
+		unsigned int event)
+{
+	int rc;
+	unsigned int j;
+	struct cpufreq_interactive_cpuinfo *pcpu;
+	struct cpufreq_frequency_table *freq_table;
+
+	switch (event) {
+	case CPUFREQ_GOV_START:
+		if (!cpu_online(policy->cpu))
+			return -EINVAL;
+
+		freq_table =3D
+			cpufreq_frequency_get_table(policy->cpu);
+
+		for_each_cpu(j, policy->cpus) {
+			pcpu =3D &per_cpu(cpuinfo, j);
+			pcpu->policy =3D policy;
+			pcpu->target_freq =3D policy->cur;
+			pcpu->freq_table =3D freq_table;
+			pcpu->freq_change_time_in_idle =3D
+				get_cpu_idle_time_us(j,
+					     &pcpu->freq_change_time);
+			pcpu->governor_enabled =3D 1;
+			smp_wmb();
+		}
+
+		if (!hispeed_freq)
+			hispeed_freq =3D policy->max;
+
+		/*
+		 * Do not register the idle hook and create sysfs
+		 * entries if we have already done so.
+		 */
+		if (atomic_inc_return(&active_count) > 1)
+			return 0;
+
+		rc =3D sysfs_create_group(cpufreq_global_kobject,
+				&interactive_attr_group);
+		if (rc)
+			return rc;
+
+		break;
+
+	case CPUFREQ_GOV_STOP:
+		for_each_cpu(j, policy->cpus) {
+			pcpu =3D &per_cpu(cpuinfo, j);
+			pcpu->governor_enabled =3D 0;
+			smp_wmb();
+			del_timer_sync(&pcpu->cpu_timer);
+
+			/*
+			 * Reset idle exit time since we may cancel the timer
+			 * before it can run after the last idle exit time,
+			 * to avoid tripping the check in idle exit for a timer
+			 * that is trying to run.
+			 */
+			pcpu->idle_exit_time =3D 0;
+		}
+
+		flush_work(&freq_scale_down_work);
+		if (atomic_dec_return(&active_count) > 0)
+			return 0;
+
+		sysfs_remove_group(cpufreq_global_kobject,
+				&interactive_attr_group);
+
+		break;
+
+	case CPUFREQ_GOV_LIMITS:
+		if (policy->max < policy->cur)
+			__cpufreq_driver_target(policy,
+					policy->max, CPUFREQ_RELATION_H);
+		else if (policy->min > policy->cur)
+			__cpufreq_driver_target(policy,
+					policy->min, CPUFREQ_RELATION_L);
+		break;
+	}
+	return 0;
+}
+
+static int cpufreq_interactive_idle_notifier(struct notifier_block *nb=
,
+					     unsigned long val,
+					     void *data)
+{
+	switch (val) {
+	case IDLE_START:
+		cpufreq_interactive_idle_start();
+		break;
+	case IDLE_END:
+		cpufreq_interactive_idle_end();
+		break;
+	}
+
+	return 0;
+}
+
+static struct notifier_block cpufreq_interactive_idle_nb =3D {
+	.notifier_call =3D cpufreq_interactive_idle_notifier,
+};
+
+static int __init cpufreq_interactive_init(void)
+{
+	unsigned int i;
+	struct cpufreq_interactive_cpuinfo *pcpu;
+	struct sched_param param =3D { .sched_priority =3D MAX_RT_PRIO-1 };
+
+	go_hispeed_load =3D DEFAULT_GO_HISPEED_LOAD;
+	min_sample_time =3D DEFAULT_MIN_SAMPLE_TIME;
+	timer_rate =3D DEFAULT_TIMER_RATE;
+
+	/* Initalize per-cpu timers */
+	for_each_possible_cpu(i) {
+		pcpu =3D &per_cpu(cpuinfo, i);
+		init_timer(&pcpu->cpu_timer);
+		pcpu->cpu_timer.function =3D cpufreq_interactive_timer;
+		pcpu->cpu_timer.data =3D i;
+	}
+
+	up_task =3D kthread_create(cpufreq_interactive_up_task, NULL,
+				 "kinteractiveup");
+	if (IS_ERR(up_task))
+		return PTR_ERR(up_task);
+
+	sched_setscheduler_nocheck(up_task, SCHED_FIFO, &param);
+	get_task_struct(up_task);
+
+	/* No rescuer thread, bind to CPU queuing the work for possibly
+	   warm cache (probably doesn't matter much). */
+	down_wq =3D alloc_workqueue("knteractive_down", 0, 1);
+
+	if (!down_wq)
+		goto err_freeuptask;
+
+	INIT_WORK(&freq_scale_down_work,
+		  cpufreq_interactive_freq_down);
+
+	spin_lock_init(&up_cpumask_lock);
+	spin_lock_init(&down_cpumask_lock);
+	mutex_init(&set_speed_lock);
+
+	idle_notifier_register(&cpufreq_interactive_idle_nb);
+
+	return cpufreq_register_governor(&cpufreq_gov_interactive);
+
+err_freeuptask:
+	put_task_struct(up_task);
+	return -ENOMEM;
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
+	kthread_stop(up_task);
+	put_task_struct(up_task);
+	destroy_workqueue(down_wq);
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
--=20
1.7.9.5

