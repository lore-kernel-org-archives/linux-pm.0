From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] thermal: broadcom: use devm_thermal_zone_of_sensor_register
Date: Tue, 30 Oct 2018 17:08:51 +0100
Message-ID: <1540915731-22312-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Mayer <mmayer@broadcom.com>
Cc: kernel-janitors@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Using devm_thermal_zone_of_sensor_register allows to simplify some
error handling code, drop a label, and drop the remove function.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---

This patch is completely orthogonal to the recent constification
patch.

 drivers/thermal/broadcom/brcmstb_thermal.c |   24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 1919f91fa756..956eef8717bb 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -329,7 +329,8 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 	priv->dev = &pdev->dev;
 	platform_set_drvdata(pdev, priv);
 
-	thermal = thermal_zone_of_sensor_register(&pdev->dev, 0, priv, &of_ops);
+	thermal = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, priv,
+						       &of_ops);
 	if (IS_ERR(thermal)) {
 		ret = PTR_ERR(thermal);
 		dev_err(&pdev->dev, "could not register sensor: %d\n", ret);
@@ -341,40 +342,23 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "could not get IRQ\n");
-		ret = irq;
-		goto err;
+		return irq;
 	}
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					brcmstb_tmon_irq_thread, IRQF_ONESHOT,
 					DRV_NAME, priv);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "could not request IRQ: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	dev_info(&pdev->dev, "registered AVS TMON of-sensor driver\n");
 
 	return 0;
-
-err:
-	thermal_zone_of_sensor_unregister(&pdev->dev, thermal);
-	return ret;
-}
-
-static int brcmstb_thermal_exit(struct platform_device *pdev)
-{
-	struct brcmstb_thermal_priv *priv = platform_get_drvdata(pdev);
-	struct thermal_zone_device *thermal = priv->thermal;
-
-	if (thermal)
-		thermal_zone_of_sensor_unregister(&pdev->dev, priv->thermal);
-
-	return 0;
 }
 
 static struct platform_driver brcmstb_thermal_driver = {
 	.probe = brcmstb_thermal_probe,
-	.remove = brcmstb_thermal_exit,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = brcmstb_thermal_id_table,
