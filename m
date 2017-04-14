From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 14/14] power: max77693_charger: Add supplied_to info to power_supply_config
Date: Fri, 14 Apr 2017 20:32:59 +0200
Message-ID: <20170414183259.24382-14-hdegoede@redhat.com>
References: <20170414183259.24382-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753329AbdDNSdU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Apr 2017 14:33:20 -0400
In-Reply-To: <20170414183259.24382-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org

On the exynos4412-trats2 the max77693 is used together with a
max17047 fuel-gauge. Add supplied_to info containing "main-battery",
so that the get_status code in the max17042_battery driver can use
power_supply_am_i_supplied and can properly let userspace know
if the battery is being charged or not.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/max77693_charger.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index 6c78884..1eeed26 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -254,6 +254,10 @@ static int max77693_charger_get_property(struct power_supply *psy,
 	return ret;
 }
 
+static char *max77693_charger_supplied_to[] = {
+	"main-battery",
+};
+
 static const struct power_supply_desc max77693_charger_desc = {
 	.name		= MAX77693_CHARGER_NAME,
 	.type		= POWER_SUPPLY_TYPE_BATTERY,
@@ -697,6 +701,8 @@ static int max77693_charger_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	psy_cfg.supplied_to = max77693_charger_supplied_to;
+	psy_cfg.num_supplicants = ARRAY_SIZE(max77693_charger_supplied_to),
 	psy_cfg.drv_data = chg;
 
 	ret = device_create_file(&pdev->dev, &dev_attr_fast_charge_timer);
-- 
2.9.3
