From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 09/14] power: supply: axp288_charger: Handle charger type changing without disconnect
Date: Mon, 19 Dec 2016 01:07:26 +0100
Message-ID: <20161219000731.10188-10-hdegoede@redhat.com>
References: <20161219000731.10188-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161219000731.10188-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-pm@vger.kernel.org

Deal with the charger type changing without a vbus-disconnect being
reported in between the 2 charger type states:

-Do not return from axp288_charger_extcon_evt_worker early in this case
 (track old_chg_type)
-Make calling axp288_charger_enable_charger with the same value as before
 a nop, to avoid the need for the caller to check this
-Do no do a dev_err when axp288_charger_enable_charger returns an error,
 axp288_charger_enable_charger already returns an error itself
-Disable the charger before changing the charge-current setting (nop if
 vbus was seen as disconnected before the change)

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 2b95db2..adeea2f 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -174,7 +174,6 @@ struct axp288_chrg_info {
 	int max_cv;
 	bool online;
 	bool present;
-	bool enable_charger;
 	bool is_charger_enabled;
 };
 
@@ -304,6 +303,9 @@ static int axp288_charger_enable_charger(struct axp288_chrg_info *info,
 {
 	int ret;
 
+	if (enable == info->is_charger_enabled)
+		return 0;
+
 	if (enable)
 		ret = regmap_update_bits(info->regmap, AXP20X_CHRG_CTRL1,
 				CHRG_CCCV_CHG_EN, CHRG_CCCV_CHG_EN);
@@ -578,6 +580,7 @@ static void axp288_charger_extcon_evt_worker(struct work_struct *work)
 	bool changed = false;
 	struct extcon_dev *edev = info->cable.edev;
 	bool old_connected = info->cable.connected;
+	enum power_supply_type old_chg_type = info->cable.chg_type;
 
 	/* Determine cable/charger type */
 	if (extcon_get_cable_state_(edev, EXTCON_CHG_USB_SDP) > 0) {
@@ -600,7 +603,8 @@ static void axp288_charger_extcon_evt_worker(struct work_struct *work)
 	}
 
 	/* Cable status changed */
-	if (old_connected != info->cable.connected)
+	if (old_connected != info->cable.connected ||
+	    old_chg_type != info->cable.chg_type)
 		changed = true;
 
 	if (!changed)
@@ -608,14 +612,9 @@ static void axp288_charger_extcon_evt_worker(struct work_struct *work)
 
 	mutex_lock(&info->lock);
 
-	if (info->is_charger_enabled && !info->cable.connected) {
-		info->enable_charger = false;
-		ret = axp288_charger_enable_charger(info, info->enable_charger);
-		if (ret < 0)
-			dev_err(&info->pdev->dev,
-				"cannot disable charger (%d)", ret);
+	if (info->cable.connected) {
+		axp288_charger_enable_charger(info, false);
 
-	} else if (!info->is_charger_enabled && info->cable.connected) {
 		switch (info->cable.chg_type) {
 		case POWER_SUPPLY_TYPE_USB:
 			current_limit = ILIM_500MA;
@@ -634,17 +633,13 @@ static void axp288_charger_extcon_evt_worker(struct work_struct *work)
 
 		/* Set vbus current limit first, then enable charger */
 		ret = axp288_charger_set_vbus_inlmt(info, current_limit);
-		if (ret < 0) {
+		if (ret == 0)
+			axp288_charger_enable_charger(info, true);
+		else
 			dev_err(&info->pdev->dev,
 				"error setting current limit (%d)", ret);
-		} else {
-			info->enable_charger = (current_limit > 0);
-			ret = axp288_charger_enable_charger(info,
-							info->enable_charger);
-			if (ret < 0)
-				dev_err(&info->pdev->dev,
-					"cannot enable charger (%d)", ret);
-		}
+	} else {
+		axp288_charger_enable_charger(info, false);
 	}
 
 	if (changed)
-- 
2.9.3
