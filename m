From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH v2] power: Remove unnecessary MODULE_ALIAS() for I2C drivers
Date: Mon, 31 Aug 2015 10:52:00 +0200
Message-ID: <1441011120-10203-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:33044 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbbHaIwL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 31 Aug 2015 04:52:11 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: pali.rohar@gmail.com, Javier Martinez Canillas <javier@osg.samsung.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org

These drivers already have an I2C device id table that is used to creat=
e
module aliases and the used MODULE_ALIAS() was either already in the I2=
C
table so it was redundant or wasn't a valid I2C id so it was never used=
=2E

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes in v2:
- Don't remove MODULE_ALIAS() for bq27x00_battery driver since there
  is a pending patch that already does this. Suggested by Pali Roh=C3=A1=
r

 drivers/power/bq24190_charger.c | 1 -
 drivers/power/pm2301_charger.c  | 1 -
 drivers/power/rt9455_charger.c  | 1 -
 drivers/power/smb347-charger.c  | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/power/bq24190_charger.c b/drivers/power/bq24190_ch=
arger.c
index 469a452cbe10..f5746b9f4e83 100644
--- a/drivers/power/bq24190_charger.c
+++ b/drivers/power/bq24190_charger.c
@@ -1543,5 +1543,4 @@ module_i2c_driver(bq24190_driver);
=20
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Mark A. Greer <mgreer@animalcreek.com>");
-MODULE_ALIAS("i2c:bq24190-charger");
 MODULE_DESCRIPTION("TI BQ24190 Charger Driver");
diff --git a/drivers/power/pm2301_charger.c b/drivers/power/pm2301_char=
ger.c
index 3a45cc0c4dce..8f9bd1d0eeb6 100644
--- a/drivers/power/pm2301_charger.c
+++ b/drivers/power/pm2301_charger.c
@@ -1264,5 +1264,4 @@ module_exit(pm2xxx_charger_exit);
=20
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Rajkumar kasirajan, Olivier Launay");
-MODULE_ALIAS("i2c:pm2xxx-charger");
 MODULE_DESCRIPTION("PM2xxx charger management driver");
diff --git a/drivers/power/rt9455_charger.c b/drivers/power/rt9455_char=
ger.c
index a49a9d44bdda..cfdbde9daf94 100644
--- a/drivers/power/rt9455_charger.c
+++ b/drivers/power/rt9455_charger.c
@@ -1760,5 +1760,4 @@ module_i2c_driver(rt9455_driver);
=20
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Anda-Maria Nicolae <anda-maria.nicolae@intel.com>");
-MODULE_ALIAS("i2c:rt9455-charger");
 MODULE_DESCRIPTION("Richtek RT9455 Charger Driver");
diff --git a/drivers/power/smb347-charger.c b/drivers/power/smb347-char=
ger.c
index 0b60a0b5878b..072c5189bd6d 100644
--- a/drivers/power/smb347-charger.c
+++ b/drivers/power/smb347-charger.c
@@ -1332,4 +1332,3 @@ MODULE_AUTHOR("Bruce E. Robertson <bruce.e.robert=
son@intel.com>");
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
 MODULE_DESCRIPTION("SMB347 battery charger driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("i2c:smb347");
--=20
2.4.3

