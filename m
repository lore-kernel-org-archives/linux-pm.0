From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v7 08/10] power: supply: olpc_battery: Avoid using platform_info
Date: Thu, 18 Apr 2019 16:46:53 +0200
Message-ID: <20190418144655.18758-9-lkundrak@v3.sk>
References: <20190418144655.18758-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190418144655.18758-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Darren Hart <dvhart@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, x86@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-pm@vger.kernel.org

This wouldn't work on the DT-based ARM platform. Let's read the EC versio=
n
directly from the EC driver instead.

This removes x86 specific bits that would prevent this driver from being
used with the EC of ARM-based OLPC XO 1.75.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

---
Changes since v5:
- Turn new_proto into a bool

Changes since v2:
- Move the priv data allocation hunk from this patch to a proper place

Changes since v1:
- Use uint8_t instead of unsigned char [1] for ecver

 drivers/power/supply/olpc_battery.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
index d83c77c2a0ec..8be44c717d85 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -57,6 +57,7 @@ struct olpc_battery_data {
 	struct power_supply *olpc_ac;
 	struct power_supply *olpc_bat;
 	char bat_serial[17];
+	bool new_proto;
 };
=20
 /*********************************************************************
@@ -100,7 +101,7 @@ static const struct power_supply_desc olpc_ac_desc =3D=
 {
 static int olpc_bat_get_status(struct olpc_battery_data *data,
 		union power_supply_propval *val, uint8_t ec_byte)
 {
-	if (olpc_platform_info.ecver > 0x44) {
+	if (data->new_proto) {
 		if (ec_byte & (BAT_STAT_CHARGING | BAT_STAT_TRICKLE))
 			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
 		else if (ec_byte & BAT_STAT_DISCHARGING)
@@ -608,6 +609,7 @@ static int olpc_battery_probe(struct platform_device =
*pdev)
 	struct power_supply_config psy_cfg =3D {};
 	struct olpc_battery_data *data;
 	uint8_t status;
+	uint8_t ecver;
 	int ret;
=20
 	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
@@ -615,13 +617,21 @@ static int olpc_battery_probe(struct platform_devic=
e *pdev)
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
+		data->new_proto =3D true;
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
2.21.0
