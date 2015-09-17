From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH v2 1/4] thermal: core: enhance thermal_zone_device_update
Date: Thu, 17 Sep 2015 15:30:51 -0700
Message-ID: <1442529054-25803-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1442529054-25803-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:28277 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630AbbIQWbY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 17 Sep 2015 18:31:24 -0400
In-Reply-To: <1442529054-25803-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: jic23@kernel.org, rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

thermal_zone_device_update is called by thermal core and clients to
trigger reading of temperature, evaluation of trips and take governor
specified actions. There can be number of reasons this may be triggered,
for example when HW calculates new temperature sample or violation of a
threshold. Since this is the only interface available for client drivers
to trigger thermal core actions, it should also should have a way to
specify the trigger event type.
This change adds additional parameter to specify event. This is optional
for the driver to specify event type, in that case this can be just
THERMAL_DEVICE_EVENT_NONE. Alternately they can select
THERMAL_DEVICE_EVENT_THRESHOLD for temperature threshold event,
THERMAL_DEVICE_EVENT_TEMP_SAMPLE for new temperature sample notification,
THERMAL_DEVICE_TRIP_TEMP_CHANGE for a temperature trip change.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/thermal.c                                 |  2 +-
 drivers/platform/x86/acerhdf.c                         |  2 +-
 drivers/thermal/db8500_thermal.c                       |  2 +-
 drivers/thermal/hisi_thermal.c                         |  3 ++-
 drivers/thermal/imx_thermal.c                          |  4 ++--
 drivers/thermal/int340x_thermal/int340x_thermal_zone.h |  2 +-
 drivers/thermal/intel_soc_dts_iosf.c                   |  3 ++-
 drivers/thermal/of-thermal.c                           |  2 +-
 drivers/thermal/qcom-spmi-temp-alarm.c                 |  2 +-
 drivers/thermal/rcar_thermal.c                         |  3 ++-
 drivers/thermal/rockchip_thermal.c                     |  3 ++-
 drivers/thermal/samsung/exynos_tmu.c                   |  2 +-
 drivers/thermal/st/st_thermal_memmap.c                 |  3 ++-
 drivers/thermal/thermal_core.c                         | 11 ++++++-----
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c     |  4 ++--
 drivers/thermal/x86_pkg_temp_thermal.c                 |  3 ++-
 include/linux/thermal.h                                | 13 +++++++++++--
 17 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 30d8518..e4f547b 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -520,7 +520,7 @@ static void acpi_thermal_check(void *data)
 	if (!tz->tz_enabled)
 		return;
 
-	thermal_zone_device_update(tz->thermal_zone);
+	thermal_zone_device_update(tz->thermal_zone, THERMAL_DEVICE_EVENT_NONE);
 }
 
 /* sys I/F for generic thermal sysfs support */
diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 460fa67..6382d4e 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -405,7 +405,7 @@ static inline void acerhdf_enable_kernelmode(void)
 	kernelmode = 1;
 
 	thz_dev->polling_delay = interval*1000;
-	thermal_zone_device_update(thz_dev);
+	thermal_zone_device_update(thz_dev, THERMAL_DEVICE_EVENT_NONE);
 	pr_notice("kernel mode fan control ON\n");
 }
 
diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index 652acd8..e4cbbe6 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -306,7 +306,7 @@ static void db8500_thermal_work(struct work_struct *work)
 	if (cur_mode == THERMAL_DEVICE_DISABLED)
 		return;
 
-	thermal_zone_device_update(pzone->therm_dev);
+	thermal_zone_device_update(pzone->therm_dev, THERMAL_DEVICE_EVENT_NONE);
 	dev_dbg(&pzone->therm_dev->device, "thermal work finished.\n");
 }
 
diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 36d0729..65f3432 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -227,7 +227,8 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 	mutex_unlock(&data->thermal_lock);
 
 	for (i = 0; i < HISI_MAX_SENSORS; i++)
-		thermal_zone_device_update(data->sensors[i].tzd);
+		thermal_zone_device_update(data->sensors[i].tzd,
+					   THERMAL_DEVICE_EVENT_NONE);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 4bec1d3..24b3aa6 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -249,7 +249,7 @@ static int imx_set_mode(struct thermal_zone_device *tz,
 	}
 
 	data->mode = mode;
-	thermal_zone_device_update(tz);
+	thermal_zone_device_update(tz, THERMAL_DEVICE_EVENT_NONE);
 
 	return 0;
 }
@@ -436,7 +436,7 @@ static irqreturn_t imx_thermal_alarm_irq_thread(int irq, void *dev)
 	dev_dbg(&data->tz->device, "THERMAL ALARM: T > %d\n",
 		data->alarm_temp / 1000);
 
