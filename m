From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 5/5] power_supply: max17042: Use regmap_update_bits instead
 read and write
Date: Tue, 24 Feb 2015 10:54:47 +0100
Message-ID: <1424771687-7976-5-git-send-email-k.kozlowski@samsung.com>
References: <1424771687-7976-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1424771687-7976-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Consolidate regmap_read() and regmap_write() into one
regmap_update_bits() call. This is more readable and safer because
regmap's mutex will prevent any concurrent access to modified registers
(the concurrent access could happen through max17042_init_chip() in
scheduled work).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/power/max17042_battery.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
index 1da6c5fbdff5..830435adfb64 100644
--- a/drivers/power/max17042_battery.c
+++ b/drivers/power/max17042_battery.c
@@ -529,7 +529,6 @@ static int max17042_init_chip(struct max17042_chip *chip)
 {
 	struct regmap *map = chip->regmap;
 	int ret;
-	int val;
 
 	max17042_override_por_values(chip);
 	/* After Power up, the MAX17042 requires 500mS in order
@@ -572,8 +571,7 @@ static int max17042_init_chip(struct max17042_chip *chip)
 	max17042_load_new_capacity_params(chip);
 
 	/* Init complete, Clear the POR bit */
-	regmap_read(map, MAX17042_STATUS, &val);
-	regmap_write(map, MAX17042_STATUS, val & (~STATUS_POR_BIT));
+	regmap_update_bits(map, MAX17042_STATUS, STATUS_POR_BIT, 0x0);
 	return 0;
 }
 
@@ -745,9 +743,9 @@ static int max17042_probe(struct i2c_client *client,
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					chip->battery.name, chip);
 		if (!ret) {
-			regmap_read(chip->regmap, MAX17042_CONFIG, &val);
-			val |= CONFIG_ALRT_BIT_ENBL;
-			regmap_write(chip->regmap, MAX17042_CONFIG, val);
+			regmap_update_bits(chip->regmap, MAX17042_CONFIG,
+					CONFIG_ALRT_BIT_ENBL,
+					CONFIG_ALRT_BIT_ENBL);
 			max17042_set_soc_threshold(chip, 1);
 		} else {
 			client->irq = 0;
-- 
1.9.1
