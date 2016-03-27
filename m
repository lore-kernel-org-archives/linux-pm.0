From: Mason <slash.tmp@free.fr>
Subject: [PATCH v4] thermal: add temperature sensor support for tango SoC
Date: Sun, 27 Mar 2016 22:35:51 +0200
Message-ID: <56F84427.1000507@free.fr>
References: <56D5C7FE.7010807@free.fr> <56D9AF4F.1010304@free.fr>
 <20160308214846.GA10950@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:36530 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751562AbcC0UgG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 27 Mar 2016 16:36:06 -0400
In-Reply-To: <20160308214846.GA10950@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Mans Rullgard <mans@mansr.com>, Rob Herring <robh@kernel.org>

From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

Since the SMP8758, Tango SoCs include several instances of a rudimentary
bandgap temperature sensor.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 Documentation/devicetree/bindings/thermal/tango-thermal.txt |  17 ++++
 drivers/thermal/Kconfig                                     |   7 ++
 drivers/thermal/Makefile                                    |   1 +
 drivers/thermal/tango_thermal.c                             | 114 +++++++++++++++++++++++++++
 4 files changed, 139 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/tango-thermal.txt b/Documentation/devicetree/bindings/thermal/tango-thermal.txt
new file mode 100644
index 000000000000..a203f7d60d35
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/tango-thermal.txt
@@ -0,0 +1,17 @@
+* Tango Thermal
+
+The SMP8758 SoC includes 3 instances of this temperature sensor
+(in the CPU, video decoder, and PCIe controller).
+
+Required properties:
+- compatible: "sigma,smp8758-thermal"
+- #thermal-sensor-cells: Should be 0 (see thermal.txt)
+- reg: Address range of the thermal registers
+
+Example:
+
+	cpu_temp: thermal@920100 {
+		compatible = "sigma,smp8758-thermal";
+		#thermal-sensor-cells = <0>;
+		reg = <0x920100 12>;
+	};
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index c37eedc35a24..b6bf563f05dc 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -260,6 +260,13 @@ config ARMADA_THERMAL
 	  Enable this option if you want to have support for thermal management
 	  controller present in Armada 370 and Armada XP SoC.
 
+config TANGO_THERMAL
+	tristate "Tango thermal management"
+	depends on ARCH_TANGO || COMPILE_TEST
+	help
+	  Enable the Tango temperature sensor driver, which provides support
+	  for the sensors used since the SMP8758.
+
 config TEGRA_SOCTHERM
 	tristate "Tegra SOCTHERM thermal management"
 	depends on ARCH_TEGRA
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 8e9cbc3b5679..06387279883d 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -35,6 +35,7 @@ obj-y				+= samsung/
 obj-$(CONFIG_DOVE_THERMAL)  	+= dove_thermal.o
 obj-$(CONFIG_DB8500_THERMAL)	+= db8500_thermal.o
 obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
+obj-$(CONFIG_TANGO_THERMAL)	+= tango_thermal.o
 obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
 obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+= db8500_cpufreq_cooling.o
 obj-$(CONFIG_INTEL_POWERCLAMP)	+= intel_powerclamp.o
diff --git a/drivers/thermal/tango_thermal.c b/drivers/thermal/tango_thermal.c
new file mode 100644
index 000000000000..decfe857e1a6
--- /dev/null
+++ b/drivers/thermal/tango_thermal.c
@@ -0,0 +1,114 @@
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/thermal.h>
+#include <linux/platform_device.h>
+
+#define TEMPSI_CMD	0
+#define TEMPSI_RES	4
+#define TEMPSI_CFG	8
+
+#define CMD_OFF		0
+#define CMD_ON		1
+#define CMD_READ	2
+
+#define IDX_MIN		0
+#define IDX_MAX		40
+#define CYCLE_COUNT	5000 /* Time to wait before sampling the result */
+
+struct tango_thermal_priv {
+	struct thermal_zone_device *zone;
+	void __iomem *base;
+	int thresh_idx;
+};
+
+static bool temp_above_thresh(void __iomem *base, int thresh_idx)
+{
+	writel(thresh_idx << 8 | CMD_READ, base + TEMPSI_CMD);
+	usleep_range(100, 200);
+	return readl(base + TEMPSI_RES);
+}
+
+static int tango_get_temp(void *arg, int *res)
+{
+	struct tango_thermal_priv *priv = arg;
+	void __iomem *base = priv->base;
+	int idx = priv->thresh_idx;
+
+	if (temp_above_thresh(base, idx)) {
+		/* Upward linear search, increment thresh */
+		while (idx < IDX_MAX && temp_above_thresh(base, ++idx))
+			cpu_relax();
+		idx = idx - 1; /* always return lower bound */
+	} else {
+		/* Downward linear search, decrement thresh */
+		while (idx > IDX_MIN && !temp_above_thresh(base, --idx))
+			cpu_relax();
+	}
+
+	*res = idx * 4500 - 38000; /* millidegrees Celsius */
+	priv->thresh_idx = idx;
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops ops = {
+	.get_temp	= tango_get_temp,
+};
+
+static int tango_thermal_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct tango_thermal_priv *priv;
+	struct device *dev = &pdev->dev;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	writel(CMD_ON, priv->base + TEMPSI_CMD);
+	writel(CYCLE_COUNT, priv->base + TEMPSI_CFG);
+
+	priv->zone = thermal_zone_of_sensor_register(dev, 0, priv, &ops);
+	if (IS_ERR(priv->zone))
+		return PTR_ERR(priv->zone);
+
+	priv->thresh_idx = 15; /* arbitrary starting point */
+	platform_set_drvdata(pdev, priv);
+	return 0;
+}
+
+static int tango_thermal_remove(struct platform_device *pdev)
+{
+	struct tango_thermal_priv *priv = platform_get_drvdata(pdev);
+
+	thermal_zone_of_sensor_unregister(&pdev->dev, priv->zone);
+	writel(CMD_OFF, priv->base + TEMPSI_CMD);
+	return 0;
+}
+
+static const struct of_device_id tango_sensor_ids[] = {
+	{
+		.compatible = "sigma,smp8758-thermal",
+	},
+	{ /* sentinel */ }
+};
+
+static struct platform_driver tango_thermal_driver = {
+	.probe	= tango_thermal_probe,
+	.remove	= tango_thermal_remove,
+	.driver	= {
+		.name		= "tango-thermal",
+		.of_match_table	= tango_sensor_ids,
+	},
+};
+
+module_platform_driver(tango_thermal_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Sigma Designs");
+MODULE_DESCRIPTION("Tango temperature sensor");
-- 
2.7.4
