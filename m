From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 02/17] thermal: add thermal_zone_device_check() helper
Date: Wed, 17 Oct 2018 17:52:28 +0200
Message-ID: <1539791563-5959-3-git-send-email-b.zolnierkie@samsung.com>
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155326epcas2p21d8b703f27fe54561a0f741fa7920dce@epcas2p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Amit kucheria <amit.kucheria@linaro.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

In order to remove the code duplication and prepare for further
changes:

* Rename static thermal_zone_device_check() helper in thermal_core.c
  to thermal_zone_device_work_check().

* Add thermal_zone_device_check() helper. Then update core code and
  drivers to use it.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/acpi/thermal.c                             |  3 +--
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |  3 ++-
 drivers/platform/x86/acerhdf.c                     |  4 +++-
 drivers/regulator/max8973-regulator.c              |  3 +--
 drivers/thermal/da9062-thermal.c                   |  7 ++-----
 drivers/thermal/db8500_thermal.c                   |  3 ++-
 drivers/thermal/hisi_thermal.c                     |  4 +---
 drivers/thermal/imx_thermal.c                      |  5 +++--
 drivers/thermal/intel_bxt_pmic_thermal.c           |  3 +--
 drivers/thermal/intel_soc_dts_iosf.c               |  3 +--
 drivers/thermal/max77620_thermal.c                 |  3 +--
 drivers/thermal/of-thermal.c                       |  3 ++-
 drivers/thermal/qcom-spmi-temp-alarm.c             |  2 +-
 drivers/thermal/rcar_gen3_thermal.c                |  3 +--
 drivers/thermal/rcar_thermal.c                     |  3 +--
 drivers/thermal/rockchip_thermal.c                 |  3 +--
 drivers/thermal/samsung/exynos_tmu.c               |  2 +-
 drivers/thermal/st/st_thermal_memmap.c             |  3 +--
 drivers/thermal/thermal_core.c                     | 14 ++++++--------
 drivers/thermal/thermal_helpers.c                  |  6 ++++++
 drivers/thermal/thermal_sysfs.c                    |  6 +++---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  2 +-
 drivers/thermal/uniphier_thermal.c                 |  2 +-
 drivers/thermal/x86_pkg_temp_thermal.c             |  2 +-
 include/linux/thermal.h                            |  3 +++
 25 files changed, 47 insertions(+), 48 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 551b71a..b8b275e1 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -520,8 +520,7 @@ static void acpi_thermal_check(void *data)
 	if (!tz->tz_enabled)
 		return;
 
-	thermal_zone_device_update(tz->thermal_zone,
-				   THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(tz->thermal_zone);
 }
 
 /* sys I/F for generic thermal sysfs support */
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index 6d29dc4..b0afd36 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -169,7 +169,8 @@ static int mlxsw_thermal_set_mode(struct thermal_zone_device *tzdev,
 	mutex_unlock(&tzdev->lock);
 
 	thermal->mode = mode;
-	thermal_zone_device_update(tzdev, THERMAL_EVENT_UNSPECIFIED);
+
+	thermal_zone_device_check(tzdev);
 
 	return 0;
 }
diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 5052242..5a2b93a 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -417,7 +417,9 @@ static inline void acerhdf_enable_kernelmode(void)
 	kernelmode = 1;
 
 	thz_dev->polling_delay = interval*1000;
-	thermal_zone_device_update(thz_dev, THERMAL_EVENT_UNSPECIFIED);
+
+	thermal_zone_device_check(thz_dev);
+
 	pr_notice("kernel mode fan control ON\n");
 }
 
diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index 7cd493e..9a522ed 100644
--- a/drivers/regulator/max8973-regulator.c
+++ b/drivers/regulator/max8973-regulator.c
@@ -495,8 +495,7 @@ static irqreturn_t max8973_thermal_irq(int irq, void *data)
 {
 	struct max8973_chip *mchip = data;
 
-	thermal_zone_device_update(mchip->tz_device,
-				   THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(mchip->tz_device);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index dd8dd94..8c6721b 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -102,9 +102,7 @@ static void da9062_thermal_poll_on(struct work_struct *work)
 		mutex_lock(&thermal->lock);
 		thermal->temperature = DA9062_MILLI_CELSIUS(125);
 		mutex_unlock(&thermal->lock);
-		thermal_zone_device_update(thermal->zone,
-					   THERMAL_EVENT_UNSPECIFIED);
-
+		thermal_zone_device_check(thermal->zone);
 		delay = msecs_to_jiffies(thermal->zone->passive_delay);
 		schedule_delayed_work(&thermal->work, delay);
 		return;
@@ -113,8 +111,7 @@ static void da9062_thermal_poll_on(struct work_struct *work)
 	mutex_lock(&thermal->lock);
 	thermal->temperature = DA9062_MILLI_CELSIUS(0);
 	mutex_unlock(&thermal->lock);
-	thermal_zone_device_update(thermal->zone,
-				   THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(thermal->zone);
 
 err_enable_irq:
 	enable_irq(thermal->irq);
diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index f491faf..ab66b2d7 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -306,7 +306,8 @@ static void db8500_thermal_work(struct work_struct *work)
 	if (cur_mode == THERMAL_DEVICE_DISABLED)
 		return;
 
-	thermal_zone_device_update(pzone->therm_dev, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(pzone->therm_dev);
+
 	dev_dbg(&pzone->therm_dev->device, "thermal work finished.\n");
 }
 
diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index b3f8d9f..63d4fc3 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -461,9 +461,7 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 		dev_crit(&data->pdev->dev, "THERMAL ALARM: %d > %d\n",
 			 temp, sensor->thres_temp);
 
-		thermal_zone_device_update(data->sensor.tzd,
-					   THERMAL_EVENT_UNSPECIFIED);
-
+		thermal_zone_device_check(data->sensor.tzd);
 	} else {
 		dev_crit(&data->pdev->dev, "THERMAL ALARM stopped: %d < %d\n",
 			 temp, sensor->thres_temp);
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index aa452ac..22f57ef 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -384,7 +384,8 @@ static int imx_set_mode(struct thermal_zone_device *tz,
 	}
 
 	data->mode = mode;
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+
+	thermal_zone_device_check(tz);
 
 	return 0;
 }
@@ -635,7 +636,7 @@ static irqreturn_t imx_thermal_alarm_irq_thread(int irq, void *dev)
 	dev_dbg(&data->tz->device, "THERMAL ALARM: T > %d\n",
 		data->alarm_temp / 1000);
 
-	thermal_zone_device_update(data->tz, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(data->tz);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/intel_bxt_pmic_thermal.c b/drivers/thermal/intel_bxt_pmic_thermal.c
index 94cfd00..73fe97b 100644
--- a/drivers/thermal/intel_bxt_pmic_thermal.c
+++ b/drivers/thermal/intel_bxt_pmic_thermal.c
@@ -203,8 +203,7 @@ static irqreturn_t pmic_thermal_irq_handler(int irq, void *data)
 
 			tzd = thermal_zone_get_zone_by_name(td->maps[i].handle);
 			if (!IS_ERR(tzd))
-				thermal_zone_device_update(tzd,
-						THERMAL_EVENT_UNSPECIFIED);
+				thermal_zone_device_check(tzd);
 
 			/* Clear the appropriate irq */
 			regmap_write(regmap, reg, reg_val & mask);
diff --git a/drivers/thermal/intel_soc_dts_iosf.c b/drivers/thermal/intel_soc_dts_iosf.c
index e0813df..caa8776 100644
--- a/drivers/thermal/intel_soc_dts_iosf.c
+++ b/drivers/thermal/intel_soc_dts_iosf.c
@@ -391,8 +391,7 @@ void intel_soc_dts_iosf_interrupt_handler(struct intel_soc_dts_sensors *sensors)
 
 		for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
 			pr_debug("TZD update for zone %d\n", i);
-			thermal_zone_device_update(sensors->soc_dts[i].tzone,
-						   THERMAL_EVENT_UNSPECIFIED);
+			thermal_zone_device_check(sensors->soc_dts[i].tzone);
 		}
 	} else
 		spin_unlock_irqrestore(&sensors->intr_notify_lock, flags);
diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index 159bbce..e6bc69f 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -82,8 +82,7 @@ static irqreturn_t max77620_thermal_irq(int irq, void *data)
 	else if (irq == mtherm->irq_tjalarm2)
 		dev_crit(mtherm->dev, "Junction Temp Alarm2(140C) occurred\n");
 
-	thermal_zone_device_update(mtherm->tz_device,
-				   THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(mtherm->tz_device);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 118910c..c422b08 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -271,7 +271,8 @@ static int of_thermal_set_mode(struct thermal_zone_device *tz,
 	mutex_unlock(&tz->lock);
 
 	data->mode = mode;
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+
+	thermal_zone_device_check(tz);
 
 	return 0;
 }
diff --git a/drivers/thermal/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom-spmi-temp-alarm.c
index ad4f3a8..d3910be 100644
--- a/drivers/thermal/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom-spmi-temp-alarm.c
@@ -188,7 +188,7 @@ static irqreturn_t qpnp_tm_isr(int irq, void *data)
 {
 	struct qpnp_tm_chip *chip = data;
 
-	thermal_zone_device_update(chip->tz_dev, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(chip->tz_dev);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 7aed533..e0d9424 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -256,8 +256,7 @@ static irqreturn_t rcar_gen3_thermal_irq_thread(int irq, void *data)
 	int i;
 
 	for (i = 0; i < priv->num_tscs; i++)
-		thermal_zone_device_update(priv->tscs[i]->zone,
-					   THERMAL_EVENT_UNSPECIFIED);
+		thermal_zone_device_check(priv->tscs[i]->zone);
 
 	spin_lock_irqsave(&priv->lock, flags);
 	rcar_thermal_irq_set(priv, true);
diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 78f9328..6619a48 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -391,8 +391,7 @@ static void rcar_thermal_work(struct work_struct *work)
 		return;
 
 	if (nctemp != cctemp)
-		thermal_zone_device_update(priv->zone,
-					   THERMAL_EVENT_UNSPECIFIED);
+		thermal_zone_device_check(priv->zone);
 }
 
 static u32 rcar_thermal_had_changed(struct rcar_thermal_priv *priv, u32 status)
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 2edd44c..5640675 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1032,8 +1032,7 @@ static irqreturn_t rockchip_thermal_alarm_irq_thread(int irq, void *dev)
 	thermal->chip->irq_ack(thermal->regs);
 
 	for (i = 0; i < thermal->chip->chn_num; i++)
-		thermal_zone_device_update(thermal->sensors[i].tzd,
-					   THERMAL_EVENT_UNSPECIFIED);
+		thermal_zone_device_check(thermal->sensors[i].tzd);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 48eef55..9e98b12 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -789,7 +789,7 @@ static void exynos_tmu_work(struct work_struct *work)
 	struct exynos_tmu_data *data = container_of(work,
 			struct exynos_tmu_data, irq_work);
 
-	thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(data->tzd);
 
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index 91d4231..323c42f 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -42,8 +42,7 @@ static irqreturn_t st_mmap_thermal_trip_handler(int irq, void *sdata)
 {
 	struct st_thermal_sensor *sensor = sdata;
 
-	thermal_zone_device_update(sensor->thermal_dev,
-				   THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(sensor->thermal_dev);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6ab9823..1fbd4bd 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -501,12 +501,12 @@ void thermal_notify_framework(struct thermal_zone_device *tz, int trip)
 }
 EXPORT_SYMBOL_GPL(thermal_notify_framework);
 
-static void thermal_zone_device_check(struct work_struct *work)
+static void thermal_zone_device_work_check(struct work_struct *work)
 {
 	struct thermal_zone_device *tz = container_of(work, struct
 						      thermal_zone_device,
 						      poll_queue.work);
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(tz);
 }
 
 /*
@@ -990,8 +990,7 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
 	mutex_lock(&thermal_list_lock);
 	list_for_each_entry(pos, &thermal_tz_list, node)
 		if (atomic_cmpxchg(&pos->need_update, 1, 0))
-			thermal_zone_device_update(pos,
-						   THERMAL_EVENT_UNSPECIFIED);
+			thermal_zone_device_check(pos);
 	mutex_unlock(&thermal_list_lock);
 
 	return cdev;
@@ -1273,12 +1272,12 @@ struct thermal_zone_device *
 	/* Bind cooling devices for this zone */
 	bind_tz(tz);
 
-	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
+	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_work_check);
 
 	thermal_zone_device_reset(tz);
 	/* Update the new thermal zone and mark it as already updated. */
 	if (atomic_cmpxchg(&tz->need_update, 1, 0))
-		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+		thermal_zone_device_check(tz);
 
 	return tz;
 
@@ -1502,8 +1501,7 @@ static int thermal_pm_notify(struct notifier_block *nb,
 		atomic_set(&in_suspend, 0);
 		list_for_each_entry(tz, &thermal_tz_list, node) {
 			thermal_zone_device_reset(tz);
-			thermal_zone_device_update(tz,
-						   THERMAL_EVENT_UNSPECIFIED);
+			thermal_zone_device_check(tz);
 		}
 		break;
 	default:
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index b18cee2..14b7a7e 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -238,3 +238,9 @@ int thermal_zone_set_mode(struct thermal_zone_device *tz,
 	return tz->ops->set_mode(tz, mode);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_set_mode);
+
+void thermal_zone_device_check(struct thermal_zone_device *tz)
+{
+	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+}
+EXPORT_SYMBOL_GPL(thermal_zone_device_check);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 2e9e762..3b38fb9 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -141,7 +141,7 @@
 	if (ret)
 		return ret;
 
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(tz);
 
 	return count;
 }
@@ -246,7 +246,7 @@
 
 	tz->forced_passive = state;
 
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(tz);
 
 	return count;
 }
@@ -313,7 +313,7 @@
 	}
 
 	if (!ret)
-		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+		thermal_zone_device_check(tz);
 
 	return ret ? ret : count;
 }
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index b4f981d..b80b6e2 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -54,7 +54,7 @@ static void ti_thermal_work(struct work_struct *work)
 	struct ti_thermal_data *data = container_of(work,
 					struct ti_thermal_data, thermal_wq);
 
