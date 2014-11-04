From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH RESEND v2 7/8] power: bq2415x_charger: Use power_supply_*() API
 for accessing function attrs
Date: Tue, 04 Nov 2014 16:01:40 +0100
Message-ID: <1415113301-25661-8-git-send-email-k.kozlowski@samsung.com>
References: <1415113301-25661-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:36559 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428AbaKDPBy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Nov 2014 10:01:54 -0500
In-reply-to: <1415113301-25661-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Anton Vorontsov <anton@enomsg.org>, Guenter Roeck <linux@roeck-us.net>, Pavel Machek <pavel@ucw.cz>, Myungjoo Ham <myungjoo.ham@samsung.com>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>

Replace direct calls to power supply function attributes with wrappers.
Wrappers provide safe access in case of unregistering the power
supply (e.g. by removing the driver). Replace:
 - get_property -> power_supply_get_property

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Jonghwa Lee <jonghwa3.lee@samusng.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/power/bq2415x_charger.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_charger.c
index 1f49986fc605..2f80de0410d9 100644
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

