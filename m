From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/5] cpuidle: menu: Clean up variables usage in menu_select()
Date: Mon, 13 Aug 2018 00:09:27 +0800
Message-ID: <1534090171-14464-2-git-send-email-leo.yan@linaro.org>
References: <1534090171-14464-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534090171-14464-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Ramesh Thomas <ramesh.thomas@intel.com>, linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
List-Id: linux-pm@vger.kernel.org

The usage for two variables 'data->predicted_us' and 'expected_interval'
in menu_select() are confused, especially these two variables are
assigned with each other: firstly 'data->predicted_us' is assigned to
the minimum value between 'data->predicted_us' and 'expected_interval',
so it presents the prediction period for taking account different
factors and include consideration for expected interval; but later
'data->predicted_us' is assigned back to 'expected_interval' and from
then on the function uses 'expected_interval' to select idle state; this
results in 'expected_interval' has two different semantics between the
top half and the bottom half of the same function.

This patch is to clean up the usage of these two variables, we always
use 'data->predicted_us' to present the idle duration predictions and
it can be used to compare with idle state target residency or tick
boundary for choosing idle state; we purely use 'expected_interval' to
record the expected interval value, which is mainly for interval
interrupt estimation.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/cpuidle/governors/menu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 5eb7d6f..b972db1 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -363,7 +363,6 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		latency_req = interactivity_req;
 
 select:
-	expected_interval = data->predicted_us;
 	/*
 	 * Find the idle state with the lowest power while satisfying
 	 * our constraints.
@@ -386,7 +385,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 			 * expected idle duration so that the tick is retained
 			 * as long as that target residency is low enough.
 			 */
-			expected_interval = drv->states[idx].target_residency;
+			data->predicted_us = drv->states[idx].target_residency;
 			break;
 		}
 		idx = i;
@@ -400,7 +399,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	 * expected idle duration is shorter than the tick period length.
 	 */
 	if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
-	    expected_interval < TICK_USEC) && !tick_nohz_tick_stopped()) {
+	    data->predicted_us < TICK_USEC) && !tick_nohz_tick_stopped()) {
 		unsigned int delta_next_us = ktime_to_us(delta_next);
 
 		*stop_tick = false;
-- 
2.7.4