-	thermal_zone_device_update(data->ti_thermal, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(data->ti_thermal);
 
 	dev_dbg(&data->ti_thermal->device, "updated thermal zone %s\n",
 		data->ti_thermal->type);
diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index 55477d7..bb95983 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -248,7 +248,7 @@ static irqreturn_t uniphier_tm_alarm_irq_thread(int irq, void *_tdev)
 {
 	struct uniphier_tm_dev *tdev = _tdev;
 
-	thermal_zone_device_update(tdev->tz_dev, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(tdev->tz_dev);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
index 1ef937d..745defc 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -317,7 +317,7 @@ static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
 	 * concurrent removal in the cpu offline callback.
 	 */
 	if (tzone)
-		thermal_zone_device_update(tzone, THERMAL_EVENT_UNSPECIFIED);
+		thermal_zone_device_check(tzone);
 
 	mutex_unlock(&thermal_zone_mutex);
 }
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 9d21fd1..3e325b3 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -454,6 +454,7 @@ struct thermal_cooling_device *
 int thermal_zone_get_offset(struct thermal_zone_device *tz);
 int thermal_zone_set_mode(struct thermal_zone_device *tz,
 			  enum thermal_device_mode mode);
+void thermal_zone_device_check(struct thermal_zone_device *tz);
 
 int get_tz_trend(struct thermal_zone_device *, int);
 struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
@@ -523,6 +524,8 @@ static inline int thermal_zone_get_offset(
 static inline int thermal_zone_set_mode(
 		struct thermal_zone_device *tz, enum thermal_device_mode mode)
 { return -ENODEV; }
+static inline void thermal_zone_device_check(struct thermal_zone_device *tz)
+{ }
 static inline int get_tz_trend(struct thermal_zone_device *tz, int trip)
 { return -ENODEV; }
 static inline struct thermal_instance *
-- 
1.9.1
