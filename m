From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 14/14] power: supply: ds2781: switch to devm_power_supply_register
Date: Mon,  1 Oct 2018 00:03:49 +0200
Message-ID: <20180930220349.10515-15-sebastian.reichel@collabora.com>
References: <20180930220349.10515-1-sebastian.reichel@collabora.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180930220349.10515-1-sebastian.reichel@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Milo Kim <milo.kim@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Liam Breck <kernel@networkimprov.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-pm@vger.kernel.org

Simplify/Cleanup the driver by switching to devm_power_supply_register
and dropping the driver's remove function.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/ds2781_battery.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/ds2781_battery.c b/drivers/power/supply/ds2781_battery.c
index ea8c66abf602..b1a4669e1f9b 100644
--- a/drivers/power/supply/ds2781_battery.c
+++ b/drivers/power/supply/ds2781_battery.c
@@ -772,8 +772,9 @@ static int ds2781_battery_probe(struct platform_device *pdev)
 	psy_cfg.drv_data		= dev_info;
 	psy_cfg.attr_grp		= ds2781_sysfs_groups;
 
-	dev_info->bat = power_supply_register(&pdev->dev, &dev_info->bat_desc,
-						&psy_cfg);
+	dev_info->bat = devm_power_supply_register(&pdev->dev,
+						   &dev_info->bat_desc,
+						   &psy_cfg);
 	if (IS_ERR(dev_info->bat)) {
 		dev_err(dev_info->dev, "failed to register battery\n");
 		return PTR_ERR(dev_info->bat);
@@ -782,21 +783,11 @@ static int ds2781_battery_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ds2781_battery_remove(struct platform_device *pdev)
-{
-	struct ds2781_device_info *dev_info = platform_get_drvdata(pdev);
-
-	power_supply_unregister(dev_info->bat);
-
-	return 0;
-}
-
 static struct platform_driver ds2781_battery_driver = {
 	.driver = {
 		.name = "ds2781-battery",
 	},
 	.probe	  = ds2781_battery_probe,
-	.remove   = ds2781_battery_remove,
 };
 module_platform_driver(ds2781_battery_driver);
 
-- 
2.19.0
