From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v6 2/5] thermal: of: implement .set_trips for device tree
 thermal zones
Date: Wed, 22 Jun 2016 16:42:02 +0800
Message-ID: <1466584925-4829-3-git-send-email-wxt@rock-chips.com>
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
Cc: huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, javi.merino-5wv7dgnIgG8@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, peter-p08lbbvQ7EI@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, smbarber-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, briannorris-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

This patch implements .set_trips for device tree thermal zones.
As the hardware-tracked trip points is supported by thermal core patch[0].

patch[0]
"thermal: Add support for hardware-tracked trip points".

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Reviewed-by: Javi Merino <javi.merino-5wv7dgnIgG8@public.gmane.org>

---

Changes in v6: None
Changes in v5: None
Changes in v4:
- as the Javi comments, %s/implemnets/implements.

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
index 780e69d..2440b8d 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -342,6 +342,9 @@ struct thermal_genl_event {
  *
  * Optional:
  * @get_trend: a pointer to a function that reads the sensor temperature trend.
+ * @set_trips: a pointer to a function that sets a temperature window. When
+ *	       this window is left the driver must inform the thermal core via
+ *	       thermal_zone_device_update.
  * @set_emul_temp: a pointer to a function that sets sensor emulated
  *		   temperature.
  * @set_trip_temp: a pointer to a function that sets the trip temperature on
@@ -350,6 +353,7 @@ struct thermal_genl_event {
 struct thermal_zone_of_device_ops {
 	int (*get_temp)(void *, int *);
 	int (*get_trend)(void *, long *);
+	int (*set_trips)(void *, int, int);
 	int (*set_emul_temp)(void *, int);
 	int (*set_trip_temp)(void *, int, int);
 };
-- 
1.9.1
