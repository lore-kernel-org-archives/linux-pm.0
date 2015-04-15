From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/3] cpuidle: Add some comments in the cpuidle_enter function
Date: Wed, 15 Apr 2015 12:00:23 +0200
Message-ID: <1429092024-20498-2-git-send-email-daniel.lezcano@linaro.org>
References: <1429092024-20498-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:32769 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435AbbDOKAg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2015 06:00:36 -0400
Received: by wiax7 with SMTP id x7so108076434wia.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2015 03:00:35 -0700 (PDT)
In-Reply-To: <1429092024-20498-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, nicolas.pitre@linaro.org

The code is a bit poor in comments. Fix that by adding some comments in the
cpuidle enter function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 1220dac..5e6c6be 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -162,19 +162,50 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 
 	trace_cpu_idle_rcuidle(index, dev->cpu);
 
+	/*
+	 * Store the idle start time for this cpu, this information
+	 * will be used by cpuidle to measure how long the cpu has
+	 * been idle and by the scheduler to prevent to wake it up too
+	 * early
+	 */
 	target_state->idle_stamp = ktime_to_us(ktime_get());
 
+	/*
+	 * The enter to the low level idle routine. This call will block
+	 * until an interrupt occurs meaning it is the end of the idle
+	 * period
+	 */
 	entered_state = target_state->enter(dev, drv, index);
 
+	/*
+	 * Measure as soon as possible the duration of the idle
+	 * period. It MUST be done before re-enabling the interrupt in
+	 * order to prevent to add in the idle time measurement the
+	 * interrupt handling duration
+	 */
 	diff = ktime_to_us(ktime_sub_us(ktime_get(), target_state->idle_stamp));
 
+	/*
+	 * Reset the idle time stamp as the scheduler may think the cpu is idle
+	 * while it is in the process of waking up
+	 */
 	target_state->idle_stamp = 0;
 
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
 
+	/*
+	 * The cpuidle_enter_coupled uses the cpuidle_enter function.
+	 * Don't re-enable the interrupts and let the enter_coupled
+	 * function to wait for all cpus to sync and to enable the
+	 * interrupts again from there
+	 */
 	if (!cpuidle_state_is_coupled(dev, drv, entered_state))
 		local_irq_enable();
 
+	/*
+	 * The idle duration will be casted to an integer, prevent to
+	 * overflow by setting a boundary to INT_MAX
+	 */
 	if (diff > INT_MAX)
 		diff = INT_MAX;
 
-- 
1.9.1

