From: Caesar Wang <wxt@rock-chips.com>
Subject: [RESEND PATCH v4 1/5] thermal: Add support for hardware-tracked trip points
Date: Fri, 27 May 2016 16:36:44 +0800
Message-ID: <1464338208-8105-2-git-send-email-wxt@rock-chips.com>
References: <1464338208-8105-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1464338208-8105-1-git-send-email-wxt@rock-chips.com>
Sender: linux-doc-owner@vger.kernel.org
To: edubezval@gmail.com, linux-pm@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, cf@rock-chips.com, huangtao@rock-chips.com, dmitry.torokhov@gmail.com, javi.merino@arm.com, peter@piie.net, Sascha Hauer <s.hauer@pengutronix.de>, Caesar Wang <wxt@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, Jonathan Corbet <corbet@lwn.net>, Laxman Dewangan <ldewangan@nvidia.com>, Andy Champ <andycham@amazon.com>, Ni Wade <wni@nvidia.com>, Leo Yan <leo.yan@linaro.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Sascha Hauer <s.hauer@pengutronix.de>

This adds support for hardware-tracked trip points to the device tree
thermal sensor framework.

The framework supports an arbitrary number of trip points. Whenever
the current temperature is updated, the trip points immediately
below and above the current temperature are found. A .set_trips
callback is then called with the temperatures. If there is no trip
point above or below the current temperature, the passed trip
temperature will be -INT_MAX or INT_MAX respectively. In this callback,
the driver should program the hardware such that it is notified
when either of these trip points are triggered. When a trip point
is triggered, the driver should call `thermal_zone_device_update'
for the respective thermal zone. This will cause the trip points
to be updated again.

If .set_trips is not implemented, the framework behaves as before.

This patch is based on an earlier version from Mikko Perttunen
<mikko.perttunen@kapsi.fi>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org

---

Changes in v4:
- Missing the lock added in v3.

Changes in v3:
- as Javi comments on https://patchwork.kernel.org/patch/9001281/.
- add the lock for preventing the called from multi placce
- add the note for pre_low/high_trip.

Changes in v2:
- update the sysfs-api.txt for set_trips.

 Documentation/thermal/sysfs-api.txt |  7 +++++
 drivers/thermal/thermal_core.c      | 56 +++++++++++++++++++++++++++++++++++++
 include/linux/thermal.h             |  7 +++++
 3 files changed, 70 insertions(+)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index efc3f3d..75d8838 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -49,6 +49,9 @@ temperature) and throttle appropriate devices.
 	.bind: bind the thermal zone device with a thermal cooling device.
 	.unbind: unbind the thermal zone device with a thermal cooling device.
 	.get_temp: get the current temperature of the thermal zone.
+	.set_trips: set the trip points window. Whenever the current temperature
+		    is updated, the trip points immediately below and above the
+		    current temperature are found.
 	.get_mode: get the current mode (enabled/disabled) of the thermal zone.
 	    - "enabled" means the kernel thermal management is enabled.
 	    - "disabled" will prevent kernel thermal driver action upon trip points
@@ -95,6 +98,10 @@ temperature) and throttle appropriate devices.
 			get_temp:	a pointer to a function that reads the
 					sensor temperature. This is mandatory
 					callback provided by sensor driver.
+			set_trips:      a pointer to a function that sets a
+					temperature window. When this window is
+					left the driver must inform the thermal
+					core via thermal_zone_device_update.
 			get_trend: 	a pointer to a function that reads the
 					sensor temperature trend.
 			set_emul_temp:	a pointer to a function that sets
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 5133cd1..0591438 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -520,6 +520,55 @@ exit:
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
 
+static void thermal_zone_set_trips(struct thermal_zone_device *tz)
+{
+	int low = -INT_MAX;
+	int high = INT_MAX;
+	int trip_temp, hysteresis;
+	int temp = tz->temperature;
+	int i, ret;
+
+	if (!tz->ops->set_trips)
+		return;
+
+	for (i = 0; i < tz->trips; i++) {
+		int trip_low;
+
+		tz->ops->get_trip_temp(tz, i, &trip_temp);
+		tz->ops->get_trip_hyst(tz, i, &hysteresis);
+
+		trip_low = trip_temp - hysteresis;
+
+		if (trip_low < temp && trip_low > low)
+			low = trip_low;
+
+		if (trip_temp > temp && trip_temp < high)
+			high = trip_temp;
+	}
+
+	/* No need to change trip points */
+	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
+		return;
+
+	mutex_lock(&tz->lock);
+
+	tz->prev_low_trip = low;
+	tz->prev_high_trip = high;
+
+	dev_dbg(&tz->device, "new temperature boundaries: %d < x < %d\n",
+			low, high);
+
+	/*
+	 * Set a temperature window. When this window is left the driver
+	 * must inform the thermal core via thermal_zone_device_update.
+	 */
+	ret = tz->ops->set_trips(tz, low, high);
+	if (ret)
+		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
+
+	mutex_unlock(&tz->lock);
+}
+
 static void update_temperature(struct thermal_zone_device *tz)
 {
 	int temp, ret;
@@ -569,6 +618,8 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 
 	update_temperature(tz);
 
+	thermal_zone_set_trips(tz);
+
 	for (count = 0; count < tz->trips; count++)
 		handle_thermal_trip(tz, count);
 }
@@ -754,6 +805,9 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 	 */
 	ret = tz->ops->set_trip_hyst(tz, trip, temperature);
 
+	if (!ret)
+		thermal_zone_set_trips(tz);
+
 	return ret ? ret : count;
 }
 
@@ -1843,6 +1897,8 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	tz->trips = trips;
 	tz->passive_delay = passive_delay;
 	tz->polling_delay = polling_delay;
+	tz->prev_low_trip = INT_MAX;
+	tz->prev_high_trip = -INT_MAX;
 	/* A new thermal zone needs to be updated anyway. */
 	atomic_set(&tz->need_update, 1);
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e45abe7..635c4003 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -98,6 +98,7 @@ struct thermal_zone_device_ops {
 	int (*unbind) (struct thermal_zone_device *,
 		       struct thermal_cooling_device *);
 	int (*get_temp) (struct thermal_zone_device *, int *);
+	int (*set_trips) (struct thermal_zone_device *, int, int);
 	int (*get_mode) (struct thermal_zone_device *,
 			 enum thermal_device_mode *);
 	int (*set_mode) (struct thermal_zone_device *,
@@ -168,6 +169,10 @@ struct thermal_attr {
  * @last_temperature:	previous temperature read
  * @emul_temperature:	emulated temperature when using CONFIG_THERMAL_EMULATION
  * @passive:		1 if you've crossed a passive trip point, 0 otherwise.
+ * @prev_low_trip:	the low current temperature if you've crossed a passive
+			trip point.
+ * @prev_high_trip:	the above current temperature if you've crossed a
+			passive trip point.
  * @forced_passive:	If > 0, temperature at which to switch on all ACPI
  *			processor cooling devices.  Currently only used by the
  *			step-wise governor.
@@ -199,6 +204,8 @@ struct thermal_zone_device {
 	int last_temperature;
 	int emul_temperature;
 	int passive;
+	int prev_low_trip;
+	int prev_high_trip;
 	unsigned int forced_passive;
 	atomic_t need_update;
 	struct thermal_zone_device_ops *ops;
-- 
1.9.1

