From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/4] thermal: Enhance thermal_zone_device_update for events
Date: Fri, 26 Aug 2016 16:21:16 -0700
Message-ID: <1472253679-15084-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1472253679-15084-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:35062 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752118AbcHZXVb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Aug 2016 19:21:31 -0400
In-Reply-To: <1472253679-15084-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Added one additional parameter to thermal_zone_device_update() to provide
caller with an optional capability to specify reason.
Currently this event is used by user space governor to trigger different
processing based on event code. Also it saves an additional call to read
temperature when the event is received.
The following events are cuurently defined:
- Unspecified event
- New temperature sample
- Trip point violated
- Trip point changed
- thermal device up and down
- thermal device power capability changed

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/thermal.c                              |  3 ++-
 drivers/platform/x86/acerhdf.c                      |  2 +-
 drivers/regulator/max8973-regulator.c               |  3 ++-
 drivers/thermal/db8500_thermal.c                    |  2 +-
 drivers/thermal/hisi_thermal.c                      |  3 ++-
 drivers/thermal/imx_thermal.c                       |  4 ++--
 .../thermal/int340x_thermal/int340x_thermal_zone.h  |  2 +-
 drivers/thermal/intel_soc_dts_iosf.c                |  3 ++-
 drivers/thermal/of-thermal.c                        |  2 +-
 drivers/thermal/qcom-spmi-temp-alarm.c              |  2 +-
 drivers/thermal/rcar_thermal.c                      |  3 ++-
 drivers/thermal/rockchip_thermal.c                  |  3 ++-
 drivers/thermal/samsung/exynos_tmu.c                |  2 +-
 drivers/thermal/st/st_thermal_memmap.c              |  3 ++-
 drivers/thermal/thermal_core.c                      | 21 +++++++++++++--------
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c  |  4 ++--
 drivers/thermal/x86_pkg_temp_thermal.c              |  3 ++-
 include/linux/thermal.h                             | 19 +++++++++++++++++--
 18 files changed, 56 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index f4ebe39..35e8fbc 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -520,7 +520,8 @@ static void acpi_thermal_check(void *data)
 	if (!tz->tz_enabled)
 		return;
 
-	thermal_zone_device_update(tz->thermal_zone);
+	thermal_zone_device_update(tz->thermal_zone,
+				   THERMAL_EVENT_UNSPECIFIED);
 }
 
 /* sys I/F for generic thermal sysfs support */
diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 460fa67..2acdb0d 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -405,7 +405,7 @@ static inline void acerhdf_enable_kernelmode(void)
 	kernelmode = 1;
 
 	thz_dev->polling_delay = interval*1000;
-	thermal_zone_device_update(thz_dev);
+	thermal_zone_device_update(thz_dev, THERMAL_EVENT_UNSPECIFIED);
 	pr_notice("kernel mode fan control ON\n");
 }
 
diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index 3958f50..e0c747a 100644
--- a/drivers/regulator/max8973-regulator.c
+++ b/drivers/regulator/max8973-regulator.c
@@ -495,7 +495,8 @@ static irqreturn_t max8973_thermal_irq(int irq, void *data)
 {
 	struct max8973_chip *mchip = data;
 
-	thermal_zone_device_update(mchip->tz_device);
+	thermal_zone_device_update(mchip->tz_device,
+				   THERMAL_EVENT_UNSPECIFIED);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index 652acd8..e776cea 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -306,7 +306,7 @@ static void db8500_thermal_work(struct work_struct *work)
 	if (cur_mode == THERMAL_DEVICE_DISABLED)
 		return;
 
-	thermal_zone_device_update(pzone->therm_dev);
+	thermal_zone_device_update(pzone->therm_dev, THERMAL_EVENT_UNSPECIFIED);
 	dev_dbg(&pzone->therm_dev->device, "thermal work finished.\n");
 }
 
diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 97fad8f..f642966 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -237,7 +237,8 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 		if (!data->sensors[i].tzd)
 			continue;
 
