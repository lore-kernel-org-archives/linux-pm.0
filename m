From: Icenowy Zheng <icenowy@aosc.xyz>
Subject: [RFC PATCH 3/5] thermal: Add support for the thermal sensor on A23/33
Date: Tue, 28 Jun 2016 18:13:23 +0800
Message-ID: <20160628101325.2522-3-icenowy@aosc.xyz>
References: <20160628101325.2522-1-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160628101325.2522-1-icenowy@aosc.xyz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, maxime.ripard@free-electrons.com, wens@csie.org, emilio@elopez.com.ar
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.xyz>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This patch adds support for the sun8iw3 thermal sensor on
Allwinner A23/33 SoCs.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 drivers/thermal/Kconfig           |   7 ++
 drivers/thermal/Makefile          |   1 +
 drivers/thermal/sun8iw3_thermal.c | 191 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 199 insertions(+)
 create mode 100644 drivers/thermal/sun8iw3_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 2d702ca..2f29ad7 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -351,6 +351,13 @@ config MTK_THERMAL
 	  Enable this option if you want to have support for thermal management
 	  controller present in Mediatek SoCs
 
+config SUN8IW3_THERMAL
+	tristate "Temperature sensor driver for Allwinner A23/33 SoCs"
+	depends on MACH_SUN8I
+	depends on OF
+	help
+	  Enable this to support thermal reporting on Allwinner A23/33 SoCs.
+
 menu "Texas Instruments thermal drivers"
 depends on ARCH_HAS_BANDGAP || COMPILE_TEST
 depends on HAS_IOMEM
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 10b07c1..a4b0072 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -50,4 +50,5 @@ obj-$(CONFIG_ST_THERMAL)	+= st/
 obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra/
 obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
 obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
+obj-$(CONFIG_SUN8IW3_THERMAL)	+= sun8iw3_thermal.o
 obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
