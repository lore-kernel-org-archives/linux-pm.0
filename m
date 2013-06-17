From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 6/6] Thermal: step_wise: set next cooling target explicitly
Date: Mon, 17 Jun 2013 21:24:28 +0800
Message-ID: <1371475468-5351-7-git-send-email-rui.zhang@intel.com>
References: <1371475468-5351-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50832 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932529Ab3FQNZD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Jun 2013 09:25:03 -0400
In-Reply-To: <1371475468-5351-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, durgadoss.r@intel.com, shawn.guo@linaro.org, ruslan.ruslichenko@ti.com, Zhang Rui <rui.zhang@intel.com>

Set the next target state explicitly for each thermal trend,
in step_wise governor, to provide more readability, and to
follow the cooling algorithm description strictly.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/step_wise.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index 53b56e6..ffa553f 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -60,7 +60,6 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 	 * cdev in use to determine the next_target.
 	 */
 	cdev->ops->get_cur_state(cdev, &cur_state);
-	next_target = instance->target;
 
 	switch (trend) {
 	case THERMAL_TREND_RAISING:
@@ -69,11 +68,14 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 				    (cur_state + 1) : instance->upper;
 			if (next_target < instance->lower)
 				next_target = instance->lower;
-		}
+		} else
+			next_target = instance->target;
 		break;
 	case THERMAL_TREND_RAISE_FULL:
 		if (throttle)
 			next_target = instance->upper;
+		else
+			next_target = instance->target;
 		break;
 	case THERMAL_TREND_DROPPING:
 		if (throttle) {
@@ -99,7 +101,10 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 		break;
 	case THERMAL_TREND_STABLE:
 		/* Do nothing */
+		next_target = instance->target;
+		break;
 	default:
+		next_target = instance->target;
 		break;
 	}
 
-- 
1.7.9.5

