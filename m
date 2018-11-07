From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 02/11] thermal: add irq-mode configuration for trip point
Date: Wed,  7 Nov 2018 18:09:44 +0100
Message-ID: <1541610593-28542-3-git-send-email-l.luba@partner.samsung.com>
References: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181107171036eucas1p13253d56b463c8f888ab8f8e418635297@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com, krzk@kernel.org, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch adds support irq mode in trip point.
When that flag is set in DT, there is no need for polling
in thermal framework. Crossing the trip point will rise an IRQ.
The naming convention for tip point 'type' can be confussing
and 'passive' (whic is passive cooling) might be interpretted wrongly.

This mechanism prevents from missue and adds explicit setting
for hardware which support interrupts for pre-configured temperature
threshold.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/thermal/of-thermal.c   | 17 +++++++++++++++++
 drivers/thermal/thermal_core.c | 10 ++++++++--
 include/linux/thermal.h        |  5 +++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 4bfdb4a..1a75946a 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -312,6 +312,20 @@ static int of_thermal_get_trip_type(struct thermal_zone_device *tz, int trip,
 	return 0;
 }
 
+static int
+of_thermal_get_trip_irq_mode(struct thermal_zone_device *tz, int trip,
+			     bool *mode)
+{
+	struct __thermal_zone *data = tz->devdata;
+
+	if (trip >= data->ntrips || trip < 0)
+		return -EDOM;
+
+	*mode = data->trips[trip].irq_mode;
+
+	return 0;
+}
+
 static int of_thermal_get_trip_temp(struct thermal_zone_device *tz, int trip,
 				    int *temp)
 {
@@ -394,6 +408,7 @@ static struct thermal_zone_device_ops of_thermal_ops = {
 	.set_mode = of_thermal_set_mode,
 
 	.get_trip_type = of_thermal_get_trip_type,
+	.get_trip_irq_mode = of_thermal_get_trip_irq_mode,
 	.get_trip_temp = of_thermal_get_trip_temp,
 	.set_trip_temp = of_thermal_set_trip_temp,
 	.get_trip_hyst = of_thermal_get_trip_hyst,
@@ -827,6 +842,8 @@ static int thermal_of_populate_trip(struct device_node *np,
 		return ret;
 	}
 
+	trip->irq_mode = of_property_read_bool(np, "irq-mode");
+
 	/* Required for cooling map matching */
 	trip->np = np;
 	of_node_get(np);
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 39fc812..6d41e08 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -406,6 +406,7 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 {
 	enum thermal_trip_type type;
+	bool irq_mode = false;
 
 	/* Ignore disabled trip points */
 	if (test_bit(trip, &tz->trips_disabled))
@@ -419,9 +420,14 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 		handle_non_critical_trips(tz, trip);
 	/*
 	 * Alright, we handled this trip successfully.
-	 * So, start monitoring again.
+	 * So, start monitoring in polling mode if
+	 * trip is not using irq HW support.
 	 */
-	monitor_thermal_zone(tz);
+	if (tz->ops->get_trip_irq_mode)
+		tz->ops->get_trip_irq_mode(tz, trip, &irq_mode);
+
+	if (!irq_mode)
+		monitor_thermal_zone(tz);
 }
 
 static void update_temperature(struct thermal_zone_device *tz)
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 5f4705f..b064565 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -103,6 +103,7 @@ struct thermal_zone_device_ops {
 		enum thermal_device_mode);
 	int (*get_trip_type) (struct thermal_zone_device *, int,
 		enum thermal_trip_type *);
+	int (*get_trip_irq_mode) (struct thermal_zone_device *, int, bool *);
 	int (*get_trip_temp) (struct thermal_zone_device *, int, int *);
 	int (*set_trip_temp) (struct thermal_zone_device *, int, int);
 	int (*get_trip_hyst) (struct thermal_zone_device *, int, int *);
@@ -196,6 +197,7 @@ struct thermal_zone_device {
 	struct thermal_attr *trip_temp_attrs;
 	struct thermal_attr *trip_type_attrs;
 	struct thermal_attr *trip_hyst_attrs;
+	struct thermal_attr *trip_irq_mode_attrs;
 	void *devdata;
 	int trips;
 	unsigned long trips_disabled;	/* bitmap for disabled trips */
@@ -364,6 +366,8 @@ struct thermal_zone_of_device_ops {
  * @temperature: temperature value in miliCelsius
  * @hysteresis: relative hysteresis in miliCelsius
  * @type: trip point type
+ * @irq_mode: to not use polling in framework set support of HW irq (which will
+ *	      be triggered when temperature reaches this level).
  */
 
 struct thermal_trip {
@@ -371,6 +375,7 @@ struct thermal_trip {
 	int temperature;
 	int hysteresis;
 	enum thermal_trip_type type;
+	bool irq_mode;
 };
 
 /* Function declarations */
-- 
2.7.4
