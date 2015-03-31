From: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Subject: [PATCH v2 2/2] thermal: hisilicon: add new hisilicon thermal sensor driver
Date: Tue, 31 Mar 2015 14:59:22 +0800
Message-ID: <1427785162-15172-3-git-send-email-kong.kongxinwei@hisilicon.com>
References: <1427785162-15172-1-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427785162-15172-1-git-send-email-kong.kongxinwei@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhuang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, devicetree@vger.kernel.org, liguozhu@hisilicon.com, xuwei5@hisilicon.com, jorge.ramirez-ortiz@linaro.org, xweikong@hotmail.com, mark.rutland@arm.com
List-Id: linux-pm@vger.kernel.org

From: kongxinwei <kong.kongxinwei@hisilicon.com>

This patch adds the support for hisilicon thermal sensor, within
hisilicon SoC. there will register sensors for thermal framework
and use device tree to bind cooling device.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: kongxinwei <kong.kongxinwei@hisilicon.com>
---
 drivers/thermal/Kconfig        |   8 +
 drivers/thermal/Makefile       |   1 +
 drivers/thermal/hisi_thermal.c | 475 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 484 insertions(+)
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
index 0000000..c03d5c3
--- /dev/null
+++ b/drivers/thermal/hisi_thermal.c
@@ -0,0 +1,475 @@
+/*
+ * Hisilicon thermal sensor driver
+ *
+ * Copyright (c) 2014-2015 Hisilicon Limited.
+ * Copyright (c) 2014-2015 Linaro Limited.
+ *
+ * Xinwei Kong <kong.kongxinwei@hisilicon.com>
+ * Leo Yan <leo.yan@linaro.org>
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
+#include <linux/cpu_cooling.h>
+#include <linux/cpufreq.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+#include <linux/types.h>
+
+#include "thermal_core.h"
+
+#define TEMP0_LAG			(0x0)
+#define TEMP0_TH			(0x4)
+#define TEMP0_RST_TH			(0x8)
+#define TEMP0_CFG			(0xC)
+#define TEMP0_EN			(0x10)
+#define TEMP0_INT_EN			(0x14)
+#define TEMP0_INT_CLR			(0x18)
+#define TEMP0_RST_MSK			(0x1C)
+#define TEMP0_RAW_INT			(0x20)
+#define TEMP0_MSK_INT			(0x24)
+#define TEMP0_VALUE			(0x28)
+
+#define HISI_TEMP_BASE			(-60)
+#define HISI_TEMP_RESET		(100000)
+#define HISI_TEMP_PASSIVE		(85000)
+
+#define HISI_MAX_SENSORS		4
+
+struct hisi_thermal_sensor {
+	struct hisi_thermal_data *thermal;
+	struct thermal_zone_device *tzd;
+	const struct thermal_trip *trip;
+
+	uint32_t id;
+	uint32_t thres_temp, reset_temp;
+};
+
+struct hisi_thermal_data {
+	struct mutex thermal_lock;
+	struct platform_device *pdev;
+	struct clk *clk;
+
+	int irq, irq_bind_sensor;
+	bool irq_enabled;
+
+	unsigned int sensors_num;
+	long sensor_temp[HISI_MAX_SENSORS];
+	struct hisi_thermal_sensor sensors[HISI_MAX_SENSORS];
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
+static inline int _temp_to_step(int temp)
+{
+	return ((temp / 1000 - HISI_TEMP_BASE) * 255 / 200);
+}
+
+static long hisi_thermal_get_sensor_temp(struct hisi_thermal_data *data,
+					 struct hisi_thermal_sensor *sensor)
+{
+	int val;
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
+	msleep(5);
+
+	val = readl(data->regs + TEMP0_VALUE);
+	val = _step_to_temp(val);
+
+	/* adjust for negative value */
+	val = (val < 0) ? 0 : val;
+
+	mutex_unlock(&data->thermal_lock);
+
+	return val;
+}
+
+static void hisi_thermal_bind_irq(struct hisi_thermal_data *data)
+{
+	struct hisi_thermal_sensor *sensor;
+
+	sensor = &data->sensors[data->irq_bind_sensor];
+
+	mutex_lock(&data->thermal_lock);
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
+	writel(_temp_to_step(sensor->thres_temp)
+			| 0x0FFFFFF00, data->regs + TEMP0_TH);
+
+	writel(_temp_to_step(HISI_TEMP_RESET), data->regs + TEMP0_RST_TH);
+
+	/* enable module */
+	writel(0x1, data->regs + TEMP0_RST_MSK);
+	writel(0x1, data->regs + TEMP0_EN);
+
+	writel(0x0, data->regs + TEMP0_INT_CLR);
+	writel(0x1, data->regs + TEMP0_INT_EN);
+	msleep(5);
+
+	mutex_unlock(&data->thermal_lock);
+
+}
+
+static void hisi_thermal_enable_sensor(struct hisi_thermal_data *data)
+{
+	hisi_thermal_bind_irq(data);
+}
+
+static void hisi_thermal_disable_sensor(struct hisi_thermal_data *data)
+{
+
+	mutex_lock(&data->thermal_lock);
+
+	/* disable sensor module */
+	writel(0x0, data->regs + TEMP0_INT_EN);
+	writel(0x0, data->regs + TEMP0_RST_MSK);
+	writel(0x0, data->regs + TEMP0_EN);
+
+	mutex_unlock(&data->thermal_lock);
+
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
+	data->sensor_temp[sensor->id] = *temp;
+
+	for (i = 0; i < HISI_MAX_SENSORS; i++) {
+		if (data->sensor_temp[i] >= max_temp) {
+			max_temp = data->sensor_temp[i];
+			sensor_id = i;
+		}
+	}
+
+	data->irq_bind_sensor = sensor_id;
+
+	dev_dbg(&data->pdev->dev, "id=%d, irq=%d, temp=%ld, thres=%d\n",
+		sensor->id, data->irq_enabled, *temp, sensor->thres_temp);
+	/*
+	 * Bind irq to sensor for two cases:
+	 *   Reenable alarm IRQ if temperature below threshold;
+	 *   if irq has been enabled, always set it;
+	 */
+	if (!data->irq_enabled && max_temp < sensor->thres_temp) {
+		data->irq_enabled = true;
+		hisi_thermal_bind_irq(data);
+		enable_irq(data->irq);
+	} else if (data->irq_enabled)
+		hisi_thermal_bind_irq(data);
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
+	for (i = 0; i < data->sensors_num; i++)
+		thermal_zone_device_update(data->sensors[i].tzd);
+
+	return IRQ_HANDLED;
+}
+
+static int hisi_thermal_init_sensor(struct platform_device *pdev,
+					struct device_node *np,
+					struct hisi_thermal_data *data,
+					int index)
+{
+	struct hisi_thermal_sensor *sensor;
+	int ret, i;
+
+	sensor = &data->sensors[index];
+
+	ret = of_property_read_u32(np, "hisilicon,tsensor-id",
+					&sensor->id);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to get id %d: %d\n", index, ret);
+		return ret;
+	}
+
+	sensor->thermal = data;
+	sensor->tzd = thermal_zone_of_sensor_register(&pdev->dev, sensor->id,
+				sensor, &hisi_of_thermal_ops);
+	if (IS_ERR(sensor->tzd)) {
+		ret = PTR_ERR(sensor->tzd);
+		dev_err(&pdev->dev, "failed to register sensor id %d: %d\n",
+			sensor->id, ret);
+		return ret;
+	}
+
+	sensor->trip = of_thermal_get_trip_points(sensor->tzd);
+
+	for (i = 0; i < of_thermal_get_ntrips(sensor->tzd); i++) {
+		if (sensor->trip[i].type == THERMAL_TRIP_PASSIVE) {
+			sensor->thres_temp = sensor->trip[i].temperature;
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int hisi_thermal_get_sensor_data(struct platform_device *pdev)
+{
+	struct hisi_thermal_data *data = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *child_np;
+	int ret, i, index;
+
+	/* sensor initialization */
+	index = 0;
+	for_each_child_of_node(np, child_np) {
+
+		if (index >= HISI_MAX_SENSORS) {
+			dev_err(&pdev->dev, "unsupported sensor number\n");
+			ret = -EINVAL;
+			goto err_init_sensors;
+		}
+
+		ret = hisi_thermal_init_sensor(pdev, child_np, data, index);
+		if (ret)
+			goto err_init_sensors;
+
+		index++;
+	}
+
+	data->sensors_num = index;
+	return 0;
+
+err_init_sensors:
+	for (i = 0; i < index; i++)
+		thermal_zone_of_sensor_unregister(&pdev->dev,
+				data->sensors[i].tzd);
+	return ret;
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
+			hisi_thermal_alarm_irq, hisi_thermal_alarm_irq_thread,
+			0, "hisi_thermal", data);
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
+	ret = hisi_thermal_get_sensor_data(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to get sensor data\n");
+		goto err_get_sensor_data;
+		return ret;
+	}
+
+	hisi_thermal_enable_sensor(data);
+	data->irq_enabled = true;
+
+	for (i = 0; i < data->sensors_num; i++)
+		hisi_thermal_toggle_sensor(&data->sensors[i], true);
+
+	return 0;
+
+err_get_sensor_data:
+	clk_disable_unprepare(data->clk);
+	return ret;
+}
+
+static int hisi_thermal_remove(struct platform_device *pdev)
+{
+	struct hisi_thermal_data *data = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < data->sensors_num; i++) {
+		struct hisi_thermal_sensor *sensor = &data->sensors[i];
+
+		hisi_thermal_toggle_sensor(sensor, false);
+		thermal_zone_of_sensor_unregister(&pdev->dev, sensor->tzd);
+	}
+
+	hisi_thermal_disable_sensor(data);
+	clk_disable_unprepare(data->clk);
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
+	hisi_thermal_enable_sensor(data);
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
+		.name	= "hisi_thermal",
+		.owner  = THIS_MODULE,
+		.pm	= &hisi_thermal_pm_ops,
+		.of_match_table = of_hisi_thermal_match,
+	},
+	.probe		= hisi_thermal_probe,
+	.remove		= hisi_thermal_remove,
+};
+
+module_platform_driver(hisi_thermal_driver);
+
+MODULE_AUTHOR("Xinwei Kong <kong.kongxinwei@hisilicon.com>");
+MODULE_AUTHOR("Leo Yan <leo.yan@linaro.org>");
+MODULE_DESCRIPTION("Hisilicon thermal driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
