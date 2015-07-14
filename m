From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] power: Destroy IDRs on module exit
Date: Tue, 14 Jul 2015 11:16:14 +0200
Message-ID: <1436865374-22027-1-git-send-email-jthumshirn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>
List-Id: linux-pm@vger.kernel.org

Destroy IDRs on module exit, freeing the resources for
* bq2415x_charger.c
* ds2782_battery.c
* ltc2941-battery-gauge.c

The drivers had to be converted to "ordinary" module_init()/module_exit=
()
style drivers instead of using module_i2c_driver.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/power/bq2415x_charger.c       | 20 +++++++++++++++++++-
 drivers/power/ds2782_battery.c        | 20 +++++++++++++++++++-
 drivers/power/ltc2941-battery-gauge.c | 20 +++++++++++++++++++-
 3 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_ch=
arger.c
index e98dcb6..38f4208 100644
--- a/drivers/power/bq2415x_charger.c
+++ b/drivers/power/bq2415x_charger.c
@@ -1773,7 +1773,25 @@ static struct i2c_driver bq2415x_driver =3D {
 	.remove =3D bq2415x_remove,
 	.id_table =3D bq2415x_i2c_id_table,
 };
-module_i2c_driver(bq2415x_driver);
+
+static int __init bq2415x_init(void)
+{
+	int ret;
+
+	ret =3D i2c_add_driver(&bq2415x_driver);
+	if (ret)
+		printk(KERN_ERR "Unable to register bq2415x-battery driver\n");
+
+	return ret;
+}
+module_init(bq2415x_init);
+
+static void __exit bq2415x_exit(void)
+{
+	i2c_del_driver(&bq2415x_driver);
+	idr_destroy(&bq2415x_id);
+}
+module_exit(bq2415x_exit);
=20
 MODULE_AUTHOR("Pali Roh=C3=A1r <pali.rohar@gmail.com>");
 MODULE_DESCRIPTION("bq2415x charger driver");
diff --git a/drivers/power/ds2782_battery.c b/drivers/power/ds2782_batt=
ery.c
index ed4d756..410bc9d 100644
--- a/drivers/power/ds2782_battery.c
+++ b/drivers/power/ds2782_battery.c
@@ -468,7 +468,25 @@ static struct i2c_driver ds278x_battery_driver =3D=
 {
 	.remove		=3D ds278x_battery_remove,
 	.id_table	=3D ds278x_id,
 };
-module_i2c_driver(ds278x_battery_driver);
+
+static int __init ds2782_init(void)
+{
+	int ret;
+
+	ret =3D i2c_add_driver(&ds278x_battery_driver);
+	if (ret)
+		printk(KERN_ERR "Unable to register ds2782-battery driver\n");
+
+	return ret;
+}
+module_init(ds2782_init);
+
+static void __exit ds2782_exit(void)
+{
+	i2c_del_driver(&ds278x_battery_driver);
+	idr_destroy(&battery_id);
+}
+module_exit(ds2782_exit);
=20
 MODULE_AUTHOR("Ryan Mallon");
 MODULE_DESCRIPTION("Maxim/Dallas DS2782 Stand-Alone Fuel Gauage IC dri=
ver");
diff --git a/drivers/power/ltc2941-battery-gauge.c b/drivers/power/ltc2=
941-battery-gauge.c
index daeb086..6fbbcd2 100644
--- a/drivers/power/ltc2941-battery-gauge.c
+++ b/drivers/power/ltc2941-battery-gauge.c
@@ -544,7 +544,25 @@ static struct i2c_driver ltc294x_driver =3D {
 	.remove		=3D ltc294x_i2c_remove,
 	.id_table	=3D ltc294x_i2c_id,
 };
-module_i2c_driver(ltc294x_driver);
+
+static int __init ltc294x_init(void)
+{
+	int ret;
+
+	ret =3D i2c_add_driver(&ltc294x_driver);
+	if (ret)
+		printk(KERN_ERR "Unable to register bq2415x-battery driver\n");
+
+	return ret;
+}
+module_init(ltc294x_init);
+
+static void __exit ltc294x_exit(void)
+{
+	i2c_del_driver(&ltc294x_driver);
+	idr_destroy(&ltc294x_id);
+}
+module_exit(ltc294x_exit);
=20
 MODULE_AUTHOR("Auryn Verwegen, Topic Embedded Systems");
 MODULE_AUTHOR("Mike Looijmans, Topic Embedded Products");
--=20
2.4.5
