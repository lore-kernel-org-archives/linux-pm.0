From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 16/20] power/reset: at91-reset: remove useless at91_reset_platform_probe()
Date: Thu, 30 Jul 2015 02:22:02 +0200
Message-ID: <1438215726-27452-17-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Since all the at91 platforms are now DT only, at91_reset_platform_probe()
is now useless, remove it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-pm@vger.kernel.org
 drivers/power/reset/at91-reset.c | 36 +-----------------------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 36dc52fb2ec8..3e8f478385c1 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -195,46 +195,12 @@ static int at91_reset_of_probe(struct platform_device *pdev)
 	return register_restart_handler(&at91_restart_nb);
 }
 
-static int at91_reset_platform_probe(struct platform_device *pdev)
-{
-	const struct platform_device_id *match;
-	struct resource *res;
-	int idx = 0;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	at91_rstc_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(at91_rstc_base)) {
-		dev_err(&pdev->dev, "Could not map reset controller address\n");
-		return PTR_ERR(at91_rstc_base);
-	}
-
-	for (idx = 0; idx < 2; idx++) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, idx + 1 );
-		at91_ramc_base[idx] = devm_ioremap(&pdev->dev, res->start,
-						   resource_size(res));
-		if (!at91_ramc_base[idx]) {
-			dev_err(&pdev->dev, "Could not map ram controller address\n");
-			return -ENOMEM;
-		}
-	}
-
-	match = platform_get_device_id(pdev);
-	at91_restart_nb.notifier_call =
-		(int (*)(struct notifier_block *,
-			 unsigned long, void *)) match->driver_data;
-
-	return register_restart_handler(&at91_restart_nb);
-}
-
 static int at91_reset_probe(struct platform_device *pdev)
 {
 	int ret;
 
-	if (pdev->dev.of_node)
-		ret = at91_reset_of_probe(pdev);
-	else
-		ret = at91_reset_platform_probe(pdev);
 
+	ret = at91_reset_of_probe(pdev);
 	if (ret)
 		return ret;
 
-- 
2.1.4
