From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH 3/4] power: reset: at91-poweroff: check shdwc data structure
 at the beginning of probe
Date: Mon, 5 Nov 2018 11:14:28 +0000
Message-ID: <1541416443-4321-4-git-send-email-claudiu.beznea@microchip.com>
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

Check at91_shdwc before continuing with probe since we want only one instan=
ce of
this driver. Inspired from commit 9f1e44774be5 ("power: reset: at91-powerof=
f:
do not procede if at91_shdwc is allocated").

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-poweroff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91=
-poweroff.c
index 48661e04a3de..e75d8f0f0526 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -160,6 +160,9 @@ static int __init at91_poweroff_probe(struct platform_d=
evice *pdev)
 	u32 ddr_type;
 	int ret;
=20
+	if (at91_shdwc)
+		return -EBUSY;
+
 	at91_shdwc =3D devm_kzalloc(&pdev->dev, sizeof(*at91_shdwc), GFP_KERNEL);
 	if (!at91_shdwc)
 		return -ENOMEM;
--=20
2.7.4
