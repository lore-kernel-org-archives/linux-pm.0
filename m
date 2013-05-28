From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] thermal: step_wise: cdev only needs update on a new target state
Date: Tue, 28 May 2013 14:55:48 +0800
Message-ID: <1369724148-15087-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:27644
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932984Ab3E1G5M (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 May 2013 02:57:12 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, Shawn Guo <shawn.guo@linaro.org>

The cooling device only needs update on a new target state.  Since we
already check old target in thermal_zone_trip_update(), we can do one
more check to see if it's a new target state.  If not, we can reasonably
save some uncecesary code execution.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
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


