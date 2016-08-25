From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v4 09/16] timer: Export next wake up of a CPU
Date: Thu, 25 Aug 2016 14:03:18 -0600
Message-ID: <1472155405-41841-10-git-send-email-lina.iyer@linaro.org>
References: <1472155405-41841-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1472155405-41841-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

Knowing the sleep length of the CPU is useful for the power state
determination on idle. The value is relative to the time when the call
was invoked by the CPU. This doesn't work well when there is a need to
know when the actual wakeup is.

By reading the next wake up event of a CPU, governors can determine the
first CPU to wake up (due to timer) amongst a cluster of CPUs and the
sleep time available between the last CPU to idle and the first CPU to
resume. This information is useful to determine if the caches and other
common hardware blocks can also be put in idle during this common period
of inactivity.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 include/linux/tick.h     |  7 +++++++
 kernel/time/tick-sched.c | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 62be0786..92fa4b0 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -117,6 +117,7 @@ extern void tick_nohz_idle_enter(void);
 extern void tick_nohz_idle_exit(void);
 extern void tick_nohz_irq_exit(void);
 extern ktime_t tick_nohz_get_sleep_length(void);
+extern ktime_t tick_nohz_get_next_wakeup(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
 #else /* !CONFIG_NO_HZ_COMMON */
@@ -131,6 +132,12 @@ static inline ktime_t tick_nohz_get_sleep_length(void)
 
 	return len;
 }
+
+static inline ktime_t tick_nohz_get_next_wakeup(int cpu)
+{
+	return tick_next_period;
+}
+
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
 #endif /* !CONFIG_NO_HZ_COMMON */
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 536ada8..5c7ac17 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -979,6 +979,17 @@ ktime_t tick_nohz_get_sleep_length(void)
 	return ts->sleep_length;
 }
 
+/**
+ * tick_nohz_get_next_wakeup - return the next wake up of the CPU
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
2.7.4
