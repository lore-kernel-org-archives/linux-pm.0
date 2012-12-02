From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 20/34] thermal: user_space: Add missing static storage class specifiers
Date: Sun,  2 Dec 2012 22:44:54 +0800
Message-ID: <1354459508-3707-20-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:29043 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814Ab2LBOpk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:40 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Sachin Kamat <sachin.kamat@linaro.org>, Zhang Rui <rui.zhang@intel.com>

From: Sachin Kamat <sachin.kamat@linaro.org>

Fixes the following sparse warnings:
drivers/thermal/user_space.c:38:5: warning:
symbol 'notify_user_space' was not declared. Should it be static?
drivers/thermal/user_space.c:46:25: warning:
symbol 'thermal_gov_user_space' was not declared. Should it be static?

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Acked-by: Durgadoss R <durgadoss.r@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/user_space.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/user_space.c b/drivers/thermal/user_space.c
index fb246b90..6bbb380 100644
--- a/drivers/thermal/user_space.c
+++ b/drivers/thermal/user_space.c
@@ -35,7 +35,7 @@
  *
  * This function notifies the user space through UEvents.
  */
-int notify_user_space(struct thermal_zone_device *tz, int trip)
+static int notify_user_space(struct thermal_zone_device *tz, int trip)
 {
 	mutex_lock(&tz->lock);
 	kobject_uevent(&tz->device.kobj, KOBJ_CHANGE);
@@ -43,7 +43,7 @@ int notify_user_space(struct thermal_zone_device *tz, int trip)
 	return 0;
 }
 
-struct thermal_governor thermal_gov_user_space = {
+static struct thermal_governor thermal_gov_user_space = {
 	.name		= "user_space",
 	.throttle	= notify_user_space,
 	.owner		= THIS_MODULE,
-- 
1.7.7.6

