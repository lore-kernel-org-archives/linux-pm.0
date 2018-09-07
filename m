From: Fieah Lim <kw@fieahl.im>
Subject: [PATCH] cpuidle: Remove unnecessary wrapper cpuidle_get_last_residency()
Date: Sat,  8 Sep 2018 04:08:38 +0800
Message-ID: <20180907200838.4966-1-kw@fieahl.im>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, open list <linux-kernel@vger.kernel.org>, "open list:CPUIDLE DRIVERS" <linux-pm@vger.kernel.org>
Cc: Fieah Lim <kw@fieahl.im>
List-Id: linux-pm@vger.kernel.org

There's no magic inside, let's just make it more intuitive.

Signed-off-by: Fieah Lim <kw@fieahl.im>
---
 drivers/cpuidle/governors/ladder.c |  2 +-
 drivers/cpuidle/governors/menu.c   |  2 +-
 include/linux/cpuidle.h            | 10 ----------
 3 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index 704880a6612a..f0dddc66af26 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -80,7 +80,7 @@ static int ladder_select_state(struct cpuidle_driver *drv,
 
 	last_state = &ldev->states[last_idx];
 
-	last_residency = cpuidle_get_last_residency(dev) - drv->states[last_idx].exit_latency;
+	last_residency = dev->last_residency - drv->states[last_idx].exit_latency;
 
 	/* consider promotion */
 	if (last_idx < drv->state_count - 1 &&
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 1aef60d160eb..715520e339da 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -492,7 +492,7 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 		measured_us = 9 * MAX_INTERESTING / 10;
 	} else {
 		/* measured value */
-		measured_us = cpuidle_get_last_residency(dev);
+		measured_us = dev->last_residency;
 
 		/* Deduct exit latency */
 		if (measured_us > 2 * target->exit_latency)
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 4325d6fdde9b..d262f620890e 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -99,16 +99,6 @@ struct cpuidle_device {
 DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
 DECLARE_PER_CPU(struct cpuidle_device, cpuidle_dev);
 
-/**
- * cpuidle_get_last_residency - retrieves the last state's residency time
- * @dev: the target CPU
- */
-static inline int cpuidle_get_last_residency(struct cpuidle_device *dev)
-{
-	return dev->last_residency;
-}
-
-
 /****************************
  * CPUIDLE DRIVER INTERFACE *
  ****************************/
-- 
2.18.0
