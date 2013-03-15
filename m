From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC patch 01/11] cpuidle : handle clockevent notify from the cpuidle framework
Date: Fri, 15 Mar 2013 15:27:00 +0100
Message-ID: <1363357630-22214-2-git-send-email-daniel.lezcano@linaro.org>
References: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36706 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754769Ab3COO1S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Mar 2013 10:27:18 -0400
Received: by mail-wi0-f169.google.com with SMTP id l13so670281wie.0
        for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2013 07:27:17 -0700 (PDT)
In-Reply-To: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, rjw@sisk.pl, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch

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

