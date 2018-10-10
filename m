From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 15/15] power: supply: olpc_battery: Add OLPC XO 1.75 support
Date: Wed, 10 Oct 2018 19:23:00 +0200
Message-ID: <20181010172300.317643-16-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010172300.317643-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Cameron <quozl@laptop.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-pm@vger.kernel.org

The battery and the protocol are essentially the same as OLPC XO 1.5,
but the responses from the EC are LSB first.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/power/supply/olpc_battery.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
index dde9863e5c4a..2adf33b9f641 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -56,6 +56,7 @@ struct olpc_battery_data {
 	struct power_supply *olpc_bat;
 	char bat_serial[17];
 	int new_proto;
+	int little_endian;
 };
=20
 /*********************************************************************
@@ -321,6 +322,14 @@ static int olpc_bat_get_voltage_max_design(union pow=
er_supply_propval *val)
 	return ret;
 }
=20
+static s16 ecword_to_cpu(struct olpc_battery_data *data, u16 ec_byte)
+{
+	if (data->little_endian)
+		return le16_to_cpu(ec_byte);
+	else
+		return be16_to_cpu(ec_byte);
+}
+
 /*********************************************************************
  *		Battery properties
  *********************************************************************/
@@ -393,7 +402,7 @@ static int olpc_bat_get_property(struct power_supply =
*psy,
 		if (ret)
 			return ret;
=20
-		val->intval =3D (s16)be16_to_cpu(ec_word) * 9760L / 32;
+		val->intval =3D ecword_to_cpu(data, ec_word) * 9760L / 32;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_AVG:
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
@@ -401,7 +410,7 @@ static int olpc_bat_get_property(struct power_supply =
*psy,
 		if (ret)
 			return ret;
=20
-		val->intval =3D (s16)be16_to_cpu(ec_word) * 15625L / 120;
+		val->intval =3D ecword_to_cpu(data, ec_word) * 15625L / 120;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
 		ret =3D olpc_ec_cmd(EC_BAT_SOC, NULL, 0, &ec_byte, 1);
@@ -432,21 +441,21 @@ static int olpc_bat_get_property(struct power_suppl=
y *psy,
 		if (ret)
 			return ret;
=20
-		val->intval =3D (s16)be16_to_cpu(ec_word) * 10 / 256;
+		val->intval =3D ecword_to_cpu(data, ec_word) * 10 / 256;
 		break;
 	case POWER_SUPPLY_PROP_TEMP_AMBIENT:
 		ret =3D olpc_ec_cmd(EC_AMB_TEMP, NULL, 0, (void *)&ec_word, 2);
 		if (ret)
 			return ret;
=20
-		val->intval =3D (int)be16_to_cpu(ec_word) * 10 / 256;
+		val->intval =3D (int)ecword_to_cpu(data, ec_word) * 10 / 256;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
 		ret =3D olpc_ec_cmd(EC_BAT_ACR, NULL, 0, (void *)&ec_word, 2);
 		if (ret)
 			return ret;
=20
-		val->intval =3D (s16)be16_to_cpu(ec_word) * 6250 / 15;
+		val->intval =3D ecword_to_cpu(data, ec_word) * 6250 / 15;
 		break;
 	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
 		ret =3D olpc_ec_cmd(EC_BAT_SERIAL, NULL, 0, (void *)&ser_buf, 8);
@@ -626,6 +635,10 @@ static int olpc_battery_probe(struct platform_device=
 *pdev)
 	if (ecver[0] > 0x44) {
 		/* XO 1 or 1.5 with a new EC firmware. */
 		data->new_proto =3D 1;
+	} else if (of_find_compatible_node(NULL, NULL, "olpc,xo1.75-ec")) {
+		/* XO 1.75 */
+		data->new_proto =3D 1;
+		data->little_endian =3D 1;
 	} else if (ecver[0] < 0x44) {
 		/*
 		 * We've seen a number of EC protocol changes; this driver
--=20
2.19.0
