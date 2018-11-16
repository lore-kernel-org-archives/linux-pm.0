From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 15/17] power: supply: olpc_battery: Use devm_power_supply_register()
Date: Fri, 16 Nov 2018 17:24:01 +0100
Message-ID: <20181116162403.49854-16-lkundrak@v3.sk>
References: <20181116162403.49854-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181116162403.49854-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Cameron <quozl@laptop.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-pm@vger.kernel.org

This simplifies the error handling.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- This was split off the "power: supply: olpc_battery: Move priv data to
  a struct" patch.

 drivers/power/supply/olpc_battery.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
index b091f897c1d4..4433eb10a23d 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -628,7 +628,7 @@ static int olpc_battery_probe(struct platform_device =
*pdev)
 	psy_cfg.of_node =3D pdev->dev.of_node;
 	psy_cfg.drv_data =3D data;
=20
-	data->olpc_ac =3D power_supply_register(&pdev->dev, &olpc_ac_desc, &psy=
_cfg);
+	data->olpc_ac =3D devm_power_supply_register(&pdev->dev, &olpc_ac_desc,=
 &psy_cfg);
 	if (IS_ERR(data->olpc_ac))
 		return PTR_ERR(data->olpc_ac);
=20
@@ -643,15 +643,13 @@ static int olpc_battery_probe(struct platform_devic=
e *pdev)
 		olpc_bat_desc.num_properties =3D ARRAY_SIZE(olpc_xo1_bat_props);
 	}
=20
-	data->olpc_bat =3D power_supply_register(&pdev->dev, &olpc_bat_desc, &p=
sy_cfg);
-	if (IS_ERR(olpc_bat)) {
-		ret =3D PTR_ERR(olpc_bat);
-		goto battery_failed;
-	}
+	data->olpc_bat =3D devm_power_supply_register(&pdev->dev, &olpc_bat_des=
c, &psy_cfg);
+	if (IS_ERR(data->olpc_bat))
+		return PTR_ERR(data->olpc_bat);
=20
 	ret =3D device_create_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
 	if (ret)
-		goto eeprom_failed;
+		return ret;
=20
 	ret =3D device_create_file(&data->olpc_bat->dev, &olpc_bat_error);
 	if (ret)
@@ -666,10 +664,6 @@ static int olpc_battery_probe(struct platform_device=
 *pdev)
=20
 error_failed:
 	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
-eeprom_failed:
-	power_supply_unregister(data->olpc_bat);
-battery_failed:
-	power_supply_unregister(data->olpc_ac);
 	return ret;
 }
=20
@@ -679,9 +673,6 @@ static int olpc_battery_remove(struct platform_device=
 *pdev)
=20
 	device_remove_file(&data->olpc_bat->dev, &olpc_bat_error);
 	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
-	power_supply_unregister(data->olpc_bat);
-	power_supply_unregister(data->olpc_ac);
-
 	return 0;
 }
=20
--=20
2.19.1
