From: Mason <slash.tmp@free.fr>
Subject: [PATCH v2] thermal: tango: add resume support
Date: Tue, 21 Jun 2016 11:05:38 +0200
Message-ID: <57690362.2000706@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:50683 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbcFUJRI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jun 2016 05:17:08 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id B9EE82DD0C
	for <linux-pm@vger.kernel.org>; Tue, 21 Jun 2016 11:06:55 +0200 (CEST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Sebastian Frias <sf84@laposte.net>

From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

When this platform is suspended, firmware powers the entire SoC down,
except a few hardware blocks waiting for wakeup events. And there is
no context to save for this particular block.

Therefore, there is nothing useful for the driver to do on suspend;
so we define a NULL suspend hook. On resume, the driver initializes
the block exactly as is done in the probe callback.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 drivers/thermal/tango_thermal.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/tango_thermal.c b/drivers/thermal/tango_thermal.c
index 70e0d9f406e9..d571ce2f546d 100644
--- a/drivers/thermal/tango_thermal.c
+++ b/drivers/thermal/tango_thermal.c
@@ -64,6 +64,12 @@ static const struct thermal_zone_of_device_ops ops = {
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
@@ -79,14 +85,30 @@ static int tango_thermal_probe(struct platform_device *pdev)
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
 
+#ifdef CONFIG_PM_SLEEP
+static int tango_thermal_resume(struct device *dev)
+{
+	struct tango_thermal_priv *priv = dev_get_drvdata(dev);
+	tango_thermal_init(priv);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(tango_thermal_pm, NULL, tango_thermal_resume);
+
+#define DEV_PM_OPS	&tango_thermal_pm
+#else
+#define DEV_PM_OPS	NULL
+#endif
+
 static const struct of_device_id tango_sensor_ids[] = {
 	{
 		.compatible = "sigma,smp8758-thermal",
@@ -99,6 +121,7 @@ static struct platform_driver tango_thermal_driver = {
 	.driver	= {
 		.name		= "tango-thermal",
 		.of_match_table	= tango_sensor_ids,
+		.pm		= DEV_PM_OPS,
 	},
 };
 
-- 
2.8.2
