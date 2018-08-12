From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 5/5] cpuidle: menu: Change to compare prediction with tick delta
Date: Mon, 13 Aug 2018 00:09:31 +0800
Message-ID: <1534090171-14464-6-git-send-email-leo.yan@linaro.org>
References: <1534090171-14464-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534090171-14464-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Ramesh Thomas <ramesh.thomas@intel.com>, linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
List-Id: linux-pm@vger.kernel.org

The tick stopping decision is made by comparing the prediction with
TICK_USEC, if the prediction is shorter than TICK_USEC then this means
the CPU is likely waken up before the tick event so it's pointless to
stop tick.  In reality when make the decision, though the tick period is
fixed to TICK_USEC, but the CPU is randomly entering/exiting idle
states so the next tick delta is float and should be in the range
[0, TICK_USEC].  This can result in wrong decision for stopping tick,
e.g. if the prediction is 3ms idle duration and we compare with
TICK_USEC=4000 (HZ=250), this can lead to a wrong conclusion is the tick
event will be later than the prediction duration so the governor doesn't
stop the tick; but in fact the tick is expired for 1ms, so the tick
wakes up the CPU ahead and the CPU cannot stay in idle for 3ms as
expected.

Alternatively, 'data->tick_delta_us' is for the tick delta value and
it's a accurate estimation for tick event coming.  This patch changes to
compare prediction with tick delta rather than comparing with the static
tick interval.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/cpuidle/governors/menu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 566c65c..06d5942 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -300,10 +300,11 @@ static bool menu_decide_stopping_tick(struct cpuidle_driver *drv,
 		return false;
 
 	/*
-	 * Don't stop the tick if the prediction is shorter than the
-	 * tick period length.
+	 * If the prediction is shorter than the next tick event, means
+	 * the CPU will be waken up before the tick event; don't stop
+	 * the tick.
 	 */
-	if (data->predicted_us < TICK_USEC)
+	if (data->predicted_us < data->tick_delta_us)
 		return false;
 
 	/*
-- 
2.7.4
