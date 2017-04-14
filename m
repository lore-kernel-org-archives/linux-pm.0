From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 05/14] power: max17042_battery: Change name in power_supply_desc to "main-battery"
Date: Fri, 14 Apr 2017 20:32:50 +0200
Message-ID: <20170414183259.24382-5-hdegoede@redhat.com>
References: <20170414183259.24382-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752912AbdDNSdI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Apr 2017 14:33:08 -0400
In-Reply-To: <20170414183259.24382-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org

The max17042 will typically be coupled with some charger IC, almost all
charger drivers contain:

static char *xxx_charger_supplied_to[] = {
        "main-battery",
};

probe()
{
	struct power_supply_config cfg;

	cfg.supplied_to = xxx_charger_supplied_to;
	cfg.num_supplicants = ARRAY_SIZE(xxx_charger_supplied_to);
	xxx->charger = power_supply_register(dev, &x_charger_desc, &_cfg);
}

Change the name in max17042's power_supply_desc to "main-battery" to
match, so that power_supply_am_i_supplied() can be used to implement
POWER_SUPPLY_PROP_STATUS.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/max17042_battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index f0ff6e8..3249eb0 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -866,7 +866,7 @@ static const struct regmap_config max17042_regmap_config = {
 };
 
 static const struct power_supply_desc max17042_psy_desc = {
-	.name		= "max170xx_battery",
+	.name		= "main-battery",
 	.type		= POWER_SUPPLY_TYPE_BATTERY,
 	.get_property	= max17042_get_property,
 	.set_property	= max17042_set_property,
@@ -876,7 +876,7 @@ static const struct power_supply_desc max17042_psy_desc = {
 };
 
 static const struct power_supply_desc max17042_no_current_sense_psy_desc = {
-	.name		= "max170xx_battery",
+	.name		= "main-battery",
 	.type		= POWER_SUPPLY_TYPE_BATTERY,
 	.get_property	= max17042_get_property,
 	.set_property	= max17042_set_property,
-- 
2.9.3
