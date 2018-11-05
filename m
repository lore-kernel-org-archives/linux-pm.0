From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH 4/4] power: reset: at91-poweroff: remove at91_ramc_of_match
Date: Mon, 5 Nov 2018 11:14:31 +0000
Message-ID: <1541416443-4321-5-git-send-email-claudiu.beznea@microchip.com>
References: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Claudiu.Beznea@microchip.com
List-Id: linux-pm@vger.kernel.org

Remove at91_ramc_of_match[] since it is not used anywhere in this code.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-poweroff.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91=
-poweroff.c
index e75d8f0f0526..43b4cccb7d0c 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -232,11 +232,6 @@ static int __exit at91_poweroff_remove(struct platform=
_device *pdev)
 	return 0;
 }
=20
-static const struct of_device_id at91_ramc_of_match[] =3D {
-	{ .compatible =3D "atmel,sama5d3-ddramc", },
-	{ /* sentinel */ }
-};
-
 static const struct of_device_id at91_poweroff_of_match[] =3D {
 	{ .compatible =3D "atmel,at91sam9260-shdwc", },
 	{ .compatible =3D "atmel,at91sam9rl-shdwc", },
--=20
2.7.4
