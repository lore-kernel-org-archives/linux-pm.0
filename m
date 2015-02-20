From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFT RESEND 4/4] power_supply: lp8788-charger: Fix leaked power supply
 on probe fail
Date: Fri, 20 Feb 2015 14:32:25 +0100
Message-ID: <1424439145-16895-4-git-send-email-k.kozlowski@samsung.com>
References: <1424439145-16895-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58702 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700AbbBTNch (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Feb 2015 08:32:37 -0500
In-reply-to: <1424439145-16895-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Milo Kim <milo.kim@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Artamonow <mad_soft@inbox.ru>, Marek Belisko <marek@goldelico.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, stable@vger.kernel.org

Driver forgot to unregister charger power supply if registering of
battery supply failed in probe(). In such case the memory associated
with power supply leaked.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Fixes: 98a276649358 ("power_supply: Add new lp8788 charger driver")
Cc: <stable@vger.kernel.org>
---
 drivers/power/lp8788-charger.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/lp8788-charger.c b/drivers/power/lp8788-charger.c
index 21fc233c7d61..176dab2e4c16 100644
--- a/drivers/power/lp8788-charger.c
+++ b/drivers/power/lp8788-charger.c
@@ -417,8 +417,10 @@ static int lp8788_psy_register(struct platform_device *pdev,
 	pchg->battery.num_properties = ARRAY_SIZE(lp8788_battery_prop);
 	pchg->battery.get_property = lp8788_battery_get_property;
 
-	if (power_supply_register(&pdev->dev, &pchg->battery))
+	if (power_supply_register(&pdev->dev, &pchg->battery)) {
+		power_supply_unregister(&pchg->charger);
 		return -EPERM;
+	}
 
 	return 0;
 }
-- 
1.9.1

