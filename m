From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH RESEND v2 6/7] power: bq2415x_charger: Decrement the power
 supply's device reference counter
Date: Tue, 04 Nov 2014 16:10:35 +0100
Message-ID: <1415113836-26098-7-git-send-email-k.kozlowski@samsung.com>
References: <1415113836-26098-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1415113836-26098-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lv Zheng <lv.zheng@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Anton Vorontsov <anton@enomsg.org>, Pavel Machek <pavel@ucw.cz>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
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
