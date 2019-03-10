From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 07/10] power: supply: olpc_battery: Use devm_power_supply_register()
Date: Sun, 10 Mar 2019 17:24:16 +0100
Message-ID: <20190310162419.11861-8-lkundrak@v3.sk>
References: <20190310162419.11861-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190310162419.11861-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Darren Hart <dvhart@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, x86@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-pm@vger.kernel.org

This simplifies the error handling.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

---
Changes since v1:
- This was split off the "power: supply: olpc_battery: Move priv data to
  a struct" patch.

 drivers/power/supply/olpc_battery.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
index f7bb9bedd893..d83c77c2a0ec 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -634,7 +634,7 @@ static int olpc_battery_probe(struct platform_device =
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
@@ -648,15 +648,13 @@ static int olpc_battery_probe(struct platform_devic=
e *pdev)
 		olpc_bat_desc.num_properties =3D ARRAY_SIZE(olpc_xo1_bat_props);
 	}
=20
-	data->olpc_bat =3D power_supply_register(&pdev->dev, &olpc_bat_desc, &p=
sy_cfg);
-	if (IS_ERR(data->olpc_bat)) {
-		ret =3D PTR_ERR(data->olpc_bat);
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
@@ -671,10 +669,6 @@ static int olpc_battery_probe(struct platform_device=
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
@@ -684,9 +678,6 @@ static int olpc_battery_remove(struct platform_device=
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
2.20.1
