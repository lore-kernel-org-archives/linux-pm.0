From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v4 14/15] power: supply: olpc_battery: Avoid using platform_info
Date: Tue,  8 Jan 2019 18:58:17 +0100
Message-ID: <20190108175818.705110-15-lkundrak@v3.sk>
References: <20190108175818.705110-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108175818.705110-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Cc: James Cameron <quozl@laptop.org>, Mark Rutland <mark.rutland@arm.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-pm@vger.kernel.org

This wouldn't work on the DT-based ARM platform. Let's read the EC versio=
n
directly from the EC driver instead.

This makes the driver no longer x86 specific.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

---
Changes since v2:
- Move the priv data allocation hunk from this patch to a proper place

Changes since v1:
- Use uint8_t instead of unsigned char [1] for ecver

 drivers/power/supply/Kconfig        |  2 +-
 drivers/power/supply/olpc_battery.c | 27 ++++++++++++++++++---------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index e901b9879e7e..67a3bb26da39 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -151,7 +151,7 @@ config BATTERY_PMU
=20
 config BATTERY_OLPC
 	tristate "One Laptop Per Child battery"
-	depends on X86_32 && OLPC
+	depends on OLPC
 	help
 	  Say Y to enable support for the battery on the OLPC laptop.
=20
diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
index 0c9f7ce6b26b..8ebb4284cf05 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -20,8 +20,6 @@
 #include <linux/jiffies.h>
 #include <linux/sched.h>
 #include <linux/olpc-ec.h>
-#include <asm/olpc.h>
-
=20
 #define EC_BAT_VOLTAGE	0x10	/* uint16_t,	*9.76/32,    mV   */
 #define EC_BAT_CURRENT	0x11	/* int16_t,	*15.625/120, mA   */
@@ -57,6 +55,7 @@ struct olpc_battery_data {
 	struct power_supply *olpc_ac;
 	struct power_supply *olpc_bat;
 	char bat_serial[17];
+	int new_proto;
 };
=20
 /*********************************************************************
@@ -100,7 +99,7 @@ static const struct power_supply_desc olpc_ac_desc =3D=
 {
 static int olpc_bat_get_status(struct olpc_battery_data *data,
 		union power_supply_propval *val, uint8_t ec_byte)
 {
-	if (olpc_platform_info.ecver > 0x44) {
+	if (data->new_proto) {
 		if (ec_byte & (BAT_STAT_CHARGING | BAT_STAT_TRICKLE))
 			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
 		else if (ec_byte & BAT_STAT_DISCHARGING)
@@ -608,19 +607,29 @@ static int olpc_battery_probe(struct platform_devic=
e *pdev)
 	struct power_supply_config psy_cfg =3D {};
 	struct olpc_battery_data *data;
 	uint8_t status;
+	uint8_t ecver;
+	int ret;
=20
 	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, data);
=20
-	/*
-	 * We've seen a number of EC protocol changes; this driver requires
-	 * the latest EC protocol, supported by 0x44 and above.
-	 */
-	if (olpc_platform_info.ecver < 0x44) {
+	/* See if the EC is already there and get the EC revision */
+	ret =3D olpc_ec_cmd(EC_FIRMWARE_REV, NULL, 0, &ecver, 1);
+	if (ret)
+		return ret;
+
+	if (ecver > 0x44) {
+		/* XO 1 or 1.5 with a new EC firmware. */
+		data->new_proto =3D 1;
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
=20
--=20
2.20.1
