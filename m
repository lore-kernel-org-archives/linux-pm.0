From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 2/3] power: reset: at91-poweroff: add support for SAM9X60
Date: Thu, 21 Feb 2019 13:45:51 +0000
Message-ID: <1550756716-3032-3-git-send-email-claudiu.beznea@microchip.com>
References: <1550756716-3032-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550756716-3032-1-git-send-email-claudiu.beznea@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, sre@kernel.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Claudiu.Beznea@microchip.com
List-Id: linux-pm@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add support for SAM9X60 shutdown controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset=
/at91-sama5d2_shdwc.c
index 0747e0cdf350..e341cc5c0ea6 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -246,12 +246,23 @@ static const struct shdwc_config sama5d2_shdwc_config=
 =3D {
 	.sr_rtcwk_shift =3D 5,
 	.sr_rttwk_shift =3D SHDW_CFG_NOT_USED,
 };
+
+static const struct shdwc_config sam9x60_shdwc_config =3D {
+	.wkup_pin_input =3D 0,
+	.mr_rtcwk_shift =3D 17,
+	.mr_rttwk_shift =3D 16,
+	.sr_rtcwk_shift =3D 5,
+	.sr_rttwk_shift =3D 4,
 };
=20
 static const struct of_device_id at91_shdwc_of_match[] =3D {
 	{
 		.compatible =3D "atmel,sama5d2-shdwc",
 		.data =3D &sama5d2_shdwc_config,
+	},
+	{
+		.compatible =3D "microchip,sam9x60-shdwc",
+		.data =3D &sam9x60_shdwc_config,
 	}, {
 		/*sentinel*/
 	}
--=20
2.7.4
