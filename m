From: Tao Wang <kevin.wangtao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: [PATCH v3 2/3] thermal: hisilicon: add thermal sensor driver for Hi3660
Date: Thu, 10 Aug 2017 16:32:14 +0800
Message-ID: <1502353935-92924-3-git-send-email-kevin.wangtao@hisilicon.com>
References: <1498102923-68481-1-git-send-email-kevin.wangtao@hisilicon.com>
 <1502353935-92924-1-git-send-email-kevin.wangtao@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1502353935-92924-1-git-send-email-kevin.wangtao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kevin.wangtao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sunzhaosheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
List-Id: linux-pm@vger.kernel.org

From: Tao Wang <kevin.wangtao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

This patch adds the support for thermal sensor of Hi3660 SoC.
this will register sensors for thermal framework and use device
tree to bind cooling device.

Signed-off-by: Tao Wang <kevin.wangtao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/thermal/Kconfig        |  13 +++
 drivers/thermal/Makefile       |   1 +
 drivers/thermal/hisi_tsensor.c | 223 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 237 insertions(+)
 create mode 100644 drivers/thermal/hisi_tsensor.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index b5b5fac..32f582d 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -203,6 +203,19 @@ config HISI_THERMAL
 	  thermal framework. cpufreq is used as the cooling device to throttle
 	  CPUs when the passive trip is crossed.
 
+config HISI_TSENSOR
+	tristate "Hisilicon tsensor driver"
+	depends on ARCH_HISI || COMPILE_TEST
+	depends on HAS_IOMEM
+	depends on OF
+	default y
+	help
+	  Enable this to plug Hisilicon's tsensor driver into the Linux thermal
+	  framework. Besides all the hardware sensors, this also support two
+	  virtual sensors, one for maximum of all the hardware sensor, and
+	  one for average of all the hardware sensor.
+	  Compitable with Hi3660 or higher.
+
 config IMX_THERMAL
 	tristate "Temperature sensor driver for Freescale i.MX SoCs"
 	depends on (ARCH_MXC && CPU_THERMAL) || COMPILE_TEST
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 094d703..8a16bd4 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_ST_THERMAL)	+= st/
 obj-$(CONFIG_QCOM_TSENS)	+= qcom/
 obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra/
 obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
+obj-$(CONFIG_HISI_TSENSOR)	+= hisi_tsensor.o
 obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
 obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
 obj-$(CONFIG_ZX2967_THERMAL)	+= zx2967_thermal.o
