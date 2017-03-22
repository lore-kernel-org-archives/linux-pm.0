From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 5/7] power: supply: bq24190_charger: Don't spam the logs on charger plug / unplug
Date: Wed, 22 Mar 2017 15:55:34 +0100
Message-ID: <20170322145536.30570-6-hdegoede@redhat.com>
References: <20170322145536.30570-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760524AbdCVOzs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Mar 2017 10:55:48 -0400
In-Reply-To: <20170322145536.30570-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Tony Lindgren <tony@atomide.com>

If the charger gets unplugged before the battery is fully charged we will
get a one time Input fault. Ignore this rather then logging a message for
it. Likewise on the next interrupt after the one time Input fault all
fault flags will be 0, do not log a message when there are no faults.

This fixes messages like these getting logged on charger unplug + replug:
bq24190-charger 15-006b: Fault: boost 0, charge 1, battery 0, ntc 0
bq24190-charger 15-006b: Fault: boost 0, charge 0, battery 0, ntc 0

Cc: Liam Breck <kernel@networkimprov.net>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-This is a new patch in v2 of this patch-set
---
 drivers/power/supply/bq24190_charger.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index b535f24..351e020 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1189,12 +1189,17 @@ static void bq24190_check_status(struct bq24190_dev_info *bdi)
 	} while (f_reg && ++i < 2);
 
 	if (f_reg != bdi->f_reg) {
-		dev_info(bdi->dev,
-			"Fault: boost %d, charge %d, battery %d, ntc %d\n",
-			!!(f_reg & BQ24190_REG_F_BOOST_FAULT_MASK),
-			!!(f_reg & BQ24190_REG_F_CHRG_FAULT_MASK),
-			!!(f_reg & BQ24190_REG_F_BAT_FAULT_MASK),
-			!!(f_reg & BQ24190_REG_F_NTC_FAULT_MASK));
+		/*
+		 * Don't spam the logs if all faults are cleared, or when the
+		 * cable providing Vbus gets unplugged.
+		 */
+		if  (f_reg && f_reg != (1 << BQ24190_REG_F_CHRG_FAULT_SHIFT))
+			dev_info(bdi->dev,
+				"Fault: boost %d, charge %d, battery %d, ntc %d\n",
+				!!(f_reg & BQ24190_REG_F_BOOST_FAULT_MASK),
+				!!(f_reg & BQ24190_REG_F_CHRG_FAULT_MASK),
+				!!(f_reg & BQ24190_REG_F_BAT_FAULT_MASK),
+				!!(f_reg & BQ24190_REG_F_NTC_FAULT_MASK));
 
 		mutex_lock(&bdi->f_reg_lock);
 		if ((bdi->f_reg & battery_mask_f) != (f_reg & battery_mask_f))
-- 
2.9.3
