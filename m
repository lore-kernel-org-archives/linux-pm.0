From: Marek Belisko <marek.belisko@open-nandra.com>
Subject: [RFC PATCH 2/5] power: generic-adc-battery: Parse more properties from DT
Date: Tue,  1 Aug 2017 22:55:23 +0200
Message-ID: <1501620926-22669-3-git-send-email-marek.belisko@open-nandra.com>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: robh+dt@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldelico.com, pavel@ucw.cz, Marek Belisko <marek.belisko@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Marek Belisko <marek.belisko@gmail.com>

Signed-off-by: Marek Belisko <marek.belisko@gmail.com>
---
 drivers/power/supply/generic-adc-battery.c | 68 ++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index b5e9208..d4daa6a 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -23,6 +23,7 @@
 #include <linux/iio/consumer.h>
 #include <linux/iio/types.h>
 #include <linux/power/generic-adc-battery.h>
+#include <linux/of_gpio.h>
 
 #define JITTER_DEFAULT 10 /* hope 10ms is enough */
 
@@ -241,6 +242,69 @@ static irqreturn_t gab_charged(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_OF
+static struct gab_platform_data *gab_dt_probe(struct platform_device *pdev)
+{
+	struct gab_platform_data *pdata;
+	struct device_node *np = pdev->dev.of_node;
+	const char *name;
+	u32 val;
+	int err;
+
+	pdata = devm_kzalloc(&pdev->dev,
+			sizeof(struct gab_platform_data),
+			GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	pdata->gpio_charge_finished  = of_get_gpio(np, 0);
+
+	/* parse and fill power_supply_info struct */
+	err = of_property_read_u32(np, "technology", &val);
+	if (err) {
+		dev_info(&pdev->dev, "Battery technology unknown\n");
+		val = 0;
+	}
+	pdata->battery_info.technology = val;
+
+	err = of_property_read_string(np, "battery-name", &name);
+	if (err) {
+		dev_info(&pdev->dev, "Battery name empty, setting default\n");
+	}
+	pdata->battery_info.name = name;
+
+	val = 0;
+	err = of_property_read_u32(np, "charge_empty_design", &val);
+	pdata->battery_info.charge_empty_design = val;
+
+	val = 0;
+	err = of_property_read_u32(np, "charge_full_design", &val);
+	pdata->battery_info.charge_full_design = val;
+
+	val = 0;
+	err = of_property_read_u32(np, "voltage_min_design", &val);
+	pdata->battery_info.voltage_min_design = val;
+
+	val = 0;
+	err = of_property_read_u32(np, "voltage_max-design", &val);
+	pdata->battery_info.voltage_max_design = val;
+
+	return pdata;
+}
+
+static const struct of_device_id of_gab_match[] = {
+	{ .compatible = "linux,generic-adc-battery", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_gab_match);
+
+#else
+static struct gab_platform_data gab_dt_probe(struct platform_device *pdev)
+{
+	ERR_PTR(-ENODEV);
+}
+#endif
+
 static int gab_probe(struct platform_device *pdev)
 {
 	struct gab *adc_bat;
@@ -258,6 +322,9 @@ static int gab_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	if (pdata == NULL)
+		pdata = gab_dt_probe(pdev);
+
 	psy_cfg.drv_data = adc_bat;
 	psy_desc = &adc_bat->psy_desc;
 	psy_desc->name = "generic-adc-batt";//pdata->battery_info.name;
@@ -418,6 +485,7 @@ static struct platform_driver gab_driver = {
 	.driver		= {
 		.name	= "generic-adc-battery",
 		.pm	= &gab_pm_ops,
+		.of_match_table = of_gab_match,
 	},
 	.probe		= gab_probe,
 	.remove		= gab_remove,
-- 
2.7.4
