From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 3/6] Thermal: fix step_wise handling of THERMAL_TREND_DROPPING
Date: Mon, 17 Jun 2013 21:24:25 +0800
Message-ID: <1371475468-5351-4-git-send-email-rui.zhang@intel.com>
References: <1371475468-5351-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50832 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932357Ab3FQNYu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Jun 2013 09:24:50 -0400
In-Reply-To: <1371475468-5351-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, durgadoss.r@intel.com, shawn.guo@linaro.org, ruslan.ruslichenko@ti.com, Zhang Rui <rui.zhang@intel.com>

Fixes two problems in the THERMAL_TREND_DROPPING
handling code in step_wise governor.
1. When the temperature is higher than the trip point,
we should not deactivate the thermal instance.
2. When the temperature is lower than the trip point,
we should not activate the thermal instance.

Also rephrase the code a bit to make it more readable.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/step_wise.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index d89e781..f0cc5e5 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -75,13 +75,19 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 			next_target = instance->upper;
 		break;
 	case THERMAL_TREND_DROPPING:
-		if (cur_state == instance->lower) {
-			if (!throttle)
-				next_target = THERMAL_NO_TARGET;
+		if (throttle) {
+			if (cur_state <= instance->lower)
+				next_target = instance->lower;
+			else
+				next_target = cur_state > instance->upper ?
+					instance->upper : cur_state - 1;
 		} else {
-			next_target = cur_state - 1;
-			if (next_target > instance->upper)
-				next_target = instance->upper;
+			if (cur_state <= instance->lower ||
+			    instance->target == THERMAL_NO_TARGET)
+				next_target = THERMAL_NO_TARGET;
+			else
+				next_target = cur_state > instance->upper ?
+					instance->upper : cur_state - 1;
 		}
 		break;
 	case THERMAL_TREND_DROP_FULL:
-- 
1.7.9.5

