From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH 1/3] power: reset: at91-poweroff: add RTT wakeup capability
Date: Thu, 14 Feb 2019 11:24:07 +0000
Message-ID: <1550143407-26109-2-git-send-email-claudiu.beznea@microchip.com>
References: <1550143407-26109-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550143407-26109-1-git-send-email-claudiu.beznea@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, sre@kernel.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Claudiu.Beznea@microchip.com
List-Id: linux-pm@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add RTT wakeup capability.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset=
/at91-sama5d2_shdwc.c
index 2b686c55b717..0747e0cdf350 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -57,15 +57,21 @@
=20
 #define SHDW_WK_PIN(reg, cfg)	((reg) & AT91_SHDW_WKUPIS((cfg)->wkup_pin_in=
put))
 #define SHDW_RTCWK(reg, cfg)	(((reg) >> ((cfg)->sr_rtcwk_shift)) & 0x1)
+#define SHDW_RTTWK(reg, cfg)	(((reg) >> ((cfg)->sr_rttwk_shift)) & 0x1)
 #define SHDW_RTCWKEN(cfg)	(1 << ((cfg)->mr_rtcwk_shift))
+#define SHDW_RTTWKEN(cfg)	(1 << ((cfg)->mr_rttwk_shift))
=20
 #define DBC_PERIOD_US(x)	DIV_ROUND_UP_ULL((1000000 * (x)), \
 							SLOW_CLOCK_FREQ)
=20
+#define SHDW_CFG_NOT_USED	(32)
+
 struct shdwc_config {
 	u8 wkup_pin_input;
 	u8 mr_rtcwk_shift;
+	u8 mr_rttwk_shift;
 	u8 sr_rtcwk_shift;
+	u8 sr_rttwk_shift;
 };
=20
 struct shdwc {
@@ -104,6 +110,8 @@ static void __init at91_wakeup_status(struct platform_d=
evice *pdev)
 		reason =3D "WKUP pin";
 	else if (SHDW_RTCWK(reg, shdw->cfg))
 		reason =3D "RTC";
+	else if (SHDW_RTTWK(reg, shdw->cfg))
+		reason =3D "RTT";
=20
 	pr_info("AT91: Wake-Up source: %s\n", reason);
 }
@@ -221,6 +229,9 @@ static void at91_shdwc_dt_configure(struct platform_dev=
ice *pdev)
 	if (of_property_read_bool(np, "atmel,wakeup-rtc-timer"))
 		mode |=3D SHDW_RTCWKEN(shdw->cfg);
=20
+	if (of_property_read_bool(np, "atmel,wakeup-rtt-timer"))
+		mode |=3D SHDW_RTTWKEN(shdw->cfg);
+
 	dev_dbg(&pdev->dev, "%s: mode =3D %#x\n", __func__, mode);
 	writel(mode, shdw->shdwc_base + AT91_SHDW_MR);
=20
@@ -231,7 +242,10 @@ static void at91_shdwc_dt_configure(struct platform_de=
vice *pdev)
 static const struct shdwc_config sama5d2_shdwc_config =3D {
 	.wkup_pin_input =3D 0,
 	.mr_rtcwk_shift =3D 17,
+	.mr_rttwk_shift	=3D SHDW_CFG_NOT_USED,
 	.sr_rtcwk_shift =3D 5,
+	.sr_rttwk_shift =3D SHDW_CFG_NOT_USED,
+};
 };
=20
 static const struct of_device_id at91_shdwc_of_match[] =3D {
--=20
2.7.4
