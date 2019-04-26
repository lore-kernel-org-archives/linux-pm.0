From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] power: supply: bq27xxx_battery: Notify also about status changes
Date: Fri, 26 Apr 2019 11:26:48 +0200
Message-ID: <1556270808-21331-1-git-send-email-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
List-Id: linux-pm@vger.kernel.org

User-space might be interested in receiving uevents when the charging
starts/stops or if conditions of battery changes (e.g.
over-temperature).  Notify about changes in battery also when the flags
change, not only SoC.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 29b3a4056865..cb9306160c14 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1612,7 +1612,8 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 			di->charge_design_full = bq27xxx_battery_read_dcap(di);
 	}
 
-	if (di->cache.capacity != cache.capacity)
+	if ((di->cache.capacity != cache.capacity) || \
+	    (di->cache.flags != cache.flags))
 		power_supply_changed(di->bat);
 
 	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)
-- 
2.7.4
