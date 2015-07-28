From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH] rx51-battery: Set name to rx51-battery
Date: Tue, 28 Jul 2015 20:44:41 +0200
Message-ID: <1438109081-8204-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46or compatibility between board code and DT, set battery name to same=
 value.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/power/rx51_battery.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/rx51_battery.c b/drivers/power/rx51_battery.=
c
index ac62069..af9383d 100644
--- a/drivers/power/rx51_battery.c
+++ b/drivers/power/rx51_battery.c
@@ -215,7 +215,7 @@ static int rx51_battery_probe(struct platform_devic=
e *pdev)
 	platform_set_drvdata(pdev, di);
=20
 	di->dev =3D &pdev->dev;
-	di->bat_desc.name =3D dev_name(&pdev->dev);
+	di->bat_desc.name =3D "rx51-battery";
 	di->bat_desc.type =3D POWER_SUPPLY_TYPE_BATTERY;
 	di->bat_desc.properties =3D rx51_battery_props;
 	di->bat_desc.num_properties =3D ARRAY_SIZE(rx51_battery_props);
--=20
1.7.9.5
