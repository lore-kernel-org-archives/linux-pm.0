From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 13/15] power: supply: olpc_battery: Move priv data to a
 struct
Date: Sun, 4 Nov 2018 15:37:43 +0100
Message-ID: <20181104143743.GF23864@amd>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-14-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vK3aNhhOnFYnG5nq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010172300.317643-14-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Cameron <quozl@laptop.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--vK3aNhhOnFYnG5nq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The global variables for private data are not too nice. I'd like some
> more, and that would clutter the global name space even further.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Ok...

> -	olpc_bat =3D power_supply_register(&pdev->dev, &olpc_bat_desc, NULL);
> -	if (IS_ERR(olpc_bat)) {
> -		ret =3D PTR_ERR(olpc_bat);
> -		goto battery_failed;
> -	}
> +	data->olpc_bat =3D devm_power_supply_register(&pdev->dev, &olpc_bat_des=
c, &psy_cfg);
> +	if (IS_ERR(data->olpc_bat))
> +		return PTR_ERR(data->olpc_bat);
> =20
> -	ret =3D device_create_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
> +	ret =3D device_create_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
>  	if (ret)
> -		goto eeprom_failed;
> +		return ret;
> =20
> -	ret =3D device_create_file(&olpc_bat->dev, &olpc_bat_error);
> +	ret =3D device_create_file(&data->olpc_bat->dev, &olpc_bat_error);
>  	if (ret)
>  		goto error_failed;
> =20
>  	if (olpc_ec_wakeup_available()) {
> -		device_set_wakeup_capable(&olpc_ac->dev, true);
> -		device_set_wakeup_capable(&olpc_bat->dev, true);
> +		device_set_wakeup_capable(&data->olpc_ac->dev, true);
> +		device_set_wakeup_capable(&data->olpc_bat->dev, true);
>  	}
> =20
>  	return 0;
> =20
>  error_failed:
> -	device_remove_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
> -eeprom_failed:
> -	power_supply_unregister(olpc_bat);
> -battery_failed:
> -	power_supply_unregister(olpc_ac);
> +	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
>  	return ret;
>  }

=2E..but you are changing error handling here, which is not mentioned in
the changelog, and I'm nut sure you got it right.

Are you sure?

>  static int olpc_battery_remove(struct platform_device *pdev)
>  {
> -	device_remove_file(&olpc_bat->dev, &olpc_bat_error);
> -	device_remove_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
> -	power_supply_unregister(olpc_bat);
> -	power_supply_unregister(olpc_ac);
> +	struct olpc_battery_data *data =3D platform_get_drvdata(pdev);
> +
> +	device_remove_file(&data->olpc_bat->dev, &olpc_bat_error);
> +	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
>  	return 0;
>  }

Here too.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vK3aNhhOnFYnG5nq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvfBDcACgkQMOfwapXb+vK1WQCfTF4visLJfRyA4b8cxbfrIz+o
+qIAnA1rqfvtf5KtmkhPx0lEdXKoz17Y
=wyJI
-----END PGP SIGNATURE-----

--vK3aNhhOnFYnG5nq--
