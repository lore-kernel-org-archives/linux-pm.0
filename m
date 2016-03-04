From: Mason <slash.tmp@free.fr>
Subject: [PATCH v2] thermal: add temperature sensor support for tango SoC
Date: Fri, 4 Mar 2016 16:52:47 +0100
Message-ID: <56D9AF4F.1010304@free.fr>
References: <56D5C7FE.7010807@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:34693 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756332AbcCDPw7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Mar 2016 10:52:59 -0500
In-Reply-To: <56D5C7FE.7010807@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm <linux-pm@vger.kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Mans Rullgard <mans@mansr.com>

From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

There are three temperature sensors in SMP8758.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 drivers/thermal/Kconfig         |   6 +++
 drivers/thermal/Makefile        |   1 +
 drivers/thermal/tango_thermal.c | 113 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+)
 create mode 100644 drivers/thermal/tango_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 7c92c09be213..b63298276532 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -254,6 +254,12 @@ config ARMADA_THERMAL
 	  Enable this option if you want to have support for thermal management
 	  controller present in Armada 370 and Armada XP SoC.
 
+config TANGO_THERMAL
+	tristate "Tango4 thermal management"
+	depends on ARCH_TANGO || COMPILE_TEST
+	help
+	  Enable SMP8758 temperature sensor driver.
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
index 000000000000..eeccb6b0894e
--- /dev/null
+++ b/drivers/thermal/tango_thermal.c
@@ -0,0 +1,113 @@
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
+#define INDEX_OFFSET	18
+
+#define sensor_idle(x)		(readl_relaxed(x + TEMPSI_CMD) & BIT(7))
+#define temp_above_thresh(x)	(readl_relaxed(x + TEMPSI_RES))
+
+static const u8 temperature[] = {
+	 37,  41,  46,  51,  55,  60,  64,  69,
+	 74,  79,  83,  88,  93,  97, 101, 106,
+	110, 115, 120, 124, 129, 133, 137, 142,
+};
+
+static int tango_get_temp(void *arg, int *res)
+{
+	int i;
+	void __iomem *base = arg;
+
+	for (i = INDEX_OFFSET; i < 41; ++i)
+	{
+		writel_relaxed(i << 8 | CMD_READ, base + TEMPSI_CMD);
+
+		while (!sensor_idle(base))
+			cpu_relax();
+
+		if (!temp_above_thresh(base))
+			break;
+	}
+
+	writel_relaxed(INDEX_OFFSET << 8 | CMD_READ, base + TEMPSI_CMD);
+	*res = temperature[i - INDEX_OFFSET] * 1000;
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops ops = {
+	.get_temp	= tango_get_temp,
+};
+
+struct tango_thermal_priv {
+	struct thermal_zone_device *zone;
+	void __iomem *base;
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
+	writel_relaxed(    50, priv->base + TEMPSI_CFG);
+
+	priv->zone = thermal_zone_of_sensor_register(dev, 0, priv->base, &ops);
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
+
+	writel_relaxed(      0, priv->base + TEMPSI_CFG);
+	writel_relaxed(CMD_OFF, priv->base + TEMPSI_CMD);
+
+	return 0;
+}
+
+static const struct of_device_id tango_sensor_ids[] = {
+	{
+		.compatible = "sigma,smp8758-sensor",
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
