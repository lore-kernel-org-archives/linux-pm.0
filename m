From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v3 5/5] power/reset: at91-poweroff: get and use slow clock
Date: Tue, 11 Aug 2015 11:12:50 +0200
Message-ID: <1439284370-13803-6-git-send-email-alexandre.belloni@free-electrons.com>
References: <1439284370-13803-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439284370-13803-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-pm@vger.kernel.org

Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system
hang") added a workaround for the slow clock as it is not properly handled
by its users.

Get and use the slow clock as it is necessary for the at91 shutdown
controller.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/power/reset/at91-poweroff.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
index 3e698d916c4f..e9e24df35f26 100644
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
 static int __init at91_poweroff_probe(struct platform_device *pdev)
 {
 	struct resource *res;
+	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	at91_shdwc_base = devm_ioremap_resource(&pdev->dev, res);
@@ -130,6 +133,16 @@ static int __init at91_poweroff_probe(struct platform_device *pdev)
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
@@ -145,6 +158,8 @@ static int __exit at91_poweroff_remove(struct platform_device *pdev)
 	if (pm_power_off == at91_poweroff)
 		pm_power_off = NULL;
 
+	clk_disable_unprepare(sclk);
+
 	return 0;
 }
 
-- 
2.1.4
