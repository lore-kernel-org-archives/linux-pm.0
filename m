From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 2/2] power_supply: lp8788-charger: Fix leaked power supply on
 probe fail
Date: Thu, 29 Jan 2015 15:39:39 +0100
Message-ID: <1422542379-8202-2-git-send-email-k.kozlowski@samsung.com>
References: <1422542379-8202-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1422542379-8202-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Milo Kim <milo.kim@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

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
