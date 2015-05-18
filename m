From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/2] power: reset: gpio-poweroff: let devm_gpiod_get set direction of gpio
Date: Mon, 18 May 2015 22:45:06 +0200
Message-ID: <1431981907-32578-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60859 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932592AbbERUpY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 16:45:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: kernel@pengutronix.de, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, linux-pm@vger.kernel.org

Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
which appeared in v3.17-rc1, the gpiod_get* functions take an additiona=
l
parameter that allows to specify direction and initial value for output=
=2E

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/power/reset/gpio-poweroff.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/=
gpio-poweroff.c
index e5332f1db8a7..be3d81ff51cc 100644
--- a/drivers/power/reset/gpio-poweroff.c
+++ b/drivers/power/reset/gpio-poweroff.c
@@ -48,6 +48,7 @@ static void gpio_poweroff_do_poweroff(void)
 static int gpio_poweroff_probe(struct platform_device *pdev)
 {
 	bool input =3D false;
+	enum gpiod_flags flags;
=20
 	/* If a pm_power_off function has already been added, leave it alone =
*/
 	if (pm_power_off !=3D NULL) {
@@ -57,25 +58,15 @@ static int gpio_poweroff_probe(struct platform_devi=
ce *pdev)
 		return -EBUSY;
 	}
=20
-	reset_gpio =3D devm_gpiod_get(&pdev->dev, NULL);
-	if (IS_ERR(reset_gpio))
-		return PTR_ERR(reset_gpio);
-
 	input =3D of_property_read_bool(pdev->dev.of_node, "input");
+	if (input)
+		flags =3D GPIOD_IN;
+	else
+		flags =3D GPIOD_OUT_LOW;
=20
-	if (input) {
-		if (gpiod_direction_input(reset_gpio)) {
-			dev_err(&pdev->dev,
-				"Could not set direction of reset GPIO to input\n");
-			return -ENODEV;
-		}
-	} else {
-		if (gpiod_direction_output(reset_gpio, 0)) {
-			dev_err(&pdev->dev,
-				"Could not set direction of reset GPIO\n");
-			return -ENODEV;
-		}
-	}
+	reset_gpio =3D devm_gpiod_get(&pdev->dev, NULL, flags);
+	if (IS_ERR(reset_gpio))
+		return PTR_ERR(reset_gpio);
=20
 	pm_power_off =3D &gpio_poweroff_do_poweroff;
 	return 0;
--=20
2.1.4

