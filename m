From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 17/34] Thermal: Fix oops and unlocking in thermal_sys.c
Date: Sun,  2 Dec 2012 22:44:51 +0800
Message-ID: <1354459508-3707-17-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:33009 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753003Ab2LBOpj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:39 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>, Durgadoss R <durgadoss.r@intel.com>, Sedat Dilek <sedat.dilek@gmail.com>, Zhang Rui <rui.zhang@intel.com>

From: Hugh Dickins <hughd@google.com>

This patch fixes the following mutex and NULL pointer
problems in thermal_sys.c:

 * mutex_unlock fix in update_temperature function
 * mutex_unlock fix in bind_cdev function
 * Correct early return to continue in bind_cdev function
 * NULL check fix in bind_cdev function
 * NULL check fix in bind_tz function

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_sys.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index a69f24c..8f0f37b 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -252,8 +252,8 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
 		}
 
 		tzp = pos->tzp;
-		if (!tzp->tbp)
-			return;
+		if (!tzp || !tzp->tbp)
+			continue;
 
 		for (i = 0; i < tzp->num_tbps; i++) {
 			if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
@@ -289,7 +289,7 @@ static void bind_tz(struct thermal_zone_device *tz)
 		goto exit;
 	}
 
-	if (!tzp->tbp)
+	if (!tzp || !tzp->tbp)
 		goto exit;
 
 	list_for_each_entry(pos, &thermal_cdev_list, node) {
@@ -387,12 +387,13 @@ static void update_temperature(struct thermal_zone_device *tz)
 	ret = tz->ops->get_temp(tz, &temp);
 	if (ret) {
 		pr_warn("failed to read out thermal zone %d\n", tz->id);
-		return;
+		goto exit;
 	}
 
 	tz->last_temperature = tz->temperature;
 	tz->temperature = temp;
 
+exit:
 	mutex_unlock(&tz->lock);
 }
 
-- 
1.7.7.6

