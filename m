From: Bastian Stender <bst@pengutronix.de>
Subject: [PATCH] thermal: imx: use cpufreq cooling of registration method
Date: Fri,  3 Nov 2017 17:42:03 +0100
Message-ID: <20171103164203.5805-1-bst@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:42151 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932321AbdKCQmw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Nov 2017 12:42:52 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, kernel@pengutronix.de, Bastian Stender <bst@pengutronix.de>

The of variant of cpufreq_cooling_register links the cooling device to
the device tree node provided.

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
 drivers/thermal/imx_thermal.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 4798b4b1fd77..de71cd3bb03a 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -473,6 +473,8 @@ MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
 
 static int imx_thermal_probe(struct platform_device *pdev)
 {
+	struct device_node *np;
+	struct device *cpu_dev;
 	struct imx_thermal_data *data;
 	struct regmap *map;
 	int measure_freq;
@@ -533,7 +535,19 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		return -EPROBE_DEFER;
 	}
 
-	data->cdev = cpufreq_cooling_register(data->policy);
+	cpu_dev = get_cpu_device(0);
+	if (!cpu_dev) {
+		pr_err("%s: failed to get cpu0 device\n", __func__);
+		return -ENODEV;
+	}
+
+	np = of_node_get(cpu_dev->of_node);
+	if (!np) {
+		dev_err(cpu_dev, "failed to find cpu0 node\n");
+		return -ENOENT;
+	}
+
+	data->cdev = of_cpufreq_cooling_register(np, data->policy);
 	if (IS_ERR(data->cdev)) {
 		ret = PTR_ERR(data->cdev);
 		dev_err(&pdev->dev,
-- 
2.11.0
