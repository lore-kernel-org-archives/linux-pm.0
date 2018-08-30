From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 4/6] power: reset: at91-poweroff: make sclk part of struct shdwc
Date: Thu, 30 Aug 2018 14:50:09 +0300
Message-ID: <1535629811-13403-5-git-send-email-claudiu.beznea@microchip.com>
References: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux@armlinux.org.uk, sre@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea@microchip.com>
List-Id: linux-pm@vger.kernel.org

Make sclk part of struct shdwc to have all the data specific to SHDWC
grouped together in one structure.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index c9994103248e..945b41b4086a 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -70,6 +70,7 @@ struct shdwc_config {
 
 struct shdwc {
 	const struct shdwc_config *cfg;
+	struct clk *sclk;
 	void __iomem *at91_shdwc_base;
 	void __iomem *mpddrc_base;
 	void __iomem *pmc_base;
@@ -80,7 +81,6 @@ struct shdwc {
  * since pm_power_off itself is global.
  */
 static struct shdwc *at91_shdwc;
-static struct clk *sclk;
 
 static const unsigned long long sdwc_dbc_period[] = {
 	0, 3, 32, 512, 4096, 32768,
@@ -271,11 +271,11 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
 	match = of_match_node(at91_shdwc_of_match, pdev->dev.of_node);
 	at91_shdwc->cfg = match->data;
 
-	sclk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(sclk))
-		return PTR_ERR(sclk);
+	at91_shdwc->sclk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(at91_shdwc->sclk))
+		return PTR_ERR(at91_shdwc->sclk);
 
-	ret = clk_prepare_enable(sclk);
+	ret = clk_prepare_enable(at91_shdwc->sclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not enable slow clock\n");
 		return ret;
@@ -328,7 +328,7 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
 unmap:
 	iounmap(at91_shdwc->pmc_base);
 clk_disable:
-	clk_disable_unprepare(sclk);
+	clk_disable_unprepare(at91_shdwc->sclk);
 
 	return ret;
 }
@@ -348,7 +348,7 @@ static int __exit at91_shdwc_remove(struct platform_device *pdev)
 		iounmap(shdw->mpddrc_base);
 	iounmap(shdw->pmc_base);
 
-	clk_disable_unprepare(sclk);
+	clk_disable_unprepare(shdw->sclk);
 
 	return 0;
 }
-- 
2.7.4
