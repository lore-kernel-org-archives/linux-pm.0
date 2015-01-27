From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFT PATCH 1/4] power_supply: twl4030_madc: Check return value of
 power_supply_register
Date: Tue, 27 Jan 2015 12:30:18 +0100
Message-ID: <1422358221-13199-2-git-send-email-k.kozlowski@samsung.com>
References: <1422358221-13199-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36557 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837AbbA0Lal (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 06:30:41 -0500
In-reply-to: <1422358221-13199-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Artamonow <mad_soft@inbox.ru>, Marek Belisko <marek@goldelico.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Darren Hart <dvhart@infradead.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, stable@vger.kernel.org

The return value of power_supply_register() call was not checked and
even on error probe() function returned 0. If registering failed then
during unbind the driver tried to unregister power supply which was not
actually registered.

This could lead to memory corruption because power_supply_unregister()
unconditionally cleans up given power supply.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Fixes: da0a00ebc239 ("power: Add twl4030_madc battery driver.")
Cc: <stable@vger.kernel.org>
---
 drivers/power/twl4030_madc_battery.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/power/twl4030_madc_battery.c b/drivers/power/twl4030_madc_battery.c
index 7ef445a6cfa6..cf907609ec49 100644
--- a/drivers/power/twl4030_madc_battery.c
+++ b/drivers/power/twl4030_madc_battery.c
@@ -192,6 +192,7 @@ static int twl4030_madc_battery_probe(struct platform_device *pdev)
 {
 	struct twl4030_madc_battery *twl4030_madc_bat;
 	struct twl4030_madc_bat_platform_data *pdata = pdev->dev.platform_data;
+	int ret = 0;
 
 	twl4030_madc_bat = kzalloc(sizeof(*twl4030_madc_bat), GFP_KERNEL);
 	if (!twl4030_madc_bat)
@@ -216,9 +217,11 @@ static int twl4030_madc_battery_probe(struct platform_device *pdev)
 
 	twl4030_madc_bat->pdata = pdata;
 	platform_set_drvdata(pdev, twl4030_madc_bat);
-	power_supply_register(&pdev->dev, &twl4030_madc_bat->psy);
+	ret = power_supply_register(&pdev->dev, &twl4030_madc_bat->psy);
+	if (ret < 0)
+		kfree(twl4030_madc_bat);
 
-	return 0;
+	return ret;
 }
 
 static int twl4030_madc_battery_remove(struct platform_device *pdev)
-- 
1.9.1

