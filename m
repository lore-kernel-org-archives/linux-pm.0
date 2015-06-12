From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] power_supply: bq25890: use flags argument of devm_gpiod_get
Date: Fri, 12 Jun 2015 09:19:34 +0200
Message-ID: <1434093574-22456-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52764 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780AbbFLHTj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jun 2015 03:19:39 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, kernel@pengutronix.de, Alexandre Courbot <gnurou@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>

Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
which appeared in v3.17-rc1, the gpiod_get* functions take an additiona=
l
parameter that allows to specify direction and initial value for output=
=2E

Simplify driver accordingly. Furthermore this is one caller less that
stops us making the flags argument to gpiod_get*() mandatory.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Hello,

this patch applies to next and is only necessary on top of 4aeae9cb0dad
(power_supply: Add support for TI BQ25890 charger chip).

Note I plan to make the flags parameter mandatory for 4.3. So unless
this change gets into 4.2, would it be ok to let it go in via the gpio
tree?

Best regards
Uwe

 drivers/power/bq25890_charger.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/power/bq25890_charger.c b/drivers/power/bq25890_ch=
arger.c
index 16b7c7bc987d..f993a55cde20 100644
--- a/drivers/power/bq25890_charger.c
+++ b/drivers/power/bq25890_charger.c
@@ -721,19 +721,14 @@ static int bq25890_usb_notifier(struct notifier_b=
lock *nb, unsigned long val,
=20
 static int bq25890_irq_probe(struct bq25890_device *bq)
 {
-	int ret;
 	struct gpio_desc *irq;
=20
-	irq =3D devm_gpiod_get_index(bq->dev, BQ25890_IRQ_PIN, 0);
+	irq =3D devm_gpiod_get_index(bq->dev, BQ25890_IRQ_PIN, 0, GPIOD_IN);
 	if (IS_ERR(irq)) {
 		dev_err(bq->dev, "Could not probe irq pin.\n");
 		return PTR_ERR(irq);
 	}
=20
-	ret =3D gpiod_direction_input(irq);
-	if (ret < 0)
-		return ret;
-
 	return gpiod_to_irq(irq);
 }
=20
--=20
2.1.4

