From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v2 1/2] power: bq2415x_charger: Properly handle ENODEV from
 power_supply_get_by_phandle
Date: Wed, 15 Oct 2014 16:25:09 +0200
Message-ID: <1413383110-20310-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:15578 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbaJOOZW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Oct 2014 10:25:22 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, stable@vger.kernel.org

The power_supply_get_by_phandle() on error returns ENODEV or NULL.
The driver later expects obtained pointer to power supply to be
valid or NULL. If it is not NULL then it dereferences it in
bq2415x_notifier_call() which would lead to dereferencing ENODEV-value
pointer.

Properly handle the power_supply_get_by_phandle() error case by
replacing error value with NULL. This indicates that usb charger
detection won't be used.

Fix also memory leak of 'name' if power_supply_get_by_phandle() fails
with NULL and probe should defer.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Fixes: faffd234cf85 ("bq2415x_charger: Add DT support")
Cc: <stable@vger.kernel.org>

---

Changes since v1:
1. Fix memory leak in probe defer (goto error_2) (suggested by Sebastian
   Reichel).
2. Don't fail the probe if 'ti,usb-charger-detection' is not present.
   Just print message.
---
 drivers/power/bq2415x_charger.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_charger.c
index e384844a1ae1..edf945a5260f 100644
--- a/drivers/power/bq2415x_charger.c
+++ b/drivers/power/bq2415x_charger.c
@@ -1579,8 +1579,15 @@ static int bq2415x_probe(struct i2c_client *client,
 	if (np) {
 		bq->notify_psy = power_supply_get_by_phandle(np, "ti,usb-charger-detection");
 
-		if (!bq->notify_psy)
-			return -EPROBE_DEFER;
+		if (IS_ERR(bq->notify_psy)) {
+			bq->notify_psy = NULL;
+			dev_info(&client->dev,
+				"no 'ti,usb-charger-detection' property (err=%ld)\n",
+				PTR_ERR(bq->notify_psy));
+		} else if (!bq->notify_psy) {
+			ret = -EPROBE_DEFER;
+			goto error_2;
+		}
 	}
 	else if (pdata->notify_device)
 		bq->notify_psy = power_supply_get_by_name(pdata->notify_device);
-- 
1.9.1

