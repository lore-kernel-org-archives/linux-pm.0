From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH V3 2/2] sched: idle: IRQ based next prediction for idle period
Date: Tue, 16 Feb 2016 16:43:03 +0100
Message-ID: <1455637383-14412-2-git-send-email-daniel.lezcano@linaro.org>
References: <1455637383-14412-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455637383-14412-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de
Cc: peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

Many IRQs are quiet most of the time, or they tend to come in bursts of
fairly equal time intervals within each burst. It is therefore possible
to detect those IRQs with stable intervals and guestimate when the next
IRQ event is most likely to happen.

Examples of such IRQs may include audio related IRQs where the FIFO size
and/or DMA descriptor size with the sample rate create stable intervals,
block devices during large data transfers, etc.  Even network streaming
of multimedia content creates patterns of periodic network interface IRQs
in some cases.

This patch adds code to compute the mean interval and variance for each IRQ
over a window of time intervals between IRQ events. Those statistics can
be used to assist cpuidle in selecting the most appropriate sleep state
by predicting the most likely time for the next interrupt.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/Kconfig   |   9 ++
 kernel/sched/Makefile     |   1 +
 kernel/sched/idle-sched.c | 280 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 290 insertions(+)
 create mode 100644 kernel/sched/idle-sched.c

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 7e48eb5..d64445b 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -23,6 +23,15 @@ config CPU_IDLE_GOV_LADDER
 config CPU_IDLE_GOV_MENU
 	bool "Menu governor (for tickless system)"
 
+config CPU_IDLE_GOV_SCHED
+	bool "Sched idle governor"
+	select IRQ_TIMINGS
+	help
+	  Enables an irq timings tracking mechanism to track the wakeup sources
+	  of the platform.
+
+	  If you are unsure, it is safe to say N.
+
 config DT_IDLE_STATES
 	bool
 
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 6768797..f7d5a35 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_SCHED_AUTOGROUP) += auto_group.o
 obj-$(CONFIG_SCHEDSTATS) += stats.o
 obj-$(CONFIG_SCHED_DEBUG) += debug.o
 obj-$(CONFIG_CGROUP_CPUACCT) += cpuacct.o
