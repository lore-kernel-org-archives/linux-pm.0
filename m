From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC PATCHv2 17/19] power: bq2415x_charger: Decrement the power
 supply's device reference counter
Date: Mon, 05 Jan 2015 16:48:00 +0100
Message-ID: <1420472882-10463-18-git-send-email-k.kozlowski@samsung.com>
References: <1420472882-10463-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1420472882-10463-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Use power_supply_put() to decrement the power supply's device reference
counter (increased by power_supply_get_by_name() or
power_supply_get_by_phandle()).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/power/bq2415x_charger.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_charger.c
index 2f80de0410d9..00809dcdd34e 100644
--- a/drivers/power/bq2415x_charger.c
+++ b/drivers/power/bq2415x_charger.c
@@ -1686,6 +1686,8 @@ error_4:
 error_3:
 	bq2415x_power_supply_exit(bq);
 error_2:
+	if (!IS_ERR(bq->notify_psy))
+		power_supply_put(bq->notify_psy);
 	kfree(name);
 error_1:
 	mutex_lock(&bq2415x_id_mutex);
@@ -1701,8 +1703,10 @@ static int bq2415x_remove(struct i2c_client *client)
 {
 	struct bq2415x_device *bq = i2c_get_clientdata(client);
 
-	if (bq->notify_psy)
+	if (bq->notify_psy) {
 		power_supply_unreg_notifier(&bq->nb);
+		power_supply_put(bq->notify_psy);
+	}
 
 	bq2415x_sysfs_exit(bq);
 	bq2415x_power_supply_exit(bq);
-- 
1.9.1
