From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] cpuidle: Change ktime_get() with local_clock()
Date: Thu, 14 Apr 2016 21:23:54 +0200
Message-ID: <1460661834-5683-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37449 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbcDNTYM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Apr 2016 15:24:12 -0400
Received: by mail-wm0-f45.google.com with SMTP id n3so2558856wmn.0
        for <linux-pm@vger.kernel.org>; Thu, 14 Apr 2016 12:24:11 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: peterz@infradead.org, mingo@kernel.org, "open list:CPUIDLE DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

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

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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