diff --git a/drivers/thermal/sun8iw3_thermal.c b/drivers/thermal/sun8iw3_thermal.c
new file mode 100644
index 0000000..332359f
--- /dev/null
+++ b/drivers/thermal/sun8iw3_thermal.c
@@ -0,0 +1,191 @@
+/*
+ * sun8iw3 THS driver
+ * Based on the work of Li Ming <liming@allwinnertech.com>>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+#include <linux/printk.h>
+
+#define THERMAL_DATA_DELAY      (100)
+
+#define THERMAL_BASSADDRESS     (0xf1c25000)
+
+#define THS_CTRL_REG0           (0x00)
+#define THS_CTRL_REG1           (0x04)
+#define THS_PRO_CTRL_REG        (0x18)
+
+#define THS_CTRL_REG0_VALUE_SUN8IW3     (0x00a300ff)
+#define THS_CTRL_REG0_VALUE_SUN8IW5     (0x002000ff)
+#define THS_CTRL_REG1_VALUE     (0x120)
+#define THS_PRO_CTRL_REG_VALUE  (0x1005f)
+
+#define THS_DATA_REG            (0x20)
+
+struct sun8iw3_ths_data {
+	void __iomem *regs;
+	struct platform_device *pdev;
+	struct clk *clk;
+	struct thermal_zone_device *tzd;
+	struct device_node *np;
+	struct delayed_work work;
+	u32 temp;
+	int divisor, minus;
+	u32 ctrl0_value;
+};
+
+static const struct of_device_id sun8iw3_ths_dt_ids[] = {
+	{ .compatible = "allwinner,sun8i-a23-ths", },
+	{ .compatible = "allwinner,sun8i-a33-ths", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sun8iw3_ths_dt_ids);
+
+static int sun8iw3_ths_get_temp(void *_data, int *out)
+{
+	struct sun8iw3_ths_data *data = _data;
+
+	if (data->temp == 0)
+		return -EINVAL;
+
+	/* According to Allwinner's 3.4 kernel */
+	*out = (data->temp * 100) / data->divisor - data->minus;
+
+	/* Convert from Celsius to millidegree Celsius */
+	*out *= 1000;
+
+	return 0;
+}
+
+static struct thermal_zone_of_device_ops sun8iw3_of_thermal_ops = {
+	.get_temp = sun8iw3_ths_get_temp,
+};
+
+static void sun8iw3_ths_work(struct work_struct *work)
+{
+	struct sun8iw3_ths_data *data;
+
+	data = container_of(work, struct sun8iw3_ths_data, work.work);
+
+	data->temp = readl(data->regs + THS_DATA_REG);
+	if (data->temp)
+		thermal_zone_device_update(data->tzd);
+
+	schedule_delayed_work(&data->work, msecs_to_jiffies(1000));
+}
+
+static int sun8iw3_ths_init(struct platform_device *pdev,
+			    struct sun8iw3_ths_data *data)
+{
+	struct resource *r;
+	int ret;
+
+	data->np = pdev->dev.of_node;
+
+	/* divisor and minus data are from Allwinner's 3.4 kernel */
+	if (of_device_is_compatible(data->np, "allwinner,sun8i-a23-ths")) {
+		data->ctrl0_value = THS_CTRL_REG0_VALUE_SUN8IW3;
+		data->divisor = 625;
+		data->minus = 265;
+	} else if (of_device_is_compatible(data->np, "allwinner,sun8i-a33-ths")) {
+		data->ctrl0_value = THS_CTRL_REG0_VALUE_SUN8IW5;
+		data->divisor = 618;
+		data->minus = 269;
+	}
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->regs = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(data->regs))
+		return PTR_ERR(data->regs);
+
+	data->clk = devm_clk_get(&pdev->dev, "pll2");
+	if (IS_ERR(data->clk)) {
+		ret = PTR_ERR(data->clk);
+		dev_err(&pdev->dev, "failed to get pll2 clk: %d\n", ret);
+		return ret;
+	}
+
+	data->tzd = devm_thermal_zone_of_sensor_register(
+				&pdev->dev, 0, data, &sun8iw3_of_thermal_ops);
+	if (IS_ERR(data->tzd)) {
+		ret = PTR_ERR(data->tzd);
+		dev_err(&pdev->dev, "can't register thermal zone: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(data->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable pll2 clk: %d\n", ret);
+		return ret;
+	}
+
+	writel(data->ctrl0_value, data->regs + THS_CTRL_REG0);
+	writel(THS_CTRL_REG1_VALUE, data->regs + THS_CTRL_REG1);
+	writel(THS_PRO_CTRL_REG_VALUE, data->regs + THS_PRO_CTRL_REG);
+
+	INIT_DELAYED_WORK(&data->work, sun8iw3_ths_work);
+	schedule_delayed_work(&data->work, msecs_to_jiffies(1000));
+
+	return 0;
+}
+
+static int sun8iw3_ths_exit(struct platform_device *pdev,
+			      struct sun8iw3_ths_data *data)
+{
+	thermal_zone_device_unregister(data->tzd);
+	cancel_delayed_work(&data->work);
+	clk_disable_unprepare(data->clk);
+	writel(0, data->regs + THS_CTRL_REG0);
+	writel(0, data->regs + THS_CTRL_REG1);
+	writel(0, data->regs + THS_PRO_CTRL_REG);
+	return 0;
+}
+
+static int sun8iw3_ths_probe(struct platform_device *pdev)
+{
+	struct sun8iw3_ths_data *data;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, data);
+
+	return sun8iw3_ths_init(pdev, data);
+}
+
+static int sun8iw3_ths_remove(struct platform_device *pdev)
+{
+	struct sun8iw3_ths_data *data = platform_get_drvdata(pdev);
+
+	return sun8iw3_ths_exit(pdev, data);
+}
+
+static struct platform_driver sun8iw3_ths_driver = {
+	.driver	= {
+		.name	= "sun8iw3-ths",
+		.of_match_table = sun8iw3_ths_dt_ids,
+	},
+	.probe		= sun8iw3_ths_probe,
+	.remove		= sun8iw3_ths_remove,
+};
+
+module_platform_driver(sun8iw3_ths_driver);
+MODULE_AUTHOR("Icenowy Zheng <icenowy@aosc.xyz>");
+MODULE_DESCRIPTION("Allwinner A23/33 SoC thermal driver");
+MODULE_LICENSE("GPL v2");
-- 
2.9.0
