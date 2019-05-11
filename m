From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] power: supply: olpc_battery: force the le/be casts
Date: Sat, 11 May 2019 10:56:14 +0200
Message-ID: <20190511085614.29677-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>, kbuild test robot <lkp@intel.com>
List-Id: linux-pm@vger.kernel.org

The endianness of data returned from the EC depends on the particular EC
version determined at run time. Cast from little/big endian explicitey
in the routine that flips endianness to the native one to make sparse
happy.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 76311b9a3295 ("power: supply: olpc_battery: Add OLPC XO 1.75 suppo=
rt")
---
 drivers/power/supply/olpc_battery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
index 4ccd242fcf72..066ec9a11153 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -326,9 +326,9 @@ static int olpc_bat_get_voltage_max_design(union powe=
r_supply_propval *val)
 static u16 ecword_to_cpu(struct olpc_battery_data *data, u16 ec_word)
 {
 	if (data->little_endian)
-		return le16_to_cpu(ec_word);
+		return le16_to_cpu((__force __le16)ec_word);
 	else
-		return be16_to_cpu(ec_word);
+		return be16_to_cpu((__force __be16)ec_word);
 }
=20
 /*********************************************************************
@@ -340,7 +340,7 @@ static int olpc_bat_get_property(struct power_supply =
*psy,
 {
 	struct olpc_battery_data *data =3D power_supply_get_drvdata(psy);
 	int ret =3D 0;
-	__be16 ec_word;
+	u16 ec_word;
 	uint8_t ec_byte;
 	__be64 ser_buf;
=20
--=20
2.21.0
