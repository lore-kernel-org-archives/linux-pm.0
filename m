From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v5 7/7] power: supply: olpc_battery: Add OLPC XO 1.75 support
Date: Thu, 10 Jan 2019 18:40:05 +0100
Message-ID: <20190110174005.1202564-8-lkundrak@v3.sk>
References: <20190110174005.1202564-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110174005.1202564-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, x86@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

The battery and the protocol are essentially the same as OLPC XO 1.5,
but the responses from the EC are LSB first.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v2:
- Fix the version conditional

Changes since v1:
- s/s16 ecword_to_cpu/u16 ecword_to_cpu/
- s/u16 ec_byte/u16 ec_word/

 drivers/power/supply/olpc_battery.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
index a6c89d002d5d..52de90049980 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -57,6 +57,7 @@ struct olpc_battery_data {
 	struct power_supply *olpc_bat;
 	char bat_serial[17];
 	int new_proto;
+	int little_endian;
 };
=20
 /*********************************************************************
@@ -322,6 +323,14 @@ static int olpc_bat_get_voltage_max_design(union pow=
er_supply_propval *val)
 	return ret;
 }
=20
+static u16 ecword_to_cpu(struct olpc_battery_data *data, u16 ec_word)
+{
+	if (data->little_endian)
+		return le16_to_cpu(ec_word);
+	else
+		return be16_to_cpu(ec_word);
+}
+
 /*********************************************************************
  *		Battery properties
  *********************************************************************/
@@ -394,7 +403,7 @@ static int olpc_bat_get_property(struct power_supply =
*psy,
 		if (ret)
 			return ret;
=20
-		val->intval =3D (s16)be16_to_cpu(ec_word) * 9760L / 32;
+		val->intval =3D ecword_to_cpu(data, ec_word) * 9760L / 32;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_AVG:
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
@@ -402,7 +411,7 @@ static int olpc_bat_get_property(struct power_supply =
*psy,
 		if (ret)
 			return ret;
=20
-		val->intval =3D (s16)be16_to_cpu(ec_word) * 15625L / 120;
+		val->intval =3D ecword_to_cpu(data, ec_word) * 15625L / 120;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
 		ret =3D olpc_ec_cmd(EC_BAT_SOC, NULL, 0, &ec_byte, 1);
@@ -433,21 +442,21 @@ static int olpc_bat_get_property(struct power_suppl=
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
@@ -621,7 +630,11 @@ static int olpc_battery_probe(struct platform_device=
 *pdev)
 	if (ret)
 		return ret;
=20
-	if (ecver > 0x44) {
+	if (of_find_compatible_node(NULL, NULL, "olpc,xo1.75-ec")) {
+		/* XO 1.75 */
+		data->new_proto =3D 1;
+		data->little_endian =3D 1;
+	} else if (ecver > 0x44) {
 		/* XO 1 or 1.5 with a new EC firmware. */
 		data->new_proto =3D 1;
 	} else if (ecver < 0x44) {
--=20
2.20.1
