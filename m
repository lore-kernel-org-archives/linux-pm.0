From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] cpuidle : handle clockevent notify from the cpuidle framework
Date: Wed, 20 Mar 2013 16:57:13 +0100
Message-ID: <1363795033-26445-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34860 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab3CTP5T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Mar 2013 11:57:19 -0400
Received: by mail-wi0-f180.google.com with SMTP id hi8so2007519wib.13
        for <linux-pm@vger.kernel.org>; Wed, 20 Mar 2013 08:57:18 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org, lenb@kernel.org

When a cpu enters a deep idle state, the local timers are stopped and
the time framework falls back to the timer device used as a broadcast
timer.

The different cpuidle drivers are calling clockevents_notify ENTER/EXIT
when the idle state stops the local timer.

The proposed patch introduces a new flag CPUIDLE_FLAG_TIMER_STOP to let
the cpuidle framework to call clockevents_notify instead of duplicating
again and again these lines in all the cpuidle drivers.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c |    9 +++++++++
 include/linux/cpuidle.h   |    1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index eba6929..c500370 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -8,6 +8,7 @@
  * This code is licenced under the GPL.
  */
 
+#include <linux/clockchips.h>
 #include <linux/kernel.h>
 #include <linux/mutex.h>
 #include <linux/sched.h>
@@ -146,12 +147,20 @@ int cpuidle_idle_call(void)
 
 	trace_cpu_idle_rcuidle(next_state, dev->cpu);
 
+	if (drv->states[next_state].flags & CPUIDLE_FLAG_TIMER_STOP)
+		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER,
+				   &dev->cpu);
+
 	if (cpuidle_state_is_coupled(dev, drv, next_state))
 		entered_state = cpuidle_enter_state_coupled(dev, drv,
 							    next_state);
 	else
 		entered_state = cpuidle_enter_state(dev, drv, next_state);
 
+	if (drv->states[next_state].flags & CPUIDLE_FLAG_TIMER_STOP)
+		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT,
+				   &dev->cpu);
+
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
 
 	/* give the governor an opportunity to reflect on the outcome */
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 480c14d..a837b33 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -57,6 +57,7 @@ struct cpuidle_state {
 /* Idle State Flags */
 #define CPUIDLE_FLAG_TIME_VALID	(0x01) /* is residency time measurable? */
 #define CPUIDLE_FLAG_COUPLED	(0x02) /* state applies to multiple cpus */
+#define CPUIDLE_FLAG_TIMER_STOP (0x04)  /* timer is stopped on this state */
 
 #define CPUIDLE_DRIVER_FLAGS_MASK (0xFFFF0000)
 
-- 
1.7.9.5

