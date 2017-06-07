From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v14 10/11] power: supply: bq27xxx: Flag identical register maps when in debug mode
Date: Wed,  7 Jun 2017 11:37:58 -0700
Message-ID: <20170607183759.20261-11-liam@networkimprov.net>
References: <20170607183759.20261-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33345 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752201AbdFGSil (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2017 14:38:41 -0400
Received: by mail-pg0-f65.google.com with SMTP id a70so2165065pge.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Jun 2017 11:38:40 -0700 (PDT)
In-Reply-To: <20170607183759.20261-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Pali Rohar <pali.rohar@gmail.com>, linux-pm@vger.kernel.org
Cc: Enric Balletbo <enric.balletbo@collabora.com>, Paul Kocialkowski <contact@paulk.fr>, Quentin Schulz <quentin.schulz@free-electrons.com>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

We tie multiple chips to unique register maps. When supporting a new chip,
it's easy to add a duplicate map by mistake.

In debug mode we now scan the register maps for duplicates.

Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq27xxx_battery.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index a7014525..f4449aba 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1931,6 +1931,25 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
 	schedule_delayed_work(&di->work, 0);
 }
 
+#ifdef DEBUG
+static void bq27xxx_battery_dbg_regs_dupes(struct bq27xxx_device_info *di)
+{
+	const size_t max = ARRAY_SIZE(bq27xxx_regs);
+	int a, b;
+
+	for (a = 1; a < max-1; a++) {
+		for (b = a+1; b < max; b++) {
+			if (!memcmp(bq27xxx_regs[a], bq27xxx_regs[b],
+				    sizeof(bq27xxx_regs[0])))
+				dev_warn(di->dev,
+					"bq27xxx_regs[%d] & [%d] are identical\n", a, b);
+		}
+	}
+}
+#else
+static inline void bq27xxx_battery_dbg_regs_dupes(struct bq27xxx_device_info *di) {}
+#endif
+
 int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 {
 	struct power_supply_desc *psy_desc;
@@ -1939,6 +1958,8 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 		.drv_data = di,
 	};
 
+	bq27xxx_battery_dbg_regs_dupes(di);
+
 	di->ram_chip = di->real_chip == BQ27421 ||
 		       di->real_chip == BQ27441 ||
 		       di->real_chip == BQ27621;
-- 
2.13.0
