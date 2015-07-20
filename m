From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH v2] idle: move latency tracing stop/start calls deeper inside the idle loop
Date: Mon, 20 Jul 2015 18:34:50 +0200
Message-ID: <1437410090-3747-1-git-send-email-l.stach@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de, patchwork-lst@pengutronix.de
List-Id: linux-pm@vger.kernel.org

Make sure to stop tracing only once we are past a point where all
latency tracing events have been processed (irqs are not enabled
again). This has the slight advantage of capturing more latency
related events in the idle path, but most importantly it makes sure
that latency tracing doesn't get re-enabled inadvertently when
new events are coming in.

This makes the irqsoff latency tracer useful again, as we stop
capturing CPU sleep time as IRQ latency.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v2: Also stop timings on enter_freeze(). Since start_critical_timings()
does reinit timestamps from a clock that may depend on the tick we call
it only after the tick is unfrozen.
---
 drivers/cpuidle/cpuidle.c |  4 ++++
 kernel/sched/idle.c       | 14 +++++---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index e8e2775c3821..a5d9f2e470ea 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -118,6 +118,7 @@ static void enter_freeze_proper(struct cpuidle_driver *drv,
 	 * cpuidle mechanism enables interrupts and doing that with timekeeping
 	 * suspended is generally unsafe.
 	 */
+	stop_critical_timings();
 	drv->states[index].enter_freeze(dev, drv, index);
 	WARN_ON(!irqs_disabled());
 	/*
@@ -126,6 +127,7 @@ static void enter_freeze_proper(struct cpuidle_driver *drv,
 	 * critical sections, so tell RCU about that.
 	 */
 	RCU_NONIDLE(tick_unfreeze());
+	start_critical_timings();
 }
 
 /**
@@ -190,7 +192,9 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	trace_cpu_idle_rcuidle(index, dev->cpu);
 	time_start = ktime_get();
 
+	stop_critical_timings();
 	entered_state = target_state->enter(dev, drv, index);
+	start_critical_timings();
 
 	time_end = ktime_get();
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 594275ed2620..8f177c73ae19 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -83,10 +83,13 @@ void __weak arch_cpu_idle(void)
  */
 void default_idle_call(void)
 {
-	if (current_clr_polling_and_test())
+	if (current_clr_polling_and_test()) {
 		local_irq_enable();
-	else
+	} else {
+		stop_critical_timings();
 		arch_cpu_idle();
+		start_critical_timings();
+	}
 }
 
 static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
@@ -141,12 +144,6 @@ static void cpuidle_idle_call(void)
 	}
 
 	/*
-	 * During the idle period, stop measuring the disabled irqs
-	 * critical sections latencies
-	 */
-	stop_critical_timings();
-
-	/*
 	 * Tell the RCU framework we are entering an idle section,
 	 * so no more rcu read side critical sections and one more
 	 * step to the grace period
@@ -198,7 +195,6 @@ exit_idle:
 		local_irq_enable();
 
 	rcu_idle_exit();
-	start_critical_timings();
 }
 
 DEFINE_PER_CPU(bool, cpu_dead_idle);
-- 
2.1.4
