From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 19/34] thermal: fair_share: Add missing static storage class specifiers
Date: Sun,  2 Dec 2012 22:44:53 +0800
Message-ID: <1354459508-3707-19-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:29043 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752879Ab2LBOpj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:39 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Sachin Kamat <sachin.kamat@linaro.org>, Zhang Rui <rui.zhang@intel.com>

From: Sachin Kamat <sachin.kamat@linaro.org>

Fixes the following sparse warnings:
drivers/thermal/fair_share.c:80:5: warning:
symbol 'fair_share_throttle' was not declared. Should it be static?
drivers/thermal/fair_share.c:111:25: warning:
symbol 'thermal_gov_fair_share' was not declared. Should it be static?

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Acked-by: Durgadoss R <durgadoss.r@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/fair_share.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
index 5d3a7a3..792479f 100644
--- a/drivers/thermal/fair_share.c
+++ b/drivers/thermal/fair_share.c
@@ -77,7 +77,7 @@ static long get_target_state(struct thermal_zone_device *tz,
  *	(Heavily assumes the trip points are in ascending order)
  * new_state of cooling device = P3 * P2 * P1
  */
-int fair_share_throttle(struct thermal_zone_device *tz, int trip)
+static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
 {
 	const struct thermal_zone_params *tzp;
 	struct thermal_cooling_device *cdev;
@@ -108,7 +108,7 @@ int fair_share_throttle(struct thermal_zone_device *tz, int trip)
 	return 0;
 }
 
-struct thermal_governor thermal_gov_fair_share = {
+static struct thermal_governor thermal_gov_fair_share = {
 	.name		= "fair_share",
 	.throttle	= fair_share_throttle,
 	.owner		= THIS_MODULE,
-- 
1.7.7.6

