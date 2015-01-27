From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFT PATCH 3/4] power_supply: ipaq_micro_battery: Fix leaking workqueue
Date: Tue, 27 Jan 2015 12:30:20 +0100
Message-ID: <1422358221-13199-4-git-send-email-k.kozlowski@samsung.com>
References: <1422358221-13199-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1422358221-13199-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Artamonow <mad_soft@inbox.ru>, Marek Belisko <marek@goldelico.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Darren Hart <dvhart@infradead.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Driver allocates singlethread workqueue in probe but it is not destroyed
during removal.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Fixes: 00a588f9d27f ("power: add driver for battery reading on iPaq h3xxx")
Cc: <stable@vger.kernel.org>
---
 drivers/power/ipaq_micro_battery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/ipaq_micro_battery.c b/drivers/power/ipaq_micro_battery.c
index 9d694605cdb7..698cf1636bb8 100644
--- a/drivers/power/ipaq_micro_battery.c
+++ b/drivers/power/ipaq_micro_battery.c
@@ -251,6 +251,7 @@ static int micro_batt_remove(struct platform_device *pdev)
 	power_supply_unregister(&micro_ac_power);
 	power_supply_unregister(&micro_batt_power);
 	cancel_delayed_work_sync(&mb->update);
+	destroy_workqueue(mb->wq);
 
 	return 0;
 }
-- 
1.9.1
