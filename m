From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFT PATCH] power: bq2415x_charger: Properly handle ENODEV from
 power_supply_get_by_phandle
Date: Tue, 14 Oct 2014 10:32:53 +0200
Message-ID: <1413275573-23014-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The power_supply_get_by_phandle() on error returns ENODEV or NULL.
The driver later expects obtained pointer to power supply to be
valid or NULL. If it is not NULL then it dereferences it in
bq2415x_notifier_call() which would lead to dereferencing ENODEV-value
pointer.

Properly handle the power_supply_get_by_phandle() error case and abort probe.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Fixes: faffd234cf85 ("bq2415x_charger: Add DT support")
Cc: <stable@vger.kernel.org>
---
 drivers/power/bq2415x_charger.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_charger.c
index e384844a1ae1..d9c457217b6a 100644
--- a/drivers/power/bq2415x_charger.c
+++ b/drivers/power/bq2415x_charger.c
@@ -1579,8 +1579,13 @@ static int bq2415x_probe(struct i2c_client *client,
 	if (np) {
 		bq->notify_psy = power_supply_get_by_phandle(np, "ti,usb-charger-detection");
 
-		if (!bq->notify_psy)
+		if (!bq->notify_psy) {
 			return -EPROBE_DEFER;
+		} else if (IS_ERR(bq->notify_psy)) {
+			dev_err(&client->dev, "no 'ti,usb-charger-detection' property\n");
+			ret = PTR_ERR(bq->notify_psy);
+			goto error_2;
+		}
 	}
 	else if (pdata->notify_device)
 		bq->notify_psy = power_supply_get_by_name(pdata->notify_device);
-- 
1.9.1