-		thermal_zone_device_update(data->sensors[i].tzd);
+		thermal_zone_device_update(data->sensors[i].tzd,
+					   THERMAL_EVENT_UNSPECIFIED);
 	}
 
 	return IRQ_HANDLED;
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index c5547bd..307737a 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -246,7 +246,7 @@ static int imx_set_mode(struct thermal_zone_device *tz,
 	}
 
 	data->mode = mode;
-	thermal_zone_device_update(tz);
+	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
 	return 0;
 }
@@ -457,7 +457,7 @@ static irqreturn_t imx_thermal_alarm_irq_thread(int irq, void *dev)
 	dev_dbg(&data->tz->device, "THERMAL ALARM: T > %d\n",
 		data->alarm_temp / 1000);
 
-	thermal_zone_device_update(data->tz);
+	thermal_zone_device_update(data->tz, THERMAL_EVENT_UNSPECIFIED);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/int340x_thermal/int340x_thermal_zone.h b/drivers/thermal/int340x_thermal/int340x_thermal_zone.h
index aaadf72..65116b1 100644
--- a/drivers/thermal/int340x_thermal/int340x_thermal_zone.h
+++ b/drivers/thermal/int340x_thermal/int340x_thermal_zone.h
@@ -62,7 +62,7 @@ static inline void *int340x_thermal_zone_get_priv_data(
 static inline void int340x_thermal_zone_device_update(
 			struct int34x_thermal_zone *tzone)
 {
-	thermal_zone_device_update(tzone->zone);
+	thermal_zone_device_update(tzone->zone, THERMAL_EVENT_UNSPECIFIED);
 }
 
 #endif
diff --git a/drivers/thermal/intel_soc_dts_iosf.c b/drivers/thermal/intel_soc_dts_iosf.c
index f72e1db..e0813df 100644
--- a/drivers/thermal/intel_soc_dts_iosf.c
+++ b/drivers/thermal/intel_soc_dts_iosf.c
@@ -391,7 +391,8 @@ void intel_soc_dts_iosf_interrupt_handler(struct intel_soc_dts_sensors *sensors)
 
 		for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
 			pr_debug("TZD update for zone %d\n", i);
-			thermal_zone_device_update(sensors->soc_dts[i].tzone);
+			thermal_zone_device_update(sensors->soc_dts[i].tzone,
+						   THERMAL_EVENT_UNSPECIFIED);
 		}
 	} else
 		spin_unlock_irqrestore(&sensors->intr_notify_lock, flags);
diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index b8e509c..f73b9f3 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -292,7 +292,7 @@ static int of_thermal_set_mode(struct thermal_zone_device *tz,
 	mutex_unlock(&tz->lock);
 
 	data->mode = mode;
-	thermal_zone_device_update(tz);
+	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
 	return 0;
 }
diff --git a/drivers/thermal/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom-spmi-temp-alarm.c
index f8a3c60..819c6d5 100644
--- a/drivers/thermal/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom-spmi-temp-alarm.c
@@ -150,7 +150,7 @@ static irqreturn_t qpnp_tm_isr(int irq, void *data)
 {
 	struct qpnp_tm_chip *chip = data;
 
-	thermal_zone_device_update(chip->tz_dev);
+	thermal_zone_device_update(chip->tz_dev, THERMAL_EVENT_UNSPECIFIED);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 71a3392..a34c8de 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -354,7 +354,8 @@ static void rcar_thermal_work(struct work_struct *work)
 		return;
 
 	if (nctemp != cctemp)
-		thermal_zone_device_update(priv->zone);
+		thermal_zone_device_update(priv->zone,
+					   THERMAL_EVENT_UNSPECIFIED);
 }
 
 static u32 rcar_thermal_had_changed(struct rcar_thermal_priv *priv, u32 status)
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 5d491f1..f60f101 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -821,7 +821,8 @@ static irqreturn_t rockchip_thermal_alarm_irq_thread(int irq, void *dev)
 	thermal->chip->irq_ack(thermal->regs);
 
 	for (i = 0; i < thermal->chip->chn_num; i++)
