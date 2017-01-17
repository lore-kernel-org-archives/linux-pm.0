From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 09/13] pinctrl: samsung: Use generic
 of_device_get_match_data helper
Date: Tue, 17 Jan 2017 13:44:40 +0100
Message-ID: <1484657084-26227-10-git-send-email-m.szyprowski@samsung.com>
References: <1484657084-26227-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170117124501eucas1p101d1468371db26b0244854e36281b9c9@eucas1p1.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:27653 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbdAQMqE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Jan 2017 07:46:04 -0500
In-reply-to: <1484657084-26227-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Replace custom code with generic helper.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
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

