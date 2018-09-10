From: Fieah Lim <kw@fieahl.im>
Subject: [PATCH v2] cpuidle: enter_state: Don't needlessly calculate diff time
Date: Tue, 11 Sep 2018 01:39:53 +0800
Message-ID: <20180910173953.10113-1-kw@fieahl.im>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, "open list:CPUIDLE DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: Fieah Lim <kw@fieahl.im>
List-Id: linux-pm@vger.kernel.org

Currently we use ktime_us_delta() to calculate last residency and
state usage unconditionally, it makes no sense to do this calculation 
when we fails to enter any idle state.
It can be optimize by moving the calculation after entered_state >= 0

While at it, merge those comment blocks into one and remove a
space between type casting of diff.

This patch has no functional changes.

Signed-off-by: Fieah Lim <kw@fieahl.im>
---
Changes from v1:
 - Rewrite changelog as Rafael J. Wysocki suggested
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
