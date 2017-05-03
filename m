From: Colin King <colin.king@canonical.com>
Subject: [PATCH] power: supply: bq27xxx: make bq27xxx_battery_settings static
Date: Wed,  3 May 2017 11:45:54 +0100
Message-ID: <20170503104554.23019-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
To: Liam Breck <kernel@networkimprov.net>, "Andrew F . Davis" <afd@ti.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The function bq27xxx_battery_settings can be made static as it
does not need to be in global scope.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/supply/bq27xxx_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 7152370b9d61..06f15da32464 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1251,7 +1251,7 @@ static void bq27xxx_battery_set_config(struct bq27xxx_device_info *di,
 	/* assume bq27xxx_battery_update() is called hereafter */
 }
 
-void bq27xxx_battery_settings(struct bq27xxx_device_info *di)
+static void bq27xxx_battery_settings(struct bq27xxx_device_info *di)
 {
 	struct power_supply_battery_info info = {};
 	unsigned int min, max;
-- 
2.11.0

