From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 3/3] cpuidle/drivers/mbed: Add new governor for embedded systems
Date: Fri,  8 Mar 2019 22:20:47 +0100
Message-ID: <20190308212047.28767-4-daniel.lezcano@linaro.org>
References: <20190308212047.28767-1-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190308212047.28767-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de
Cc: ulf.hansson@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The objective is the same for all the governors: save energy, but at
the end the governors menu, ladder and teo aim to improve the
performances with an acceptable energy drop for some workloads which
are identified for servers and desktops (with the help of a firmware).

It is very difficult to do changes in these governors for embedded
systems without impacting performances on servers/desktops or ruin the
optimizations for the workloads on these platforms.

The mbed governor is a new governor targeting embedded systems
running on battery where the energy saving has a higher priority than
servers or desktops. This governor aims to save energy as much as
possible but accepting a performance degradation.

In this way, we can optimize the governor for specific mobile workload
and more generally embedded systems without impacting other platforms.

The governor is based on the irq timings where we predict the next
interrupt occurrences on the current CPU and the next timer. It is
well suited for mobile and more generally embedded systems where the
interrupts are usually pinned on one CPU and where the power is more
important than the performances.

The multimedia applications on the embedded system spawns several
threads which are migrated across the different CPUs and waking
between them up. In order to catch this situation we have also to
track the idle task rescheduling duration with a relative degree of
confidence as the scheduler is involved in the task migrations. The
resched information is in the scope of the governor via the reflect
callback.

The governor begins with a clean foundation basing the prediction on
the irq behavior returned by the irq timings, the timers and the idle
task rescheduling. The advantage of the approach is we have a full
view of the wakeup sources as we identify them separately and then we
can control the situation without relying on biased heuristics.

Despite the naive idle state selection for this first iteration, the
governor provides a performance improvement of 30% for Jankbench
throughout for the same amount of energy than the menu governor and a
similar energy saving for other workloads. There are areas of
improvement for the different workloads which will be optimized
iteratively with non-regression testing for previous identified
workloads on an Android reference platform.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/Kconfig            |  11 ++-
 drivers/cpuidle/governors/Makefile |   1 +
 drivers/cpuidle/governors/mbed.c   | 143 +++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cpuidle/governors/mbed.c

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 8caccbbd7353..6fef94c9bde0 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -4,7 +4,7 @@ config CPU_IDLE
 	bool "CPU idle PM support"
 	default y if ACPI || PPC_PSERIES
 	select CPU_IDLE_GOV_LADDER if (!NO_HZ && !NO_HZ_IDLE)
-	select CPU_IDLE_GOV_MENU if (NO_HZ || NO_HZ_IDLE) && !CPU_IDLE_GOV_TEO
+	select CPU_IDLE_GOV_MENU if (NO_HZ || NO_HZ_IDLE) && !CPU_IDLE_GOV_TEO && !CPU_IDLE_GOV_MBED
 	help
 	  CPU idle is a generic framework for supporting software-controlled
 	  idle processor power management.  It includes modular cross-platform
@@ -32,6 +32,15 @@ config CPU_IDLE_GOV_TEO
 	  Some workloads benefit from using it and it generally should be safe
 	  to use.  Say Y here if you are not happy with the alternatives.
 
+config CPU_IDLE_GOV_MBED
+	bool "Embedded governor"
+	select IRQ_TIMINGS
+	help
+	  The embedded governor is based on irq timings measurements and
+	  pattern research combined with the next timer. This governor
+	  suits very well on embedded systems where the interrupts are
+	  grouped on a single core and the power is the priority.
+
 config DT_IDLE_STATES
 	bool
 
diff --git a/drivers/cpuidle/governors/Makefile b/drivers/cpuidle/governors/Makefile
index 4d8aff5248a8..d4571935575c 100644
--- a/drivers/cpuidle/governors/Makefile
+++ b/drivers/cpuidle/governors/Makefile
@@ -5,3 +5,4 @@
 obj-$(CONFIG_CPU_IDLE_GOV_LADDER) += ladder.o
 obj-$(CONFIG_CPU_IDLE_GOV_MENU) += menu.o
 obj-$(CONFIG_CPU_IDLE_GOV_TEO) += teo.o
