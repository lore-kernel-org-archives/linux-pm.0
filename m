From: Mason <slash.tmp@free.fr>
Subject: [PATCH v3] thermal: add temperature sensor support for tango SoC
Date: Thu, 24 Mar 2016 13:18:38 +0100
Message-ID: <56F3DB1E.9050605@free.fr>
References: <56D5C7FE.7010807@free.fr> <56D9AF4F.1010304@free.fr>
 <20160308214846.GA10950@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:53451 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728AbcCXMSv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 24 Mar 2016 08:18:51 -0400
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
 drivers/thermal/tango_thermal.c                             | 122 +++++++++++++++++++++++++++
 4 files changed, 147 insertions(+)

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
index 8cc4ac64a91c..53a1f0e92e82 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -254,6 +254,13 @@ config ARMADA_THERMAL
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
index cfae6a654793..8bfea2b7e722 100644
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
index 000000000000..6b5f0d10fbd0
--- /dev/null
+++ b/drivers/thermal/tango_thermal.c
@@ -0,0 +1,122 @@
+#include <linux/io.h>
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
+#define IDX_MIN		12
+#define IDX_MAX		40
+#define CYCLE_COUNT	50 /* Time to wait before sampling the result */
+
+static const u8 temperature[] = {
+	15, 19, 23, 28, 33, 37, 41, 46, 51, 55, 60, 64, 69, 74, 79, 83,
+	88, 93, 97, 101, 106, 110, 115, 120, 124, 129, 133, 137,
+};
+
+struct tango_thermal_priv {
+	struct thermal_zone_device *zone;
+	void __iomem *base;
+	int thresh_idx;
+};
+
+#define sensor_idle(base) (readl(base + TEMPSI_CMD) & BIT(7))
+
+static bool temp_above_thresh(void __iomem *base, int thresh_idx)
+{
+	writel_relaxed(thresh_idx << 8 | CMD_READ, base + TEMPSI_CMD);
+
+	while (!sensor_idle(base))
+		cpu_relax();
+
+	return readl_relaxed(base + TEMPSI_RES);
+}
+
+static int tango_get_temp(void *arg, int *res)
+{
+	struct tango_thermal_priv *priv = arg;
+	void __iomem *base = priv->base;
+	int idx = priv->thresh_idx;
+
+	if (temp_above_thresh(base, idx)) {
+		/* Downward linear search */
+		while (idx > IDX_MIN && temp_above_thresh(base, --idx))
+			cpu_relax();
+	} else {
+		/* Upward linear search */
+		while (idx < IDX_MAX && !temp_above_thresh(base, ++idx))
+			cpu_relax();
+		idx = idx - 1;
+	}
+
+	priv->thresh_idx = idx;
+	*res = temperature[idx - IDX_MIN] * 1000;
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
+	writel_relaxed(CMD_ON, priv->base + TEMPSI_CMD);
+	writel_relaxed(CYCLE_COUNT, priv->base + TEMPSI_CFG);
+
+	priv->zone = thermal_zone_of_sensor_register(dev, 0, priv, &ops);
+	if (IS_ERR(priv->zone))
+		return PTR_ERR(priv->zone);
+
+	platform_set_drvdata(pdev, priv);
+	return 0;
+}
+
+static int tango_thermal_remove(struct platform_device *pdev)
+{
+	struct tango_thermal_priv *priv = platform_get_drvdata(pdev);
+
+	thermal_zone_of_sensor_unregister(&pdev->dev, priv->zone);
+	writel_relaxed(CMD_OFF, priv->base + TEMPSI_CMD);
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
2.7.0

