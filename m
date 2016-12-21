From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 05/12] power: supply: axp288_charger: Move init_hw_regs call before supply registration
Date: Wed, 21 Dec 2016 15:36:50 +0100
Message-ID: <20161221143657.322-6-hdegoede@redhat.com>
References: <20161221143657.322-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161221143657.322-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-pm@vger.kernel.org

Move the charger_init_hw_regs() above the power_supply_register call,
the axp288_charger_usb_set_property() uses axp288_chrg_info.max_cv and
.max_cc which get set by charger_init_hw_regs().

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 250dd70..1588efd 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -836,6 +836,10 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, info);
 	mutex_init(&info->lock);
 
+	ret = charger_init_hw_regs(info);
+	if (ret)
+		return ret;
+
 	/* Register with power supply class */
 	charger_cfg.drv_data = info;
 	info->psy_usb = devm_power_supply_register(dev, &axp288_charger_desc,
@@ -890,10 +894,6 @@ static int axp288_charger_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = charger_init_hw_regs(info);
-	if (ret)
-		return ret;
-
 	return 0;
 }
 
-- 
2.9.3
