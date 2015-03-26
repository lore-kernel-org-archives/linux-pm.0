From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 07/13] thermal: of: streamline .get_temp callbacks
Date: Thu, 26 Mar 2015 16:53:54 +0100
Message-ID: <1427385240-6086-8-git-send-email-s.hauer@pengutronix.de>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

In the thermal framework it was decided that temperatures can't
be negative, so let the .get_temp callback in struct
thermal_zone_of_device_ops take an unsigned long pointer for
the temperature like the .get_temp callback in
struct thermal_zone_device_ops does.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/hwmon/lm75.c                               | 2 +-
 drivers/hwmon/ntc_thermistor.c                     | 2 +-
 drivers/hwmon/tmp102.c                             | 2 +-
 drivers/input/touchscreen/sun4i-ts.c               | 2 +-
 drivers/thermal/rockchip_thermal.c                 | 2 +-
 drivers/thermal/samsung/exynos_tmu.c               | 2 +-
 drivers/thermal/tegra_soctherm.c                   | 2 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 2 +-
 include/linux/thermal.h                            | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index fe41d5a..9df3ca3 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -104,7 +104,7 @@ static inline long lm75_reg_to_mc(s16 temp, u8 resolution)
 
 /* sysfs attributes for hwmon */
 
-static int lm75_read_temp(void *dev, long *temp)
+static int lm75_read_temp(void *dev, unsigned long *temp)
 {
 	struct lm75_data *data = lm75_update_device(dev);
 
diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index 112e4d4..12cb333 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -430,7 +430,7 @@ static int ntc_thermistor_get_ohm(struct ntc_data *data)
 	return -EINVAL;
 }
 
-static int ntc_read_temp(void *dev, long *temp)
+static int ntc_read_temp(void *dev, unsigned long *temp)
 {
 	struct ntc_data *data = dev_get_drvdata(dev);
 	int ohm;
diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index 9da2735..25bd72b 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -98,7 +98,7 @@ static struct tmp102 *tmp102_update_device(struct device *dev)
 	return tmp102;
 }
 
-static int tmp102_read_temp(void *dev, long *temp)
+static int tmp102_read_temp(void *dev, unsigned long *temp)
 {
 	struct tmp102 *tmp102 = tmp102_update_device(dev);
 
diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
index b93a28b..26a7cf5 100644
--- a/drivers/input/touchscreen/sun4i-ts.c
+++ b/drivers/input/touchscreen/sun4i-ts.c
@@ -198,7 +198,7 @@ static int sun4i_get_temp(const struct sun4i_ts_data *ts, long *temp)
 	return 0;
 }
 
-static int sun4i_get_tz_temp(void *data, long *temp)
+static int sun4i_get_tz_temp(void *data, unsigned long *temp)
 {
 	return sun4i_get_temp(data, temp);
 }
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 3aa46ac..67dfc67 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -366,7 +366,7 @@ static irqreturn_t rockchip_thermal_alarm_irq_thread(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static int rockchip_thermal_get_temp(void *_sensor, long *out_temp)
+static int rockchip_thermal_get_temp(void *_sensor, unsigned long *out_temp)
 {
 	struct rockchip_thermal_sensor *sensor = _sensor;
 	struct rockchip_thermal_data *thermal = sensor->thermal;
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 1d30b09..5f721f2 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -713,7 +713,7 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
 }
 
-static int exynos_get_temp(void *p, long *temp)
+static int exynos_get_temp(void *p, unsigned long *temp)
 {
 	struct exynos_tmu_data *data = p;
 
diff --git a/drivers/thermal/tegra_soctherm.c b/drivers/thermal/tegra_soctherm.c
index 9197fc0..1c4e455 100644
--- a/drivers/thermal/tegra_soctherm.c
+++ b/drivers/thermal/tegra_soctherm.c
@@ -306,7 +306,7 @@ static long translate_temp(u16 val)
 	return t;
 }
 
-static int tegra_thermctl_get_temp(void *data, long *out_temp)
+static int tegra_thermctl_get_temp(void *data, unsigned long *out_temp)
 {
 	struct tegra_thermctl_zone *zone = data;
 	u32 val;
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 7f8e5f3..f480a01 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -76,7 +76,7 @@ static inline int ti_thermal_hotspot_temperature(int t, int s, int c)
 
 /* thermal zone ops */
 /* Get temperature callback function for thermal zone*/
-static inline int __ti_thermal_get_temp(void *devdata, long *temp)
+static inline int __ti_thermal_get_temp(void *devdata, unsigned long *temp)
 {
 	struct thermal_zone_device *pcb_tz = NULL;
 	struct ti_thermal_data *data = devdata;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index ba2e29a..2f77091 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -272,7 +272,7 @@ struct thermal_genl_event {
  *		   temperature.
  */
 struct thermal_zone_of_device_ops {
-	int (*get_temp)(void *, long *);
+	int (*get_temp)(void *, unsigned long *);
 	int (*get_trend)(void *, int trend, enum thermal_trend *);
 	int (*set_emul_temp)(void *, unsigned long);
 };
-- 
2.1.4
