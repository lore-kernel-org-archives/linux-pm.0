From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 03/14] power: max17047_battery: The temp alert values are 8-bit 2's complement
Date: Fri, 14 Apr 2017 20:32:48 +0200
Message-ID: <20170414183259.24382-3-hdegoede@redhat.com>
References: <20170414183259.24382-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752042AbdDNSdF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Apr 2017 14:33:05 -0400
In-Reply-To: <20170414183259.24382-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org

The temp alert values are 8-bit 2's complement, so sign-extend them
before reporting them back to the caller.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/max17042_battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 790dfa9..a51b296 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -270,14 +270,14 @@ static int max17042_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 		/* LSB is Alert Minimum. In deci-centigrade */
-		val->intval = (data & 0xff) * 10;
+		val->intval = sign_extend32(data & 0xff, 7) * 10;
 		break;
 	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
 		ret = regmap_read(map, MAX17042_TALRT_Th, &data);
 		if (ret < 0)
 			return ret;
 		/* MSB is Alert Maximum. In deci-centigrade */
-		val->intval = (data >> 8) * 10;
+		val->intval = sign_extend32(data >> 8, 7) * 10;
 		break;
 	case POWER_SUPPLY_PROP_TEMP_MIN:
 		val->intval = chip->pdata->temp_min;
-- 
2.9.3