-	thermal_zone_device_update(data->tz);
+	thermal_zone_device_update(data->tz, THERMAL_DEVICE_EVENT_NONE);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/int340x_thermal/int340x_thermal_zone.h b/drivers/thermal/int340x_thermal/int340x_thermal_zone.h
index aaadf72..2f93b85 100644
--- a/drivers/thermal/int340x_thermal/int340x_thermal_zone.h
+++ b/drivers/thermal/int340x_thermal/int340x_thermal_zone.h
@@ -62,7 +62,7 @@ static inline void *int340x_thermal_zone_get_priv_data(
 static inline void int340x_thermal_zone_device_update(
 			struct int34x_thermal_zone *tzone)
 {
-	thermal_zone_device_update(tzone->zone);
+	thermal_zone_device_update(tzone->zone, THERMAL_DEVICE_EVENT_THRESHOLD);
 }
 
 #endif
diff --git a/drivers/thermal/intel_soc_dts_iosf.c b/drivers/thermal/intel_soc_dts_iosf.c
index 5841d1d..4402ab0 100644
--- a/drivers/thermal/intel_soc_dts_iosf.c
+++ b/drivers/thermal/intel_soc_dts_iosf.c
@@ -392,7 +392,8 @@ void intel_soc_dts_iosf_interrupt_handler(struct intel_soc_dts_sensors *sensors)
 
 		for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
 			pr_debug("TZD update for zone %d\n", i);
-			thermal_zone_device_update(sensors->soc_dts[i].tzone);
+			thermal_zone_device_update(sensors->soc_dts[i].tzone,
+						THERMAL_DEVICE_EVENT_THRESHOLD);
 		}
 	} else
 		spin_unlock_irqrestore(&sensors->intr_notify_lock, flags);
diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 42b7d42..4168bf9 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -292,7 +292,7 @@ static int of_thermal_set_mode(struct thermal_zone_device *tz,
 	mutex_unlock(&tz->lock);
 
 	data->mode = mode;
-	thermal_zone_device_update(tz);
+	thermal_zone_device_update(tz, THERMAL_DEVICE_EVENT_NONE);
 
 	return 0;
 }
diff --git a/drivers/thermal/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom-spmi-temp-alarm.c
index b677aad..bf3da3c 100644
--- a/drivers/thermal/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom-spmi-temp-alarm.c
@@ -150,7 +150,7 @@ static irqreturn_t qpnp_tm_isr(int irq, void *data)
 {
 	struct qpnp_tm_chip *chip = data;
 
-	thermal_zone_device_update(chip->tz_dev);
+	thermal_zone_device_update(chip->tz_dev, THERMAL_DEVICE_EVENT_NONE);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 5d4ae7d..2eac44a 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -308,7 +308,8 @@ static void rcar_thermal_work(struct work_struct *work)
 
 	rcar_thermal_get_temp(priv->zone, &nctemp);
 	if (nctemp != cctemp)
-		thermal_zone_device_update(priv->zone);
+		thermal_zone_device_update(priv->zone,
+					   THERMAL_DEVICE_EVENT_NONE);
 }
 
 static u32 rcar_thermal_had_changed(struct rcar_thermal_priv *priv, u32 status)
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index c89ffb2..b3d7214 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -361,7 +361,8 @@ static irqreturn_t rockchip_thermal_alarm_irq_thread(int irq, void *dev)
 	thermal->chip->irq_ack(thermal->regs);
 
 	for (i = 0; i < ARRAY_SIZE(thermal->sensors); i++)
-		thermal_zone_device_update(thermal->sensors[i].tzd);
+		thermal_zone_device_update(thermal->sensors[i].tzd,
+					   THERMAL_DEVICE_EVENT_NONE);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 0bae8cc..80ccc92 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -223,7 +223,7 @@ static void exynos_report_trigger(struct exynos_tmu_data *p)
 		return;
 	}
 
-	thermal_zone_device_update(tz);
+	thermal_zone_device_update(tz, THERMAL_DEVICE_EVENT_NONE);
 
 	mutex_lock(&tz->lock);
 	/* Find the level for which trip happened */
diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index fc0c9e1..45b6b9f 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -42,7 +42,8 @@ static irqreturn_t st_mmap_thermal_trip_handler(int irq, void *sdata)
 {
 	struct st_thermal_sensor *sensor = sdata;
 
-	thermal_zone_device_update(sensor->thermal_dev);
+	thermal_zone_device_update(sensor->thermal_dev,
+				   THERMAL_DEVICE_EVENT_NONE);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 5e5fc70..18e7802 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -536,7 +536,8 @@ static void update_temperature(struct thermal_zone_device *tz)
 				tz->last_temperature, tz->temperature);
 }
 
