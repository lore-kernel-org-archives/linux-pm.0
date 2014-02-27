From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] Thermal: thermal zone governor fix
Date: Thu, 27 Feb 2014 14:41:16 +0800
Message-ID: <1393483276.2637.7.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47711 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051AbaB0GlU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 27 Feb 2014 01:41:20 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: eduardo <eduardo.valentin@ti.com>, javi.merino@arm.com, wni@nvidia.com

>From cd587add3043ed7bf3347e5d956f65ec8adf04cf Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Fri, 24 Jan 2014 10:23:19 +0800
Subject: [PATCH] Thermal: thermal zone governor fix

This patch does a cleanup about the thermal zone governor,
and make the following rules,
1. For thermal zone devices that are registered w/o tz->tzp,
   they can use the default thermal governor only.
2. For thermal zone devices w/ governor name specified in
   tz->tzp->governor_name, we will use the default governor
   if the governor specified is not available at the moment,
   and update tz->governor when the matched governor is registered.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_core.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/thermal_core.c
b/drivers/thermal/thermal_core.c
index 338a88b..6bcf0628a 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -56,10 +56,15 @@ static LIST_HEAD(thermal_governor_list);
 static DEFINE_MUTEX(thermal_list_lock);
 static DEFINE_MUTEX(thermal_governor_lock);
 
+static struct thermal_governor *def_governor;
+
 static struct thermal_governor *__find_governor(const char *name)
 {
 	struct thermal_governor *pos;
 
+	if (!name)
+		return def_governor;
+
 	list_for_each_entry(pos, &thermal_governor_list, governor_list)
 		if (!strnicmp(name, pos->name, THERMAL_NAME_LENGTH))
 			return pos;
@@ -82,17 +87,23 @@ int thermal_register_governor(struct
thermal_governor *governor)
 	if (__find_governor(governor->name) == NULL) {
 		err = 0;
 		list_add(&governor->governor_list, &thermal_governor_list);
+		if (!def_governor && !strncmp(governor->name,
+			THERMAL_DEFAULT_GOVERNOR, THERMAL_NAME_LENGTH))
+			def_governor = governor;
 	}
 
 	mutex_lock(&thermal_list_lock);
 
 	list_for_each_entry(pos, &thermal_tz_list, node) {
+		/*
+		 * only thermal zones with specified tz->tzp->governor_name
+		 * may run with tz->govenor unset
+		 */
 		if (pos->governor)
 			continue;
-		if (pos->tzp)
-			name = pos->tzp->governor_name;
-		else
-			name = DEFAULT_THERMAL_GOVERNOR;
+
+		name = pos->tzp->governor_name;
+
 		if (!strnicmp(name, governor->name, THERMAL_NAME_LENGTH))
 			pos->governor = governor;
 	}
@@ -342,8 +353,8 @@ static void monitor_thermal_zone(struct
thermal_zone_device *tz)
 static void handle_non_critical_trips(struct thermal_zone_device *tz,
 			int trip, enum thermal_trip_type trip_type)
 {
-	if (tz->governor)
-		tz->governor->throttle(tz, trip);
+	tz->governor ?
+		tz->governor->throttle(tz, trip) : def_governor(tz, trip);
 }
 
 static void handle_critical_trips(struct thermal_zone_device *tz,
@@ -1533,7 +1544,7 @@ struct thermal_zone_device
*thermal_zone_device_register(const char *type,
 	if (tz->tzp)
 		tz->governor = __find_governor(tz->tzp->governor_name);
 	else
-		tz->governor = __find_governor(DEFAULT_THERMAL_GOVERNOR);
+		tz->governor = def_governor;
 
 	mutex_unlock(&thermal_governor_lock);
 
-- 
1.7.9.5



