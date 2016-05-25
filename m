From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v3 2/5] thermal: of: implement .set_trips for device tree thermal zones
Date: Wed, 25 May 2016 11:47:46 +0800
Message-ID: <1464148069-26254-3-git-send-email-wxt@rock-chips.com>
References: <1464148069-26254-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464148069-26254-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, linux-pm@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, cf@rock-chips.com, huangtao@rock-chips.com, dmitry.torokhov@gmail.com, javi.merino@arm.com, peter@piie.net, Sascha Hauer <s.hauer@pengutronix.de>, Caesar Wang <wxt@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Sascha Hauer <s.hauer@pengutronix.de>

This patch implemnets .set_trips for device tree thermal zones.
As the hardware-tracked trip points is supported by thermal core patch[0].

patch[0]
"thermal: Add support for hardware-tracked trip points".

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>

---

Changes in v3:
- as the Javi comments on https://patchwork.kernel.org/patch/9001311/.
- add the select if they set the option for devicetree.

Changes in v2:
- add the commit in patch[v2 2/5].

 drivers/thermal/of-thermal.c | 19 +++++++++++++++++++
 include/linux/thermal.h      |  4 ++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index b8e509c..2d2a06f 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -101,6 +101,17 @@ static int of_thermal_get_temp(struct thermal_zone_device *tz,
 	return data->ops->get_temp(data->sensor_data, temp);
 }
 
+static int of_thermal_set_trips(struct thermal_zone_device *tz,
+				int low, int high)
+{
+	struct __thermal_zone *data = tz->devdata;
+
+	if (!data->ops || !data->ops->set_trips)
+		return -EINVAL;
+
+	return data->ops->set_trips(data->sensor_data, low, high);
+}
+
 /**
  * of_thermal_get_ntrips - function to export number of available trip
  *			   points.
@@ -427,6 +438,14 @@ thermal_zone_of_add_sensor(struct device_node *zone,
 
 	tzd->ops->get_temp = of_thermal_get_temp;
 	tzd->ops->get_trend = of_thermal_get_trend;
+
+	/*
+	 * The thermal zone core will calculate the window if they have set the
+	 * optional set_trips pointer.
+	 */
+	if (ops->set_trips)
+		tzd->ops->set_trips = of_thermal_set_trips;
+
 	tzd->ops->set_emul_temp = of_thermal_set_emul_temp;
 	mutex_unlock(&tzd->lock);
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 635c4003..f68da05 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -340,12 +340,16 @@ struct thermal_genl_event {
  *
  * Optional:
  * @get_trend: a pointer to a function that reads the sensor temperature trend.
+ * @set_trips: a pointer to a function that sets a temperature window. When
+ *	       this window is left the driver must inform the thermal core via
+ *	       thermal_zone_device_update.
  * @set_emul_temp: a pointer to a function that sets sensor emulated
  *		   temperature.
  */
 struct thermal_zone_of_device_ops {
 	int (*get_temp)(void *, int *);
 	int (*get_trend)(void *, long *);
+	int (*set_trips)(void *, int, int);
 	int (*set_emul_temp)(void *, int);
 	int (*set_trip_temp)(void *, int, int);
 };
-- 
1.9.1
