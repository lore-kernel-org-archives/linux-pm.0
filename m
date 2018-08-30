From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 5/6] power: reset: at91-poweroff: rename at91_shdwc_base member of struct shdwc
Date: Thu, 30 Aug 2018 14:50:10 +0300
Message-ID: <1535629811-13403-6-git-send-email-claudiu.beznea@microchip.com>
References: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux@armlinux.org.uk, sre@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea@microchip.com>
List-Id: linux-pm@vger.kernel.org

Rename at91_shdwc_base member of struct shdwc to shdwc_base. There is
already an "at91" string in at91_shdwc object.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index 945b41b4086a..ad6e2796690a 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -71,7 +71,7 @@ struct shdwc_config {
 struct shdwc {
 	const struct shdwc_config *cfg;
 	struct clk *sclk;
-	void __iomem *at91_shdwc_base;
+	void __iomem *shdwc_base;
 	void __iomem *mpddrc_base;
 	void __iomem *pmc_base;
 };
@@ -92,7 +92,7 @@ static void __init at91_wakeup_status(struct platform_device *pdev)
 	u32 reg;
 	char *reason = "unknown";
 
-	reg = readl(shdw->at91_shdwc_base + AT91_SHDW_SR);
+	reg = readl(shdw->shdwc_base + AT91_SHDW_SR);
 
 	dev_dbg(&pdev->dev, "%s: status = %#x\n", __func__, reg);
 
@@ -138,7 +138,7 @@ static void at91_poweroff(void)
 		:
 		: "r" (at91_shdwc->mpddrc_base),
 		  "r" cpu_to_le32(AT91_DDRSDRC_LPDDR2_PWOFF),
-		  "r" (at91_shdwc->at91_shdwc_base),
+		  "r" (at91_shdwc->shdwc_base),
 		  "r" cpu_to_le32(AT91_SHDW_KEY | AT91_SHDW_SHDW),
 		  "r" (at91_shdwc->pmc_base)
 		: "r6");
@@ -222,10 +222,10 @@ static void at91_shdwc_dt_configure(struct platform_device *pdev)
 		mode |= SHDW_RTCWKEN(shdw->cfg);
 
 	dev_dbg(&pdev->dev, "%s: mode = %#x\n", __func__, mode);
-	writel(mode, shdw->at91_shdwc_base + AT91_SHDW_MR);
+	writel(mode, shdw->shdwc_base + AT91_SHDW_MR);
 
 	input = at91_shdwc_get_wakeup_input(pdev, np);
-	writel(input, shdw->at91_shdwc_base + AT91_SHDW_WUIR);
+	writel(input, shdw->shdwc_base + AT91_SHDW_WUIR);
 }
 
 static const struct shdwc_config sama5d2_shdwc_config = {
@@ -262,10 +262,10 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, at91_shdwc);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	at91_shdwc->at91_shdwc_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(at91_shdwc->at91_shdwc_base)) {
+	at91_shdwc->shdwc_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(at91_shdwc->shdwc_base)) {
 		dev_err(&pdev->dev, "Could not map reset controller address\n");
-		return PTR_ERR(at91_shdwc->at91_shdwc_base);
+		return PTR_ERR(at91_shdwc->shdwc_base);
 	}
 
 	match = of_match_node(at91_shdwc_of_match, pdev->dev.of_node);
@@ -341,8 +341,8 @@ static int __exit at91_shdwc_remove(struct platform_device *pdev)
 		pm_power_off = NULL;
 
 	/* Reset values to disable wake-up features  */
-	writel(0, shdw->at91_shdwc_base + AT91_SHDW_MR);
-	writel(0, shdw->at91_shdwc_base + AT91_SHDW_WUIR);
+	writel(0, shdw->shdwc_base + AT91_SHDW_MR);
+	writel(0, shdw->shdwc_base + AT91_SHDW_WUIR);
 
 	if (shdw->mpddrc_base)
 		iounmap(shdw->mpddrc_base);
-- 
2.7.4
