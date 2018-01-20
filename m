From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] power: supply: da9030_battery: fix boolean value assignment
 in da9030_set_charge
Date: Fri, 19 Jan 2018 21:52:09 -0600
Message-ID: <20180120035209.GA15623@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-pm@vger.kernel.org

Assign true or false to boolean variables instead of an integer value.

This issue was detected with the help of Coccinelle.

Fixes: 342d765e011f ("power_supply: Add Dialog DA9030 battery charger driver")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/power/supply/da9030_battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/da9030_battery.c b/drivers/power/supply/da9030_battery.c
index 5ca0f4d..2cc05bc 100644
--- a/drivers/power/supply/da9030_battery.c
+++ b/drivers/power/supply/da9030_battery.c
@@ -238,10 +238,10 @@ static void da9030_set_charge(struct da9030_charger *charger, int on)
 		val = DA9030_CHRG_CHARGER_ENABLE;
 		val |= (charger->charge_milliamp / 100) << 3;
 		val |= (charger->charge_millivolt - 4000) / 50;
-		charger->is_on = 1;
+		charger->is_on = true;
 	} else {
 		val = 0;
-		charger->is_on = 0;
+		charger->is_on = false;
 	}
 
 	da903x_write(charger->master, DA9030_CHARGE_CONTROL, val);
-- 
2.7.4
