From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] power_supply: 88pm860x: Fix leaked power supply on probe fail
Date: Tue, 27 Jan 2015 16:51:54 +0100
Message-ID: <1422373914-17235-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:49919 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932305AbbA0PwG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 10:52:06 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, stable@vger.kernel.org

Driver forgot to unregister power supply if request_threaded_irq()
failed in probe(). In such case the memory associated with power supply
leaked.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Fixes: a830d28b48bf ("power_supply: Enable battery-charger for 88pm860x")
Cc: <stable@vger.kernel.org>
---
 drivers/power/88pm860x_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/88pm860x_charger.c b/drivers/power/88pm860x_charger.c
index 650930e4fa79..734ec4afa14d 100644
--- a/drivers/power/88pm860x_charger.c
+++ b/drivers/power/88pm860x_charger.c
@@ -711,6 +711,7 @@ static int pm860x_charger_probe(struct platform_device *pdev)
 	return 0;
 
 out_irq:
+	power_supply_unregister(&info->usb);
 	while (--i >= 0)
 		free_irq(info->irq[i], info);
 out:
-- 
1.9.1