-		thermal_zone_device_update(thermal->sensors[i].tzd);
+		thermal_zone_device_update(thermal->sensors[i].tzd,
+					   THERMAL_EVENT_UNSPECIFIED);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index f3ce94e..ad1186d 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -225,7 +225,7 @@ static void exynos_report_trigger(struct exynos_tmu_data *p)
 		return;
 	}
 
-	thermal_zone_device_update(tz);
+	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
 	mutex_lock(&tz->lock);
 	/* Find the level for which trip happened */
diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index fc0c9e1..91d4231 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -42,7 +42,8 @@ static irqreturn_t st_mmap_thermal_trip_handler(int irq, void *sdata)
 {
 	struct st_thermal_sensor *sensor = sdata;
 
-	thermal_zone_device_update(sensor->thermal_dev);
+	thermal_zone_device_update(sensor->thermal_dev,
+				   THERMAL_EVENT_UNSPECIFIED);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index e2fc616..0ffc1cd 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -557,7 +557,8 @@ static void thermal_zone_device_reset(struct thermal_zone_device *tz)
 		pos->initialized = false;
 }
 
-void thermal_zone_device_update(struct thermal_zone_device *tz)
+void thermal_zone_device_update(struct thermal_zone_device *tz,
+				enum thermal_notify_event event)
 {
 	int count;
 
@@ -569,6 +570,8 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 
 	update_temperature(tz);
 
+	tz->notify_event = event;
+
 	for (count = 0; count < tz->trips; count++)
 		handle_thermal_trip(tz, count);
 }
@@ -579,7 +582,7 @@ static void thermal_zone_device_check(struct work_struct *work)
 	struct thermal_zone_device *tz = container_of(work, struct
 						      thermal_zone_device,
 						      poll_queue.work);
-	thermal_zone_device_update(tz);
+	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 }
 
 /* sys I/F for thermal zone */
@@ -703,7 +706,7 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	thermal_zone_device_update(tz);
+	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
 	return count;
 }
@@ -822,7 +825,7 @@ passive_store(struct device *dev, struct device_attribute *attr,
 
 	tz->forced_passive = state;
 
-	thermal_zone_device_update(tz);
+	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
 	return count;
 }
@@ -913,7 +916,7 @@ emul_temp_store(struct device *dev, struct device_attribute *attr,
 	}
 
 	if (!ret)
-		thermal_zone_device_update(tz);
+		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
 	return ret ? ret : count;
 }
