From: Devendra Naga <develkernel412222@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20power=3A=20bq2414x=3A=20use=20module=5Fi2c=5Fdriver=20macro?=
Date: Sat,  8 Dec 2012 12:16:20 -0500
Message-ID: <1354986980-10489-1-git-send-email-develkernel412222@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44971 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964947Ab2LHRQ3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 8 Dec 2012 12:16:29 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so1137787pad.19
        for <linux-pm@vger.kernel.org>; Sat, 08 Dec 2012 09:16:29 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org
Cc: Devendra Naga <develkernel412222@gmail.com>

use the module_i2c_driver macro and reduce code and also remove the
duplicated module init and exit places.

Signed-off-by: Devendra Naga <develkernel412222@gmail.com>
---
 drivers/power/bq2415x_charger.c |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_ch=
arger.c
index ee842b3..b05df0a 100644
--- a/drivers/power/bq2415x_charger.c
+++ b/drivers/power/bq2415x_charger.c
@@ -1653,18 +1653,7 @@ static struct i2c_driver bq2415x_driver =3D {
 	.id_table =3D bq2415x_i2c_id_table,
 };
=20
-static int __init bq2415x_init(void)
-{
-	return i2c_add_driver(&bq2415x_driver);
-}
-module_init(bq2415x_init);
-
-static void __exit bq2415x_exit(void)
-{
-	i2c_del_driver(&bq2415x_driver);
-}
-module_exit(bq2415x_exit);
-
+module_i2c_driver(bq2415x_driver);
 MODULE_AUTHOR("Pali Roh=C3=A1r <pali.rohar@gmail.com>");
 MODULE_DESCRIPTION("bq2415x charger driver");
 MODULE_LICENSE("GPL");
--=20
1.7.10.4

