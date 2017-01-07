From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH v1 3/3] thermal: zx2967: add thermal driver for ZTE's zx2967 family
Date: Sat,  7 Jan 2017 13:38:08 +0800
Message-ID: <1483767488-19778-3-git-send-email-baoyou.xie@linaro.org>
References: <1483767488-19778-1-git-send-email-baoyou.xie@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35433 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161357AbdAGFjD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 Jan 2017 00:39:03 -0500
Received: by mail-pg0-f47.google.com with SMTP id i5so193642192pgh.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Jan 2017 21:39:02 -0800 (PST)
In-Reply-To: <1483767488-19778-1-git-send-email-baoyou.xie@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, jun.nie@linaro.org, gregkh@linuxfoundation.org, davem@davemloft.net, geert+renesas@glider.be, akpm@linux-foundation.org, mchehab@kernel.org, linux@roeck-us.net
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org, baoyou.xie@linaro.org, xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn

This patch adds thermal driver for ZTE's zx2967 family.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/thermal/Kconfig          |   6 +
 drivers/thermal/Makefile         |   1 +
 drivers/thermal/zx2967_thermal.c | 241 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+)
 create mode 100644 drivers/thermal/zx2967_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 18f2de6..0dd597e 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -445,3 +445,9 @@ config BCM2835_THERMAL
 	  Support for thermal sensors on Broadcom bcm2835 SoCs.
 
 endif
+
+config ZX2967_THERMAL
+	tristate "Thermal sensors on zx2967 SoC"
+	depends on ARCH_ZX
+	help
+	  Support for thermal sensors on ZTE zx2967 SoCs.
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 677c6d9..c00c05e 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
 obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
 obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
 obj-$(CONFIG_BCM2835_THERMAL)	+= bcm2835_thermal.o
