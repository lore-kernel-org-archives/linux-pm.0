From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v2 2/2] power: bq2415x_charger: Fix memory leak on DTS parsing
 error
Date: Wed, 15 Oct 2014 16:25:10 +0200
Message-ID: <1413383110-20310-2-git-send-email-k.kozlowski@samsung.com>
References: <1413383110-20310-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1413383110-20310-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Memory allocated for 'name' was leaking if required binding properties
were not present.

The memory for 'name' was allocated early at probe with kasprintf(). It
was freed in error paths executed before and after parsing DTS but not
in that error path.

Fix the error path for parsing device tree properties.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Fixes: faffd234cf85 ("bq2415x_charger: Add DT support")
Cc: <stable@vger.kernel.org>

---

Changes since v1:
1. None, new patch.
---
 drivers/power/bq2415x_charger.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_charger.c
index edf945a5260f..311be01480c8 100644
--- a/drivers/power/bq2415x_charger.c
+++ b/drivers/power/bq2415x_charger.c
@@ -1609,27 +1609,27 @@ static int bq2415x_probe(struct i2c_client *client,
 		ret = of_property_read_u32(np, "ti,current-limit",
 				&bq->init_data.current_limit);
 		if (ret)
-			return ret;
+			goto error_2;
 		ret = of_property_read_u32(np, "ti,weak-battery-voltage",
 				&bq->init_data.weak_battery_voltage);
 		if (ret)
-			return ret;
+			goto error_2;
 		ret = of_property_read_u32(np, "ti,battery-regulation-voltage",
 				&bq->init_data.battery_regulation_voltage);
 		if (ret)
-			return ret;
+			goto error_2;
 		ret = of_property_read_u32(np, "ti,charge-current",
 				&bq->init_data.charge_current);
 		if (ret)
-			return ret;
+			goto error_2;
 		ret = of_property_read_u32(np, "ti,termination-current",
 				&bq->init_data.termination_current);
 		if (ret)
-			return ret;
+			goto error_2;
 		ret = of_property_read_u32(np, "ti,resistor-sense",
 				&bq->init_data.resistor_sense);
 		if (ret)
-			return ret;
+			goto error_2;
 	} else {
 		memcpy(&bq->init_data, pdata, sizeof(bq->init_data));
 	}
-- 
1.9.1
