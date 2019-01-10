From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v5 6/7] power: supply: olpc_battery: Avoid using platform_info
Date: Thu, 10 Jan 2019 18:40:04 +0100
Message-ID: <20190110174005.1202564-7-lkundrak@v3.sk>
References: <20190110174005.1202564-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110174005.1202564-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, x86@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-pm@vger.kernel.org

This wouldn't work on the DT-based ARM platform. Let's read the EC version
directly from the EC driver instead.

This removes x86 specific bits that would prevent this driver from being
used with the EC of ARM-based OLPC XO 1.75.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

---
Changes since v2:
- Move the priv data allocation hunk from this patch to a proper place

Changes since v1:
- Use uint8_t instead of unsigned char [1] for ecver

 drivers/power/supply/olpc_battery.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
index 1fcc459433a8..a6c89d002d5d 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -22,7 +22,6 @@
 #include <linux/olpc-ec.h>
 #include <asm/olpc.h>
 
-
 #define EC_BAT_VOLTAGE	0x10	/* uint16_t,	*9.76/32,    mV   */
 #define EC_BAT_CURRENT	0x11	/* int16_t,	*15.625/120, mA   */
 #define EC_BAT_ACR	0x12	/* int16_t,	*6250/15,    µAh  */
@@ -57,6 +56,7 @@ struct olpc_battery_data {
 	struct power_supply *olpc_ac;
 	struct power_supply *olpc_bat;
 	char bat_serial[17];
+	int new_proto;
 };
 
 /*********************************************************************
@@ -100,7 +100,7 @@ static const struct power_supply_desc olpc_ac_desc = {
 static int olpc_bat_get_status(struct olpc_battery_data *data,
 		union power_supply_propval *val, uint8_t ec_byte)
 {
-	if (olpc_platform_info.ecver > 0x44) {
+	if (data->new_proto) {
 		if (ec_byte & (BAT_STAT_CHARGING | BAT_STAT_TRICKLE))
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
 		else if (ec_byte & BAT_STAT_DISCHARGING)
@@ -608,6 +608,7 @@ static int olpc_battery_probe(struct platform_device *pdev)
 	struct power_supply_config psy_cfg = {};
 	struct olpc_battery_data *data;
 	uint8_t status;
+	uint8_t ecver;
 	int ret;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
@@ -615,13 +616,21 @@ static int olpc_battery_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, data);
 
-	/*
-	 * We've seen a number of EC protocol changes; this driver requires
-	 * the latest EC protocol, supported by 0x44 and above.
-	 */
-	if (olpc_platform_info.ecver < 0x44) {
+	/* See if the EC is already there and get the EC revision */
+	ret = olpc_ec_cmd(EC_FIRMWARE_REV, NULL, 0, &ecver, 1);
+	if (ret)
+		return ret;
+
+	if (ecver > 0x44) {
+		/* XO 1 or 1.5 with a new EC firmware. */
+		data->new_proto = 1;
+	} else if (ecver < 0x44) {
+		/*
+		 * We've seen a number of EC protocol changes; this driver
+		 * requires the latest EC protocol, supported by 0x44 and above.
+		 */
 		printk(KERN_NOTICE "OLPC EC version 0x%02x too old for "
-			"battery driver.\n", olpc_platform_info.ecver);
+			"battery driver.\n", ecver);
 		return -ENXIO;
 	}
 
-- 
2.20.1
