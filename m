From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 4/5] cpuidle: menu: Don't stay in shallow state for a long time
Date: Mon, 13 Aug 2018 00:09:30 +0800
Message-ID: <1534090171-14464-5-git-send-email-leo.yan@linaro.org>
References: <1534090171-14464-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534090171-14464-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Ramesh Thomas <ramesh.thomas@intel.com>, linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
List-Id: linux-pm@vger.kernel.org

To avoid staying in a shallow state for a long time, the menu governor
relies on not stopping tick when detects the prediction is shorter than
the tick event.  This is just luckily to cover most cases but cannot say
it is completely safe.  For example, if the prediction is 2000us and the
TICK_USEC=1000 so it's impossible to meet the condition
'data->predicted_us < TICK_USEC' and this lead to stop the tick for a
shallow state; finally the CPU is possible to stay in this shallow state
for very long time.

This patch checks the candidate idle state isn't deepest one and find if
the timer will come after more than 2 times of the maximum target
residency, though the governor selects a shallow state according to
prediction, due the timer is most reliable waken up source but it will
come very late, so the CPU has chance to stay in the shallow state
for a long time; the patch doesn't stop the tick for this case so can
avoid powernightmares issue.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/cpuidle/governors/menu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 4f02207..566c65c 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -284,6 +284,10 @@ static unsigned int get_typical_interval(struct menu_device *data)
 static bool menu_decide_stopping_tick(struct cpuidle_driver *drv,
 				      struct menu_device *data, int idx)
 {
+	int max_target_residency;
+
+	max_target_residency = drv->states[drv->state_count-1].target_residency;
+
 	/*
 	 * If the tick has been stopped yet, force to stop it afterwards and
 	 * don't give chance to set *stop_tick to false.
@@ -302,6 +306,23 @@ static bool menu_decide_stopping_tick(struct cpuidle_driver *drv,
 	if (data->predicted_us < TICK_USEC)
 		return false;
 
+	/*
+	 * The candidate idle state isn't deepest one, on the other hand
+	 * the most reliable wakeup source is timer (compare against to
+	 * interrupts) says it will come after more than 2 times of maximum
+	 * target residency, this means the CPU has risk to stay in shallow
+	 * state for more than 2 times of maximum target residency.
+	 *
+	 * It's acceptable to stay in the shallow state at this time but we
+	 * need to ensure to wake up the CPU by tick to check if has better
+	 * choice.  Finally it can have choice to select deeper state and
+	 * avoid the CPU staying in shallow state for very long time and
+	 * without any wake up event.
+	 */
+	if (idx < drv->state_count - 1 &&
+	    data->next_timer_us > max_target_residency * 2)
+		return false;
+
 	/* Otherwise, let's stop the tick at this time. */
 	return true;
 }
-- 
2.7.4
