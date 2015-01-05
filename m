From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] power: bq24190: Fix ignored supplicants
Date: Mon, 05 Jan 2015 09:51:48 +0100
Message-ID: <1420447908-4389-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The driver mismatched 'num_supplicants' with 'num_supplies' of
power_supply structure.

It provided list of supplicants (power_supply.supplied_to) but did
not set the number of supplicants. Instead it set the num_supplies which
is used when iterating over number of supplies (power_supply.supplied_from).

As a result the list of supplicants was ignored by core because its size
was 0.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: <stable@vger.kernel.org>
Fixes: d7bf353fd0aa ("bq24190_charger: Add support for TI BQ24190 Battery Charger")
---
 drivers/power/bq24190_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/bq24190_charger.c b/drivers/power/bq24190_charger.c
index ad3ff8fbfbbb..e4c95e1a6733 100644
--- a/drivers/power/bq24190_charger.c
+++ b/drivers/power/bq24190_charger.c
@@ -929,7 +929,7 @@ static void bq24190_charger_init(struct power_supply *charger)
 	charger->properties = bq24190_charger_properties;
 	charger->num_properties = ARRAY_SIZE(bq24190_charger_properties);
 	charger->supplied_to = bq24190_charger_supplied_to;
-	charger->num_supplies = ARRAY_SIZE(bq24190_charger_supplied_to);
+	charger->num_supplicants = ARRAY_SIZE(bq24190_charger_supplied_to);
 	charger->get_property = bq24190_charger_get_property;
 	charger->set_property = bq24190_charger_set_property;
 	charger->property_is_writeable = bq24190_charger_property_is_writeable;
-- 
1.9.1
