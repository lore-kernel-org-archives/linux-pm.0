From: Daniel Perez <danielperezdeandres@gmail.com>
Subject: [PATCH v2] Power: supply: sbs-charger: simplified bool function
Date: Wed, 15 Feb 2017 16:46:21 +0100
Message-ID: <1487173581-19388-1-git-send-email-danielperezdeandres@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35954 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdBOPr3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Feb 2017 10:47:29 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolassaenzj@gmail.com, Daniel Perez <danielperezdeandres@gmail.com>

v1 -> v2:
 - given Joe Perches' comment, I've further simplified the syntax
   of the bool function, removing the ternary conditional

Signed-off-by: Daniel Perez <danielperezdeandres@gmail.com>
---
 drivers/power/supply/sbs-charger.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/power/supply/sbs-charger.c b/drivers/power/supply/sbs-charger.c
index 353765a..15947db 100644
--- a/drivers/power/supply/sbs-charger.c
+++ b/drivers/power/supply/sbs-charger.c
@@ -137,10 +137,7 @@ static enum power_supply_property sbs_properties[] = {
 
 static bool sbs_readable_reg(struct device *dev, unsigned int reg)
 {
-	if (reg < SBS_CHARGER_REG_SPEC_INFO)
-		return false;
-	else
-		return true;
+	return reg >= SBS_CHARGER_REG_SPEC_INFO;
 }
 
 static bool sbs_volatile_reg(struct device *dev, unsigned int reg)
-- 
2.7.4
