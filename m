From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/5] cpuidle: menu: Record tick delta value in struct menu_device
Date: Mon, 13 Aug 2018 00:09:28 +0800
Message-ID: <1534090171-14464-3-git-send-email-leo.yan@linaro.org>
References: <1534090171-14464-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534090171-14464-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Ramesh Thomas <ramesh.thomas@intel.com>, linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
List-Id: linux-pm@vger.kernel.org

Since the tick delta is used in multiple places in menu_select(), it's
better to use single one variable to record this value; furthermore, for
more readable we can refactor the code to split a separate function to
making decision for stopping tick, which also needs to use tick delta
value as one metric for consideration.

To achieve these purposes, this patch adds a new item 'tick_delta_us' in
struct menu_device to record tick delta value.  This patch also is a
preparation for optimization stopping tick in sequential patches.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/cpuidle/governors/menu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index b972db1..83618ab 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -124,6 +124,7 @@ struct menu_device {
 	int             tick_wakeup;
 
 	unsigned int	next_timer_us;
+	unsigned int	tick_delta_us;
 	unsigned int	predicted_us;
 	unsigned int	bucket;
 	unsigned int	correction_factor[BUCKETS];
@@ -305,6 +306,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 
 	/* determine the expected residency time, round up */
 	data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&delta_next));
+	data->tick_delta_us = ktime_to_us(delta_next);
 
 	get_iowait_load(&nr_iowaiters, &cpu_load);
 	data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
@@ -317,7 +319,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	 * timer event for the idle state selection.
 	 */
 	if (tick_nohz_tick_stopped()) {
-		data->predicted_us = ktime_to_us(delta_next);
+		data->predicted_us = data->tick_delta_us;
 		goto select;
 	}
 
@@ -400,11 +402,11 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	 */
 	if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
 	    data->predicted_us < TICK_USEC) && !tick_nohz_tick_stopped()) {
-		unsigned int delta_next_us = ktime_to_us(delta_next);
 
 		*stop_tick = false;
 
-		if (idx > 0 && drv->states[idx].target_residency > delta_next_us) {
+		if (idx > 0 &&
+		    drv->states[idx].target_residency > data->tick_delta_us) {
 			/*
 			 * The tick is not going to be stopped and the target
 			 * residency of the state to be returned is not within
@@ -417,7 +419,8 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 					continue;
 
 				idx = i;
-				if (drv->states[i].target_residency <= delta_next_us)
+				if (drv->states[i].target_residency <=
+				    data->tick_delta_us)
 					break;
 			}
 		}
-- 
2.7.4
