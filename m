From: Lina Iyer <lina.iyer@linaro.org>
Subject: [RFC v2 05/12] timer: Export next wake up of a CPU
Date: Fri, 12 Feb 2016 13:50:31 -0700
Message-ID: <1455310238-8963-6-git-send-email-lina.iyer@linaro.org>
References: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:32937 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbcBLUv1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2016 15:51:27 -0500
Received: by mail-pf0-f172.google.com with SMTP id q63so52948758pfb.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Feb 2016 12:51:27 -0800 (PST)
In-Reply-To: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

Knowing the sleep length of the CPU is useful for the power state
determination on idle. However, when the common sleep time between
multiple CPUs is needed, the sleep length of a CPU is not useful.

By reading the next wake up event of a CPU, governors can determine the
first CPU to wake up (due to timer) amongst a cluster of CPUs and the
sleep time available between the last CPU to idle and the first CPU to
resume. This information is useful to determine if the caches and other
common hardware blocks can also be put in idle during this common period
of inactivity.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
Changes since RFC v1 -
- any CPU can access this variable if that CPU has IRQs disabled

 include/linux/tick.h     | 10 ++++++++++
 kernel/time/tick-sched.c | 13 +++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 97fd4e5..b8a2e06 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -104,6 +104,7 @@ extern void tick_nohz_idle_enter(void);
 extern void tick_nohz_idle_exit(void);
 extern void tick_nohz_irq_exit(void);
 extern ktime_t tick_nohz_get_sleep_length(void);
+extern ktime_t tick_nohz_get_next_wakeup(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
 #else /* !CONFIG_NO_HZ_COMMON */
@@ -118,6 +119,15 @@ static inline ktime_t tick_nohz_get_sleep_length(void)
 
 	return len;
 }
+
+static inline ktime_t tick_nohz_get_next_wakeup(int cpu)
+{
+	ktime_t len = { .tv64 = NSEC_PER_SEC/HZ };
+
+	/* Next wake up is the tick period, assume it starts now */
+	return ktime_add(len, ktime_get());
+}
+
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
 #endif /* !CONFIG_NO_HZ_COMMON */
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 0b17424..f0ddaec 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -888,6 +888,19 @@ ktime_t tick_nohz_get_sleep_length(void)
 	return ts->sleep_length;
 }
 
+/**
+ * tick_nohz_get_next_wakeup - return the next wake up of the CPU
+ *
+ * Called with interrupts disabled on the cpu
+ */
+ktime_t tick_nohz_get_next_wakeup(int cpu)
+{
+	struct clock_event_device *dev =
+			per_cpu(tick_cpu_device.evtdev, cpu);
+
+	return dev->next_event;
+}
+
 static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
 {
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-- 
2.1.4

