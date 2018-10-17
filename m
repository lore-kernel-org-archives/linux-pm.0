From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 01/17] thermal: add thermal_zone_set_mode() helper
Date: Wed, 17 Oct 2018 17:52:27 +0200
Message-ID: <1539791563-5959-2-git-send-email-b.zolnierkie@samsung.com>
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155320epcas2p439b713149d94aa485b3c2ffba063ea03@epcas2p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Amit kucheria <amit.kucheria@linaro.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

In order to remove the code duplication and prepare for further
changes:

* Add thermal_zone_set_mode() helper. Then update core code and
  drivers to use it.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/hisi_thermal.c     | 14 ++------------
 drivers/thermal/of-thermal.c       |  3 ++-
 drivers/thermal/rockchip_thermal.c | 26 +++++++++-----------------
 drivers/thermal/thermal_helpers.c  | 14 ++++++++++++++
 drivers/thermal/thermal_sysfs.c    |  8 +++++---
 include/linux/thermal.h            |  5 +++++
 6 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 761d055..b3f8d9f 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -515,15 +515,6 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 };
 MODULE_DEVICE_TABLE(of, of_hisi_thermal_match);
 
-static void hisi_thermal_toggle_sensor(struct hisi_thermal_sensor *sensor,
-				       bool on)
-{
-	struct thermal_zone_device *tzd = sensor->tzd;
-
-	tzd->ops->set_mode(tzd,
-		on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED);
-}
-
 static int hisi_thermal_probe(struct platform_device *pdev)
 {
 	struct hisi_thermal_data *data;
@@ -571,7 +562,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 		}
 	}
 
-	hisi_thermal_toggle_sensor(&data->sensor, true);
+	thermal_zone_set_mode((&data->sensor)->tzd, THERMAL_DEVICE_ENABLED);
 
 	return 0;
 }
@@ -579,9 +570,8 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 static int hisi_thermal_remove(struct platform_device *pdev)
 {
 	struct hisi_thermal_data *data = platform_get_drvdata(pdev);
-	struct hisi_thermal_sensor *sensor = &data->sensor;
 
-	hisi_thermal_toggle_sensor(sensor, false);
+	thermal_zone_set_mode((&data->sensor)->tzd, THERMAL_DEVICE_DISABLED);
 
 	data->disable_sensor(data);
 
diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 4f28165..118910c 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -496,7 +496,8 @@ struct thermal_zone_device *
 			tzd = thermal_zone_of_add_sensor(child, sensor_np,
 							 data, ops);
 			if (!IS_ERR(tzd))
-				tzd->ops->set_mode(tzd, THERMAL_DEVICE_ENABLED);
+				thermal_zone_set_mode(tzd,
+						      THERMAL_DEVICE_ENABLED);
 
 			of_node_put(sensor_specs.np);
 			of_node_put(child);
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index f36375d..2edd44c 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1022,15 +1022,6 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 };
 MODULE_DEVICE_TABLE(of, of_rockchip_thermal_match);
 
-static void
-rockchip_thermal_toggle_sensor(struct rockchip_thermal_sensor *sensor, bool on)
-{
-	struct thermal_zone_device *tzd = sensor->tzd;
-
-	tzd->ops->set_mode(tzd,
-		on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED);
-}
-
 static irqreturn_t rockchip_thermal_alarm_irq_thread(int irq, void *dev)
 {
 	struct rockchip_thermal_data *thermal = dev;
@@ -1292,7 +1283,8 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 	thermal->chip->control(thermal->regs, true);
 
 	for (i = 0; i < thermal->chip->chn_num; i++)
-		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
+		thermal_zone_set_mode((&thermal->sensors[i])->tzd,
+				      THERMAL_DEVICE_ENABLED);
 
 	platform_set_drvdata(pdev, thermal);
 
@@ -1311,11 +1303,9 @@ static int rockchip_thermal_remove(struct platform_device *pdev)
 	struct rockchip_thermal_data *thermal = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < thermal->chip->chn_num; i++) {
-		struct rockchip_thermal_sensor *sensor = &thermal->sensors[i];
-
-		rockchip_thermal_toggle_sensor(sensor, false);
-	}
+	for (i = 0; i < thermal->chip->chn_num; i++)
+		thermal_zone_set_mode((&thermal->sensors[i])->tzd,
+				      THERMAL_DEVICE_DISABLED);
 
 	thermal->chip->control(thermal->regs, false);
 
@@ -1332,7 +1322,8 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
 	int i;
 
 	for (i = 0; i < thermal->chip->chn_num; i++)
-		rockchip_thermal_toggle_sensor(&thermal->sensors[i], false);
+		thermal_zone_set_mode((&thermal->sensors[i])->tzd,
+				      THERMAL_DEVICE_DISABLED);
 
 	thermal->chip->control(thermal->regs, false);
 
@@ -1383,7 +1374,8 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
 	thermal->chip->control(thermal->regs, true);
 
 	for (i = 0; i < thermal->chip->chn_num; i++)
-		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
+		thermal_zone_set_mode((&thermal->sensors[i])->tzd,
+				      THERMAL_DEVICE_ENABLED);
 
 	pinctrl_pm_select_default_state(dev);
 
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 2ba756a..b18cee2 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -224,3 +224,17 @@ int thermal_zone_get_offset(struct thermal_zone_device *tz)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_offset);
+
+/**
+ * thermal_zone_set_mode() - sets mode of thermal zone device
+ * @tz: a valid pointer to a struct thermal_zone_device
+ * @mode: mode to be set
+ *
+ * Return: On success returns 0, an error code otherwise.
+ */
+int thermal_zone_set_mode(struct thermal_zone_device *tz,
+			  enum thermal_device_mode mode)
+{
+	return tz->ops->set_mode(tz, mode);
+}
+EXPORT_SYMBOL_GPL(thermal_zone_set_mode);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 2241cea..2e9e762 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -69,17 +69,19 @@
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	int result;
+	enum thermal_device_mode mode;
 
 	if (!tz->ops->set_mode)
 		return -EPERM;
 
 	if (!strncmp(buf, "enabled", sizeof("enabled") - 1))
-		result = tz->ops->set_mode(tz, THERMAL_DEVICE_ENABLED);
+		mode = THERMAL_DEVICE_ENABLED;
 	else if (!strncmp(buf, "disabled", sizeof("disabled") - 1))
-		result = tz->ops->set_mode(tz, THERMAL_DEVICE_DISABLED);
+		mode = THERMAL_DEVICE_DISABLED;
 	else
-		result = -EINVAL;
+		return -EINVAL;
 
+	result = thermal_zone_set_mode(tz, mode);
 	if (result)
 		return result;
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 5f4705f..9d21fd1 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -452,6 +452,8 @@ struct thermal_cooling_device *
 int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 int thermal_zone_get_slope(struct thermal_zone_device *tz);
 int thermal_zone_get_offset(struct thermal_zone_device *tz);
+int thermal_zone_set_mode(struct thermal_zone_device *tz,
+			  enum thermal_device_mode mode);
 
 int get_tz_trend(struct thermal_zone_device *, int);
 struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
@@ -518,6 +520,9 @@ static inline int thermal_zone_get_slope(
 static inline int thermal_zone_get_offset(
 		struct thermal_zone_device *tz)
 { return -ENODEV; }
+static inline int thermal_zone_set_mode(
+		struct thermal_zone_device *tz, enum thermal_device_mode mode)
+{ return -ENODEV; }
 static inline int get_tz_trend(struct thermal_zone_device *tz, int trip)
 { return -ENODEV; }
 static inline struct thermal_instance *
-- 
1.9.1
