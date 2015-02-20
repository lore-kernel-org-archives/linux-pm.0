From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFT RESEND 2/4] power_supply: ipaq_micro_battery: Fix leaking
 workqueue
Date: Fri, 20 Feb 2015 14:32:23 +0100
Message-ID: <1424439145-16895-2-git-send-email-k.kozlowski@samsung.com>
References: <1424439145-16895-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57580 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754005AbbBTNcg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Feb 2015 08:32:36 -0500
In-reply-to: <1424439145-16895-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Milo Kim <milo.kim@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Artamonow <mad_soft@inbox.ru>, Marek Belisko <marek@goldelico.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, stable@vger.kernel.org

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

