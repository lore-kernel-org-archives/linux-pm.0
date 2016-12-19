From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 10/14] power: supply: axp288_charger: Some minor cleanups
Date: Mon, 19 Dec 2016 01:07:27 +0100
Message-ID: <20161219000731.10188-11-hdegoede@redhat.com>
References: <20161219000731.10188-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161219000731.10188-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-pm@vger.kernel.org

Remove info->health, info->present and info->online caching, as no code
is reading the cached values.

Remove if (changed) check before calling power_supply_changed(), we
return early from axp288_charger_extcon_evt_worker if nothing has
changed, so the check is not needed.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index adeea2f..f033a5e 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -166,14 +166,11 @@ struct axp288_chrg_info {
 		struct work_struct work;
 	} cable;
 
-	int health;
 	int inlmt;
 	int cc;
 	int cv;
 	int max_cc;
 	int max_cv;
-	bool online;
-	bool present;
 	bool is_charger_enabled;
 };
 
@@ -431,8 +428,7 @@ static int axp288_charger_usb_get_property(struct power_supply *psy,
 		ret = axp288_charger_is_present(info);
 		if (ret < 0)
 			goto psy_get_prop_fail;
-		info->present = ret;
-		val->intval = info->present;
+		val->intval = ret;
 		break;
 	case POWER_SUPPLY_PROP_ONLINE:
 		/* Check for OTG case first */
@@ -443,8 +439,7 @@ static int axp288_charger_usb_get_property(struct power_supply *psy,
 		ret = axp288_charger_is_online(info);
 		if (ret < 0)
 			goto psy_get_prop_fail;
-		info->online = ret;
-		val->intval = info->online;
+		val->intval = ret;
 		break;
 	case POWER_SUPPLY_PROP_HEALTH:
 		val->intval = axp288_get_charger_health(info);
@@ -577,7 +572,6 @@ static void axp288_charger_extcon_evt_worker(struct work_struct *work)
 	struct axp288_chrg_info *info =
 	    container_of(work, struct axp288_chrg_info, cable.work);
 	int ret, current_limit;
-	bool changed = false;
 	struct extcon_dev *edev = info->cable.edev;
 	bool old_connected = info->cable.connected;
 	enum power_supply_type old_chg_type = info->cable.chg_type;
@@ -603,11 +597,8 @@ static void axp288_charger_extcon_evt_worker(struct work_struct *work)
 	}
 
 	/* Cable status changed */
-	if (old_connected != info->cable.connected ||
-	    old_chg_type != info->cable.chg_type)
-		changed = true;
-
-	if (!changed)
+	if (old_connected == info->cable.connected &&
+	    old_chg_type == info->cable.chg_type)
 		return;
 
 	mutex_lock(&info->lock);
@@ -642,13 +633,9 @@ static void axp288_charger_extcon_evt_worker(struct work_struct *work)
 		axp288_charger_enable_charger(info, false);
 	}
 
-	if (changed)
-		info->health = axp288_get_charger_health(info);
-
 	mutex_unlock(&info->lock);
 
-	if (changed)
-		power_supply_changed(info->psy_usb);
+	power_supply_changed(info->psy_usb);
 }
 
 static int axp288_charger_handle_cable_evt(struct notifier_block *nb,
-- 
2.9.3