-void thermal_zone_device_update(struct thermal_zone_device *tz)
+void thermal_zone_device_update(struct thermal_zone_device *tz,
+				enum thermal_device_event_type event)
 {
 	int count;
 
@@ -555,7 +556,7 @@ static void thermal_zone_device_check(struct work_struct *work)
 	struct thermal_zone_device *tz = container_of(work, struct
 						      thermal_zone_device,
 						      poll_queue.work);
-	thermal_zone_device_update(tz);
+	thermal_zone_device_update(tz, THERMAL_DEVICE_EVENT_NONE);
 }
 
 /* sys I/F for thermal zone */
@@ -794,7 +795,7 @@ passive_store(struct device *dev, struct device_attribute *attr,
 
 	tz->forced_passive = state;
 
-	thermal_zone_device_update(tz);
+	thermal_zone_device_update(tz, THERMAL_DEVICE_EVENT_NONE);
 
 	return count;
 }
@@ -885,7 +886,7 @@ emul_temp_store(struct device *dev, struct device_attribute *attr,
 	}
 
 	if (!ret)
-		thermal_zone_device_update(tz);
+		thermal_zone_device_update(tz, THERMAL_DEVICE_EVENT_NONE);
 
 	return ret ? ret : count;
 }
@@ -1872,7 +1873,7 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 
 	INIT_DELAYED_WORK(&(tz->poll_queue), thermal_zone_device_check);
 
-	thermal_zone_device_update(tz);
+	thermal_zone_device_update(tz, THERMAL_DEVICE_EVENT_NONE);
 
 	return tz;
 
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index b213a12..ab2a011 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -52,7 +52,7 @@ static void ti_thermal_work(struct work_struct *work)
 	struct ti_thermal_data *data = container_of(work,
 					struct ti_thermal_data, thermal_wq);
 
-	thermal_zone_device_update(data->ti_thermal);
+	thermal_zone_device_update(data->ti_thermal, THERMAL_DEVICE_EVENT_NONE);
 
 	dev_dbg(&data->ti_thermal->device, "updated thermal zone %s\n",
 		data->ti_thermal->type);
@@ -205,7 +205,7 @@ static int ti_thermal_set_mode(struct thermal_zone_device *thermal,
 	data->mode = mode;
 	ti_bandgap_write_update_interval(bgp, data->sensor_id,
 					data->ti_thermal->polling_delay);
-	thermal_zone_device_update(data->ti_thermal);
+	thermal_zone_device_update(data->ti_thermal, THERMAL_DEVICE_EVENT_NONE);
 	dev_dbg(&thermal->device, "thermal polling set for duration=%d msec\n",
 		data->ti_thermal->polling_delay);
 
diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
index 7fc919f..849f682 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -348,7 +348,8 @@ static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
 	}
 	if (notify) {
 		pr_debug("thermal_zone_device_update\n");
-		thermal_zone_device_update(phdev->tzone);
+		thermal_zone_device_update(phdev->tzone,
+					   THERMAL_DEVICE_EVENT_THRESHOLD);
 	}
 }
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 17292fe..c074f6a 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -87,6 +87,13 @@ enum thermal_trend {
 	THERMAL_TREND_DROP_FULL, /* apply lowest cooling action */
 };
 
+enum thermal_device_event_type {
+	THERMAL_DEVICE_EVENT_NONE, /* No specific reason */
+	THERMAL_DEVICE_EVENT_THRESHOLD, /* temp thereshold event */
+	THERMAL_DEVICE_EVENT_TEMP_SAMPLE, /* New temp sample notify */
+	THERMAL_DEVICE_TRIP_TEMP_CHANGE, /* trip temp change */
+};
+
 struct thermal_zone_device_ops {
 	int (*bind) (struct thermal_zone_device *,
 		     struct thermal_cooling_device *);
@@ -393,7 +400,8 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
 				     unsigned int);
 int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
 				       struct thermal_cooling_device *);
-void thermal_zone_device_update(struct thermal_zone_device *);
+void thermal_zone_device_update(struct thermal_zone_device *,
+				enum thermal_device_event_type);
 
 struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
 		const struct thermal_cooling_device_ops *);
@@ -436,7 +444,8 @@ static inline int thermal_zone_unbind_cooling_device(
 	struct thermal_zone_device *tz, int trip,
 	struct thermal_cooling_device *cdev)
 { return -ENODEV; }
-static inline void thermal_zone_device_update(struct thermal_zone_device *tz)
+static inline void thermal_zone_device_update(struct thermal_zone_device *tz,
+					      enum thermal_device_event_type)
 { }
 static inline struct thermal_cooling_device *
 thermal_cooling_device_register(char *type, void *devdata,
-- 
1.9.3

