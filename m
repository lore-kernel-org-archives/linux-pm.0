From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 3/5] cpuidle: menu: Provide menu_decide_stopping_tick()
Date: Mon, 13 Aug 2018 00:09:29 +0800
Message-ID: <1534090171-14464-4-git-send-email-leo.yan@linaro.org>
References: <1534090171-14464-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534090171-14464-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Ramesh Thomas <ramesh.thomas@intel.com>, linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
List-Id: linux-pm@vger.kernel.org

This patch is only for code refactoring and without functional change.
It introduces a new function menu_decide_stopping_tick(); we can use
this function to focus on making stopping tick decision.  With moving
out stopping tick decision code, it lets the below piece code is
simplized only for the idle state calibration and thus save one indent
level in the loop.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/cpuidle/governors/menu.c | 76 ++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 26 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 83618ab..4f02207 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -276,6 +276,37 @@ static unsigned int get_typical_interval(struct menu_device *data)
 }
 
 /**
+ * menu_decide_stopping_tick - decides if need to stopping tick
+ * @drv: cpuidle driver containing state data
+ * @data: menu_device structure pointer
+ * @idx: the candidate idle state index
+ */
+static bool menu_decide_stopping_tick(struct cpuidle_driver *drv,
+				      struct menu_device *data, int idx)
+{
+	/*
+	 * If the tick has been stopped yet, force to stop it afterwards and
+	 * don't give chance to set *stop_tick to false.
+	 */
+	if (tick_nohz_tick_stopped())
+		return true;
+
+	/* Don't stop the tick if the selected state is a polling one */
+	if (drv->states[idx].flags & CPUIDLE_FLAG_POLLING)
+		return false;
+
+	/*
+	 * Don't stop the tick if the prediction is shorter than the
+	 * tick period length.
+	 */
+	if (data->predicted_us < TICK_USEC)
+		return false;
+
+	/* Otherwise, let's stop the tick at this time. */
+	return true;
+}
+
+/**
  * menu_select - selects the next idle state to enter
  * @drv: cpuidle driver containing state data
  * @dev: the CPU
@@ -396,33 +427,26 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	if (idx == -1)
 		idx = 0; /* No states enabled. Must use 0. */
 
-	/*
-	 * Don't stop the tick if the selected state is a polling one or if the
-	 * expected idle duration is shorter than the tick period length.
-	 */
-	if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
-	    data->predicted_us < TICK_USEC) && !tick_nohz_tick_stopped()) {
-
-		*stop_tick = false;
+	*stop_tick = menu_decide_stopping_tick(drv, data, idx);
 
-		if (idx > 0 &&
-		    drv->states[idx].target_residency > data->tick_delta_us) {
-			/*
-			 * The tick is not going to be stopped and the target
-			 * residency of the state to be returned is not within
-			 * the time until the next timer event including the
-			 * tick, so try to correct that.
-			 */
-			for (i = idx - 1; i >= 0; i--) {
-			    if (drv->states[i].disabled ||
-			        dev->states_usage[i].disable)
-					continue;
-
-				idx = i;
-				if (drv->states[i].target_residency <=
-				    data->tick_delta_us)
-					break;
-			}
+	/* Calibrate the idle state according to the tick event. */
+	if (!*stop_tick && idx > 0 &&
+	    drv->states[idx].target_residency > data->tick_delta_us) {
+		/*
+		 * The tick is not going to be stopped and the target
+		 * residency of the state to be returned is not within
+		 * the time until the next timer event including the
+		 * tick, so try to correct that.
+		 */
+		for (i = idx - 1; i >= 0; i--) {
+			if (drv->states[i].disabled ||
+			    dev->states_usage[i].disable)
+				continue;
+
+			idx = i;
+			if (drv->states[i].target_residency <=
+			    data->tick_delta_us)
+				break;
 		}
 	}
 
-- 
2.7.4
