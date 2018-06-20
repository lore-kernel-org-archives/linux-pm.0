From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v8 06/26] timer: Export next wakeup time of a CPU
Date: Wed, 20 Jun 2018 19:22:06 +0200
Message-ID: <20180620172226.15012-7-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Lina Iyer <lina.iyer@linaro.org>

Knowing the sleep duration of CPUs, is known to be needed while selecting
the most energy efficient idle state for a CPU or a group of CPUs.

However, to be able to compute the sleep duration, we need to know at what
time the next expected wakeup is for the CPU. Therefore, let's export this
information via a new function, tick_nohz_get_next_wakeup(). Following
changes make use of it.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/tick.h     |  8 ++++++++
 kernel/time/tick-sched.c | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 55388ab45fd4..e48f6b26b425 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -125,6 +125,7 @@ extern bool tick_nohz_idle_got_tick(void);
 extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
 extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
+extern ktime_t tick_nohz_get_next_wakeup(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
 
@@ -151,6 +152,13 @@ static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 	*delta_next = TICK_NSEC;
 	return *delta_next;
 }
+
+static inline ktime_t tick_nohz_get_next_wakeup(int cpu)
+{
+	/* Next wake up is the tick period, assume it starts now */
+	return ktime_add(ktime_get(), TICK_NSEC);
+}
+
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
 
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index da9455a6b42b..f380bb4f0744 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1089,6 +1089,16 @@ unsigned long tick_nohz_get_idle_calls(void)
 	return ts->idle_calls;
 }
 
+/**
+ * tick_nohz_get_next_wakeup - return the next wake up of the CPU
+ */
+ktime_t tick_nohz_get_next_wakeup(int cpu)
+{
+	struct clock_event_device *dev = per_cpu(tick_cpu_device.evtdev, cpu);
+
+	return dev->next_event;
+}
+
 static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
 {
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-- 
2.17.1
