From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/3] cpuidle ladder: Better idle duration measurement without using CPUIDLE_FLAG_TIME_INVALID
Date: Tue, 16 Dec 2014 01:52:07 -0500
Message-ID: <83e27d4a9f387aa9781de927ea7f436f388de7bd.1418712225.git.len.brown@intel.com>
References: <1418712728-2193-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yh0-f43.google.com ([209.85.213.43]:36595 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaLPGwS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Dec 2014 01:52:18 -0500
In-Reply-To: <1418712728-2193-1-git-send-email-lenb@kernel.org>
In-Reply-To: <c55877aa13886c660da484118a96117f939553e3.1418712225.git.len.brown@intel.com>
References: <c55877aa13886c660da484118a96117f939553e3.1418712225.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>

From: Len Brown <len.brown@intel.com>

When the ladder governor sees the CPUIDLE_FLAG_TIME_INVALID flag,
it unconditionally causes a state promotion by setting last_residency
to a number higher than the state's promotion_time:

last_residency = last_state->threshold.promotion_time + 1

It does this for fear that cpuidle_get_last_residency()
will be in-accurate, because cpuidle_enter_state() invoked
a state with CPUIDLE_FLAG_TIME_INVALID.

But the only state with CPUIDLE_FLAG_TIME_INVALID is
acpi_safe_halt(), which may return well after its actual
idle duration because it enables interrupts, so cpuidle_enter_state()
also measures interrupt service time.

So what?  In ladder, a huge invalid last_residency has exactly
the same effect as the current code -- it unconditionally
causes a state promotion.

In the case where the idle residency plus measured interrupt
handling time is less than the state's demotion_time -- we should
use that timestamp to give ladder a chance to demote, rather than
unconditionally promoting.

This can be done by simply ignoring the CPUIDLE_FLAG_TIME_INVALID,
and using the "invalid" time, as it is either equal to what we are
doing today, or better.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/governors/ladder.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index 37263d9..401c010 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -79,12 +79,7 @@ static int ladder_select_state(struct cpuidle_driver *drv,
 
 	last_state = &ldev->states[last_idx];
 
-	if (!(drv->states[last_idx].flags & CPUIDLE_FLAG_TIME_INVALID)) {
-		last_residency = cpuidle_get_last_residency(dev) - \
-					 drv->states[last_idx].exit_latency;
-	}
-	else
-		last_residency = last_state->threshold.promotion_time + 1;
+	last_residency = cpuidle_get_last_residency(dev) - drv->states[last_idx].exit_latency;
 
 	/* consider promotion */
 	if (last_idx < drv->state_count - 1 &&
-- 
2.1.2.451.g98349e5

