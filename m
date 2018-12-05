From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v2 15/17] power: supply: olpc_battery: Use
 devm_power_supply_register()
Date: Wed, 5 Dec 2018 21:58:00 +0100
Message-ID: <20181205205800.dqg3airnnvmzduyl@earth.universe>
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-16-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3944094970198869584=="
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20181116162403.49854-16-lkundrak@v3.sk>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, devel@driverdev.osuosl.org, Eric Miao <eric.y.miao@gmail.com>, James Cameron <quozl@laptop.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Andy Shevchenko <andy@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============3944094970198869584==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2zavjpobxxrb6mg6"
Content-Disposition: inline


--2zavjpobxxrb6mg6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 16, 2018 at 05:24:01PM +0100, Lubomir Rintel wrote:
> This simplifies the error handling.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>=20
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> Changes since v1:
> - This was split off the "power: supply: olpc_battery: Move priv data to
>   a struct" patch.
>=20
>  drivers/power/supply/olpc_battery.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
> index b091f897c1d4..4433eb10a23d 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -628,7 +628,7 @@ static int olpc_battery_probe(struct platform_device =
*pdev)
>  	psy_cfg.of_node =3D pdev->dev.of_node;
>  	psy_cfg.drv_data =3D data;
> =20
> -	data->olpc_ac =3D power_supply_register(&pdev->dev, &olpc_ac_desc, &psy=
_cfg);
> +	data->olpc_ac =3D devm_power_supply_register(&pdev->dev, &olpc_ac_desc,=
 &psy_cfg);
>  	if (IS_ERR(data->olpc_ac))
>  		return PTR_ERR(data->olpc_ac);
> =20
> @@ -643,15 +643,13 @@ static int olpc_battery_probe(struct platform_devic=
e *pdev)
>  		olpc_bat_desc.num_properties =3D ARRAY_SIZE(olpc_xo1_bat_props);
>  	}
> =20
> -	data->olpc_bat =3D power_supply_register(&pdev->dev, &olpc_bat_desc, &p=
sy_cfg);
> -	if (IS_ERR(olpc_bat)) {
> -		ret =3D PTR_ERR(olpc_bat);
> -		goto battery_failed;
> -	}
> +	data->olpc_bat =3D devm_power_supply_register(&pdev->dev, &olpc_bat_des=
c, &psy_cfg);
> +	if (IS_ERR(data->olpc_bat))
> +		return PTR_ERR(data->olpc_bat);
> =20
>  	ret =3D device_create_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
>  	if (ret)
> -		goto eeprom_failed;
> +		return ret;
> =20
>  	ret =3D device_create_file(&data->olpc_bat->dev, &olpc_bat_error);
>  	if (ret)
> @@ -666,10 +664,6 @@ static int olpc_battery_probe(struct platform_device=
 *pdev)
> =20
>  error_failed:
>  	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
> -eeprom_failed:
> -	power_supply_unregister(data->olpc_bat);
> -battery_failed:
> -	power_supply_unregister(data->olpc_ac);
>  	return ret;
>  }
> =20
> @@ -679,9 +673,6 @@ static int olpc_battery_remove(struct platform_device=
 *pdev)
> =20
>  	device_remove_file(&data->olpc_bat->dev, &olpc_bat_error);
>  	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
> -	power_supply_unregister(data->olpc_bat);
> -	power_supply_unregister(data->olpc_ac);
> -
>  	return 0;
>  }
> =20
> --=20
> 2.19.1
>=20

--2zavjpobxxrb6mg6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIO9gACgkQ2O7X88g7
+prfpw//V7/f7zADi/0A0e8qUovcWhycMk5Q3l+O8pwziULaZUUJb9zoF0JARKDn
Ie5a2ib+nJLBADkOvh7GXka5tvVPgn1K1CC65Sdddm7a31b2qlts+oo5yJcDoyq7
G9SRctk19Oo/u1QR2MQ1yyfWSxd0si0oXVGJQC/cMz69rY/hSoBCH3kq0PtQiYMv
jN+7KJEAsi1gOZrlIm0MBcbRqumSywm0DVbD9Yjlwptja8Fgo1qT65zx9uErpZ2U
zHR0wiJ5LafnzbgJGFBQ0Tn8prtBwL9yg6KykKYbsqrFCqeu+KJuWOPOza/GMU8g
acvNFAI4chNTr5WZ2R/21yz+NybUekzo0DFyttjGATrDYJR6qVyXaMMxv5q8U67I
uF1wgktQ4wI8aIPJ2+/CDev32H1FOdndmfh7j9Kh3BVXd1QBmQKbEB1lMNhxFU4V
rqz9pQi5Q6Q/YylDSmnllSGN4Vj6rrwx2yOkG09BZIVBJC0xLiv99CGnpb44tELb
GdWo0bM92jbi9xhk6wxs5Ji+sZA0FqLfRFFGYR8W1bHFoKpofchTXD7mzyoBMqnr
SHvoVlHrQ/zVB8JG8lEmUyKv3LQZkzaCAPO/27W4GXSlUpiVY1qmxExR2wiHcXDB
xj7qvKbm8WTB0jBmG3Hc9juVRl64mXkn36eB1vxeC1+RQVQxp+U=
=pGoN
-----END PGP SIGNATURE-----

--2zavjpobxxrb6mg6--

--===============3944094970198869584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============3944094970198869584==--
