From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFT RESEND 1/4] power_supply: twl4030_madc: Check return value of
 power_supply_register
Date: Fri, 20 Feb 2015 14:32:22 +0100
Message-ID: <1424439145-16895-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Milo Kim <milo.kim@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Artamonow <mad_soft@inbox.ru>, Marek Belisko <marek@goldelico.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

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
