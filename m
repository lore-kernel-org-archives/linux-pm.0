From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/2] power: reset: ltc2952: use _optional variant of devm_gpiod_get
Date: Mon, 18 May 2015 22:45:07 +0200
Message-ID: <1431981907-32578-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1431981907-32578-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60858 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932505AbbERUpY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 16:45:24 -0400
In-Reply-To: <1431981907-32578-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: kernel@pengutronix.de, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, linux-pm@vger.kernel.org

devm_gpiod_get_optional returns NULL if devm_gpiod_get would return an
ENOENT error pointer.

There is no semantic change intended.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Hello,

probably you could argue if the other errors returned by
devm_gpiod_get_optional should be ignored or not. I'd say it would be c=
leaner
to forward the error but as the driver explictly claims it should be ok=
, I
kept this behaviour.

=46or forwarding the error replace "data->gpio_trigger =3D NULL" by
"return PTR_ERR(data->gpio_trigger)".

Best regards
Uwe

 drivers/power/reset/ltc2952-poweroff.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/res=
et/ltc2952-poweroff.c
index 1e08195551fe..62c91acd6584 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -202,16 +202,15 @@ static int ltc2952_poweroff_init(struct platform_=
device *pdev)
 		return ret;
 	}
=20
-	data->gpio_trigger =3D devm_gpiod_get(&pdev->dev, "trigger", GPIOD_IN=
);
+	data->gpio_trigger =3D devm_gpiod_get_optional(&pdev->dev, "trigger",
+						     GPIOD_IN);
 	if (IS_ERR(data->gpio_trigger)) {
 		/*
 		 * It's not a problem if the trigger gpio isn't available, but
 		 * it is worth a warning if its use was defined in the device
 		 * tree.
 		 */
-		if (PTR_ERR(data->gpio_trigger) !=3D -ENOENT)
-			dev_err(&pdev->dev,
-				"unable to claim gpio \"trigger\"\n");
+		dev_err(&pdev->dev, "unable to claim gpio \"trigger\"\n");
 		data->gpio_trigger =3D NULL;
 	}
=20
--=20
2.1.4

