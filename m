From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v3 2/5] thermal: of: Extend of-thermal.c to provide check if
 trip point is valid
Date: Mon, 08 Dec 2014 18:04:18 +0100
Message-ID: <1418058261-25251-3-git-send-email-l.majewski@samsung.com>
References: <1416500488-7232-1-git-send-email-l.majewski@samsung.com>
 <1418058261-25251-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:42916 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbaLHRG4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Dec 2014 12:06:56 -0500
In-reply-to: <1418058261-25251-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Mikko Perttunen <mperttunen@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, Caesar Wang <caesar.wang@rock-chips.com>, navneet kumar <navneetk@nvidia.com>, Lukasz Majewski <l.majewski@samsung.com>

This patch extends the of-thermal.c to provide check if trip point is
valid.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v3:
- Rename of_thermal_is_trip_en() to of_thermal_is_trip_valid()
- Export of_thermal_is_trip_valid symbol as GPL
- Fix the build error when CONFIG_THERMAL_OF is not defined

Changes for v2:
- Replace int with bool
- Replace 1/0 with true/false
- Add check if data pointer is not NULL
- Add missing doxygen style comment for the function
---
 drivers/thermal/of-thermal.c   | 21 +++++++++++++++++++++
 drivers/thermal/thermal_core.h |  6 ++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 7facd23..87b9cfe 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -133,6 +133,27 @@ int of_thermal_get_ntrips(struct thermal_zone_device *tz)
 }
 EXPORT_SYMBOL_GPL(of_thermal_get_ntrips);
 
+/**
+ * of_thermal_is_trip_valid - function to check if trip point is valid
+ *
+ * @tz:	pointer to a thermal zone
+ * @trip:	trip point to evaluate
+ *
+ * This function is responsible for checking if passed trip point is valid
+ *
+ * Return: true if trip point is valid, false otherwise
+ */
+bool of_thermal_is_trip_valid(struct thermal_zone_device *tz, int trip)
+{
+	struct __thermal_zone *data = tz->devdata;
+
+	if (!data || trip >= data->ntrips || trip < 0)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(of_thermal_is_trip_valid);
+
 static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
 				enum thermal_trend *trend)
 {
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 1cc5041..58a0dfa 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -90,6 +90,7 @@ static inline void thermal_gov_user_space_unregister(void) {}
 int of_parse_thermal_zones(void);
 void of_thermal_destroy_zones(void);
 int of_thermal_get_ntrips(struct thermal_zone_device *);
+bool of_thermal_is_trip_valid(struct thermal_zone_device *, int);
 #else
 static inline int of_parse_thermal_zones(void) { return 0; }
 static inline void of_thermal_destroy_zones(void) { }
@@ -97,6 +98,11 @@ static inline int of_thermal_get_ntrips(struct thermal_zone_device *tz)
 {
 	return 0;
 }
+static inline bool of_thermal_is_trip_valid(struct thermal_zone_device *tz,
+					    int trip)
+{
+	return 0;
+}
 #endif
 
 #endif /* __THERMAL_CORE_H__ */
-- 
2.0.0.rc2

