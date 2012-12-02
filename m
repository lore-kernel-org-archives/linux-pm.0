From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 18/34] thermal: step_wise: Add missing static storage class specifiers
Date: Sun,  2 Dec 2012 22:44:52 +0800
Message-ID: <1354459508-3707-18-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:29043 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631Ab2LBOpi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:38 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Sachin Kamat <sachin.kamat@linaro.org>, Zhang Rui <rui.zhang@intel.com>

From: Sachin Kamat <sachin.kamat@linaro.org>

Fixes the following sparse warnings:
drivers/thermal/step_wise.c:153:5: warning:
symbol 'step_wise_throttle' was not declared. Should it be static?
drivers/thermal/step_wise.c:172:25: warning:
symbol 'thermal_gov_step_wise' was not declared. Should it be static?

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Acked-by: Durgadoss R <durgadoss.r@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/step_wise.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index 3f9cfcf..1242cff 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -150,7 +150,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
  * step. If the zone is 'cooling down' it brings back the performance of
  * the devices by one step.
  */
-int step_wise_throttle(struct thermal_zone_device *tz, int trip)
+static int step_wise_throttle(struct thermal_zone_device *tz, int trip)
 {
 	struct thermal_instance *instance;
 
@@ -169,7 +169,7 @@ int step_wise_throttle(struct thermal_zone_device *tz, int trip)
 	return 0;
 }
 
-struct thermal_governor thermal_gov_step_wise = {
+static struct thermal_governor thermal_gov_step_wise = {
 	.name		= DEFAULT_THERMAL_GOVERNOR,
 	.throttle	= step_wise_throttle,
 	.owner		= THIS_MODULE,
-- 
1.7.7.6

