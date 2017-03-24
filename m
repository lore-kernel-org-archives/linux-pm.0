From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH] power: bq24190_charger: Limit over/under voltage fault logging
Date: Fri, 24 Mar 2017 03:29:55 -0700
Message-ID: <20170324102955.13808-1-liam@networkimprov.net>
References: <20170322145536.30570-6-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36108 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbdCXKae (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Mar 2017 06:30:34 -0400
Received: by mail-pg0-f65.google.com with SMTP id 81so2392154pgh.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Mar 2017 03:30:33 -0700 (PDT)
In-Reply-To: <20170322145536.30570-6-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

If the charger gets unplugged before the battery is fully charged we will
get an over/under voltage fault. Ignore this rather then logging a message for
it. Likewise on the next interrupt after the fault all fault flags will be 0,
do not log a message when there are no faults.

This fixes messages like these getting logged on charger unplug + replug:
bq24190-charger 15-006b: Fault: boost 0, charge 1, battery 0, ntc 0
bq24190-charger 15-006b: Fault: boost 0, charge 0, battery 0, ntc 0

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Sebastian, here is a replacement for the original version.
I include Hans' sign-off since he wrote the original.

 drivers/power/supply/bq24190_charger.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 897491d..2e734ab 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1257,12 +1257,15 @@ static void bq24190_check_status(struct bq24190_dev_info *bdi)
 	} while (f_reg && ++i < 2);
 
 	if (f_reg != bdi->f_reg) {
-		dev_info(bdi->dev,
-			"Fault: boost %d, charge %d, battery %d, ntc %d\n",
-			!!(f_reg & BQ24190_REG_F_BOOST_FAULT_MASK),
-			!!(f_reg & BQ24190_REG_F_CHRG_FAULT_MASK),
-			!!(f_reg & BQ24190_REG_F_BAT_FAULT_MASK),
-			!!(f_reg & BQ24190_REG_F_NTC_FAULT_MASK));
+		if (f_reg && ((ss_reg & BQ24190_REG_SS_PG_STAT_MASK) ||
+		    f_reg != (1 << BQ24190_REG_F_CHRG_FAULT_SHIFT)))
+			/* omit over/under voltage fault after disconnect */
+			dev_warn(bdi->dev,
+				"Fault: boost %d, charge %d, battery %d, ntc %d\n",
+				!!(f_reg & BQ24190_REG_F_BOOST_FAULT_MASK),
+				!!(f_reg & BQ24190_REG_F_CHRG_FAULT_MASK),
+				!!(f_reg & BQ24190_REG_F_BAT_FAULT_MASK),
+				!!(f_reg & BQ24190_REG_F_NTC_FAULT_MASK));
 
 		mutex_lock(&bdi->f_reg_lock);
 		if ((bdi->f_reg & battery_mask_f) != (f_reg & battery_mask_f))
-- 
2.9.3
