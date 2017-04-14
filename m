From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 02/13] power: max17042_battery: Use sign_extend32 instead of DIY code
Date: Fri, 14 Apr 2017 14:59:08 +0200
Message-ID: <20170414125919.25771-2-hdegoede@redhat.com>
References: <20170414125919.25771-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751473AbdDNM7Y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Apr 2017 08:59:24 -0400
In-Reply-To: <20170414125919.25771-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org

Use sign_extend32 to sign-extend variables where necessary instead of
DIY code.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/max17042_battery.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index da7a75f..790dfa9 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -106,13 +106,7 @@ static int max17042_get_temperature(struct max17042_chip *chip, int *temp)
 	if (ret < 0)
 		return ret;
 
-	*temp = data;
-	/* The value is signed. */
-	if (*temp & 0x8000) {
-		*temp = (0x7fff & ~*temp) + 1;
-		*temp *= -1;
-	}
-
+	*temp = sign_extend32(data, 15);
 	/* The value is converted into deci-centigrade scale */
 	/* Units of LSB = 1 / 256 degree Celsius */
 	*temp = *temp * 10 / 256;
@@ -302,13 +296,7 @@ static int max17042_get_property(struct power_supply *psy,
 			if (ret < 0)
 				return ret;
 
-			val->intval = data;
-			if (val->intval & 0x8000) {
-				/* Negative */
-				val->intval = ~val->intval & 0x7fff;
-				val->intval++;
-				val->intval *= -1;
-			}
+			val->intval = sign_extend32(data, 15);
 			val->intval *= 1562500 / chip->pdata->r_sns;
 		} else {
 			return -EINVAL;
@@ -320,13 +308,7 @@ static int max17042_get_property(struct power_supply *psy,
 			if (ret < 0)
 				return ret;
 
-			val->intval = data;
-			if (val->intval & 0x8000) {
-				/* Negative */
-				val->intval = ~val->intval & 0x7fff;
-				val->intval++;
-				val->intval *= -1;
-			}
+			val->intval = sign_extend32(data, 15);
 			val->intval *= 1562500 / chip->pdata->r_sns;
 		} else {
 			return -EINVAL;
-- 
2.9.3
