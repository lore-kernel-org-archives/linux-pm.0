From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 1/6] thermal: step_wise: cdev only needs update on a new target state
Date: Mon, 17 Jun 2013 21:24:23 +0800
Message-ID: <1371475468-5351-2-git-send-email-rui.zhang@intel.com>
References: <1371475468-5351-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50832 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756202Ab3FQNYl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Jun 2013 09:24:41 -0400
In-Reply-To: <1371475468-5351-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, durgadoss.r@intel.com, shawn.guo@linaro.org, ruslan.ruslichenko@ti.com, Zhang Rui <rui.zhang@intel.com>

From: Shawn Guo <shawn.guo@linaro.org>

The cooling device only needs update on a new target state.  Since we
already check old target in thermal_zone_trip_update(), we can do one
more check to see if it's a new target state.  If not, we can reasonably
save some uncecesary code execution.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/step_wise.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index 4d4ddae..0afbd86 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -133,6 +133,9 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 		old_target = instance->target;
 		instance->target = get_target_state(instance, trend, throttle);
 
+		if (old_target == instance->target)
+			continue;
+
 		/* Activate a passive thermal instance */
 		if (old_target == THERMAL_NO_TARGET &&
 			instance->target != THERMAL_NO_TARGET)
-- 
1.7.9.5

