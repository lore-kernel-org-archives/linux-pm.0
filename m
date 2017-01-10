From: Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH] power: supply: axp20x_usb_power: fix warning on 64bit
Date: Tue, 10 Jan 2017 18:48:12 +0100
Message-ID: <20170110174812.19026-1-msuchanek@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Michal Suchanek <msuchanek@suse.de>
List-Id: linux-pm@vger.kernel.org

Casting of_device_get_match_data return value to int causes warning on 64bit
architectures.

../drivers/power/supply/axp20x_usb_power.c: In function
'axp20x_usb_power_probe':
../drivers/power/supply/axp20x_usb_power.c:297:21: warning: cast from
pointer to integer of different size [-Wpointer-to-int-cast]

Fixes: 0dcc70ca8644 ("power: supply: axp20x_usb_power: use of_device_id
    data field instead of device_is_compatible")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 drivers/power/supply/axp20x_usb_power.c | 5 +++--
 include/linux/mfd/axp20x.h              | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 1bcb02551e02..632a33fe2d54 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -48,7 +48,7 @@ struct axp20x_usb_power {
 	struct device_node *np;
 	struct regmap *regmap;
 	struct power_supply *supply;
-	int axp20x_id;
+	enum axp20x_variants axp20x_id;
 };
 
 static irqreturn_t axp20x_usb_power_irq(int irq, void *devid)
@@ -294,7 +294,8 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	if (!power)
 		return -ENOMEM;
 
-	power->axp20x_id = (int)of_device_get_match_data(&pdev->dev);
+	power->axp20x_id = (enum axp20x_variants)of_device_get_match_data(
+								&pdev->dev);
 
 	power->np = pdev->dev.of_node;
 	power->regmap = axp20x->regmap;
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 0aa4ef7157b8..0d9a1ff38393 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -13,7 +13,7 @@
 
 #include <linux/regmap.h>
 
-enum {
+enum axp20x_variants {
 	AXP152_ID = 0,
 	AXP202_ID,
 	AXP209_ID,
-- 
2.10.2
