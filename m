From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] Thermal: thermal zone governor fix
Date: Mon, 03 Mar 2014 13:46:13 +0800
Message-ID: <1393825573.2199.3.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47553 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800AbaCCFqQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 3 Mar 2014 00:46:16 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: javi.merino@arm.com, eduardo <eduardo.valentin@ti.com>, wni@nvidia.com

>From 635a1f41a8f95a35d1bf24c9cc018ffb018a93e6 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Fri, 24 Jan 2014 10:23:19 +0800
Subject: [PATCH] Thermal: thermal zone governor fix

This patch does a cleanup about the thermal zone govenor,
setting and make the following rule.
1. For thermal zone devices that are registered w/o tz->tzp,
   they can use the default thermal governor only.
2. For thermal zone devices w/ governor name specified in
   tz->tzp->governor_name, we will use the default govenor
   if the governor specified is not available at the moment,
   and update tz->governor when the matched governor is registered.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_core.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 338a88b..1346205 100644
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
 
+	if (!name || !name[0])
+		return def_governor;
+
 	list_for_each_entry(pos, &thermal_governor_list, governor_list)
 		if (!strnicmp(name, pos->name, THERMAL_NAME_LENGTH))
 			return pos;
@@ -82,17 +87,23 @@ int thermal_register_governor(struct thermal_governor *governor)
 	if (__find_governor(governor->name) == NULL) {
 		err = 0;
 		list_add(&governor->governor_list, &thermal_governor_list);
+		if (!def_governor && !strncmp(governor->name,
+			DEFAULT_THERMAL_GOVERNOR, THERMAL_NAME_LENGTH))
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
@@ -342,8 +353,8 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
 static void handle_non_critical_trips(struct thermal_zone_device *tz,
 			int trip, enum thermal_trip_type trip_type)
 {
-	if (tz->governor)
-		tz->governor->throttle(tz, trip);
+	tz->governor ? tz->governor->throttle(tz, trip) :
+		       def_governor->throttle(tz, trip);
 }
 
 static void handle_critical_trips(struct thermal_zone_device *tz,
@@ -1533,7 +1544,7 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	if (tz->tzp)
 		tz->governor = __find_governor(tz->tzp->governor_name);
 	else
-		tz->governor = __find_governor(DEFAULT_THERMAL_GOVERNOR);
+		tz->governor = def_governor;
 
 	mutex_unlock(&thermal_governor_lock);
 
-- 
1.7.9.5



