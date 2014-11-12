From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: core: ignore invalid trip temperature
Date: Wed, 12 Nov 2014 15:43:29 -0800
Message-ID: <1415835809-23376-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28952 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753645AbaKLXns (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 12 Nov 2014 18:43:48 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Ignore invalid trip temperature less or equal to zero. Some
buggy systems have invalid trips, causing system shutdown.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9bf10aa..fbf301a 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -368,7 +368,7 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 	tz->ops->get_trip_temp(tz, trip, &trip_temp);
 
 	/* If we have not crossed the trip_temp, we do not care. */
-	if (tz->temperature < trip_temp)
+	if (trip_temp <= 0 || tz->temperature < trip_temp)
 		return;
 
 	trace_thermal_zone_trip(tz, trip, trip_type);
-- 
1.9.1

