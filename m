From: Leo Yan <leo.yan@linaro.org>
Subject: [RESEND PATCH v1 2/2] cpuidle: menu: Dismiss tick impaction on correction factors
Date: Fri, 10 Aug 2018 01:20:03 +0800
Message-ID: <1533835203-5789-3-git-send-email-leo.yan@linaro.org>
References: <1533835203-5789-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533835203-5789-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
List-Id: linux-pm@vger.kernel.org

If the idle duration predictor detects the tick is triggered, and with
meeting the condition 'data->next_timer_us > TICK_USEC', it will give a
big compensation for the 'measured' interval; this is purposed to avoid
artificially small correction factor values.  Unfortunately, this still
cannot cover all cases of the tick impaction on correction factors,
e.g. if the predicted next event is less than ITCK_USEC, then all
wakening up by the ticks will be taken as usual case and reducing exit
latency, as results the tick events heavily impacts the correction
factors.  Moreover, the coming tick sometimes is very soon, especially
at the first time when the CPU becomes idle the tick expire time might
be vary, so ticks can introduce big deviation on correction factors.

If idle governor deliberately doesn't stop the tick timer, the tick
event is coming as expected with fixed interval, so the tick event is
predictable; if the tick event is coming early than other normal timer
event and other possible wakeup events, we need to dismiss the tick
impaction on correction factors, this can let the correction factor
array is purely used for other wakeup events correctness rather than
sched tick.

This patch is to check if it's a tick wakeup, it takes the CPU can
stay in the idle state for enough time so it gives high compensation
for the measured' interval, this can avoid tick impaction on the
correction factor array.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/cpuidle/governors/menu.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 2ce4068..43cbde3 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -525,15 +525,13 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	 * assume the state was never reached and the exit latency is 0.
 	 */
 
-	if (data->tick_wakeup && data->next_timer_us > TICK_USEC) {
+	if (data->tick_wakeup) {
 		/*
-		 * The nohz code said that there wouldn't be any events within
-		 * the tick boundary (if the tick was stopped), but the idle
-		 * duration predictor had a differing opinion.  Since the CPU
-		 * was woken up by a tick (that wasn't stopped after all), the
-		 * predictor was not quite right, so assume that the CPU could
-		 * have been idle long (but not forever) to help the idle
-		 * duration predictor do a better job next time.
+		 * Since the CPU was woken up by a tick (that wasn't stopped
+		 * after all), the predictor was not quite right, so assume
+		 * that the CPU could have been idle long (but not forever)
+		 * to help the idle duration predictor do a better job next
+		 * time.
 		 */
 		measured_us = 9 * MAX_INTERESTING / 10;
 	} else {
-- 
2.7.4
