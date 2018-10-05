From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] power: supply: olpc_battery: correct the temperature units
Date: Fri,  5 Oct 2018 03:52:30 +0200
Message-ID: <20181005015230.373962-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

According to [1] and [2], the temperature values are in tenths of degree
Celsius. Exposing the Celsius value makes the battery appear on fire:

  $ upower -i /org/freedesktop/UPower/devices/battery_olpc_battery
  ...
      temperature:         236.9 degrees C

Tested on OLPC XO-1 and OLPC XO-1.75 laptops.

[1] include/linux/power_supply.h
[2] Documentation/power/power_supply_class.txt

Cc: stable@vger.kernel.org
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/power/supply/olpc_battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
index 6da79ae14860..5a97e42a3547 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -428,14 +428,14 @@ static int olpc_bat_get_property(struct power_suppl=
y *psy,
 		if (ret)
 			return ret;
=20
-		val->intval =3D (s16)be16_to_cpu(ec_word) * 100 / 256;
+		val->intval =3D (s16)be16_to_cpu(ec_word) * 10 / 256;
 		break;
 	case POWER_SUPPLY_PROP_TEMP_AMBIENT:
 		ret =3D olpc_ec_cmd(EC_AMB_TEMP, NULL, 0, (void *)&ec_word, 2);
 		if (ret)
 			return ret;
=20
-		val->intval =3D (int)be16_to_cpu(ec_word) * 100 / 256;
+		val->intval =3D (int)be16_to_cpu(ec_word) * 10 / 256;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
 		ret =3D olpc_ec_cmd(EC_BAT_ACR, NULL, 0, (void *)&ec_word, 2);
--=20
2.19.0
