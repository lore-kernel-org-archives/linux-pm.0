From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2] power_supply: bq24257: use flags argument of devm_gpiod_get
Date: Fri, 12 Jun 2015 10:54:04 +0200
Message-ID: <1434099244-28202-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1434093882-31795-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53969 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbbFLIyL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jun 2015 04:54:11 -0400
In-Reply-To: <1434093882-31795-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, kernel@pengutronix.de, Alexandre Courbot <gnurou@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
which appeared in v3.17-rc1, the gpiod_get* functions take an additiona=
l
parameter that allows to specify direction and initial value for output=
=2E

Simplify driver accordingly. Furthermore this is one caller less that
stops us making the flags argument to gpiod_get*() mandatory.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Changes since (implicit) v1, sent with Message-Id: 1434093882-31795-1-g=
it-send-email-u.kleine-koenig@pengutronix.de:

 - make it compilable

 drivers/power/bq24257_charger.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_ch=
arger.c
index ce7f5bbfd5e3..5859bc7c1616 100644
--- a/drivers/power/bq24257_charger.c
+++ b/drivers/power/bq24257_charger.c
@@ -608,31 +608,26 @@ static int bq24257_power_supply_init(struct bq242=
57_device *bq)
=20
 static int bq24257_irq_probe(struct bq24257_device *bq)
 {
-	int ret;
 	struct gpio_desc *stat_irq;
=20
-	stat_irq =3D devm_gpiod_get_index(bq->dev, BQ24257_STAT_IRQ, 0);
+	stat_irq =3D devm_gpiod_get_index(bq->dev, BQ24257_STAT_IRQ, 0, GPIOD=
_IN);
 	if (IS_ERR(stat_irq)) {
 		dev_err(bq->dev, "could not probe stat_irq pin\n");
 		return PTR_ERR(stat_irq);
 	}
=20
-	ret =3D gpiod_direction_input(stat_irq);
-	if (ret < 0)
-		return ret;
-
 	return gpiod_to_irq(stat_irq);
 }
=20
 static int bq24257_pg_gpio_probe(struct bq24257_device *bq)
 {
-	bq->pg =3D devm_gpiod_get_index(bq->dev, BQ24257_PG_GPIO, 0);
+	bq->pg =3D devm_gpiod_get_index(bq->dev, BQ24257_PG_GPIO, 0, GPIOD_IN=
);
 	if (IS_ERR(bq->pg)) {
 		dev_err(bq->dev, "could not probe PG pin\n");
 		return PTR_ERR(bq->pg);
 	}
=20
-	return gpiod_direction_input(bq->pg);
+	return 0;
 }
=20
 static int bq24257_fw_probe(struct bq24257_device *bq)
--=20
2.1.4