+obj-$(CONFIG_ZX2967_THERMAL)	+= zx2967_thermal.o
diff --git a/drivers/thermal/zx2967_thermal.c b/drivers/thermal/zx2967_thermal.c
new file mode 100644
index 0000000..1aef070
--- /dev/null
+++ b/drivers/thermal/zx2967_thermal.c
@@ -0,0 +1,241 @@
+/*
+ * ZTE's zx2967 family thermal sensor driver
+ *
+ * Copyright (C) 2017 ZTE Ltd.
+ *
+ * Author: Baoyou Xie <baoyou.xie@linaro.org>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+/* DCF Control Register */
+#define ZX2967_THERMAL_DCF		0x4
+
+/* Selection Register */
+#define ZX2967_THERMAL_SEL		0x8
+
+/* Control Register */
+#define ZX2967_THERMAL_CTRL		0x10
+
+#define ZX2967_THERMAL_ID_MASK		(0x18)
+
+struct zx2967_thermal_sensor {
+	struct zx2967_thermal_priv *priv;
+	struct thermal_zone_device *tzd;
+	int id;
+};
+
+#define NUM_SENSORS	1
+
+struct zx2967_thermal_priv {
+	struct zx2967_thermal_sensor	sensors[NUM_SENSORS];
+	struct mutex			lock;
+	struct clk			*clk_gate;
+	struct clk			*pclk;
+	void __iomem			*regs;
+	struct pinctrl			*pinmux_dvi0_d3;
+	struct pinctrl			*pinmux_dvi0_d4;
+	struct pinctrl			*pinmux_dvi0_d5;
+};
+
+static int zx2967_thermal_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct zx2967_thermal_priv *priv = platform_get_drvdata(pdev);
+
+	if (priv && priv->pclk)
+		clk_disable_unprepare(priv->pclk);
+
+	if (priv && priv->clk_gate)
+		clk_disable_unprepare(priv->clk_gate);
+	dev_info(dev, "suspended\n");
+
+	return 0;
+}
+
+static int zx2967_thermal_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct zx2967_thermal_priv *priv = platform_get_drvdata(pdev);
+	int error;
+
+	error = clk_prepare_enable(priv->clk_gate);
+	if (error)
+		return error;
+
+	error = clk_prepare_enable(priv->pclk);
+	if (error)
+		return error;
+
+	dev_info(dev, "resumed\n");
+
+	return 0;
+}
+
+static int zx2967_thermal_get_temp(void *data, int *temp)
+{
+	void __iomem *regs;
+	struct zx2967_thermal_sensor *sensor = data;
+	struct zx2967_thermal_priv *priv = sensor->priv;
+	unsigned long timeout = jiffies + msecs_to_jiffies(100);
+	u32 val, sel_id;
+
+	regs = priv->regs;
+	mutex_lock(&priv->lock);
+
+	writel_relaxed(0, regs);
+	writel_relaxed(2, regs + ZX2967_THERMAL_DCF);
+
+	val = readl_relaxed(regs + ZX2967_THERMAL_SEL);
+	val &= ~ZX2967_THERMAL_ID_MASK;
+	sel_id = sensor->id ? 8 : 0x10;
+	val |= sel_id;
+	writel_relaxed(val, regs + ZX2967_THERMAL_SEL);
+
+	usleep_range(100, 300);
+	while (!(readl_relaxed(regs + ZX2967_THERMAL_CTRL) & 0x1000)) {
+		if (time_after(jiffies, timeout)) {
+			pr_err("*** Thermal sensor %d data timeout\n",
+			      sensor->id);
+			mutex_unlock(&priv->lock);
+			return -EIO;
+		}
+	}
+
+	writel_relaxed(3, regs + ZX2967_THERMAL_DCF);
+	val = readl_relaxed(regs + ZX2967_THERMAL_CTRL) & 0xfff;
+	writel_relaxed(1, regs);
+
+	/** Calculate temperature */
+	*temp = DIV_ROUND_CLOSEST((val - 922) * 1000, 1951);
+
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+
+static struct thermal_zone_of_device_ops zx2967_of_thermal_ops = {
+	.get_temp = zx2967_thermal_get_temp,
+};
+
+static int zx2967_thermal_probe(struct platform_device *pdev)
+{
+	struct zx2967_thermal_priv *priv;
+	struct resource *res;
+	int ret, i;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->regs))
+		return PTR_ERR(priv->regs);
+
+	priv->clk_gate = devm_clk_get(&pdev->dev, "tempsensor_gate");
+	if (IS_ERR(priv->clk_gate)) {
+		ret = PTR_ERR(priv->clk_gate);
+		dev_err(&pdev->dev, "failed to get clock gate: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(priv->clk_gate);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable converter clock: %d\n",
+			ret);
+		return ret;
+	}
+
+	priv->pclk = devm_clk_get(&pdev->dev, "tempsensor_pclk");
+	if (IS_ERR(priv->pclk)) {
+		ret = PTR_ERR(priv->pclk);
+		dev_err(&pdev->dev, "failed to get apb clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(priv->pclk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable converter clock: %d\n",
+			ret);
+		return ret;
+	}
+
+	mutex_init(&priv->lock);
+	for (i = 0; i < NUM_SENSORS; i++) {
+		struct zx2967_thermal_sensor *sensor = &priv->sensors[i];
+
+		sensor->priv = priv;
+		sensor->id = i;
+		sensor->tzd = thermal_zone_of_sensor_register(&pdev->dev,
+					i,
+					sensor,
+					&zx2967_of_thermal_ops);
+		if (IS_ERR(sensor->tzd)) {
+			ret = PTR_ERR(sensor->tzd);
+			dev_err(&pdev->dev, "failed to register sensor %d: %d\n",
+				i, ret);
+			goto remove_ts;
+		}
+	}
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+
+remove_ts:
+	for (i--; i >= 0; i--)
+		thermal_zone_of_sensor_unregister(&pdev->dev,
+						  priv->sensors[i].tzd);
+
+	return ret;
+}
+
+static int zx2967_thermal_exit(struct platform_device *pdev)
+{
+	struct zx2967_thermal_priv *priv = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < NUM_SENSORS; i++) {
+		struct zx2967_thermal_sensor *sensor = &priv->sensors[i];
+
+		thermal_zone_of_sensor_unregister(&pdev->dev, sensor->tzd);
+	}
+	clk_disable_unprepare(priv->pclk);
+	clk_disable_unprepare(priv->clk_gate);
+
+	return 0;
+}
+
+static const struct of_device_id zx2967_thermal_id_table[] = {
+	{ .compatible = "zte,zx2967-thermal" },
+	{ .compatible = "zte,zx296718-thermal" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, zx2967_thermal_id_table);
+
+static SIMPLE_DEV_PM_OPS(zx2967_thermal_pm_ops,
+			 zx2967_thermal_suspend, zx2967_thermal_resume);
+
+static struct platform_driver zx2967_thermal_driver = {
+	.probe = zx2967_thermal_probe,
+	.remove = zx2967_thermal_exit,
+	.driver = {
+		.name = "zx2967_thermal",
+		.of_match_table = zx2967_thermal_id_table,
+		.pm = &zx2967_thermal_pm_ops,
+	},
+};
+module_platform_driver(zx2967_thermal_driver);
+
+MODULE_AUTHOR("Baoyou Xie <baoyou.xie@linaro.org>");
+MODULE_DESCRIPTION("ZTE zx2967 thermal driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

