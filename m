From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 05/34] Thermal: Pass zone parameters as argument to tzd_register
Date: Sun,  2 Dec 2012 22:44:39 +0800
Message-ID: <1354459508-3707-5-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:6656 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751770Ab2LBOpf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:35 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Durgadoss R <durgadoss.r@intel.com>, Zhang Rui <rui.zhang@intel.com>

From: Durgadoss R <durgadoss.r@intel.com>

This patch adds the thermal zone parameter as an argument to
the tzd_register() function call; and updates other drivers
using this function.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/thermal.c                             |    6 +++---
 drivers/platform/x86/acerhdf.c                     |    2 +-
 drivers/platform/x86/intel_mid_thermal.c           |    2 +-
 drivers/power/power_supply_core.c                  |    2 +-
 drivers/staging/omap-thermal/omap-thermal-common.c |    2 +-
 drivers/thermal/exynos_thermal.c                   |    2 +-
 drivers/thermal/rcar_thermal.c                     |    2 +-
 drivers/thermal/spear_thermal.c                    |    2 +-
 drivers/thermal/thermal_sys.c                      |    3 +++
 include/linux/thermal.h                            |    3 ++-
 10 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 804204d..1794468 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -900,14 +900,14 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 	if (tz->trips.passive.flags.valid)
 		tz->thermal_zone =
 			thermal_zone_device_register("acpitz", trips, 0, tz,
-						     &acpi_thermal_zone_ops,
+						&acpi_thermal_zone_ops, NULL,
 						     tz->trips.passive.tsp*100,
 						     tz->polling_frequency*100);
 	else
 		tz->thermal_zone =
 			thermal_zone_device_register("acpitz", trips, 0, tz,
-						     &acpi_thermal_zone_ops, 0,
-						     tz->polling_frequency*100);
+						&acpi_thermal_zone_ops, NULL,
+						0, tz->polling_frequency*100);
 	if (IS_ERR(tz->thermal_zone))
 		return -ENODEV;
 
diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 84c5688..c2e3e63 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -662,7 +662,7 @@ static int acerhdf_register_thermal(void)
 		return -EINVAL;
 
 	thz_dev = thermal_zone_device_register("acerhdf", 1, 0, NULL,
-					      &acerhdf_dev_ops, 0,
+					      &acerhdf_dev_ops, NULL, 0,
 					      (kernelmode) ? interval*1000 : 0);
 	if (IS_ERR(thz_dev))
 		return -EINVAL;
