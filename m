From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v5 1/5] thermal: Add support for hardware-tracked trip points
Date: Mon,  6 Jun 2016 19:44:45 +0800
Message-ID: <1465213489-14898-2-git-send-email-wxt@rock-chips.com>
References: <1465213489-14898-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465213489-14898-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, linux-pm@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, cf@rock-chips.com, huangtao@rock-chips.com, dmitry.torokhov@gmail.com, javi.merino@arm.com, peter@piie.net, Sascha Hauer <s.hauer@pengutronix.de>, Caesar Wang <wxt@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, Jonathan Corbet <corbet@lwn.net>, Andy Champ <andycham@amazon.com>, Laxman Dewangan <ldewangan@nvidia.com>, Durgadoss R <durgadoss.r@intel.com>, Ni Wade <wni@nvidia.com>, Leo Yan <leo.yan@linaro.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
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

Changes in v5:
- add the lock for thermal_zone_set_trips function.
- change based on next kernel.

Changes in v4:
- Missing the lock added in v3.

Changes in v3:
- as Javi comments on https://patchwork.kernel.org/patch/9001281/.
- add the lock for preventing the called from multi placce
- add the note for pre_low/high_trip.

Changes in v2:
- update the sysfs-api.txt for set_trips.

 Documentation/thermal/sysfs-api.txt |  7 +++++
 drivers/thermal/thermal_core.c      | 54 +++++++++++++++++++++++++++++++++++++
 drivers/thermal/thermal_sysfs.c     |  3 +++
 include/linux/thermal.h             | 10 +++++++
 4 files changed, 74 insertions(+)

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
index 792aab7..e69aee2 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -368,6 +368,56 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 	monitor_thermal_zone(tz);
 }
 
+void thermal_zone_set_trips(struct thermal_zone_device *tz)
+{
+	int low = -INT_MAX;
+	int high = INT_MAX;
+	int trip_temp, hysteresis;
+	int i, ret;
+
+	mutex_lock(&tz->lock);
+
+	if (!tz->ops->set_trips)
+		goto exit;
+
+	for (i = 0; i < tz->trips; i++) {
+		int trip_low;
+
+		tz->ops->get_trip_temp(tz, i, &trip_temp);
+		tz->ops->get_trip_hyst(tz, i, &hysteresis);
+
+		trip_low = trip_temp - hysteresis;
+
+		if (trip_low < tz->temperature && trip_low > low)
+			low = trip_low;
+
+		if (trip_temp > tz->temperature && trip_temp < high)
+			high = trip_temp;
+	}
+
+	/* No need to change trip points */
+	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
+		goto exit;
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
+exit:
+	mutex_unlock(&tz->lock);
+}
+EXPORT_SYMBOL_GPL(thermal_zone_set_trips);
+
 static void update_temperature(struct thermal_zone_device *tz)
 {
 	int temp, ret;
@@ -417,6 +467,8 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 
 	update_temperature(tz);
 
+	thermal_zone_set_trips(tz);
+
 	for (count = 0; count < tz->trips; count++)
 		handle_thermal_trip(tz, count);
 }
@@ -1175,6 +1227,8 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	tz->trips = trips;
 	tz->passive_delay = passive_delay;
 	tz->polling_delay = polling_delay;
+	tz->prev_low_trip = INT_MAX;
+	tz->prev_high_trip = -INT_MAX;
 
 	/* sys I/F */
 	/* Add nodes that are always present via .groups */
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 743df50..33bbe30 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -219,6 +219,9 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 	ret = tz->ops->set_trip_hyst(tz, trip, temperature);
 	mutex_unlock(&tz->lock);
 
+	if (!ret)
+		thermal_zone_set_trips(tz);
+
 	return ret ? ret : count;
 }
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index ea667b6..780e69d 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -99,6 +99,7 @@ struct thermal_zone_device_ops {
 	int (*unbind) (struct thermal_zone_device *,
 		       struct thermal_cooling_device *);
 	int (*get_temp) (struct thermal_zone_device *, int *);
+	int (*set_trips) (struct thermal_zone_device *, int, int);
 	int (*get_mode) (struct thermal_zone_device *,
 			 enum thermal_device_mode *);
 	int (*set_mode) (struct thermal_zone_device *,
@@ -169,6 +170,10 @@ struct thermal_attr {
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
@@ -201,6 +206,8 @@ struct thermal_zone_device {
 	int last_temperature;
 	int emul_temperature;
 	int passive;
+	int prev_low_trip;
+	int prev_high_trip;
 	unsigned int forced_passive;
 	atomic_t need_update;
 	struct thermal_zone_device_ops *ops;
@@ -428,6 +435,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
 int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
 				       struct thermal_cooling_device *);
 void thermal_zone_device_update(struct thermal_zone_device *);
+void thermal_zone_set_trips(struct thermal_zone_device *);
 
 struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
 		const struct thermal_cooling_device_ops *);
@@ -477,6 +485,8 @@ static inline int thermal_zone_unbind_cooling_device(
 { return -ENODEV; }
 static inline void thermal_zone_device_update(struct thermal_zone_device *tz)
 { }
+static inline void thermal_zone_set_trips(struct thermal_zone_device *tz)
+{ }
 static inline struct thermal_cooling_device *
 thermal_cooling_device_register(char *type, void *devdata,
 	const struct thermal_cooling_device_ops *ops)
-- 
1.9.1
