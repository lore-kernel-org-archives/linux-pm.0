From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 7/8] power: bq2415x_charger: Use power_supply_*() API for
 accessing function attrs
Date: Tue, 14 Oct 2014 14:20:45 +0200
Message-ID: <1413289246-31650-8-git-send-email-k.kozlowski@samsung.com>
References: <1413289246-31650-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1413289246-31650-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Anton Vorontsov <anton@enomsg.org>, Guenter Roeck <linux@roeck-us.net>, Pavel Machek <pavel@ucw.cz>, Myungjoo Ham <myungjoo.ham@samsung.com>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Replace direct calls to power supply function attributes with wrappers.
Wrappers provide safe access access in case of unregistering the power
supply (.e.g by removing the driver). Replace:
 - get_property -> power_supply_get_property

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/power/bq2415x_charger.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_charger.c
index d9c457217b6a..81a3a78b92d8 100644
--- a/drivers/power/bq2415x_charger.c
+++ b/drivers/power/bq2415x_charger.c
@@ -816,7 +816,8 @@ static int bq2415x_notifier_call(struct notifier_block *nb,
 
 	dev_dbg(bq->dev, "notifier call was called\n");
 
-	ret = psy->get_property(psy, POWER_SUPPLY_PROP_CURRENT_MAX, &prop);
+	ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_CURRENT_MAX,
+			&prop);
 	if (ret != 0)
 		return NOTIFY_OK;
 
-- 
1.9.1
