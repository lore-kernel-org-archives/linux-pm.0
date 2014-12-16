From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/3] cpuidle menu: Better idle duration measurement without using CPUIDLE_FLAG_TIME_INVALID
Date: Tue, 16 Dec 2014 01:52:06 -0500
Message-ID: <c55877aa13886c660da484118a96117f939553e3.1418712225.git.len.brown@intel.com>
References: <1418712728-2193-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1418712728-2193-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

When menu sees CPUIDLE_FLAG_TIME_INVALID, it ignores its timestamps,
and assumes that idle lasted as long as the time till next predicted
timer expiration.

But if an interrupt was seen and serviced before that duration,
it would actually be more accurate to use the measured time
rather than rounding up to the next predicted timer expiration.

And if an interrupt is seen and serviced such that the mesured time
exceeds the time till next predicted timer expiration, then
truncating to that expiration is the right thing to do --
since we can never stay idle past that timer expiration.

So the code can do a better job without
checking for CPUIDLE_FLAG_TIME_INVALID.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/governors/menu.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 659d7b0..4058079 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -396,8 +396,8 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	 * power state and occurrence of the wakeup event.
 	 *
 	 * If the entered idle state didn't support residency measurements,
-	 * we are basically lost in the dark how much time passed.
-	 * As a compromise, assume we slept for the whole expected time.
+	 * we use them anyway if they are short, and if long,
+	 * truncate to the whole expected time.
 	 *
 	 * Any measured amount of time will include the exit latency.
 	 * Since we are interested in when the wakeup begun, not when it
@@ -405,22 +405,17 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	 * the measured amount of time is less than the exit latency,
 	 * assume the state was never reached and the exit latency is 0.
 	 */
-	if (unlikely(target->flags & CPUIDLE_FLAG_TIME_INVALID)) {
-		/* Use timer value as is */
-		measured_us = data->next_timer_us;
 
-	} else {
-		/* Use measured value */
-		measured_us = cpuidle_get_last_residency(dev);
+	/* measured value */
+	measured_us = cpuidle_get_last_residency(dev);
 
-		/* Deduct exit latency */
-		if (measured_us > target->exit_latency)
-			measured_us -= target->exit_latency;
+	/* Deduct exit latency */
+	if (measured_us > target->exit_latency)
+		measured_us -= target->exit_latency;
 
-		/* Make sure our coefficients do not exceed unity */
-		if (measured_us > data->next_timer_us)
-			measured_us = data->next_timer_us;
-	}
+	/* Make sure our coefficients do not exceed unity */
+	if (measured_us > data->next_timer_us)
+		measured_us = data->next_timer_us;
 
 	/* Update our correction ratio */
 	new_factor = data->correction_factor[data->bucket];
-- 
2.1.2.451.g98349e5

