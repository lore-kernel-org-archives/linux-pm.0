From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v3 4/4] power: bq24190_charger: Delay before polling reset flag
Date: Sat,  1 Apr 2017 13:25:19 -0700
Message-ID: <20170401202519.16280-5-liam@networkimprov.net>
References: <20170401202519.16280-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35003 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbdDAUZj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Apr 2017 16:25:39 -0400
Received: by mail-pg0-f66.google.com with SMTP id g2so22896680pge.2
        for <linux-pm@vger.kernel.org>; Sat, 01 Apr 2017 13:25:39 -0700 (PDT)
In-Reply-To: <20170401202519.16280-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Hans de Goede <hdegoede@redhat.com>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

On chip reset, polling loop was reading reset register immediately.
Instead, call udelay() before reading chip register.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq24190_charger.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 52389c5..898faed 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -543,18 +543,14 @@ static int bq24190_register_reset(struct bq24190_dev_info *bdi)
 
 	/* Reset bit will be cleared by hardware so poll until it is */
 	do {
+		udelay(10);
 		ret = bq24190_read_mask(bdi, BQ24190_REG_POC,
 				BQ24190_REG_POC_RESET_MASK,
 				BQ24190_REG_POC_RESET_SHIFT,
 				&v);
 		if (ret < 0)
 			return ret;
-
-		if (!v)
-			break;
-
-		udelay(10);
-	} while (--limit);
+	} while (v && --limit);
 
 	if (!limit)
 		return -EIO;
-- 
2.9.3
