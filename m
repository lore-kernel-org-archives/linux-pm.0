From: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
Subject: [PATCH 2/2] power: supply: max17042_battery: add technology property support
Date: Sun, 25 Sep 2016 23:10:11 +0200
Message-ID: <1474837811-9413-3-git-send-email-wolfgit@wiedmeyer.de>
References: <1474837811-9413-1-git-send-email-wolfgit@wiedmeyer.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474837811-9413-1-git-send-email-wolfgit@wiedmeyer.de>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
List-Id: linux-pm@vger.kernel.org

This patch reports the battery technology as Li-ion.

Signed-off-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
---
 drivers/power/max17042_battery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
index 20cb1fd..43cb5df 100644
--- a/drivers/power/max17042_battery.c
+++ b/drivers/power/max17042_battery.c
@@ -92,6 +92,7 @@ static enum power_supply_property max17042_battery_props[] = {
 	POWER_SUPPLY_PROP_TEMP_MIN,
 	POWER_SUPPLY_PROP_TEMP_MAX,
 	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
 };
@@ -296,6 +297,9 @@ static int max17042_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 		break;
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
+		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		if (chip->pdata->enable_current_sense) {
 			ret = regmap_read(map, MAX17042_Current, &data);
-- 
Website: https://fossencdi.org
OpenPGP: 0F30 D1A0 2F73 F70A 6FEE  048E 5816 A24C 1075 7FC4
Key download: https://wiedmeyer.de/keys/ww.asc
