From: Mason <slash.tmp@free.fr>
Subject: [PATCH v3] thermal: tango: add resume support
Date: Mon, 18 Jul 2016 14:21:29 +0200
Message-ID: <578CC9C9.3050806@free.fr>
References: <57726196.5060909@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:3893 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832AbcGRMVt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 18 Jul 2016 08:21:49 -0400
In-Reply-To: <57726196.5060909@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@baylibre.com>, Sebastian Frias <sf84@laposte.net>, Thierry Reding <thierry.reding@gmail.com>, Arnd Bergmann <arnd@arndb.de>

From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

When this platform is suspended, firmware powers the entire SoC down,
except a few hardware blocks waiting for wakeup events. And there is
no context to save for this particular block.

Therefore, there is nothing useful for the driver to do on suspend;
so we define a NULL suspend hook. On resume, the driver initializes
the block exactly as is done in the probe callback.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
Changes in v3
Drop the DEV_PM_OPS macro, which caused some confusion.
Note: tango_thermal_pm struct only exists when CONFIG_PM_SLEEP is defined
@Kevin, can I add your Reviewed-by tag back?
---
 drivers/thermal/tango_thermal.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/tango_thermal.c b/drivers/thermal/tango_thermal.c
index 70e0d9f406e9..957f8937e126 100644
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
@@ -79,14 +85,24 @@ static int tango_thermal_probe(struct platform_device *pdev)
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
+	tango_thermal_init(dev_get_drvdata(dev));
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(tango_thermal_pm, NULL, tango_thermal_resume);
+#endif
+
 static const struct of_device_id tango_sensor_ids[] = {
 	{
 		.compatible = "sigma,smp8758-thermal",
@@ -99,6 +115,9 @@ static struct platform_driver tango_thermal_driver = {
 	.driver	= {
 		.name		= "tango-thermal",
 		.of_match_table	= tango_sensor_ids,
+#ifdef CONFIG_PM_SLEEP
+		.pm		= &tango_thermal_pm,
+#endif
 	},
 };
 
-- 
2.9.0
