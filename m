From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 10/14] power: max17042_battery: mAh readings depend on r_sns value
Date: Fri, 14 Apr 2017 20:32:55 +0200
Message-ID: <20170414183259.24382-10-hdegoede@redhat.com>
References: <20170414183259.24382-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753329AbdDNSdP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Apr 2017 14:33:15 -0400
In-Reply-To: <20170414183259.24382-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org

The PROP_CHARGE_FULL code was hardcoded for the default sense
resistor of 0.010 Ohm, make it use r_sns which contains the
actual sense resistor value in micro-Ohms instead.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-This is a new patch in v2 of this patch-set
---
 drivers/power/supply/max17042_battery.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 0ce6c65..c380c5f 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -220,6 +220,7 @@ static int max17042_get_property(struct power_supply *psy,
 	struct regmap *map = chip->regmap;
 	int ret;
 	u32 data;
+	u64 data64;
 
 	if (!chip->init_complete)
 		return -EAGAIN;
@@ -309,7 +310,9 @@ static int max17042_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 
-		val->intval = data * 1000 / 2;
+		data64 = data * 5000000ll;
+		do_div(data64, chip->pdata->r_sns);
+		val->intval = data64;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
 		ret = regmap_read(map, MAX17042_QH, &data);
-- 
2.9.3
