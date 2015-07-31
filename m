From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 17/23] power/reset: at91-reset: remove useless at91_reset_platform_probe()
Date: Fri, 31 Jul 2015 11:39:53 +0200
Message-ID: <1438335599-3301-18-git-send-email-alexandre.belloni__33336.5139122636$1438337566$gmane$org@free-electrons.com>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:35632 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751098AbbGaKMh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 06:12:37 -0400
Received: from localhost (128-79-216-6.hfc.dyn.abo.bbox.fr [128.79.216.6])
	by mail.free-electrons.com (Postfix) with ESMTPSA id 3B8C3366
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2015 12:12:37 +0200 (CEST)
In-Reply-To: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-pm@vger.kernel.or

Since all the at91 platforms are now DT only, at91_reset_platform_probe()
is now useless, remove it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-pm@vger.kernel.or
 drivers/power/reset/at91-reset.c | 47 +++-------------------------------------
 1 file changed, 3 insertions(+), 44 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 36dc52fb2ec8..3225c8590ed0 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -169,11 +169,11 @@ static struct notifier_block at91_restart_nb = {
 	.priority = 192,
 };
 
-static int at91_reset_of_probe(struct platform_device *pdev)
+static int at91_reset_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	struct device_node *np;
-	int idx = 0;
+	int ret, idx = 0;
 
 	at91_rstc_base = of_iomap(pdev->dev.of_node, 0);
 	if (!at91_rstc_base) {
@@ -192,49 +192,8 @@ static int at91_reset_of_probe(struct platform_device *pdev)
 
 	match = of_match_node(at91_reset_of_match, pdev->dev.of_node);
 	at91_restart_nb.notifier_call = match->data;
-	return register_restart_handler(&at91_restart_nb);
-}
-
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
-static int at91_reset_probe(struct platform_device *pdev)
-{
-	int ret;
-
-	if (pdev->dev.of_node)
-		ret = at91_reset_of_probe(pdev);
-	else
-		ret = at91_reset_platform_probe(pdev);
 
+	ret = register_restart_handler(&at91_restart_nb);
 	if (ret)
 		return ret;
 
-- 
2.1.4

