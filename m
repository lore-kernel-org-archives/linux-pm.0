From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/3] cpuidle: Store the idle start time stamp
Date: Wed, 15 Apr 2015 12:00:22 +0200
Message-ID: <1429092024-20498-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:33106 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372AbbDOKAf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2015 06:00:35 -0400
Received: by wgin8 with SMTP id n8so40886311wgi.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2015 03:00:33 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, nicolas.pitre@linaro.org

The scheduler uses the idle timestamp stored in the struct rq to retrieve the
time when the cpu went idle in order to find the idlest cpu. Unfortunately
this information is wrong as it does not have the same meaning from the cpuidle
point of view. The idle_stamp in the struct rq gives the information when the
idle task has been scheduled while the idle task could be interrupted several
times and the cpu going through an idle/wakeup multiple times.

Add the idle start time in the idle state structure.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c | 10 ++++++----
 include/linux/cpuidle.h   |  1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 080bd2d..1220dac 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -158,21 +158,23 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	int entered_state;
 
 	struct cpuidle_state *target_state = &drv->states[index];
-	ktime_t time_start, time_end;
 	s64 diff;
 
 	trace_cpu_idle_rcuidle(index, dev->cpu);
-	time_start = ktime_get();
+
+	target_state->idle_stamp = ktime_to_us(ktime_get());
 
 	entered_state = target_state->enter(dev, drv, index);
 
-	time_end = ktime_get();
+	diff = ktime_to_us(ktime_sub_us(ktime_get(), target_state->idle_stamp));
+
+	target_state->idle_stamp = 0;
+
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
 
 	if (!cpuidle_state_is_coupled(dev, drv, entered_state))
 		local_irq_enable();
 
-	diff = ktime_to_us(ktime_sub(time_end, time_start));
 	if (diff > INT_MAX)
 		diff = INT_MAX;
 
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 306178d..2facce6 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -44,6 +44,7 @@ struct cpuidle_state {
 	int		power_usage; /* in mW */
 	unsigned int	target_residency; /* in US */
 	bool		disabled; /* disabled on all CPUs */
+	u64             idle_stamp;
 
 	int (*enter)	(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
-- 
1.9.1

