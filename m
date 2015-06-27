From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] power: axp288_charger: Fix broken extcon API calls
Date: Fri, 26 Jun 2015 18:12:44 -0700
Message-ID: <1435367564-12900-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Chanwoo Choi <cw00.choi@samsung.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>
List-Id: linux-pm@vger.kernel.org

The extcon API calls have been changed to add an additional argument.
This causes build errors such as

drivers/power/axp288_charger.c:851:2: error:
	too few arguments to function 'extcon_register_notifier'

Fixes: 73b6ecdb93e8 ("extcon: Redefine the unique id of supported
	external connectors without 'enum extcon' type")
Fixes: 046050f6e623 ("extcon: Update the prototype of
	extcon_register_notifier() with enum extcon")
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/power/axp288_charger.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/power/axp288_charger.c b/drivers/power/axp288_charger.c
index 5680317f4823..0aa6e7fd25d4 100644
--- a/drivers/power/axp288_charger.c
+++ b/drivers/power/axp288_charger.c
@@ -848,7 +848,8 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	/* Register for extcon notification */
 	INIT_WORK(&info->cable.work, axp288_charger_extcon_evt_worker);
 	info->cable.nb.notifier_call = axp288_charger_handle_cable_evt;
-	ret = extcon_register_notifier(info->cable.edev, &info->cable.nb);
+	ret = extcon_register_notifier(info->cable.edev, EXTCON_NONE,
+				       &info->cable.nb);
 	if (ret) {
 		dev_err(&info->pdev->dev,
 			"failed to register extcon notifier %d\n", ret);
@@ -909,7 +910,8 @@ intr_reg_failed:
 		extcon_unregister_interest(&info->otg.cable);
 	power_supply_unregister(info->psy_usb);
 psy_reg_failed:
-	extcon_unregister_notifier(info->cable.edev, &info->cable.nb);
+	extcon_unregister_notifier(info->cable.edev, EXTCON_NONE,
+				   &info->cable.nb);
 	return ret;
 }
 
@@ -920,7 +922,8 @@ static int axp288_charger_remove(struct platform_device *pdev)
 	if (info->otg.cable.edev)
 		extcon_unregister_interest(&info->otg.cable);
 
-	extcon_unregister_notifier(info->cable.edev, &info->cable.nb);
+	extcon_unregister_notifier(info->cable.edev, EXTCON_NONE,
+				   &info->cable.nb);
 	power_supply_unregister(info->psy_usb);
 
 	return 0;
-- 
2.1.0
