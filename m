From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH V2] cpuidle: Change ktime_get() with local_clock()
Date: Thu, 21 Apr 2016 10:56:30 +0200
Message-ID: <1461228990-28957-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: peterz@infradead.org, mingo@kernel.org, "open list:CPUIDLE DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The ktime_get() can have a non negligeable overhead, use local_clock()
instead.

In order to test the difference between ktime_get() and local_clock(),
a quick hack has been added to trigger, via debugfs, 10000 times a
call to ktime_get() and local_clock() and measure the elapsed time.

Then the average value, the min and max is computed for each call.

>From userspace, the test above was called 100 times every 2 seconds.

So, ktime_get() and local_clock() have been called 1000000 times in
total.

The results are:

ktime_get():
============
 * average: 101 ns (stddev: 27.4)
 * maximum: 38313 ns
 * minimum: 65 ns

local_clock():
==============
 * average: 60 ns (stddev: 9.8)
 * maximum: 13487 ns
 * minimum: 46 ns

The local_clock() is faster and more stable.

Even if it is a drop in the ocean, changing the ktime_get() by the
local_clock() allows to save 80ns at idle time (entry + exit). And
in some circumstances, especially when there are several CPUs racing
for the clock access, we save tens of microseconds.

The idle duration resulting from a diff is converted from nanosec to
microsec. This could be done with integer division (div 1000) - which is
an expensive operation or by 10 bits shifting (div 1024) - which is fast
but unprecise.

The following table gives some results at the limits.

 ------------------------------------------
|   nsec   |   div(1000)   |   div(1024)   |
 ------------------------------------------
|   1e3    |        1 usec |      976 nsec |
 ------------------------------------------
|   1e6    |     1000 usec |      976 usec |
 ------------------------------------------
|   1e9    |  1000000 usec |   976562 usec |
 ------------------------------------------

There is a linear deviation of 2.34%. This loss of precision is acceptable
in the context of the resulting diff which is used for statistics. These
ones are processed to guess estimate an approximation of the duration of the
next idle period which ends up into an idle state selection. The selection
criteria takes into account the next duration based on large intervals,
represented by the idle state's target residency.

The 2^10 division is enough because the approximation regarding the 1e3
division is lost in all the approximations done for the next idle duration
computation.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
  V2:
      - Explained in the changelog why div1024 is enough precise for our
        purpose.
---
 drivers/cpuidle/cpuidle.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index f996efc..78447bc 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -173,7 +173,7 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 
 	struct cpuidle_state *target_state = &drv->states[index];
 	bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
-	ktime_t time_start, time_end;
+	u64 time_start, time_end;
 	s64 diff;
 
 	/*
@@ -195,13 +195,13 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	sched_idle_set_state(target_state);
 
 	trace_cpu_idle_rcuidle(index, dev->cpu);
-	time_start = ktime_get();
+	time_start = local_clock();
 
 	stop_critical_timings();
 	entered_state = target_state->enter(dev, drv, index);
 	start_critical_timings();
 
-	time_end = ktime_get();
+	time_end = local_clock();
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
 
 	/* The cpu is no longer idle or about to enter idle. */
@@ -217,7 +217,11 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	if (!cpuidle_state_is_coupled(drv, entered_state))
 		local_irq_enable();
 
-	diff = ktime_to_us(ktime_sub(time_end, time_start));
+	/*
+	 * local_clock() returns the time in nanosecond, let's shift
+	 * by 10 (divide by 1024) to have microsecond based time.
+	 */
+	diff = (time_end - time_start) >> 10;
 	if (diff > INT_MAX)
 		diff = INT_MAX;
 
-- 
1.9.1
