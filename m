From: Daniel Perez de Andres <danielperezdeandres@gmail.com>
Subject: [PATCH v3] Power: supply: sbs-charger: simplified bool function
Date: Fri, 17 Mar 2017 11:42:41 +0100
Message-ID: <1489747361-8957-1-git-send-email-danielperezdeandres@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolassaenzj@gmail.com, Daniel Perez <danielperezdeandres@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Daniel Perez <danielperezdeandres@gmail.com>

This patch rewrites the implementation of the regmap's readable function
sbs_readable_reg 

Signed-off-by: Daniel Perez <danielperezdeandres@gmail.com>
---
v2 -> v3:
 - v3 is needed because version history was misplaced in the patch message.
v1 -> v2:
 - given Joe Perches' comment, I've further simplified the syntax
   of the bool function, removing the ternary conditional


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
