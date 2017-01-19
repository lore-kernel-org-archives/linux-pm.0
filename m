From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 09/13] pinctrl: samsung: Use generic
 of_device_get_match_data helper
Date: Thu, 19 Jan 2017 14:48:49 +0100
Message-ID: <1484833733-16082-10-git-send-email-m.szyprowski@samsung.com>
References: <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170119134908eucas1p1768743f7e2578af5ae47291a6123c3f8@eucas1p1.samsung.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-reply-to: <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Replace custom code with generic helper.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 2803ae57f373..59f99ea7e65b 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -27,6 +27,7 @@
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/irqdomain.h>
+#include <linux/of_device.h>
 #include <linux/spinlock.h>
 #include <linux/syscore_ops.h>
 
@@ -955,15 +956,12 @@ static int samsung_gpiolib_unregister(struct platform_device *pdev,
 	return 0;
 }
 
-static const struct of_device_id samsung_pinctrl_dt_match[];
-
 /* retrieve the soc specific data */
 static const struct samsung_pin_ctrl *
 samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
 			     struct platform_device *pdev)
 {
 	int id;
-	const struct of_device_id *match;
 	struct device_node *node = pdev->dev.of_node;
 	struct device_node *np;
 	const struct samsung_pin_bank_data *bdata;
@@ -978,8 +976,8 @@ static int samsung_gpiolib_unregister(struct platform_device *pdev,
 		dev_err(&pdev->dev, "failed to get alias id\n");
 		return ERR_PTR(-ENOENT);
 	}
-	match = of_match_node(samsung_pinctrl_dt_match, node);
-	ctrl = (struct samsung_pin_ctrl *)match->data + id;
+	ctrl = of_device_get_match_data(&pdev->dev);
+	ctrl += id;
 
 	d->suspend = ctrl->suspend;
 	d->resume = ctrl->resume;
-- 
1.9.1

