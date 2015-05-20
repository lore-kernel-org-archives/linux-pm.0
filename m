From: Xinwei Kong <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: [PATCH v6 2/3] thermal: hisilicon: add new hisilicon thermal sensor driver
Date: Wed, 20 May 2015 19:16:37 +0800
Message-ID: <1432120598-18268-3-git-send-email-kong.kongxinwei@hisilicon.com>
References: <1432120598-18268-1-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432120598-18268-1-git-send-email-kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhuang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, Javi.Merino-5wv7dgnIgG8@public.gmane.org, jorge.ramirez-ortiz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dan.zhao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gongyu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, guodong.xu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, zhenwei.wang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org, liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
List-Id: linux-pm@vger.kernel.org

From: kongxinwei <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>

This patch adds the support for hisilicon thermal sensor, within
hisilicon SoC. there will register sensors for thermal framework
and use device tree to bind cooling device.

Signed-off-by: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: kongxinwei <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
---
 drivers/thermal/Kconfig        |   8 +
 drivers/thermal/Makefile       |   1 +
 drivers/thermal/hisi_thermal.c | 419 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 428 insertions(+)
 create mode 100644 drivers/thermal/hisi_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index af40db0..81aee01 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -136,6 +136,14 @@ config THERMAL_EMULATION
 	  because userland can easily disable the thermal policy by simply
 	  flooding this sysfs node with low temperature values.
 
+config HISI_THERMAL
+	tristate "Hisilicon thermal driver"
+	depends on ARCH_HISI && CPU_THERMAL && OF
+	help
+	  Enable this to plug hisilicon's thermal sensor driver into the Linux
+	  thermal framework. cpufreq is used as the cooling device to throttle
+	  CPUs when the passive trip is crossed.
+
 config IMX_THERMAL
 	tristate "Temperature sensor driver for Freescale i.MX SoCs"
 	depends on CPU_THERMAL
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index fa0dc48..08ae7ac 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -39,3 +39,4 @@ obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-thermal/
 obj-$(CONFIG_INT340X_THERMAL)  += int340x_thermal/
 obj-$(CONFIG_ST_THERMAL)	+= st/
 obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra_soctherm.o
+obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
new file mode 100644
index 0000000..356ec2c
--- /dev/null
+++ b/drivers/thermal/hisi_thermal.c
@@ -0,0 +1,419 @@
+/*
+ * Hisilicon thermal sensor driver
+ *
+ * Copyright (c) 2014-2015 Hisilicon Limited.
+ * Copyright (c) 2014-2015 Linaro Limited.
+ *
+ * Xinwei Kong <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
+ * Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/cpufreq.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+
+#include "thermal_core.h"
+
+#define TEMP0_TH			(0x4)
+#define TEMP0_RST_TH			(0x8)
+#define TEMP0_CFG			(0xC)
+#define TEMP0_EN			(0x10)
+#define TEMP0_INT_EN			(0x14)
+#define TEMP0_INT_CLR			(0x18)
+#define TEMP0_RST_MSK			(0x1C)
+#define TEMP0_VALUE			(0x28)
+
+#define HISI_TEMP_BASE			(-60)
+#define HISI_TEMP_RESET			(100000)
+
+#define HISI_MAX_SENSORS		4
+
+struct hisi_thermal_sensor {
+	struct hisi_thermal_data *thermal;
+	struct thermal_zone_device *tzd;
+
+	long sensor_temp;
+	uint32_t id;
+	uint32_t thres_temp;
+};
+
+struct hisi_thermal_data {
+	struct mutex thermal_lock;    /* protects register data */
+	struct platform_device *pdev;
+	struct clk *clk;
+	struct hisi_thermal_sensor sensors[HISI_MAX_SENSORS];
+
+	int irq, irq_bind_sensor;
+	bool irq_enabled;
+
+	void __iomem *regs;
+};
+
+/* in millicelsius */
+static inline int _step_to_temp(int step)
+{
+	/*
+	 * Every step equals (1 * 200) / 255 celsius, and finally
+	 * need convert to millicelsius.
+	 */
+	return (HISI_TEMP_BASE + (step * 200 / 255)) * 1000;
+}
+
+static inline long _temp_to_step(long temp)
+{
+	return ((temp / 1000 - HISI_TEMP_BASE) * 255 / 200);
+}
+
+static long hisi_thermal_get_sensor_temp(struct hisi_thermal_data *data,
+					 struct hisi_thermal_sensor *sensor)
+{
+	long val;
+
+	mutex_lock(&data->thermal_lock);
+
+	/* disable interrupt */
+	writel(0x0, data->regs + TEMP0_INT_EN);
+	writel(0x1, data->regs + TEMP0_INT_CLR);
+
+	/* disable module firstly */
+	writel(0x0, data->regs + TEMP0_EN);
+
+	/* select sensor id */
+	writel((sensor->id << 12), data->regs + TEMP0_CFG);
+
+	/* enable module */
+	writel(0x1, data->regs + TEMP0_EN);
+
+	usleep_range(3000, 5000);
+
+	val = readl(data->regs + TEMP0_VALUE);
+	val = _step_to_temp(val);
+
+	mutex_unlock(&data->thermal_lock);
+
+	return val;
+}
+
+static void hisi_thermal_enable_bind_irq_sensor
+			(struct hisi_thermal_data *data)
+{
+	struct hisi_thermal_sensor *sensor;
+
+	mutex_lock(&data->thermal_lock);
+
+	sensor = &data->sensors[data->irq_bind_sensor];
+
+	/* setting the hdak time */
+	writel(0x0, data->regs + TEMP0_CFG);
+
+	/* disable module firstly */
+	writel(0x0, data->regs + TEMP0_RST_MSK);
+	writel(0x0, data->regs + TEMP0_EN);
+
+	/* select sensor id */
+	writel((sensor->id << 12), data->regs + TEMP0_CFG);
+
+	/* enable for interrupt */
+	writel(_temp_to_step(sensor->thres_temp) | 0x0FFFFFF00,
+	       data->regs + TEMP0_TH);
+
+	writel(_temp_to_step(HISI_TEMP_RESET), data->regs + TEMP0_RST_TH);
+
+	/* enable module */
+	writel(0x1, data->regs + TEMP0_RST_MSK);
+	writel(0x1, data->regs + TEMP0_EN);
+
+	writel(0x0, data->regs + TEMP0_INT_CLR);
+	writel(0x1, data->regs + TEMP0_INT_EN);
+
+	usleep_range(3000, 5000);
+
+	mutex_unlock(&data->thermal_lock);
+}
+
+static void hisi_thermal_disable_sensor(struct hisi_thermal_data *data)
+{
+	mutex_lock(&data->thermal_lock);
+
+	/* disable sensor module */
+	writel(0x0, data->regs + TEMP0_INT_EN);
+	writel(0x0, data->regs + TEMP0_RST_MSK);
+	writel(0x0, data->regs + TEMP0_EN);
+
+	mutex_unlock(&data->thermal_lock);
+}
+
+static int hisi_thermal_get_temp(void *_sensor, long *temp)
+{
+	struct hisi_thermal_sensor *sensor = _sensor;
+	struct hisi_thermal_data *data = sensor->thermal;
+
+	int sensor_id = 0, i;
+	long max_temp = 0;
+
+	*temp = hisi_thermal_get_sensor_temp(data, sensor);
+
+	sensor->sensor_temp = *temp;
+
+	for (i = 0; i < HISI_MAX_SENSORS; i++) {
+		if (data->sensors[i].sensor_temp >= max_temp) {
+			max_temp = data->sensors[i].sensor_temp;
+			sensor_id = i;
+		}
+	}
+
+	mutex_lock(&data->thermal_lock);
+	data->irq_bind_sensor = sensor_id;
+	mutex_unlock(&data->thermal_lock);
+
+	dev_dbg(&data->pdev->dev, "id=%d, irq=%d, temp=%ld, thres=%d\n",
+		sensor->id, data->irq_enabled, *temp, sensor->thres_temp);
+	/*
+	 * Bind irq to sensor for two cases:
+	 *   Reenable alarm IRQ if temperature below threshold;
+	 *   if irq has been enabled, always set it;
+	 */
+	if (data->irq_enabled) {
+		hisi_thermal_enable_bind_irq_sensor(data);
+		return 0;
+	}
+
+	if (max_temp < sensor->thres_temp) {
+		data->irq_enabled = true;
+		hisi_thermal_enable_bind_irq_sensor(data);
+		enable_irq(data->irq);
+	}
+
+	return 0;
+}
+
+static struct thermal_zone_of_device_ops hisi_of_thermal_ops = {
+	.get_temp = hisi_thermal_get_temp,
+};
+
+static irqreturn_t hisi_thermal_alarm_irq(int irq, void *dev)
+{
+	struct hisi_thermal_data *data = dev;
+
+	disable_irq_nosync(irq);
+	data->irq_enabled = false;
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
+{
+	struct hisi_thermal_data *data = dev;
+	struct hisi_thermal_sensor *sensor;
+	int i;
+
+	sensor = &data->sensors[data->irq_bind_sensor];
+
+	dev_crit(&data->pdev->dev, "THERMAL ALARM: T > %d\n",
+		 sensor->thres_temp / 1000);
+
+	for (i = 0; i < HISI_MAX_SENSORS; i++)
+		thermal_zone_device_update(data->sensors[i].tzd);
+
+	return IRQ_HANDLED;
+}
+
+static int hisi_thermal_register_sensor(struct platform_device *pdev,
+					struct hisi_thermal_data *data,
+					struct hisi_thermal_sensor *sensor,
+					int index)
+{
+	int ret, i;
+	const struct thermal_trip *trip;
+
+	sensor->id = index;
+	sensor->thermal = data;
+
+	sensor->tzd = thermal_zone_of_sensor_register(&pdev->dev, sensor->id,
+				sensor, &hisi_of_thermal_ops);
+	if (IS_ERR(sensor->tzd)) {
+		ret = PTR_ERR(sensor->tzd);
+		dev_err(&pdev->dev, "failed to register sensor id %d: %d\n",
+			sensor->id, ret);
+		return ret;
+	}
+
+	trip = of_thermal_get_trip_points(sensor->tzd);
+
+	for (i = 0; i < of_thermal_get_ntrips(sensor->tzd); i++) {
+		if (trip[i].type == THERMAL_TRIP_PASSIVE) {
+			sensor->thres_temp = trip[i].temperature;
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static const struct of_device_id of_hisi_thermal_match[] = {
+	{ .compatible = "hisilicon,tsensor" },
+	{ /* end */ }
+};
+MODULE_DEVICE_TABLE(of, of_hisi_thermal_match);
+
+static void hisi_thermal_toggle_sensor(struct hisi_thermal_sensor *sensor,
+				       bool on)
+{
+	struct thermal_zone_device *tzd = sensor->tzd;
+
+	tzd->ops->set_mode(tzd,
+		on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED);
+}
+
+static int hisi_thermal_probe(struct platform_device *pdev)
+{
+	struct hisi_thermal_data *data;
+	struct resource *res;
+	int i;
+	int ret;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	mutex_init(&data->thermal_lock);
+	data->pdev = pdev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(data->regs)) {
+		dev_err(&pdev->dev, "failed to get io address\n");
+		return PTR_ERR(data->regs);
+	}
+
+	data->irq = platform_get_irq(pdev, 0);
+	if (data->irq < 0)
+		return data->irq;
+
+	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
+					hisi_thermal_alarm_irq,
+					hisi_thermal_alarm_irq_thread,
+					0, "hisi_thermal", data);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, data);
+
+	data->clk = devm_clk_get(&pdev->dev, "thermal_clk");
+	if (IS_ERR(data->clk)) {
+		ret = PTR_ERR(data->clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"failed to get thermal clk: %d\n", ret);
+		return ret;
+	}
+
+	/* enable clock for thermal */
+	ret = clk_prepare_enable(data->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < HISI_MAX_SENSORS; ++i) {
+		ret = hisi_thermal_register_sensor(pdev, data,
+						   &data->sensors[i], i);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"failed to register thermal sensor: %d\n", ret);
+			goto err_get_sensor_data;
+		}
+	}
+
+	hisi_thermal_enable_bind_irq_sensor(data);
+	data->irq_enabled = true;
+
+	for (i = 0; i < HISI_MAX_SENSORS; i++)
+		hisi_thermal_toggle_sensor(&data->sensors[i], true);
+
+	return 0;
+
+err_get_sensor_data:
+	clk_disable_unprepare(data->clk);
+
+	return ret;
+}
+
+static int hisi_thermal_remove(struct platform_device *pdev)
+{
+	struct hisi_thermal_data *data = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < HISI_MAX_SENSORS; i++) {
+		struct hisi_thermal_sensor *sensor = &data->sensors[i];
+
+		hisi_thermal_toggle_sensor(sensor, false);
+		thermal_zone_of_sensor_unregister(&pdev->dev, sensor->tzd);
+	}
+
+	hisi_thermal_disable_sensor(data);
+	clk_disable_unprepare(data->clk);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int hisi_thermal_suspend(struct device *dev)
+{
+	struct hisi_thermal_data *data = dev_get_drvdata(dev);
+
+	hisi_thermal_disable_sensor(data);
+	data->irq_enabled = false;
+
+	clk_disable_unprepare(data->clk);
+
+	return 0;
+}
+
+static int hisi_thermal_resume(struct device *dev)
+{
+	struct hisi_thermal_data *data = dev_get_drvdata(dev);
+
+	clk_prepare_enable(data->clk);
+
+	data->irq_enabled = true;
+	hisi_thermal_enable_bind_irq_sensor(data);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(hisi_thermal_pm_ops,
+			 hisi_thermal_suspend, hisi_thermal_resume);
+
+static struct platform_driver hisi_thermal_driver = {
+	.driver = {
+		.name		= "hisi_thermal",
+		.owner		= THIS_MODULE,
+		.pm		= &hisi_thermal_pm_ops,
+		.of_match_table = of_hisi_thermal_match,
+	},
+	.probe	= hisi_thermal_probe,
+	.remove	= hisi_thermal_remove,
+};
+
+module_platform_driver(hisi_thermal_driver);
+
+MODULE_AUTHOR("Xinwei Kong <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>");
+MODULE_AUTHOR("Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>");
+MODULE_DESCRIPTION("Hisilicon thermal driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
