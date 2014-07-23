From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/2] cpuidle: Remove time measurement in poll state
Date: Wed, 23 Jul 2014 19:02:48 +0200
Message-ID: <1406134968-6483-2-git-send-email-daniel.lezcano@linaro.org>
References: <1406134968-6483-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:48120 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793AbaGWRCu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jul 2014 13:02:50 -0400
Received: by mail-wg0-f41.google.com with SMTP id z12so1495483wgg.12
        for <linux-pm@vger.kernel.org>; Wed, 23 Jul 2014 10:02:49 -0700 (PDT)
In-Reply-To: <1406134968-6483-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org

The time measurement is already done in the cpuidle framework in the
'cpuidle_enter_state' function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/driver.c |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 9634f20..e431d11 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -182,10 +182,6 @@ static void __cpuidle_driver_init(struct cpuidle_driver *drv)
 static int poll_idle(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int index)
 {
-	ktime_t	t1, t2;
-	s64 diff;
-
-	t1 = ktime_get();
 	local_irq_enable();
 	if (!current_set_polling_and_test()) {
 		while (!need_resched())
@@ -193,13 +189,6 @@ static int poll_idle(struct cpuidle_device *dev,
 	}
 	current_clr_polling();
 
-	t2 = ktime_get();
-	diff = ktime_to_us(ktime_sub(t2, t1));
-	if (diff > INT_MAX)
-		diff = INT_MAX;
-
-	dev->last_residency = (int) diff;
-
 	return index;
 }
 
-- 
1.7.9.5