diff --git a/drivers/platform/x86/intel_mid_thermal.c b/drivers/platform/x86/intel_mid_thermal.c
index c809761..93de090 100644
--- a/drivers/platform/x86/intel_mid_thermal.c
+++ b/drivers/platform/x86/intel_mid_thermal.c
@@ -502,7 +502,7 @@ static int mid_thermal_probe(struct platform_device *pdev)
 			goto err;
 		}
 		pinfo->tzd[i] = thermal_zone_device_register(name[i],
-				0, 0, td_info, &tzd_ops, 0, 0);
+				0, 0, td_info, &tzd_ops, NULL, 0, 0);
 		if (IS_ERR(pinfo->tzd[i])) {
 			kfree(td_info);
 			ret = PTR_ERR(pinfo->tzd[i]);
diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 2436f13..f77a412 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -201,7 +201,7 @@ static int psy_register_thermal(struct power_supply *psy)
 	for (i = 0; i < psy->num_properties; i++) {
 		if (psy->properties[i] == POWER_SUPPLY_PROP_TEMP) {
 			psy->tzd = thermal_zone_device_register(psy->name, 0, 0,
-					psy, &psy_tzd_ops, 0, 0);
+					psy, &psy_tzd_ops, NULL, 0, 0);
 			if (IS_ERR(psy->tzd))
 				return PTR_ERR(psy->tzd);
 			break;
diff --git a/drivers/staging/omap-thermal/omap-thermal-common.c b/drivers/staging/omap-thermal/omap-thermal-common.c
index 5c0c203b..788f64f 100644
--- a/drivers/staging/omap-thermal/omap-thermal-common.c
+++ b/drivers/staging/omap-thermal/omap-thermal-common.c
@@ -270,7 +270,7 @@ int omap_thermal_expose_sensor(struct omap_bandgap *bg_ptr, int id,
 	/* Create thermal zone */
 	data->omap_thermal = thermal_zone_device_register(domain,
 				OMAP_TRIP_NUMBER, 0, data, &omap_thermal_ops,
-				FAST_TEMP_MONITORING_RATE,
+				NULL, FAST_TEMP_MONITORING_RATE,
 				FAST_TEMP_MONITORING_RATE);
 	if (IS_ERR_OR_NULL(data->omap_thermal)) {
 		dev_err(bg_ptr->dev, "thermal zone device is NULL\n");
diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
index 6dd29e4..7772d16 100644
--- a/drivers/thermal/exynos_thermal.c
+++ b/drivers/thermal/exynos_thermal.c
@@ -451,7 +451,7 @@ static int exynos_register_thermal(struct thermal_sensor_conf *sensor_conf)
 	th_zone->cool_dev_size++;
 
 	th_zone->therm_dev = thermal_zone_device_register(sensor_conf->name,
-			EXYNOS_ZONE_COUNT, 0, NULL, &exynos_dev_ops, 0,
+			EXYNOS_ZONE_COUNT, 0, NULL, &exynos_dev_ops, NULL, 0,
 			IDLE_INTERVAL);
 
 	if (IS_ERR(th_zone->therm_dev)) {
diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index f7a1b57..762f637 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -211,7 +211,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 	}
 
 	zone = thermal_zone_device_register("rcar_thermal", 0, 0, priv,
-					    &rcar_thermal_zone_ops, 0, 0);
+				    &rcar_thermal_zone_ops, NULL, 0, 0);
 	if (IS_ERR(zone)) {
 		dev_err(&pdev->dev, "thermal zone device is NULL\n");
 		ret = PTR_ERR(zone);
diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 9bc9692..6b2d8b2 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -147,7 +147,7 @@ static int spear_thermal_probe(struct platform_device *pdev)
 	writel_relaxed(stdev->flags, stdev->thermal_base);
 
 	spear_thermal = thermal_zone_device_register("spear_thermal", 0, 0,
-				stdev, &ops, 0, 0);
+				stdev, &ops, NULL, 0, 0);
 	if (IS_ERR(spear_thermal)) {
 		dev_err(&pdev->dev, "thermal zone device is NULL\n");
 		ret = PTR_ERR(spear_thermal);
diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 1f98c56..dca3bfc 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -1341,6 +1341,7 @@ static void remove_trip_attrs(struct thermal_zone_device *tz)
  * @mask:	a bit string indicating the writeablility of trip points
  * @devdata:	private device data
  * @ops:	standard thermal zone device callbacks
+ * @tzp:	thermal zone platform parameters
  * @passive_delay: number of milliseconds to wait between polls when
  *		   performing passive cooling
  * @polling_delay: number of milliseconds to wait between polls when checking
@@ -1353,6 +1354,7 @@ static void remove_trip_attrs(struct thermal_zone_device *tz)
 struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	int trips, int mask, void *devdata,
 	const struct thermal_zone_device_ops *ops,
+	const struct thermal_zone_params *tzp,
 	int passive_delay, int polling_delay)
 {
 	struct thermal_zone_device *tz;
@@ -1386,6 +1388,7 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 
 	strcpy(tz->type, type ? : "");
 	tz->ops = ops;
+	tz->tzp = tzp;
 	tz->device.class = &thermal_class;
 	tz->devdata = devdata;
 	tz->trips = trips;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 4caa32e..58cb1c0 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -200,7 +200,8 @@ struct thermal_genl_event {
 
 /* Function declarations */
 struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
-		void *, const struct thermal_zone_device_ops *, int, int);
+		void *, const struct thermal_zone_device_ops *,
+		const struct thermal_zone_params *, int, int);
 void thermal_zone_device_unregister(struct thermal_zone_device *);
 
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
-- 
1.7.7.6