@@ -1509,7 +1512,8 @@ __thermal_cooling_device_register(struct device_node *np,
 	mutex_lock(&thermal_list_lock);
 	list_for_each_entry(pos, &thermal_tz_list, node)
 		if (atomic_cmpxchg(&pos->need_update, 1, 0))
-			thermal_zone_device_update(pos);
+			thermal_zone_device_update(pos,
+						   THERMAL_EVENT_UNSPECIFIED);
 	mutex_unlock(&thermal_list_lock);
 
 	return cdev;
@@ -1952,7 +1956,7 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	thermal_zone_device_reset(tz);
 	/* Update the new thermal zone and mark it as already updated. */
 	if (atomic_cmpxchg(&tz->need_update, 1, 0))
-		thermal_zone_device_update(tz);
+		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
 	return tz;
 
@@ -2209,7 +2213,8 @@ static int thermal_pm_notify(struct notifier_block *nb,
 		atomic_set(&in_suspend, 0);
 		list_for_each_entry(tz, &thermal_tz_list, node) {
 			thermal_zone_device_reset(tz);
-			thermal_zone_device_update(tz);
+			thermal_zone_device_update(tz,
+						   THERMAL_EVENT_UNSPECIFIED);
 		}
 		break;
 	default:
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 15c0a9a..6598a25 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -52,7 +52,7 @@ static void ti_thermal_work(struct work_struct *work)
 	struct ti_thermal_data *data = container_of(work,
 					struct ti_thermal_data, thermal_wq);
 
-	thermal_zone_device_update(data->ti_thermal);
+	thermal_zone_device_update(data->ti_thermal, THERMAL_EVENT_UNSPECIFIED);
 
 	dev_dbg(&data->ti_thermal->device, "updated thermal zone %s\n",
 		data->ti_thermal->type);
@@ -205,7 +205,7 @@ static int ti_thermal_set_mode(struct thermal_zone_device *thermal,
 	data->mode = mode;
 	ti_bandgap_write_update_interval(bgp, data->sensor_id,
 					data->ti_thermal->polling_delay);
-	thermal_zone_device_update(data->ti_thermal);
+	thermal_zone_device_update(data->ti_thermal, THERMAL_EVENT_UNSPECIFIED);
 	dev_dbg(&thermal->device, "thermal polling set for duration=%d msec\n",
 		data->ti_thermal->polling_delay);
 
diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
index 97f0a2b..95f4c1b 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -348,7 +348,8 @@ static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
 	}
 	if (notify) {
 		pr_debug("thermal_zone_device_update\n");
-		thermal_zone_device_update(phdev->tzone);
+		thermal_zone_device_update(phdev->tzone,
+					   THERMAL_EVENT_UNSPECIFIED);
 	}
 }
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index ee517be..6b13e48 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -92,6 +92,17 @@ enum thermal_trend {
 	THERMAL_TREND_DROP_FULL, /* apply lowest cooling action */
 };
 
+/* Thermal notification reason */
+enum thermal_notify_event {
+	THERMAL_EVENT_UNSPECIFIED, /* Unspecified event */
+	THERMAL_EVENT_TEMP_SAMPLE, /* New Temperature sample */
+	THERMAL_TRIP_VIOLATED, /* TRIP Point violation */
+	THERMAL_TRIP_CHANGED, /* TRIP Point temperature changed */
+	THERMAL_DEVICE_DOWN, /* Thermal device is down */
+	THERMAL_DEVICE_UP, /* Thermal device is up after a down event */
+	THERMAL_DEVICE_POWER_CAPABILITY_CHANGED, /* power capability changed */
+};
+
 struct thermal_zone_device_ops {
 	int (*bind) (struct thermal_zone_device *,
 		     struct thermal_cooling_device *);
@@ -182,6 +193,7 @@ struct thermal_attr {
  * @lock:	lock to protect thermal_instances list
  * @node:	node in thermal_tz_list (in thermal_core.c)
  * @poll_queue:	delayed work for polling
+ * @notify_event: Last notification event
  */
 struct thermal_zone_device {
 	int id;
@@ -210,6 +222,7 @@ struct thermal_zone_device {
 	struct mutex lock;
 	struct list_head node;
 	struct delayed_work poll_queue;
+	enum thermal_notify_event notify_event;
 };
 
 /**
@@ -425,7 +438,8 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
 				     unsigned int);
 int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
 				       struct thermal_cooling_device *);
-void thermal_zone_device_update(struct thermal_zone_device *);
+void thermal_zone_device_update(struct thermal_zone_device *,
+				enum thermal_notify_event);
 
 struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
 		const struct thermal_cooling_device_ops *);
@@ -473,7 +487,8 @@ static inline int thermal_zone_unbind_cooling_device(
 	struct thermal_zone_device *tz, int trip,
 	struct thermal_cooling_device *cdev)
 { return -ENODEV; }
-static inline void thermal_zone_device_update(struct thermal_zone_device *tz)
+static inline void thermal_zone_device_update(struct thermal_zone_device *tz,
+					      enum thermal_notify_event event)
 { }
 static inline struct thermal_cooling_device *
 thermal_cooling_device_register(char *type, void *devdata,
-- 
2.7.4

