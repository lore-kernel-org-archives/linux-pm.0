From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 06/14] power: supply: axp288_charger: Register extcon notifers after power_supply
Date: Mon, 19 Dec 2016 01:07:23 +0100
Message-ID: <20161219000731.10188-7-hdegoede@redhat.com>
References: <20161219000731.10188-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161219000731.10188-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-pm@vger.kernel.org

The extcon notifier work calls power_supply_changed on the power_supply
we register, so the extcon notifiers should be registered after we
register the power_supply.

While touching this code anyways, refactor the code for the 3 cable types
into a loop to avoid code repetition.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 42 +++++++++++++----------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index e435b1e..5ed0a45 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -815,6 +815,8 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
 	struct power_supply_config charger_cfg = {};
+	unsigned int cable_ids[] = { EXTCON_CHG_USB_SDP, EXTCON_CHG_USB_CDP,
+				     EXTCON_CHG_USB_DCP };
 
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
@@ -831,33 +833,6 @@ static int axp288_charger_probe(struct platform_device *pdev)
 		return -EPROBE_DEFER;
 	}
 
-	/* Register for extcon notification */
-	INIT_WORK(&info->cable.work, axp288_charger_extcon_evt_worker);
-	info->cable.nb.notifier_call = axp288_charger_handle_cable_evt;
-	ret = devm_extcon_register_notifier(dev, info->cable.edev,
-					EXTCON_CHG_USB_SDP, &info->cable.nb);
-	if (ret) {
-		dev_err(&info->pdev->dev,
-			"failed to register extcon notifier for SDP %d\n", ret);
-		return ret;
-	}
-
-	ret = devm_extcon_register_notifier(dev, info->cable.edev,
-					EXTCON_CHG_USB_CDP, &info->cable.nb);
-	if (ret) {
-		dev_err(&info->pdev->dev,
-			"failed to register extcon notifier for CDP %d\n", ret);
-		return ret;
-	}
-
-	ret = devm_extcon_register_notifier(dev, info->cable.edev,
-					EXTCON_CHG_USB_DCP, &info->cable.nb);
-	if (ret) {
-		dev_err(&info->pdev->dev,
-			"failed to register extcon notifier for DCP %d\n", ret);
-		return ret;
-	}
-
 	platform_set_drvdata(pdev, info);
 	mutex_init(&info->lock);
 
@@ -870,6 +845,19 @@ static int axp288_charger_probe(struct platform_device *pdev)
 		return PTR_ERR(info->psy_usb);
 	}
 
+	/* Register for extcon notification */
+	INIT_WORK(&info->cable.work, axp288_charger_extcon_evt_worker);
+	info->cable.nb.notifier_call = axp288_charger_handle_cable_evt;
+	for (i = 0; i < ARRAY_SIZE(cable_ids); i++) {
+		ret = devm_extcon_register_notifier(dev, info->cable.edev,
+						cable_ids[i], &info->cable.nb);
+		if (ret) {
+			dev_err(dev, "failed to register extcon notifier for %u: %d\n",
+				cable_ids[i], ret);
+			return ret;
+		}
+	}
+
 	/* Register for OTG notification */
 	INIT_WORK(&info->otg.work, axp288_charger_otg_evt_worker);
 	info->otg.id_nb.notifier_call = axp288_charger_handle_otg_evt;
-- 
2.9.3
