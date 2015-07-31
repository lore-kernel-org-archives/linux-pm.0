From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 18/23] power/reset: at91-reset: get and use slow clock
Date: Fri, 31 Jul 2015 11:39:54 +0200
Message-ID: <1438335599-3301-19-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system
hang") added a workaround for the slow clock as it is not properly handled
by its users.

Get and use the slow clock as it is necessary for the at91 reset
controller.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-pm@vger.kernel.org
 drivers/power/reset/at91-reset.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 3225c8590ed0..19fdd4c107dc 100644
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
@@ -193,9 +195,21 @@ static int at91_reset_probe(struct platform_device *pdev)
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
 
-- 
2.1.4
