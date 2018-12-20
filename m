From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] power: twl4030: fix a missing check of return value
Date: Thu, 20 Dec 2018 13:51:24 -0600
Message-ID: <20181220195124.29467-1-kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

If twl4030_bci_read() fails, the read data in "s" is incorrect,
which is however used in the following execution. The fix checks
the return value of twl4030_bci_read() and returns an error code
upstream upon the failure of twl4030_bci_read().

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/power/supply/twl4030_charger.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 0e202d4273fb..4299873a1118 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -809,7 +809,9 @@ static int twl4030_bci_get_property(struct power_supply *psy,
 		is_charging = state & TWL4030_MSTATEC_AC;
 	if (!is_charging) {
 		u8 s;
-		twl4030_bci_read(TWL4030_BCIMDEN, &s);
+		ret = twl4030_bci_read(TWL4030_BCIMDEN, &s);
+		if (ret < 0)
+			return ret;
 		if (psy->desc->type == POWER_SUPPLY_TYPE_USB)
 			is_charging = s & 1;
 		else
-- 
2.17.1
