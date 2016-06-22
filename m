From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v6 1/5] thermal: Add support for hardware-tracked trip points
Date: Wed, 22 Jun 2016 16:42:01 +0800
Message-ID: <1466584925-4829-2-git-send-email-wxt@rock-chips.com>
References: <1466584925-4829-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1466584925-4829-1-git-send-email-wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, smbarber-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Durgadoss R <durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, briannorris-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andy Champ <andycham-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, javi.merino-5wv7dgnIgG8@public.gmane.org, Ni Wade <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, peter-p08lbbvQ7EI@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

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
<mikko.perttunen-/1wQRMveznE@public.gmane.org>

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Reviewed-by: Javi Merino <javi.merino-5wv7dgnIgG8@public.gmane.org>

---

Changes in v6:
- add Javi's Reviewed-by
- As Rui's comments on https://patchwork.kernel.org/patch/9157909/,
  add the "get_trip_hyst" to judge.
- fixes a check warning from the scripts.

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
index 792aab7..be734f7 100644
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
+	if (!tz->ops->set_trips || !tz->ops->get_trip_hyst)
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
+	dev_dbg(&tz->device,
+		"new temperature boundaries: %d < x < %d\n", low, high);
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
index c3bf72d..ff8dd26 100644
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
