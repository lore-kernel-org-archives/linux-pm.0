From: Bastian Stender <bst@pengutronix.de>
Subject: [PATCH] cpufreq: imx6q/thermal: imx: move CPU cooling device from thermal to cpufreq
Date: Wed, 15 Nov 2017 10:23:32 +0100
Message-ID: <20171115092332.9320-1-bst@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51279 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751189AbdKOJXi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 04:23:38 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de, Bastian Stender <bst@pengutronix.de>

The cooling device should be part of the i.MX cpufreq driver. So move
it there.

Use of_cpufreq_power_cooling_register to link the cooling device to the
device tree node provided.

This makes it possible to bind the cpufreq cooling device to a custom
thermal zone via a cooling-maps entry like:

	cooling-maps {
		map0 {
			trip = <&board_alert>;
			cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
		};
	};

Assuming a cpu node exists with label "cpu0" and #cooling-cells
property.

Signed-off-by: Bastian Stender <bst@pengutronix.de>
---

This is a rework of "thermal: imx: use cpufreq cooling of
registration method" (id:20171103164203.5805-1-bst@pengutronix.de) and a
merged version of the follow-up patches "thermal: imx: remove cooling
device" (id:20171114134829.1354-1-bst@pengutronix.de) and "cpufreq:
imx6q: add CPU as cooling device"
(id:20171114135128.6173-1-bst@pengutronix.de).
---
 drivers/cpufreq/imx6q-cpufreq.c | 37 +++++++++++++++++++++++++++++++++++++
 drivers/thermal/imx_thermal.c   | 15 ---------------
 2 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 14466a9b01c0..6c7c59766990 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -9,6 +9,7 @@
 #include <linux/clk.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
+#include <linux/cpu_cooling.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -35,6 +36,7 @@ static struct clk *pll2_bus_clk;
 static struct clk *secondary_sel_clk;
 
 static struct device *cpu_dev;
+static struct thermal_cooling_device *cdev;
 static bool free_opp;
 static struct cpufreq_frequency_table *freq_table;
 static unsigned int transition_latency;
@@ -169,6 +171,32 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 	return 0;
 }
 
+static void imx6q_cpufreq_ready(struct cpufreq_policy *policy)
+{
+	struct device_node *np = of_node_get(cpu_dev->of_node);
+	u32 capacitance = 0;
+
+	if (WARN_ON(!np))
+		return;
+
+	if (of_find_property(np, "#cooling-cells", NULL)) {
+		of_property_read_u32(np, "dynamic-power-coefficient", &capacitance);
+
+		cdev = of_cpufreq_power_cooling_register(np,
+						policy, capacitance, NULL);
+
+		if (IS_ERR(cdev)) {
+			dev_err(cpu_dev,
+				"running cpufreq without cooling device: %ld\n",
+				PTR_ERR(cdev));
+
+			cdev = NULL;
+		}
+	}
+
+	of_node_put(np);
+}
+
 static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 {
 	int ret;
@@ -180,13 +208,22 @@ static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
+static int imx6q_cpufreq_exit(struct cpufreq_policy *policy)
+{
+	cpufreq_cooling_unregister(cdev);
+
+	return 0;
+}
+
 static struct cpufreq_driver imx6q_cpufreq_driver = {
 	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = imx6q_set_target,
 	.get = cpufreq_generic_get,
 	.init = imx6q_cpufreq_init,
+	.exit = imx6q_cpufreq_exit,
 	.name = "imx6q-cpufreq",
+	.ready = imx6q_cpufreq_ready,
 	.attr = cpufreq_generic_attr,
 	.suspend = cpufreq_generic_suspend,
 };
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 4798b4b1fd77..3bdbde675698 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -91,7 +91,6 @@ static struct thermal_soc_data thermal_imx6sx_data = {
 struct imx_thermal_data {
 	struct cpufreq_policy *policy;
 	struct thermal_zone_device *tz;
-	struct thermal_cooling_device *cdev;
 	enum thermal_device_mode mode;
 	struct regmap *tempmon;
 	u32 c1, c2; /* See formula in imx_get_sensor_data() */
@@ -533,22 +532,12 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		return -EPROBE_DEFER;
 	}
 
-	data->cdev = cpufreq_cooling_register(data->policy);
-	if (IS_ERR(data->cdev)) {
-		ret = PTR_ERR(data->cdev);
-		dev_err(&pdev->dev,
-			"failed to register cpufreq cooling device: %d\n", ret);
-		cpufreq_cpu_put(data->policy);
-		return ret;
-	}
-
 	data->thermal_clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(data->thermal_clk)) {
 		ret = PTR_ERR(data->thermal_clk);
 		if (ret != -EPROBE_DEFER)
 			dev_err(&pdev->dev,
 				"failed to get thermal clk: %d\n", ret);
-		cpufreq_cooling_unregister(data->cdev);
 		cpufreq_cpu_put(data->policy);
 		return ret;
 	}
@@ -563,7 +552,6 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(data->thermal_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
-		cpufreq_cooling_unregister(data->cdev);
 		cpufreq_cpu_put(data->policy);
 		return ret;
 	}
@@ -579,7 +567,6 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"failed to register thermal zone device %d\n", ret);
 		clk_disable_unprepare(data->thermal_clk);
-		cpufreq_cooling_unregister(data->cdev);
 		cpufreq_cpu_put(data->policy);
 		return ret;
 	}
@@ -608,7 +595,6 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
 		clk_disable_unprepare(data->thermal_clk);
 		thermal_zone_device_unregister(data->tz);
-		cpufreq_cooling_unregister(data->cdev);
 		cpufreq_cpu_put(data->policy);
 		return ret;
 	}
@@ -630,7 +616,6 @@ static int imx_thermal_remove(struct platform_device *pdev)
 		clk_disable_unprepare(data->thermal_clk);
 
 	thermal_zone_device_unregister(data->tz);
-	cpufreq_cooling_unregister(data->cdev);
 	cpufreq_cpu_put(data->policy);
 
 	return 0;
-- 
2.11.0
