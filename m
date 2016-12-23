From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v2 10/11] power: supply: bq275xx: cleanup over temperature flag check.
Date: Fri, 23 Dec 2016 11:05:06 +1100
Message-ID: <1482451507-37676-11-git-send-email-chris@lapa.com.au>
References: <1482369743-79764-1-git-send-email-chris@lapa.com.au>
 <1482451507-37676-1-git-send-email-chris@lapa.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33731 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942096AbcLWAFq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Dec 2016 19:05:46 -0500
Received: by mail-pg0-f67.google.com with SMTP id g1so19901598pgn.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Dec 2016 16:05:46 -0800 (PST)
In-Reply-To: <1482451507-37676-1-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: pali.rohar@gmail.com, afd@ti.com, sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chris Lapa <chris@lapa.com.au>

From: Chris Lapa <chris@lapa.com.au>

Separated the check out into its own function to make its functionality
easier to understand.

Signed-off-by: Chris Lapa <chris@lapa.com.au>
---
 drivers/power/supply/bq27xxx_battery.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index c92c809..e647bd1 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -956,14 +956,22 @@ static int bq27xxx_battery_read_pwr_avg(struct bq27xxx_device_info *di)
 }
 
 /*
- * Returns true if a battery over temperature condition is detected
+ * Returns true if the device has multiple over temperature flags
  */
-static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
+static inline bool bq27xxx_has_multiple_overtemp_flags(const struct bq27xxx_device_info *di)
 {
-	if (di->chip == BQ275XX || di->chip == BQ27500 || di->chip == BQ27510G1
+	return di->chip == BQ275XX || di->chip == BQ27500 || di->chip == BQ27510G1
 			|| di->chip == BQ27510G2 || di->chip == BQ27510G3 || di->chip == BQ27541
 			|| di->chip == BQ27520G1 || di->chip == BQ27520G2 || di->chip == BQ27520G3
-			|| di->chip == BQ27520G4 || di->chip == BQ27545)
+			|| di->chip == BQ27520G4 || di->chip == BQ27545;
+}
+
+/*
+ * Returns true if a battery over temperature condition is detected
+ */
+static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
+{
+	if (bq27xxx_has_multiple_overtemp_flags(di))
 		return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
 	if (di->chip == BQ27530 || di->chip == BQ27421)
 		return flags & BQ27XXX_FLAG_OT;
-- 
2.1.4

