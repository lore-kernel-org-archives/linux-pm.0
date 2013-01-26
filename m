From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] cpufreq: instantiate cpufreq-cpu0 as a platform_driver
Date: Sat, 26 Jan 2013 21:55:50 +0800
Message-ID: <1359208550-16402-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:38357
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751019Ab3AZN4B (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 26 Jan 2013 08:56:01 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@sisk.pl>, AnilKumar Ch <anilkumar@ti.com>, Mark Langsdorf <mark.langsdorf@calxeda.com>, Shawn Guo <shawn.guo@linaro.org>

As multiplatform build is being adopted by more and more ARM platforms,
initcall function should be used very carefully.  For example, when
GENERIC_CPUFREQ_CPU0 is built in the kernel, cpu0_cpufreq_driver_init()
will be called on all the platforms to initialize cpufreq-cpu0 driver.

To eliminate this undesired the effect, the patch changes cpufreq-cpu0
driver to have it instantiated as a platform_driver.  Then it will only
run on platforms that create the platform_device "cpufreq-cpu0".

Along with the change, it also changes cpu_dev to be &pdev->dev,
so that managed functions can start working, and module build gets
supported too.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Rafael,

The patch depends patch "power: export opp cpufreq functions".
https://patchwork.kernel.org/patch/1847261/

AnilKumar,

Unfortunately, the change will require some platform level adoption
to have cpufreq-cpu0 driver continue working for am33xx.  But it should
be as simple as something like below.

	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
	platform_device_register_full(&devinfo);

Shawn

 drivers/cpufreq/Kconfig        |    2 +-
 drivers/cpufreq/cpufreq-cpu0.c |   35 +++++++++++++++++++++++------------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index ea512f4..774dc1c 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -180,7 +180,7 @@ config CPU_FREQ_GOV_CONSERVATIVE
 	  If in doubt, say N.
 
 config GENERIC_CPUFREQ_CPU0
-	bool "Generic CPU0 cpufreq driver"
+	tristate "Generic CPU0 cpufreq driver"
 	depends on HAVE_CLK && REGULATOR && PM_OPP && OF
 	select CPU_FREQ_TABLE
 	help
diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index debc5a7..dae0667 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -12,12 +12,12 @@
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
 #include <linux/clk.h>
-#include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/opp.h>
+#include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
@@ -177,7 +177,7 @@ static struct cpufreq_driver cpu0_cpufreq_driver = {
 	.attr = cpu0_cpufreq_attr,
 };
 
-static int cpu0_cpufreq_driver_init(void)
+static int cpu0_cpufreq_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
 	int ret;
@@ -188,23 +188,17 @@ static int cpu0_cpufreq_driver_init(void)
 		return -ENOENT;
 	}
 
-	cpu_dev = get_cpu_device(0);
-	if (!cpu_dev) {
-		pr_err("failed to get cpu0 device\n");
-		ret = -ENODEV;
-		goto out_put_node;
-	}
-
+	cpu_dev = &pdev->dev;
 	cpu_dev->of_node = np;
 
-	cpu_clk = clk_get(cpu_dev, NULL);
+	cpu_clk = devm_clk_get(cpu_dev, NULL);
 	if (IS_ERR(cpu_clk)) {
 		ret = PTR_ERR(cpu_clk);
 		pr_err("failed to get cpu0 clock: %d\n", ret);
 		goto out_put_node;
 	}
 
-	cpu_reg = regulator_get(cpu_dev, "cpu0");
+	cpu_reg = devm_regulator_get(cpu_dev, "cpu0");
 	if (IS_ERR(cpu_reg)) {
 		pr_warn("failed to get cpu0 regulator\n");
 		cpu_reg = NULL;
@@ -267,7 +261,24 @@ out_put_node:
 	of_node_put(np);
 	return ret;
 }
-late_initcall(cpu0_cpufreq_driver_init);
+
+static int cpu0_cpufreq_remove(struct platform_device *pdev)
+{
+	cpufreq_unregister_driver(&cpu0_cpufreq_driver);
+	opp_free_cpufreq_table(cpu_dev, &freq_table);
+
+	return 0;
+}
+
+static struct platform_driver cpu0_cpufreq_platdrv = {
+	.driver = {
+		.name	= "cpufreq-cpu0",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= cpu0_cpufreq_probe,
+	.remove		= cpu0_cpufreq_remove,
+};
+module_platform_driver(cpu0_cpufreq_platdrv);
 
 MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
 MODULE_DESCRIPTION("Generic CPU0 cpufreq driver");
-- 
1.7.9.5


