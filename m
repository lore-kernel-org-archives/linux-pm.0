From: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
Subject: [PATCH 1/2] power: supply: max17042_battery: use VF SOC register for capacity property
Date: Sun, 25 Sep 2016 23:10:10 +0200
Message-ID: <1474837811-9413-2-git-send-email-wolfgit@wiedmeyer.de>
References: <1474837811-9413-1-git-send-email-wolfgit@wiedmeyer.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474837811-9413-1-git-send-email-wolfgit@wiedmeyer.de>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
List-Id: linux-pm@vger.kernel.org

The capacity property uses the RepSOC register to report the current state
of charge. This register did not provide a reliable SOC value during my
testing with the max17047 variant on a Galaxy S3 (Trats2/GT-I9300). The
reported value did not change or even stayed zero in some cases.
However, the VF SOC register provided an accurate SOC value at all times.
It uses the voltage fuel gauge to determine the SOC.

Signed-off-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
---
 drivers/power/max17042_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
index da7a75f..20cb1fd 100644
--- a/drivers/power/max17042_battery.c
+++ b/drivers/power/max17042_battery.c
@@ -246,7 +246,7 @@ static int max17042_get_property(struct power_supply *psy,
 		val->intval = data * 625 / 8;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
-		ret = regmap_read(map, MAX17042_RepSOC, &data);
+		ret = regmap_read(map, MAX17042_VFSOC, &data);
 		if (ret < 0)
 			return ret;
 
-- 
Website: https://fossencdi.org
OpenPGP: 0F30 D1A0 2F73 F70A 6FEE  048E 5816 A24C 1075 7FC4
Key download: https://wiedmeyer.de/keys/ww.asc
