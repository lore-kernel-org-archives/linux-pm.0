From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v3 1/4] power: bq24190_charger: Limit over/under voltage fault logging
Date: Sat,  1 Apr 2017 13:25:16 -0700
Message-ID: <20170401202519.16280-2-liam@networkimprov.net>
References: <20170401202519.16280-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36806 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbdDAUZg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Apr 2017 16:25:36 -0400
Received: by mail-pf0-f193.google.com with SMTP id r137so4771384pfr.3
        for <linux-pm@vger.kernel.org>; Sat, 01 Apr 2017 13:25:36 -0700 (PDT)
In-Reply-To: <20170401202519.16280-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Hans de Goede <hdegoede@redhat.com>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

If the charger is unplugged before the battery is full we may
see an over/under voltage fault. Ignore this rather then emitting
a message or uevent.

This prevents messages like these getting logged on charger unplug/replug:
bq24190-charger 15-006b: Fault: boost 0, charge 1, battery 0, ntc 0
bq24190-charger 15-006b: Fault: boost 0, charge 0, battery 0, ntc 0

Cc: Tony Lindgren <tony@atomide.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/bq24190_charger.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index a699ad3..64a48b9 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1222,8 +1222,13 @@ static void bq24190_check_status(struct bq24190_dev_info *bdi)
 		}
 	} while (f_reg && ++i < 2);
 
+	/* ignore over/under voltage fault after disconnect */
+	if (f_reg == (1 << BQ24190_REG_F_CHRG_FAULT_SHIFT) &&
+	    !(ss_reg & BQ24190_REG_SS_PG_STAT_MASK))
+		f_reg = 0;
+
 	if (f_reg != bdi->f_reg) {
-		dev_info(bdi->dev,
+		dev_warn(bdi->dev,
 			"Fault: boost %d, charge %d, battery %d, ntc %d\n",
 			!!(f_reg & BQ24190_REG_F_BOOST_FAULT_MASK),
 			!!(f_reg & BQ24190_REG_F_CHRG_FAULT_MASK),
-- 
2.9.3
