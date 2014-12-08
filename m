From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v3 4/5] thermal: of: Extend of-thermal to export table of trip
 points
Date: Mon, 08 Dec 2014 18:04:20 +0100
Message-ID: <1418058261-25251-5-git-send-email-l.majewski@samsung.com>
References: <1416500488-7232-1-git-send-email-l.majewski@samsung.com>
 <1418058261-25251-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1418058261-25251-1-git-send-email-l.majewski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Mikko Perttunen <mperttunen@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, Caesar Wang <caesar.wang@rock-chips.com>, navneet kumar <navneetk@nvidia.com>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch extends the of-thermal.c to export trip points for a given
thermal zone.

Thermal drivers should use of_thermal_get_trip_points() method to get
pointer to table of thermal trip points.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v3:
- Export of_thermal_get_trip_points symbol as GPL
- Fix the build error when CONFIG_THERMAL_OF is not defined

Changes for v2:
- New patch - as suggested by Eduardo Valentin
---
 drivers/thermal/of-thermal.c   | 22 ++++++++++++++++++++++
 drivers/thermal/thermal_core.h |  7 +++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index d3ac117..e062bf5 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -139,6 +139,28 @@ bool of_thermal_is_trip_valid(struct thermal_zone_device *tz, int trip)
 }
 EXPORT_SYMBOL_GPL(of_thermal_is_trip_valid);
 
+/**
+ * of_thermal_get_trip_points - function to get access to a globally exported
+ *				trip points
+ *
+ * @tz:	pointer to a thermal zone
+ *
+ * This function provides a pointer to trip points table
+ *
+ * Return: pointer to trip points table, NULL otherwise
+ */
+const struct thermal_trip * const
+of_thermal_get_trip_points(struct thermal_zone_device *tz)
+{
+	struct __thermal_zone *data = tz->devdata;
+
+	if (!data)
+		return NULL;
+
+	return data->trips;
+}
+EXPORT_SYMBOL_GPL(of_thermal_get_trip_points);
+
 static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
 				enum thermal_trend *trend)
 {
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 58a0dfa..9083e75 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -91,6 +91,8 @@ int of_parse_thermal_zones(void);
 void of_thermal_destroy_zones(void);
 int of_thermal_get_ntrips(struct thermal_zone_device *);
 bool of_thermal_is_trip_valid(struct thermal_zone_device *, int);
+const struct thermal_trip * const
+of_thermal_get_trip_points(struct thermal_zone_device *);
 #else
 static inline int of_parse_thermal_zones(void) { return 0; }
 static inline void of_thermal_destroy_zones(void) { }
@@ -103,6 +105,11 @@ static inline bool of_thermal_is_trip_valid(struct thermal_zone_device *tz,
 {
 	return 0;
 }
+static inline const struct thermal_trip * const
+of_thermal_get_trip_points(struct thermal_zone_device *tz)
+{
+	return NULL;
+}
 #endif
 
 #endif /* __THERMAL_CORE_H__ */
-- 
2.0.0.rc2
