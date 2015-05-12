From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 2/2] thermal: of-thermal: add support for reading coefficients property
Date: Mon, 11 May 2015 20:04:17 -0700
Message-ID: <1431399857-13943-3-git-send-email-edubezval@gmail.com>
References: <1431399857-13943-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431399857-13943-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>, hongtao.jia@freescale.com, kong.kongxinwei@hisilicon.com
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

In order to avoid having each driver adding their own
specific DT property to specify slope and offset,
this patch adds a basic coefficient reading from
DT thermal zone node. Right now, as the thermal
framework does not support multiple sensors,
the current coefficients apply only to the only
sensor in the thermal zone.

The supported equation is a simple linear model:
	slope * <sensor reading> + offset.

slope and offset are read from the coefficients
DT property. In the same way as it is described in
the DT thermal binding.

So, as of today, the thermal framework will support
only cases like:
                /* hotspot = 1 * adc + 6000 */
		coefficients =          <1      6000>;

Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/of-thermal.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 9e8c614..b295b2b 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -58,6 +58,8 @@ struct __thermal_bind_params {
  * @mode: current thermal zone device mode (enabled/disabled)
  * @passive_delay: polling interval while passive cooling is activated
  * @polling_delay: zone polling interval
+ * @slope: slope of the temperature adjustment curve
+ * @offset: offset of the temperature adjustment curve
  * @ntrips: number of trip points
  * @trips: an array of trip points (0..ntrips - 1)
  * @num_tbps: number of thermal bind params
@@ -70,6 +72,8 @@ struct __thermal_zone {
 	enum thermal_device_mode mode;
 	int passive_delay;
 	int polling_delay;
+	int slope;
+	int offset;
 
 	/* trip data */
 	int ntrips;
@@ -716,7 +720,7 @@ static int thermal_of_populate_trip(struct device_node *np,
  * @np parameter and fills the read data into a __thermal_zone data structure
  * and return this pointer.
  *
- * TODO: Missing properties to parse: thermal-sensor-names and coefficients
+ * TODO: Missing properties to parse: thermal-sensor-names
  *
  * Return: On success returns a valid struct __thermal_zone,
  * otherwise, it returns a corresponding ERR_PTR(). Caller must
@@ -728,7 +732,7 @@ thermal_of_build_thermal_zone(struct device_node *np)
 	struct device_node *child = NULL, *gchild;
 	struct __thermal_zone *tz;
 	int ret, i;
-	u32 prop;
+	u32 prop, coef[2];
 
 	if (!np) {
 		pr_err("no thermal zone np\n");
@@ -753,6 +757,20 @@ thermal_of_build_thermal_zone(struct device_node *np)
 	}
 	tz->polling_delay = prop;
 
+	/*
+	 * REVIST: for now, the thermal framework supports only
+	 * one sensor per thermal zone. Thus, we are considering
+	 * only the first two values as slope and offset.
+	 */
+	ret = of_property_read_u32_array(np, "coefficients", coef, 2);
+	if (ret == 0) {
+		tz->slope = coef[0];
+		tz->offset = coef[1];
+	} else {
+		tz->slope = 1;
+		tz->offset = 0;
+	}
+
 	/* trips */
 	child = of_get_child_by_name(np, "trips");
 
@@ -900,6 +918,10 @@ int __init of_parse_thermal_zones(void)
 		for (i = 0; i < tz->ntrips; i++)
 			mask |= 1 << i;
 
+		/* these two are left for temperature drivers to use */
+		tzp->slope = tz->slope;
+		tzp->offset = tz->offset;
+
 		zone = thermal_zone_device_register(child->name, tz->ntrips,
 						    mask, tz,
 						    ops, tzp,
-- 
2.3.4
