From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC PATCHv2 09/19] power: bq2415x_charger: Use power_supply_*() API
 for accessing function attrs
Date: Mon, 05 Jan 2015 16:47:52 +0100
Message-ID: <1420472882-10463-10-git-send-email-k.kozlowski@samsung.com>
References: <1420472882-10463-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1420472882-10463-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

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