+obj-$(CONFIG_CPU_IDLE_GOV_MBED) += mbed.o
diff --git a/drivers/cpuidle/governors/mbed.c b/drivers/cpuidle/governors/mbed.c
new file mode 100644
index 000000000000..8d8c8ba92533
--- /dev/null
+++ b/drivers/cpuidle/governors/mbed.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019, Linaro Ltd
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ */
+#include <linux/cpuidle.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/tick.h>
+#include <linux/interrupt.h>
+#include <linux/sched/clock.h>
+
+struct mbed_device {
+	u64 idle_ema_avg;
+	u64 idle_total;
+	unsigned long last_jiffies;
+};
+
+#define EMA_ALPHA_VAL		64
+#define EMA_ALPHA_SHIFT		7
+#define MAX_RESCHED_INTERVAL_MS	100
+
+static DEFINE_PER_CPU(struct mbed_device, mbed_devices);
+
+static int mbed_ema_new(s64 value, s64 ema_old)
+{
+	if (likely(ema_old))
+		return ema_old + (((value - ema_old) * EMA_ALPHA_VAL) >>
+				  EMA_ALPHA_SHIFT);
+	return value;
+}
+
+static void mbed_reflect(struct cpuidle_device *dev, int index)
+{
+        struct mbed_device *mbed_dev = this_cpu_ptr(&mbed_devices);
+
+	/*
+	 * The idle task was not rescheduled since
+	 * MAX_RESCHED_INTERVAL_MS, let's consider the duration is
+	 * long enough to clear our stats.
+	 */
+	if (time_after(jiffies, mbed_dev->last_jiffies +
+		       msecs_to_jiffies(MAX_RESCHED_INTERVAL_MS)))
+		mbed_dev->idle_ema_avg = 0;
+
+	/*
+	 * Sum all the residencies in order to compute the total
+	 * duration of the idle task.
+	 */
+	mbed_dev->idle_total += dev->last_residency;
+
+	/*
+	 * We exited the idle state with the need_resched() flag, the
+	 * idle task will be rescheduled, so store the duration the
+	 * idle task was scheduled in an exponential moving average and
+	 * reset the total of the idle duration.
+	 */
+	if (need_resched()) {
+		mbed_dev->idle_ema_avg = mbed_ema_new(mbed_dev->idle_total,
+						      mbed_dev->idle_ema_avg);
+		mbed_dev->idle_total = 0;
+		mbed_dev->last_jiffies = jiffies;
+	}
+}
+
+static int mbed_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
+		       bool *stop_tick)
+{
+        struct mbed_device *mbed_dev = this_cpu_ptr(&mbed_devices);
+	int latency_req = cpuidle_governor_latency_req(dev->cpu);
+	int i, index = 0;
+	ktime_t delta_next;
+	u64 now, irq_length, timer_length;
+	u64 idle_duration_us;
+
+	/*
+	 * Get the present time as reference for the next steps
+	 */
+	now = local_clock();
+
+	/*
+	 * Get the next interrupt event giving the 'now' as a
+	 * reference, if the next event appears to have already
+	 * expired then we get the 'now' returned which ends up with a
+	 * zero duration.
+	 */
+	irq_length = irq_timings_next_event(now) - now;
+
+	/*
+	 * Get the timer duration before expiration.
+	 */
+	timer_length = ktime_to_ns(tick_nohz_get_sleep_length(&delta_next));
+
+	/*
+	 * Get the smallest duration between the timer and the irq next event.
+	 */
+	idle_duration_us = min_t(u64, irq_length, timer_length) / NSEC_PER_USEC;
+
+	/*
+	 * Get the idle task duration average if the information is
+	 * available.
+	 */
+	if (mbed_dev->idle_ema_avg)
+		idle_duration_us = min_t(u64, idle_duration_us,
+					 mbed_dev->idle_ema_avg);
+
+	for (i = 0; i < drv->state_count; i++) {
+		struct cpuidle_state *s = &drv->states[i];
+		struct cpuidle_state_usage *su = &dev->states_usage[i];
+
+		if (s->disabled || su->disable)
+			continue;
+
+		if (s->exit_latency > latency_req)
+			break;
+
+		if (s->target_residency > idle_duration_us)
+			break;
+
+		index = i;
+	}
+
+	if (!index)
+		*stop_tick = false;
+
+	return index;
+}
+
+static struct cpuidle_governor mbed_governor = {
+	.name =		"mbed",
+	.rating =	20,
+	.select =	mbed_select,
+	.reflect =	mbed_reflect,
+};
+
+static int __init init_governor(void)
+{
+	irq_timings_enable();
+	return cpuidle_register_governor(&mbed_governor);
+}
+
+postcore_initcall(init_governor);
-- 
2.17.1
