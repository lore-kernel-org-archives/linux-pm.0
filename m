From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v3 3/5] power/reset: at91-reset: get and use slow clock
Date: Tue, 11 Aug 2015 11:12:48 +0200
Message-ID: <1439284370-13803-4-git-send-email-alexandre.belloni@free-electrons.com>
References: <1439284370-13803-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:54492 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933808AbbHKJM7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 05:12:59 -0400
In-Reply-To: <1439284370-13803-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>

Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system
hang") added a workaround for the slow clock as it is not properly handled
by its users.

Get and use the slow clock as it is necessary for the at91 reset
controller.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/power/reset/at91-reset.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 120f3dec9574..8f0bcb232149 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -11,6 +11,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
@@ -46,6 +47,7 @@ enum reset_type {
 };
 
 static void __iomem *at91_ramc_base[2], *at91_rstc_base;
+static struct clk *sclk;
 
 /*
 * unless the SDRAM is cleanly shutdown before we hit the
@@ -193,9 +195,21 @@ static int __init at91_reset_probe(struct platform_device *pdev)
 	match = of_match_node(at91_reset_of_match, pdev->dev.of_node);
 	at91_restart_nb.notifier_call = match->data;
 
+	sclk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(sclk))
+		return PTR_ERR(sclk);
+
+	ret = clk_prepare_enable(sclk);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not enable slow clock\n");
+		return ret;
+	}
+
 	ret = register_restart_handler(&at91_restart_nb);
-	if (ret)
+	if (ret) {
+		clk_disable_unprepare(sclk);
 		return ret;
+	}
 
 	at91_reset_status(pdev);
 
@@ -205,6 +219,7 @@ static int __init at91_reset_probe(struct platform_device *pdev)
 static int __exit at91_reset_remove(struct platform_device *pdev)
 {
 	unregister_restart_handler(&at91_restart_nb);
+	clk_disable_unprepare(sclk);
 
 	return 0;
 }
-- 
2.1.4

