From: Daniel Perez <danielperezdeandres@gmail.com>
Subject: [PATCH] Power: Supply: sbs-charger: simplfied bool function
Date: Tue, 14 Feb 2017 14:43:10 +0100
Message-ID: <1487079790-724-1-git-send-email-danielperezdeandres@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolassaenzj@gmail.com, Daniel Perez <danielperezdeandres@gmail.com>
List-Id: linux-pm@vger.kernel.org

Simplified the syntax of a simple bool return value function.

Signed-off-by: Daniel Perez <danielperezdeandres@gmail.com>
---
 drivers/power/supply/sbs-charger.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/power/supply/sbs-charger.c b/drivers/power/supply/sbs-charger.c
index 353765a..3e40553 100644
--- a/drivers/power/supply/sbs-charger.c
+++ b/drivers/power/supply/sbs-charger.c
@@ -137,10 +137,7 @@ static enum power_supply_property sbs_properties[] = {
 
 static bool sbs_readable_reg(struct device *dev, unsigned int reg)
 {
-	if (reg < SBS_CHARGER_REG_SPEC_INFO)
-		return false;
-	else
-		return true;
+	return reg < SBS_CHARGER_REG_SPEC_INFO ? false : true;
 }
 
 static bool sbs_volatile_reg(struct device *dev, unsigned int reg)
-- 
2.7.4
