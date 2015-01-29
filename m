From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH] thermal: step_wise: spelling fixes
Date: Thu, 29 Jan 2015 09:57:21 -0800
Message-ID: <1422554241-22782-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36272 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbbA2R5f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 12:57:35 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/thermal/step_wise.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index fdd1f523a1ed..5a0f12d08e8b 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -45,7 +45,7 @@
  *    c. if the trend is THERMAL_TREND_RAISE_FULL, do nothing
  *    d. if the trend is THERMAL_TREND_DROP_FULL, use lower limit,
  *       if the cooling state already equals lower limit,
- *       deactive the thermal instance
+ *       deactivate the thermal instance
  */
 static unsigned long get_target_state(struct thermal_instance *instance,
 				enum thermal_trend trend, bool throttle)
@@ -169,7 +169,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 }
 
 /**
- * step_wise_throttle - throttles devices asscciated with the given zone
+ * step_wise_throttle - throttles devices associated with the given zone
  * @tz - thermal_zone_device
  * @trip - the trip point
  * @trip_type - type of the trip point
-- 
1.9.1

