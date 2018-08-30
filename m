From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/6] power: reset: at91-poweroff: make mpddrc_base part of struct shdwc
Date: Thu, 30 Aug 2018 14:50:08 +0300
Message-ID: <1535629811-13403-4-git-send-email-claudiu.beznea@microchip.com>
References: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux@armlinux.org.uk, sre@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea@microchip.com>
List-Id: linux-pm@vger.kernel.org

Make mpddrc_base part of struct shdwc since there is also only one
instance of struct shdwc *at91_shdwc in system and to have all data
specific to SHDWC grouped together.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index 94ad79d0d82e..c9994103248e 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -71,6 +71,7 @@ struct shdwc_config {
 struct shdwc {
 	const struct shdwc_config *cfg;
 	void __iomem *at91_shdwc_base;
+	void __iomem *mpddrc_base;
 	void __iomem *pmc_base;
 };
 
@@ -80,7 +81,6 @@ struct shdwc {
  */
 static struct shdwc *at91_shdwc;
 static struct clk *sclk;
-static void __iomem *mpddrc_base;
 
 static const unsigned long long sdwc_dbc_period[] = {
 	0, 3, 32, 512, 4096, 32768,
@@ -136,7 +136,7 @@ static void at91_poweroff(void)
 
 		"	b	.\n\t"
 		:
-		: "r" (mpddrc_base),
+		: "r" (at91_shdwc->mpddrc_base),
 		  "r" cpu_to_le32(AT91_DDRSDRC_LPDDR2_PWOFF),
 		  "r" (at91_shdwc->at91_shdwc_base),
 		  "r" cpu_to_le32(AT91_SHDW_KEY | AT91_SHDW_SHDW),
@@ -305,21 +305,22 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
 		goto unmap;
 	}
 
-	mpddrc_base = of_iomap(np, 0);
+	at91_shdwc->mpddrc_base = of_iomap(np, 0);
 	of_node_put(np);
 
-	if (!mpddrc_base) {
+	if (!at91_shdwc->mpddrc_base) {
 		ret = -ENOMEM;
 		goto unmap;
 	}
 
 	pm_power_off = at91_poweroff;
 
-	ddr_type = readl(mpddrc_base + AT91_DDRSDRC_MDR) & AT91_DDRSDRC_MD;
+	ddr_type = readl(at91_shdwc->mpddrc_base + AT91_DDRSDRC_MDR) &
+			 AT91_DDRSDRC_MD;
 	if (ddr_type != AT91_DDRSDRC_MD_LPDDR2 &&
 	    ddr_type != AT91_DDRSDRC_MD_LPDDR3) {
-		iounmap(mpddrc_base);
-		mpddrc_base = NULL;
+		iounmap(at91_shdwc->mpddrc_base);
+		at91_shdwc->mpddrc_base = NULL;
 	}
 
 	return 0;
@@ -343,8 +344,8 @@ static int __exit at91_shdwc_remove(struct platform_device *pdev)
 	writel(0, shdw->at91_shdwc_base + AT91_SHDW_MR);
 	writel(0, shdw->at91_shdwc_base + AT91_SHDW_WUIR);
 
-	if (mpddrc_base)
-		iounmap(mpddrc_base);
+	if (shdw->mpddrc_base)
+		iounmap(shdw->mpddrc_base);
 	iounmap(shdw->pmc_base);
 
 	clk_disable_unprepare(sclk);
-- 
2.7.4
