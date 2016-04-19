From: Mason <slash.tmp@free.fr>
Subject: [PATCH v8 1/2] thermal: add temperature sensor support for tango SoC
Date: Tue, 19 Apr 2016 16:21:16 +0200
Message-ID: <57163EDC.7030307@free.fr>
References: <20160308214846.GA10950@localhost.localdomain>
 <56F84427.1000507@free.fr> <56F91A47.9060901@free.fr>
 <20160329020050.GA15721@localhost.localdomain> <56FACE0B.9060606@free.fr>
 <20160330000503.GA2625@localhost.localdomain> <56FBEE4F.3060106@free.fr>
 <56FD8582.80002@free.fr> <20160401015240.GB19409@localhost.localdomain>
 <570254D8.3090406@free.fr> <20160406155155.GB326@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:3511 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754696AbcDSOdu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 19 Apr 2016 10:33:50 -0400
In-Reply-To: <20160406155155.GB326@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Frias <sf84@laposte.net>, arm-soc <arm@kernel.org>

From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

The Tango thermal driver provides support for the primitive temperature
sensor embedded in Tango chips since the SMP8758.

This sensor only generates a 1-bit signal to indicate whether the die
temperature exceeds a programmable threshold.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 Documentation/devicetree/bindings/thermal/tango-thermal.txt |  17 ++++
 drivers/thermal/Kconfig                                     |   9 +++
 drivers/thermal/Makefile                                    |   1 +
 drivers/thermal/tango_thermal.c                             | 111 +++++++++++++++++++++++++++
 4 files changed, 138 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/tango-thermal.txt b/Documentation/devicetree/bindings/thermal/tango-thermal.txt
new file mode 100644
index 000000000000..212198d4b937
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/tango-thermal.txt
@@ -0,0 +1,17 @@
+* Tango Thermal
+
+The SMP8758 SoC includes 3 instances of this temperature sensor
+(in the CPU, video decoder, and PCIe controller).
+
+Required properties:
+- #thermal-sensor-cells: Should be 0 (see thermal.txt)
+- compatible: "sigma,smp8758-thermal"
+- reg: Address range of the thermal registers
+
+Example:
+
+	cpu_temp: thermal@920100 {
+		#thermal-sensor-cells = <0>;
+		compatible = "sigma,smp8758-thermal";
+		reg = <0x920100 12>;
+	};
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index c37eedc35a24..1c9ab79fa3e0 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -260,6 +260,15 @@ config ARMADA_THERMAL
 	  Enable this option if you want to have support for thermal management
 	  controller present in Armada 370 and Armada XP SoC.
 
+config TANGO_THERMAL
+	tristate "Tango thermal management"
+	depends on ARCH_TANGO || COMPILE_TEST
+	help
+	  Enable the Tango thermal driver, which supports the primitive
+	  temperature sensor embedded in Tango chips since the SMP8758.
+	  This sensor only generates a 1-bit signal to indicate whether
+	  the die temperature exceeds a programmable threshold.
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
index 000000000000..d6592bfbd057
--- /dev/null
+++ b/drivers/thermal/tango_thermal.c
@@ -0,0 +1,111 @@
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/thermal.h>
+#include <linux/platform_device.h>
+
+/*
+ * According to a data sheet draft, "this temperature sensor uses a bandgap
+ * type of circuit to compare a voltage which has a negative temperature
+ * coefficient with a voltage that is proportional to absolute temperature.
+ * A resistor bank allows 41 different temperature thresholds to be selected
+ * and the logic output will then indicate whether the actual die temperature
+ * lies above or below the selected threshold."
+ */
+
+#define TEMPSI_CMD	0
+#define TEMPSI_RES	4
+#define TEMPSI_CFG	8
+
+#define CMD_OFF		0
+#define CMD_ON		1
+#define CMD_READ	2
+
+#define IDX_MIN		15
+#define IDX_MAX		40
+
+struct tango_thermal_priv {
+	void __iomem *base;
+	int thresh_idx;
+};
+
+static bool temp_above_thresh(void __iomem *base, int thresh_idx)
+{
+	writel(CMD_READ | thresh_idx << 8, base + TEMPSI_CMD);
+	usleep_range(10, 20);
+	writel(CMD_READ | thresh_idx << 8, base + TEMPSI_CMD);
+
+	return readl(base + TEMPSI_RES);
+}
+
+static int tango_get_temp(void *arg, int *res)
+{
+	struct tango_thermal_priv *priv = arg;
+	int idx = priv->thresh_idx;
+
+	if (temp_above_thresh(priv->base, idx)) {
+		/* Search upward by incrementing thresh_idx */
+		while (idx < IDX_MAX && temp_above_thresh(priv->base, ++idx))
+			cpu_relax();
+		idx = idx - 1; /* always return lower bound */
+	} else {
+		/* Search downward by decrementing thresh_idx */
+		while (idx > IDX_MIN && !temp_above_thresh(priv->base, --idx))
+			cpu_relax();
+	}
+
+	*res = (idx * 9 / 2 - 38) * 1000; /* millidegrees Celsius */
+	priv->thresh_idx = idx;
+
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
+	struct thermal_zone_device *tzdev;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->thresh_idx = IDX_MIN;
+	writel(CMD_ON, priv->base + TEMPSI_CMD);
+
+	tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, priv, &ops);
+	if (IS_ERR(tzdev))
+		return PTR_ERR(tzdev);
+
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
2.8.1
