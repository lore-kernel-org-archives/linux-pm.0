From: Fieah Lim <kw@fieahl.im>
Subject: [PATCH] cpuidle: enter_state: Don't needlessly calculate diff time
Date: Sat,  8 Sep 2018 02:54:48 +0800
Message-ID: <20180907185448.30987-1-kw@fieahl.im>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, "open list:CPUIDLE DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: Fieah Lim <kw@fieahl.im>
List-Id: linux-pm@vger.kernel.org

ktime_us_delta() is not that cheap on some platform,
and I think this is also the right thing to do.
While at it, fix some coding style as well.

Signed-off-by: Fieah Lim <kw@fieahl.im>
---
 drivers/cpuidle/cpuidle.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 6df894d65d9e..5f6b2c9b6555 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -247,21 +247,20 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	if (!cpuidle_state_is_coupled(drv, index))
 		local_irq_enable();
 
-	diff = ktime_us_delta(time_end, time_start);
-	if (diff > INT_MAX)
-		diff = INT_MAX;
-
-	dev->last_residency = (int) diff;
+	dev->last_residency = 0;
 
 	if (entered_state >= 0) {
-		/* Update cpuidle counters */
-		/* This can be moved to within driver enter routine
+		/* Update cpuidle counters
+		 * This can be moved to within driver enter routine,
 		 * but that results in multiple copies of same code.
 		 */
+		diff = ktime_us_delta(time_end, time_start);
+		if (diff > INT_MAX)
+			diff = INT_MAX;
+
+		dev->last_residency = (int)diff;
 		dev->states_usage[entered_state].time += dev->last_residency;
 		dev->states_usage[entered_state].usage++;
-	} else {
-		dev->last_residency = 0;
 	}
 
 	return entered_state;
-- 
2.18.0
