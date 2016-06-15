From: Mason <slash.tmp@free.fr>
Subject: [RFC] Adding PM support to thermal driver
Date: Wed, 15 Jun 2016 18:14:14 +0200
Message-ID: <57617ED6.6050305@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:10669 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932554AbcFOQOa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 15 Jun 2016 12:14:30 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@arm.com>
Cc: linux-pm <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Frias <sf84@laposte.net>

Hello,

I need to support suspend-to-RAM in my platform.
This platform powers down on suspend, so the contents of device registers are lost.
Can you tell me if this patch looks OK for adding S2R support?
(I would then make a formal submission.)


Regards.


diff --git a/drivers/thermal/tango_thermal.c b/drivers/thermal/tango_thermal.c
index 70e0d9f406e9..29ef9f2f1b93 100644
--- a/drivers/thermal/tango_thermal.c
+++ b/drivers/thermal/tango_thermal.c
@@ -62,10 +62,16 @@ static int tango_get_temp(void *arg, int *res)
 
 static const struct thermal_zone_of_device_ops ops = {
 	.get_temp	= tango_get_temp,
 };
 
+static void tango_thermal_init(struct tango_thermal_priv *priv)
+{
+	writel(0, priv->base + TEMPSI_CFG);
+	writel(CMD_ON, priv->base + TEMPSI_CMD);
+}
+
 static int tango_thermal_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct tango_thermal_priv *priv;
 	struct thermal_zone_device *tzdev;
@@ -77,18 +83,28 @@ static int tango_thermal_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
+	platform_set_drvdata(pdev, priv);
 	priv->thresh_idx = IDX_MIN;
-	writel(0, priv->base + TEMPSI_CFG);
-	writel(CMD_ON, priv->base + TEMPSI_CMD);
+	tango_thermal_init(priv);
 
 	tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, priv, &ops);
 	return PTR_ERR_OR_ZERO(tzdev);
 }
 
+static int tango_thermal_resume(struct device *dev)
+{
+	struct tango_thermal_priv *priv = dev_get_drvdata(dev);
+	tango_thermal_init(priv);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(tango_thermal_pm_ops, NULL, tango_thermal_resume);
+
 static const struct of_device_id tango_sensor_ids[] = {
 	{
 		.compatible = "sigma,smp8758-thermal",
 	},
 	{ /* sentinel */ }
@@ -97,10 +113,11 @@ static const struct of_device_id tango_sensor_ids[] = {
 static struct platform_driver tango_thermal_driver = {
 	.probe	= tango_thermal_probe,
 	.driver	= {
 		.name		= "tango-thermal",
 		.of_match_table	= tango_sensor_ids,
+		.pm		= &tango_thermal_pm_ops,
 	},
 };
 
 module_platform_driver(tango_thermal_driver);
 
