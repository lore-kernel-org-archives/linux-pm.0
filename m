From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/2] cpuidle: Remove TIME_INVALID flag
Date: Fri, 21 Nov 2014 10:29:52 +0100
Message-ID: <1416562192-14114-2-git-send-email-daniel.lezcano@linaro.org>
References: <1416562192-14114-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38385 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754592AbaKUJaD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Nov 2014 04:30:03 -0500
Received: by mail-wi0-f178.google.com with SMTP id hi2so8101105wib.17
        for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2014 01:29:59 -0800 (PST)
In-Reply-To: <1416562192-14114-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-acpi@vger.kernel.org

The time measurement is always valid for all the drivers for all the idle
states. This flag is no longer needed.

Remove it as well as the code using it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/governors/ladder.c |  8 ++------
 drivers/cpuidle/governors/menu.c   | 25 ++++++++-----------------
 include/linux/cpuidle.h            |  2 --
 3 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index 37263d9..55a1fc9 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -79,12 +79,8 @@ static int ladder_select_state(struct cpuidle_driver *drv,
 
 	last_state = &ldev->states[last_idx];
 
-	if (!(drv->states[last_idx].flags & CPUIDLE_FLAG_TIME_INVALID)) {
-		last_residency = cpuidle_get_last_residency(dev) - \
-					 drv->states[last_idx].exit_latency;
-	}
-	else
-		last_residency = last_state->threshold.promotion_time + 1;
+	last_residency = cpuidle_get_last_residency(dev) - \
+				 drv->states[last_idx].exit_latency;
 
 	/* consider promotion */
 	if (last_idx < drv->state_count - 1 &&
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 659d7b0..2191ea0 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -395,32 +395,23 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	 * Try to figure out how much time passed between entry to low
 	 * power state and occurrence of the wakeup event.
 	 *
-	 * If the entered idle state didn't support residency measurements,
-	 * we are basically lost in the dark how much time passed.
-	 * As a compromise, assume we slept for the whole expected time.
-	 *
 	 * Any measured amount of time will include the exit latency.
 	 * Since we are interested in when the wakeup begun, not when it
 	 * was completed, we must subtract the exit latency. However, if
 	 * the measured amount of time is less than the exit latency,
 	 * assume the state was never reached and the exit latency is 0.
 	 */
-	if (unlikely(target->flags & CPUIDLE_FLAG_TIME_INVALID)) {
-		/* Use timer value as is */
-		measured_us = data->next_timer_us;
 
-	} else {
-		/* Use measured value */
-		measured_us = cpuidle_get_last_residency(dev);
+	/* Use measured value */
+	measured_us = cpuidle_get_last_residency(dev);
 
-		/* Deduct exit latency */
-		if (measured_us > target->exit_latency)
-			measured_us -= target->exit_latency;
+	/* Deduct exit latency */
+	if (measured_us > target->exit_latency)
+		measured_us -= target->exit_latency;
 
-		/* Make sure our coefficients do not exceed unity */
-		if (measured_us > data->next_timer_us)
-			measured_us = data->next_timer_us;
-	}
+	/* Make sure our coefficients do not exceed unity */
+	if (measured_us > data->next_timer_us)
+		measured_us = data->next_timer_us;
 
 	/* Update our correction ratio */
 	new_factor = data->correction_factor[data->bucket];
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index a07e087..d697b9e 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -53,7 +53,6 @@ struct cpuidle_state {
 };
 
 /* Idle State Flags */
-#define CPUIDLE_FLAG_TIME_INVALID	(0x01) /* is residency time measurable? */
 #define CPUIDLE_FLAG_COUPLED	(0x02) /* state applies to multiple cpus */
 #define CPUIDLE_FLAG_TIMER_STOP (0x04)  /* timer is stopped on this state */
 
@@ -90,7 +89,6 @@ DECLARE_PER_CPU(struct cpuidle_device, cpuidle_dev);
  * cpuidle_get_last_residency - retrieves the last state's residency time
  * @dev: the target CPU
  *
- * NOTE: this value is invalid if CPUIDLE_FLAG_TIME_INVALID is set
  */
 static inline int cpuidle_get_last_residency(struct cpuidle_device *dev)
 {
-- 
1.9.1

