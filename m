From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v2] thermal: Fix binding problem when there is thermal zone params
Date: Wed, 6 Nov 2013 14:30:13 +0800
Message-ID: <1383719413-4142-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2977 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135Ab3KFGaf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2013 01:30:35 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: durgadoss.r@intel.com, eduardo.valentin@ti.com, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, Wei Ni <wni@nvidia.com>, Jinyoung Park <jinyoungp@nvidia.com>

The thermal zone params can be used to set governor
to specific thermal governor for thermal zone device.
But if the thermal zone params has only governor name
without thermal bind params, then the thermal zone device
will not be binding to cooling device. Because tz->ops->bind
operator is not invoked in bind_tz() and bind_cdev() when
there is thermal zone params.

Signed-off-by: Wei Ni <wni@nvidia.com>
Signed-off-by: Jinyoung Park <jinyoungp@nvidia.com>
---
 drivers/thermal/thermal_core.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 4962a6a..aa59567 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -247,10 +247,11 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
 		if (!pos->tzp && !pos->ops->bind)
 			continue;
 
-		if (!pos->tzp && pos->ops->bind) {
+		if (pos->ops->bind) {
 			ret = pos->ops->bind(pos, cdev);
 			if (ret)
 				print_bind_err_msg(pos, cdev, ret);
+			continue;
 		}
 
 		tzp = pos->tzp;
@@ -282,8 +283,8 @@ static void bind_tz(struct thermal_zone_device *tz)
 
 	mutex_lock(&thermal_list_lock);
 
-	/* If there is no platform data, try to use ops->bind */
-	if (!tzp && tz->ops->bind) {
+	/* If there is ops->bind, try to use ops->bind */
+	if (tz->ops->bind) {
 		list_for_each_entry(pos, &thermal_cdev_list, node) {
 			ret = tz->ops->bind(tz, pos);
 			if (ret)
-- 
1.7.9.5

