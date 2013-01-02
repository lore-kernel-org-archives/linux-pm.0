From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH RESEND 3/4] thermal: cleanup: use dev_* helper functions
Date: Wed, 2 Jan 2013 17:29:41 +0200
Message-ID: <1357140582-8151-4-git-send-email-eduardo.valentin@ti.com>
References: <1357140582-8151-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52808 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752755Ab3ABPa4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 2 Jan 2013 10:30:56 -0500
In-Reply-To: <1357140582-8151-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: durgadoss.r@intel.com, linux-pm@lists.linux-foundation.org, linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>

Change the logging messages to used dev_* helper functions.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/thermal_sys.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 70ce100..fba27c3 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -354,8 +354,9 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 		tz->ops->notify(tz, trip, trip_type);
 
 	if (trip_type == THERMAL_TRIP_CRITICAL) {
-		pr_emerg("Critical temperature reached(%d C),shutting down\n",
-			 tz->temperature / 1000);
+		dev_emerg(&tz->device,
+			  "critical temperature reached(%d C),shutting down\n",
+			  tz->temperature / 1000);
 		orderly_poweroff(true);
 	}
 }
@@ -386,7 +387,8 @@ static void update_temperature(struct thermal_zone_device *tz)
 
 	ret = tz->ops->get_temp(tz, &temp);
 	if (ret) {
-		pr_warn("failed to read out thermal zone %d\n", tz->id);
+		dev_warn(&tz->device, "failed to read out thermal zone %d\n",
+			 tz->id);
 		goto exit;
 	}
 
@@ -1770,7 +1772,7 @@ int thermal_generate_netlink_event(struct thermal_zone_device *tz,
 
 	result = genlmsg_multicast(skb, 0, thermal_event_mcgrp.id, GFP_ATOMIC);
 	if (result)
-		pr_info("failed to send netlink event:%d\n", result);
+		dev_err(&tz->device, "Failed to send netlink event:%d", result);
 
 	return result;
 }
-- 
1.7.7.1.488.ge8e1c