+obj-$(CONFIG_CPU_IDLE_GOV_SCHED) += idle-sched.o
diff --git a/kernel/sched/idle-sched.c b/kernel/sched/idle-sched.c
new file mode 100644
index 0000000..4dc03da
--- /dev/null
+++ b/kernel/sched/idle-sched.c
@@ -0,0 +1,280 @@
+/*
+ *  Copyright (C) 2016 Linaro Ltd, Daniel Lezcano <daniel.lezcano@linaro.org>
+ *                                 Nicolas Pitre <nicolas.pitre@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/cpuidle.h>
+#include <linux/interrupt.h>
+#include <linux/ktime.h>
+#include <linux/tick.h>
+
+/**
+ * irqt_mean - compute the average
+ *
+ * @irqt: the irq timings structure
+ *
+ * Returns an u32 corresponding to the mean value, or zero if there is
+ * no data
+ */
+static inline u32 irqt_mean(struct irq_timings *irqt)
+{
+	return irqt->sum >> IRQ_TIMINGS_SHIFT;
+}
+
+/**
+ * irqt_variance - compute the variance
+ *
+ * @irqt: the irq timings structure
+ *
+ * Returns an u64 corresponding to the variance, or zero if there is
+ * no data
+ */
+static u64 irqt_variance(struct irq_timings *irqt, u32 mean)
+{
+	int i;
+	u64 variance = 0;
+
+	/*
+	 * The variance is the sum of the squared difference to the
+	 * average divided by the number of elements.
+	 */
+	for (i = 0; i < IRQ_TIMINGS_SIZE; i++) {
+		s32 diff = irqt->values[i] - mean;
+		variance += (s64)diff * diff;
+	}
+
+	return variance >> IRQ_TIMINGS_SHIFT;
+}
+
+/**
+ * next_irq_event - returns the next irq event
+ *
+ * Returns a guess estimate remaining time before an interrupt
+ * occurs. The type s64 corresponding in a duration in microsecond.
+ *
+ * The value is always greater or equal to zero. In case, there is no
+ * possible prediction, S64_MAX is returned.
+ */
+static s64 next_irq_event(void)
+{
+	struct irq_timings *irqt;
+	unsigned int irq = 0;
+	u64 variance, now;
+	s64 diff, next = 0, min = S64_MAX;
+	u32 interval, mean;
+	s32 deviation;
+
+	now = local_clock();
+
+	/*
+	 * Search for the earliest expected interruption.
+	 */
+	rcu_read_lock();
+	while ((irqt = irqtiming_get_next(&irq))) {
+
+		/*
+		 * No values available.
+		 */
+		if (!irqt->timestamp)
+			continue;
+
+		/*
+		 * This interrupt last triggered more than a second ago.
+		 * It is definitely not predictable for our purpose anymore.
+		 */
+		if ((now - irqt->timestamp) > NSEC_PER_SEC)
+			continue;
+
+		/*
+		 * If the mean value is null, just ignore this wakeup
+		 * source.
+		 */
+		mean = irqt_mean(irqt);
+		if (!mean)
+			continue;
+
+		variance = irqt_variance(irqt, mean);
+		/*
+		 * We want to check the last interval is:
+		 *
+		 *  mean - stddev < interval < mean + stddev
+		 *
+		 * That simplifies to:
+		 *
+		 * -stddev < interval - mean < stddev
+		 *
+		 * abs(interval - mean) < stddev
+		 *
+		 * The standard deviation is the sqrt of the variance:
+		 *
+		 * abs(interval - mean) < sqrt(variance)
+		 *
+		 * and we want to avoid the sqrt, so we square the
+		 * equation:
+		 *
+		 * (interval - mean)^2 < variance
+		 *
+		 * So if the latest value of the stats complies with
+		 * this condition, then the wakeup source is
+		 * considered predictable and can be used to predict
+		 * the next event.
+		 */
+		interval = irqt->values[irqt->w_index];
+		deviation = interval - mean;
+		if ((s64)deviation * deviation > variance)
+			continue;
+
+		/*
+		 * Let's compute the next event: the wakeup source is
+		 * considered predictable, we add the average interval
+		 * time added to the latest interruption event
+		 * time. Note the timestamp is stored in nsec while
+		 * the mean time is microsec.
+		 */
+		next = irqt->timestamp + (mean << 10);
+
+		/*
+		 * If the interrupt is supposed to happen before the
+		 * minimum time, then it becomes the minimum.
+		 */
+		if (next < min)
+			min = next;
+	}
+	rcu_read_unlock();
+
+	/*
+	 * There is no prediction for any interrupt, so we return
+	 * S64_MAX.
+	 */
+	if (!next)
+		return S64_MAX;
+
+	/*
+	 * At this point, we have our prediction but the caller is
+	 * expecting the remaining time before the next event, so
+	 * compute the expected sleep length.
+	 */
+	diff = min - now;
+
+	/*
+	 * min and now are nanosecond units, let's convert to
+	 * microsec the result of the diff.
+	 */
+	diff >>= 10;
+
+	/*
+	 * The result could be negative for different reasons:
+	 * - the prediction is incorrect but we can't do anything here
+	 *   except assuming the interrupt occured effectively.
+	 *    
+	 * - the prediction was too near now and expired while we were
+	 *   in this function.
+	 *
+	 * In those cases, we return 0. Otherwise we return the expected
+	 * duration before an interrupt occurs.
+	 */
+	return diff > 0 ? diff : 0;
+}
+
+/**
+ * sched_idle_next_wakeup - Predict the next wakeup on the current cpu
+ *
+ * The next event on the cpu is based on a statistic approach of the
+ * interrupt events and the timer deterministic value. From the timer
+ * or the irqs, we return the one expected to occur first.
+ *
+ * Returns the expected remaining idle time before being woken up by
+ * an interruption.
+ */
+s64 sched_idle_next_wakeup(void)
+{
+	s64 next_timer = ktime_to_us(tick_nohz_get_sleep_length());
+	s64 next_irq = next_irq_event();
+
+	return min(next_irq, next_timer);
+}
+
+/**
+ * sched_idle - go to idle for a specified amount of time
+ *
+ * @duration: the idle duration time
+ * @latency: the latency constraint
+ *
+ * Returns 0 on success, < 0 otherwise.
+ */
+int sched_idle(s64 duration, unsigned int latency)
+{
+	struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
+	struct cpuidle_state_usage *su;
+	struct cpuidle_state *s;
+	int i, ret = 0, index = -1;
+
+	rcu_idle_enter();
+
+	/*
+	 * No cpuidle driver is available, let's use the default arch
+	 * idle function.
+	 */
+	if (cpuidle_not_available(drv, dev))
+		goto default_idle;
+
+	/*
+	 * Find the idle state with the lowest power while satisfying
+	 * our constraints. We will save energy if the duration of the
+	 * idle time is bigger than the target residency which is the
+	 * break even point. The choice will be modulated by the
+	 * latency.
+	 */
+	for (i = 0; i < drv->state_count; i++) {
+
+		s = &drv->states[i];
+
+		su = &dev->states_usage[i];
+
+		if (s->disabled || su->disable)
+			continue;
+		if (s->target_residency > duration)
+			continue;
+		if (s->exit_latency > latency)
+			continue;
+
+		index = i;
+	}
+
+	/*
+	 * The idle task must be scheduled, it is pointless to go to
+	 * idle, just re-enable the interrupt and return.
+	 */
+	if (current_clr_polling_and_test()) {
+		local_irq_enable();
+		goto out;
+	}
+
+	if (index < 0) {
+		/*
+		 * No idle callbacks fulfilled the constraints, jump
+		 * to the default function like there wasn't any
+		 * cpuidle driver.
+		 */
+		goto default_idle;
+	} else {
+		/*
+		 * Enter the idle state previously returned by the
+		 * governor decision.  This function will block until
+		 * an interrupt occurs and will take care of
+		 * re-enabling the local interrupts
+		 */
+		return cpuidle_enter(drv, dev, index);
+	}
+
+default_idle:
+	default_idle_call();
+out:
+	rcu_idle_exit();
+	return ret;
+}
-- 
1.9.1
