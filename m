From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v11 6/8] time: tick-sched: Remove tick_nohz_get_sleep_length()
Date: Tue, 26 Feb 2019 15:54:13 +0100
Message-ID: <20190226145415.19411-7-ulf.hansson@linaro.org>
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226145415.19411-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

There are no longer any users of tick_nohz_get_sleep_length(), so let's
drop it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
[Ulf: Clarified information in changelog]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v11:
	- New patch.

---
 include/linux/tick.h     |  6 ------
 kernel/time/tick-sched.c | 39 ---------------------------------------
 2 files changed, 45 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 5b10a0e4acbb..1a0158736072 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -124,7 +124,6 @@ extern void tick_nohz_idle_enter(void);
 extern void tick_nohz_idle_exit(void);
 extern void tick_nohz_irq_exit(void);
 extern bool tick_nohz_idle_got_tick(void);
-extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
 extern ktime_t tick_nohz_get_next_timer(void);
 extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
@@ -153,11 +152,6 @@ static inline ktime_t tick_nohz_get_next_timer(void)
 	return tick_nohz_get_next_hrtimer();
 }
 
-static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
-{
-	*delta_next = TICK_NSEC;
-	return *delta_next;
-}
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
 
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 9966be665074..a376c7db26ce 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1088,45 +1088,6 @@ ktime_t tick_nohz_get_next_timer(void)
 	return min_t(u64, next_hrtimer, next_timer);
 }
 
-/**
- * tick_nohz_get_sleep_length - return the expected length of the current sleep
- * @delta_next: duration until the next event if the tick cannot be stopped
- *
- * Called from power state control code with interrupts disabled
- */
-ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
-{
-	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
-	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
-	int cpu = smp_processor_id();
-	/*
-	 * The idle entry time is expected to be a sufficient approximation of
-	 * the current time at this point.
-	 */
-	ktime_t now = ts->idle_entrytime;
-	ktime_t next_event;
-
-	WARN_ON_ONCE(!ts->inidle);
-
-	*delta_next = ktime_sub(dev->next_event, now);
-
-	if (!can_stop_idle_tick(cpu, ts))
-		return *delta_next;
-
-	next_event = tick_nohz_next_event(ts, cpu);
-	if (!next_event)
-		return *delta_next;
-
-	/*
-	 * If the next highres timer to expire is earlier than next_event, the
-	 * idle governor needs to know that.
-	 */
-	next_event = min_t(u64, next_event,
-			   hrtimer_next_event_without(&ts->sched_timer));
-
-	return ktime_sub(next_event, now);
-}
-
 /**
  * tick_nohz_get_idle_calls_cpu - return the current idle calls counter value
  * for a particular CPU.
-- 
2.17.1