diff --git a/drivers/thermal/hisi_tsensor.c b/drivers/thermal/hisi_tsensor.c
new file mode 100644
index 0000000..c8eec9d
--- /dev/null
+++ b/drivers/thermal/hisi_tsensor.c
@@ -0,0 +1,223 @@
+/*
+ *  linux/drivers/thermal/hisi_tsensor.c
+ *
+ *  Copyright (c) 2017 Hisilicon Limited.
+ *  Copyright (c) 2017 Linaro Limited.
+ *
+ *  Author: Tao Wang <kevin.wangtao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
+ *  Author: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+#include "thermal_core.h"
+
+#define VIRTUAL_SENSORS		2
+
+/* hisi Thermal Sensor Dev Structure */
+struct hisi_thermal_sensor {
+	struct hisi_thermal_data *thermal;
+	struct thermal_zone_device *tzd;
+	unsigned int id;
+};
+
+struct hisi_thermal_data {
+	struct platform_device *pdev;
+	struct hisi_thermal_sensor *sensors;
+	void __iomem *thermal_base;
+	unsigned int *reg_offset;
+	unsigned int range[2];
+	unsigned int coef[2];
+	unsigned int max_hw_sensor;
+};
+
+static int hisi_thermal_get_temp(void *_sensor, int *temp)
+{
+	struct hisi_thermal_sensor *sensor = _sensor;
+	struct hisi_thermal_data *data = sensor->thermal;
+	unsigned int idx, adc_min, adc_max, max_sensor;
+	int val, average = 0, max = 0;
+
+	adc_min = data->range[0];
+	adc_max = data->range[1];
+	max_sensor = data->max_hw_sensor;
+
+	if (sensor->id < max_sensor) {
+		val = readl(data->thermal_base + data->reg_offset[sensor->id]);
+		val = clamp_val(val, adc_min, adc_max);
+	} else {
+		for (idx = 0; idx < max_sensor; idx++) {
+			val = readl(data->thermal_base
+					+ data->reg_offset[idx]);
+			val = clamp_val(val, adc_min, adc_max);
+			average += val;
+			if (val > max)
+				max = val;
+		}
+
+		if (sensor->id == max_sensor)
+			val = max;
+		else
+			val = average / max_sensor;
+	}
+
+	*temp = ((val - adc_min) * data->coef[0]) / (adc_max - adc_min)
+		+ data->coef[1];
+
+	return 0;
+}
+
+static struct thermal_zone_of_device_ops hisi_of_thermal_ops = {
+	.get_temp = hisi_thermal_get_temp,
+};
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
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct hisi_thermal_data *data;
+	struct hisi_thermal_sensor *sensor;
+	struct resource *res;
+	unsigned int max_sensor;
+	int ret, i;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->pdev = pdev;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->thermal_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(data->thermal_base)) {
+		dev_err(dev, "failed to get reg base\n");
+		return -ENOMEM;
+	}
+
+	max_sensor = of_property_count_u32_elems(np, "offset");
+	if (max_sensor < 0) {
+		dev_err(dev, "failed to get max sensor\n");
+		return -EINVAL;
+	}
+	data->max_hw_sensor = max_sensor;
+
+	data->sensors = devm_kzalloc(dev,
+		sizeof(*data->sensors) * (max_sensor + VIRTUAL_SENSORS),
+		GFP_KERNEL);
+	if (IS_ERR(data->sensors)) {
+		dev_err(dev, "failed to alloc sensors\n");
+		return -ENOMEM;
+	}
+
+	data->reg_offset = devm_kzalloc(dev,
+		sizeof(*data->reg_offset) * max_sensor, GFP_KERNEL);
+	if (IS_ERR(data->reg_offset)) {
+		dev_err(dev, "failed to alloc sensor offset\n");
+		return -ENOMEM;
+	}
+
+	ret = of_property_read_u32_array(np,
+		"offset", data->reg_offset, max_sensor);
+	if (ret < 0) {
+		dev_err(dev, "failed to get reg offset\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32_array(np, "coefficients", data->coef, 2);
+	if (ret < 0) {
+		dev_err(dev, "failed to get coef\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32_array(np, "hisi,adc-range", data->range, 2);
+	if (ret < 0) {
+		dev_err(dev, "failed to get range\n");
+		return -EINVAL;
+	}
+
+	platform_set_drvdata(pdev, data);
+
+	for (i = 0; i < max_sensor + VIRTUAL_SENSORS; ++i) {
+		sensor = &data->sensors[i];
+		sensor->id = i;
+		sensor->thermal = data;
+		sensor->tzd = thermal_zone_of_sensor_register(dev,
+				i, sensor, &hisi_of_thermal_ops);
+		if (IS_ERR(sensor->tzd)) {
+			sensor->tzd = NULL;
+		} else {
+			hisi_thermal_toggle_sensor(sensor, true);
+			dev_info(dev, "thermal sensor%d registered\n", i);
+		}
+	}
+
+	return 0;
+}
+
+static int hisi_thermal_exit(struct platform_device *pdev)
+{
+	struct hisi_thermal_data *data = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < data->max_hw_sensor + VIRTUAL_SENSORS; i++) {
+		struct hisi_thermal_sensor *sensor = &data->sensors[i];
+
+		if (!sensor->tzd)
+			continue;
+
+		hisi_thermal_toggle_sensor(sensor, false);
+		thermal_zone_of_sensor_unregister(&pdev->dev, sensor->tzd);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id hisi_thermal_id_table[] = {
+	{ .compatible = "hisilicon,tsensor" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, hisi_thermal_id_table);
+
+static struct platform_driver hisi_thermal_driver = {
+	.probe = hisi_thermal_probe,
+	.remove = hisi_thermal_exit,
+	.driver = {
+		.name = "hisi_tsensor",
+		.of_match_table = hisi_thermal_id_table,
+	},
+};
+
+module_platform_driver(hisi_thermal_driver);
+
+MODULE_AUTHOR("Tao Wang <kevin.wangtao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>");
+MODULE_AUTHOR("Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>");
+MODULE_DESCRIPTION("hisi tsensor driver");
+MODULE_LICENSE("GPL v2");
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
