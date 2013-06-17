From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 5/6] Thermal: step_wise handle THERMAL_TREND_STABLE explicitly
Date: Mon, 17 Jun 2013 21:24:27 +0800
Message-ID: <1371475468-5351-6-git-send-email-rui.zhang@intel.com>
References: <1371475468-5351-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50832 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932529Ab3FQNY7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Jun 2013 09:24:59 -0400
In-Reply-To: <1371475468-5351-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, durgadoss.r@intel.com, shawn.guo@linaro.org, ruslan.ruslichenko@ti.com, Zhang Rui <rui.zhang@intel.com>

The current code does not show the handling of
THERMAL_TREND_STABLE explicitly, which may be confusing.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/step_wise.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index 84d6e90..53b56e6 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -36,6 +36,7 @@
  *       for this trip point
  *    d. if the trend is THERMAL_TREND_DROP_FULL, use lower limit
  *       for this trip point
+ *    e. if the trend is THERMAL_TREND_STABLE, do nothing.
  * If the temperature is lower than a trip point,
  *    a. if the trend is THERMAL_TREND_RAISING, do nothing
  *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
@@ -44,6 +45,7 @@
  *    c. if the trend is THERMAL_TREND_RAISE_FULL, do nothing
  *    d. if the trend is THERMAL_TREND_DROP_FULL, deactive
  *	 the thermal instance
+ *    e. if the trend is THERMAL_TREND_STABLE, do nothing.
  */
 static unsigned long get_target_state(struct thermal_instance *instance,
 				enum thermal_trend trend, bool throttle)
@@ -95,6 +97,8 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 		else
 			next_target = THERMAL_NO_TARGET;
 		break;
+	case THERMAL_TREND_STABLE:
+		/* Do nothing */
 	default:
 		break;
 	}
-- 
1.7.9.5

