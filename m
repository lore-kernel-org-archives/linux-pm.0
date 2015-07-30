From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 18/20] power/reset: at91-poweroff: get and use slow clock
Date: Thu, 30 Jul 2015 02:22:04 +0200
Message-ID: <1438215726-27452-19-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:56690 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754647AbbG3AWh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2015 20:22:37 -0400
In-Reply-To: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-pm@vger.kernel.org

Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system
hang") added a workaround for the slow clock as it is not properly handled
by its users.

Get and use the slow clock as it is necessary for the at91 shutdown
controller.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-pm@vger.kernel.org
 drivers/power/reset/at91-poweroff.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
index 9847cfb7e23d..fadd1a41729b 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -10,6 +10,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -48,6 +49,7 @@ static const char *shdwc_wakeup_modes[] = {
 };
 
 static void __iomem *at91_shdwc_base;
+static struct clk *sclk;
 
 static void __init at91_wakeup_status(void)
 {
@@ -122,6 +124,7 @@ static void at91_poweroff_dt_set_wakeup_mode(struct platform_device *pdev)
 static int at91_poweroff_probe(struct platform_device *pdev)
 {
 	struct resource *res;
+	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	at91_shdwc_base = devm_ioremap_resource(&pdev->dev, res);
@@ -130,6 +133,16 @@ static int at91_poweroff_probe(struct platform_device *pdev)
 		return PTR_ERR(at91_shdwc_base);
 	}
 
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
 	at91_wakeup_status();
 
 	if (pdev->dev.of_node)
-- 
2.1.4

