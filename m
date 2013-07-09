From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [RFC PATCH 3/4] thermal: ti-soc-thermal: use thermal DT infrastructure
Date: Tue, 9 Jul 2013 10:00:13 -0400
Message-ID: <1373378414-28086-4-git-send-email-eduardo.valentin@ti.com>
References: <1373378414-28086-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39538 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753977Ab3GIOAy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 9 Jul 2013 10:00:54 -0400
In-Reply-To: <1373378414-28086-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, durgadoss.r@intel.com, amit.daniel@samsung.com
Cc: rui.zhang@intel.com, Eduardo Valentin <eduardo.valentin@ti.com>

This patch improves the ti-soc-thermal driver by adding the
support to build the thermal zones based on DT nodes.

The driver will have two options now to build the thermal
zones. The first option is the zones originally coded
in this driver. So, the driver behavior will be same
if there is no DT node describing the zones. The second
option, when it is found a DT node with thermal data,
will used the common infrastructure to build the thermal
zone and bind its cooling devices.

In either case, this driver still adds to the system
a cpufreq cooling device.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 35 +++++++++++++++-------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 4c5f55c37..213a883 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -31,6 +31,7 @@
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_cooling.h>
+#include <linux/of.h>
 
 #include "ti-thermal.h"
 #include "ti-bandgap.h"
@@ -75,11 +76,10 @@ static inline int ti_thermal_hotspot_temperature(int t, int s, int c)
 
 /* thermal zone ops */
 /* Get temperature callback function for thermal zone*/
-static inline int ti_thermal_get_temp(struct thermal_zone_device *thermal,
-				      unsigned long *temp)
+static inline int __ti_thermal_get_temp(void *devdata, unsigned long *temp)
 {
 	struct thermal_zone_device *pcb_tz = NULL;
-	struct ti_thermal_data *data = thermal->devdata;
+	struct ti_thermal_data *data = devdata;
 	struct ti_bandgap *bgp;
 	const struct ti_temp_sensor *s;
 	int ret, tmp, slope, constant;
@@ -117,6 +117,14 @@ static inline int ti_thermal_get_temp(struct thermal_zone_device *thermal,
 	return ret;
 }
 
+static inline int ti_thermal_get_temp(struct thermal_zone_device *thermal,
+				      unsigned long *temp)
+{
+	struct ti_thermal_data *data = thermal->devdata;
+
+	return __ti_thermal_get_temp(data, temp);
+}
+
 /* Bind callback functions for thermal zone */
 static int ti_thermal_bind(struct thermal_zone_device *thermal,
 			   struct thermal_cooling_device *cdev)
@@ -302,17 +310,24 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 	if (!data)
 		return -EINVAL;
 
-	/* Create thermal zone */
-	data->ti_thermal = thermal_zone_device_register(domain,
+	/* in case this is specified by DT */
+	if (of_find_node_by_name(bgp->dev->of_node, "thermal_zone")) {
+		data->ti_thermal = thermal_zone_of_device_register(bgp->dev,
+						data, __ti_thermal_get_temp);
+		/* TODO: return */
+	} else {
+		/* Create thermal zone */
+		data->ti_thermal = thermal_zone_device_register(domain,
 				OMAP_TRIP_NUMBER, 0, data, &ti_thermal_ops,
 				NULL, FAST_TEMP_MONITORING_RATE,
 				FAST_TEMP_MONITORING_RATE);
-	if (IS_ERR(data->ti_thermal)) {
-		dev_err(bgp->dev, "thermal zone device is NULL\n");
-		return PTR_ERR(data->ti_thermal);
+		if (IS_ERR(data->ti_thermal)) {
+			dev_err(bgp->dev, "thermal zone device is NULL\n");
+			return PTR_ERR(data->ti_thermal);
+		}
+		data->ti_thermal->polling_delay = FAST_TEMP_MONITORING_RATE;
+		ti_bandgap_set_sensor_data(bgp, id, data);
 	}
-	data->ti_thermal->polling_delay = FAST_TEMP_MONITORING_RATE;
-	ti_bandgap_set_sensor_data(bgp, id, data);
 
 	return 0;
 }
-- 
1.8.2.1.342.gfa7285d

