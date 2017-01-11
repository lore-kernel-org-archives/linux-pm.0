From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] power: supply: axp20x_usb_power: fix 64-bit build warning
Date: Wed, 11 Jan 2017 15:51:55 +0100
Message-ID: <20170111145211.746189-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>, Quentin Schulz <quentin.schulz@free-electrons.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Casting a pointer to 'int' is not always valid:

drivers/power/supply/axp20x_usb_power.c: In function 'axp20x_usb_power_probe':
drivers/power/supply/axp20x_usb_power.c:297:21: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]

This makes the code use uintptr_t explicitly.

Fixes: 0dcc70ca8644 ("power: supply: axp20x_usb_power: use of_device_id data field instead of device_is_compatible")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/supply/axp20x_usb_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 1bcb02551e02..ecad8b6f9b84 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -294,7 +294,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	if (!power)
 		return -ENOMEM;
 
-	power->axp20x_id = (int)of_device_get_match_data(&pdev->dev);
+	power->axp20x_id = (uintptr_t)of_device_get_match_data(&pdev->dev);
 
 	power->np = pdev->dev.of_node;
 	power->regmap = axp20x->regmap;
-- 
2.9.0
