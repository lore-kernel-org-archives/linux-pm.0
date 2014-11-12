From: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
Subject: [PATCH] bq27x00_battery: fix register offset for bq27425
Date: Wed, 12 Nov 2014 23:04:08 +0100
Message-ID: <1415829848-29730-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-pm@vger.kernel.org

- SOC is at 0x1C so we must add 0x4 as stated in the comment to read th=
e
  right value.
- DCAP is at 0x3c so we also must use a value with the right offset to =
get
  the correct design capacity.

Actually testing on a bq27410 which has the same register map as bq2742=
5
(but adds new registers).

Signed-off-by: Eric B=C3=A9nard <eric@eukrea.com>
---
 drivers/power/bq27x00_battery.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27x00_ba=
ttery.c
index e3bacfe..ab18e96 100644
--- a/drivers/power/bq27x00_battery.c
+++ b/drivers/power/bq27x00_battery.c
@@ -76,7 +76,8 @@
=20
 /* bq27425 register addresses are same as bq27x00 addresses minus 4 */
 #define BQ27425_REG_OFFSET		0x04
-#define BQ27425_REG_SOC			0x18 /* Register address plus offset */
+#define BQ27425_REG_SOC		(0x1C + BQ27425_REG_OFFSET)
+#define BQ27425_REG_DCAP		(0x3C + BQ27425_REG_OFFSET)
=20
 #define BQ27000_RS			20 /* Resistor sense */
 #define BQ27x00_POWER_CONSTANT		(256 * 29200 / 1000)
@@ -282,9 +283,12 @@ static int bq27x00_battery_read_ilmd(struct bq27x0=
0_device_info *di)
 {
 	int ilmd;
=20
-	if (bq27xxx_is_chip_version_higher(di))
-		ilmd =3D bq27x00_read(di, BQ27500_REG_DCAP, false);
-	else
+	if (bq27xxx_is_chip_version_higher(di)) {
+		if (di->chip =3D=3D BQ27425)
+			ilmd =3D bq27x00_read(di, BQ27425_REG_DCAP, false);
+		else
+			ilmd =3D bq27x00_read(di, BQ27500_REG_DCAP, false);
+	} else
 		ilmd =3D bq27x00_read(di, BQ27000_REG_ILMD, true);
=20
 	if (ilmd < 0) {
--=20
2.1.1
