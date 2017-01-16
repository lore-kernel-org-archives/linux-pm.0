From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 07/12] pinctrl: samsung: Remove dead code
Date: Mon, 16 Jan 2017 07:45:02 +0100
Message-ID: <1484549107-5957-8-git-send-email-m.szyprowski@samsung.com>
References: <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170116064526eucas1p150c6653c9f1fac798ea79f6bee5631a1@eucas1p1.samsung.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-reply-to: <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

'enable' parameter has been removed a while ago, so all code for handling
it can be simply removed.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index b11e67e85460..7648a280c0f4 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -350,7 +350,7 @@ static void pin_to_reg_bank(struct samsung_pinctrl_drv_data *drvdata,
 
 /* enable or disable a pinmux function */
 static void samsung_pinmux_setup(struct pinctrl_dev *pctldev, unsigned selector,
-					unsigned group, bool enable)
+					unsigned group)
 {
 	struct samsung_pinctrl_drv_data *drvdata;
 	const struct samsung_pin_bank_type *type;
@@ -380,8 +380,7 @@ static void samsung_pinmux_setup(struct pinctrl_dev *pctldev, unsigned selector,
 
 	data = readl(reg + type->reg_offset[PINCFG_TYPE_FUNC]);
 	data &= ~(mask << shift);
-	if (enable)
-		data |= func->val << shift;
+	data |= func->val << shift;
 	writel(data, reg + type->reg_offset[PINCFG_TYPE_FUNC]);
 
 	spin_unlock_irqrestore(&bank->slock, flags);
@@ -392,7 +391,7 @@ static int samsung_pinmux_set_mux(struct pinctrl_dev *pctldev,
 				  unsigned selector,
 				  unsigned group)
 {
-	samsung_pinmux_setup(pctldev, selector, group, true);
+	samsung_pinmux_setup(pctldev, selector, group);
 	return 0;
 }
 
-- 
1.9.1

