From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v3 4/6] power: bq27xxx_battery: Fix typos and change naming for state of charge functions
Date: Wed, 5 Aug 2015 11:05:38 -0500
Message-ID: <1438790740-29856-5-git-send-email-afd@ti.com>
References: <1438790740-29856-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46308 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495AbbHEQHw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 5 Aug 2015 12:07:52 -0400
In-Reply-To: <1438790740-29856-1-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>

=46ix typos and change "relative state of charge" to "state of charge" =
as not
all supported devices use relative state of charge.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Acked-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/power/bq27xxx_battery.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_ba=
ttery.c
index 0734413..1ff88ad 100644
--- a/drivers/power/bq27xxx_battery.c
+++ b/drivers/power/bq27xxx_battery.c
@@ -229,26 +229,26 @@ static bool bq27xxx_is_chip_version_higher(struct=
 bq27xxx_device_info *di)
 }
=20
 /*
- * Return the battery Relative State-of-Charge
+ * Return the battery State-of-Charge
  * Or < 0 if something fails.
  */
-static int bq27xxx_battery_read_rsoc(struct bq27xxx_device_info *di)
+static int bq27xxx_battery_read_soc(struct bq27xxx_device_info *di)
 {
-	int rsoc;
+	int soc;
=20
 	if (di->chip =3D=3D BQ27500 || di->chip =3D=3D BQ27742)
-		rsoc =3D bq27xxx_read(di, BQ27500_REG_SOC, false);
+		soc =3D bq27xxx_read(di, BQ27500_REG_SOC, false);
 	else if (di->chip =3D=3D BQ27510)
-		rsoc =3D bq27xxx_read(di, BQ27510_REG_SOC, false);
+		soc =3D bq27xxx_read(di, BQ27510_REG_SOC, false);
 	else if (di->chip =3D=3D BQ27425)
-		rsoc =3D bq27xxx_read(di, BQ27425_REG_SOC, false);
-	else
-		rsoc =3D bq27xxx_read(di, BQ27000_REG_RSOC, true);
+		soc =3D bq27xxx_read(di, BQ27425_REG_SOC, false);
+	else /* for the bq27000 we read the "relative" SoC register */
+		soc =3D bq27xxx_read(di, BQ27000_REG_RSOC, true);
=20
-	if (rsoc < 0)
-		dev_dbg(di->dev, "error reading relative State-of-Charge\n");
+	if (soc < 0)
+		dev_dbg(di->dev, "error reading State-of-Charge\n");
=20
-	return rsoc;
+	return soc;
 }
=20
 /*
@@ -275,7 +275,7 @@ static int bq27xxx_battery_read_charge(struct bq27x=
xx_device_info *di, u8 reg)
 }
=20
 /*
- * Return the battery Nominal available capaciy in =C2=B5Ah
+ * Return the battery Nominal available capacity in =C2=B5Ah
  * Or < 0 if something fails.
  */
 static inline int bq27xxx_battery_read_nac(struct bq27xxx_device_info =
*di)
@@ -416,7 +416,7 @@ static int bq27xxx_battery_read_time(struct bq27xxx=
_device_info *di, u8 reg)
 }
=20
 /*
- * Read a power avg register.
+ * Read an average power register.
  * Return < 0 if something fails.
  */
 static int bq27xxx_battery_read_pwr_avg(struct bq27xxx_device_info *di=
, u8 reg)
@@ -498,7 +498,7 @@ static void bq27xxx_battery_update(struct bq27xxx_d=
evice_info *di)
 			cache.charge_full =3D -ENODATA;
 			cache.health =3D -ENODATA;
 		} else {
-			cache.capacity =3D bq27xxx_battery_read_rsoc(di);
+			cache.capacity =3D bq27xxx_battery_read_soc(di);
 			if (is_bq27742 || is_bq27510)
 				cache.time_to_empty =3D
 					bq27xxx_battery_read_time(di,
--=20
1.9.1

