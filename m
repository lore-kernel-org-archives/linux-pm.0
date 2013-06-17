From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 4/6] Thermal: fix step_wise handling of THERMAL_TREND_DROP_EFULL
Date: Mon, 17 Jun 2013 21:24:26 +0800
Message-ID: <1371475468-5351-5-git-send-email-rui.zhang@intel.com>
References: <1371475468-5351-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50832 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932357Ab3FQNYy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Jun 2013 09:24:54 -0400
In-Reply-To: <1371475468-5351-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, durgadoss.r@intel.com, shawn.guo@linaro.org, ruslan.ruslichenko@ti.com, Zhang Rui <rui.zhang@intel.com>

Change the step_wise cooling algorithm to handle
THERMAL_TREND_DROP_FULL a bit differently.

When the temperature is higher than the trip point,
we should always use the instance->lower as the next target state.
When the temperature is lower than the trip point,
we should always deactive the thermal instance.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/step_wise.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index f0cc5e5..84d6e90 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -42,9 +42,8 @@
  *       state for this trip point, if the cooling state already
  *       equals lower limit, deactivate the thermal instance
  *    c. if the trend is THERMAL_TREND_RAISE_FULL, do nothing
- *    d. if the trend is THERMAL_TREND_DROP_FULL, use lower limit,
- *       if the cooling state already equals lower limit,
- *       deactive the thermal instance
+ *    d. if the trend is THERMAL_TREND_DROP_FULL, deactive
+ *	 the thermal instance
  */
 static unsigned long get_target_state(struct thermal_instance *instance,
 				enum thermal_trend trend, bool throttle)
@@ -91,11 +90,10 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 		}
 		break;
 	case THERMAL_TREND_DROP_FULL:
-		if (cur_state == instance->lower) {
-			if (!throttle)
-				next_target = THERMAL_NO_TARGET;
-		} else
+		if (throttle)
 			next_target = instance->lower;
+		else
+			next_target = THERMAL_NO_TARGET;
 		break;
 	default:
 		break;
-- 
1.7.9.5

