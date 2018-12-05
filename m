From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v2 13/17] power: supply: olpc_battery: Use DT to get
 battery version
Date: Wed, 5 Dec 2018 21:54:59 +0100
Message-ID: <20181205205459.bsumxn57hjjzvqaj@earth.universe>
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-14-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gka4uuyygtti7jd3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181116162403.49854-14-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Cameron <quozl@laptop.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--gka4uuyygtti7jd3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 16, 2018 at 05:23:59PM +0100, Lubomir Rintel wrote:
> Avoid using the x86 OLPC platform specific call to get the board
> version. It won't work on FDT-based ARM MMP2 platform.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>=20
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

I assume this patch cannot be applied to power-supply without patch
12 having been merged to avoid breaking XO1.5 devices temporarily?

-- Sebastian

> Changes since v1:
> - Sort the new include a bit higher
>=20
>  drivers/power/supply/olpc_battery.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
> index 5a97e42a3547..5323987d9284 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -14,6 +14,7 @@
>  #include <linux/types.h>
>  #include <linux/err.h>
>  #include <linux/device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
>  #include <linux/jiffies.h>
> @@ -622,11 +623,13 @@ static int olpc_battery_probe(struct platform_devic=
e *pdev)
>  	olpc_ac =3D power_supply_register(&pdev->dev, &olpc_ac_desc, NULL);
>  	if (IS_ERR(olpc_ac))
>  		return PTR_ERR(olpc_ac);
> -
> -	if (olpc_board_at_least(olpc_board_pre(0xd0))) { /* XO-1.5 */
> +	if (of_property_match_string(pdev->dev.of_node, "compatible",
> +					"olpc,xo1.5-battery") >=3D 0) {
> +		/* XO-1.5 */
>  		olpc_bat_desc.properties =3D olpc_xo15_bat_props;
>  		olpc_bat_desc.num_properties =3D ARRAY_SIZE(olpc_xo15_bat_props);
> -	} else { /* XO-1 */
> +	} else {
> +		/* XO-1 */
>  		olpc_bat_desc.properties =3D olpc_xo1_bat_props;
>  		olpc_bat_desc.num_properties =3D ARRAY_SIZE(olpc_xo1_bat_props);
>  	}
> @@ -672,6 +675,7 @@ static int olpc_battery_remove(struct platform_device=
 *pdev)
> =20
>  static const struct of_device_id olpc_battery_ids[] =3D {
>  	{ .compatible =3D "olpc,xo1-battery" },
> +	{ .compatible =3D "olpc,xo1.5-battery" },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, olpc_battery_ids);
> --=20
> 2.19.1
>=20

--gka4uuyygtti7jd3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIOyMACgkQ2O7X88g7
+ppYQQ//eWJazyIvHlo7mhsllTEJxWn+akOo/zS8IcxjhAz+WxEFY62MgIjeuhXh
slYouNvYyLNndhAkPxAPMS1OP68ySOZrjb93iMw5zoR93t17gAKydVWEMTo1p+Y3
PmkCPJ3pIbid0uPrehQY91sAanQpLXlSROnOsC8ZFpDaDDB0xR+JtQWvpwGWwmej
iDCku0l4TG5bfXY5l4wDEzRe1/B8GAAqH49gqLLAjGVR0xAba0abhlxLaE/tqBdB
T+8lD6637NK0+GKwszMYKfXhFTyF80M9UXRYImwgExXl7V3uUqk7wzZZzo8Q6RS8
hhyfX5dR7O7bu1UensrVFkJ1UTDvM/eYm0OZGMa8u61t1ly4TUtQOKM0WoJMTRLK
mVVyHpPFzmoGovmBSknAUFqr2xX332mdkylzSUmr8DEBvsx2+9FL0UQQqnJve3rF
YYJWqTXV+hP1oFbTYruZFtuEnMsWdmyoHIEjbHIxxi3a+kqZelVZrOFC6s4ZtcZy
takcXz8bgsa4sSnEuhkZosHNz+cD1szzWJcnCcr9m0B9xrfDLFF8c4Syhm2MVdwa
3bhCdnfmbHrahwrE8DNbCck0CbtbYaYHnMLA+4L6q3oTqsPlVZcZ8esEubMesayH
JP5Yd90FHYdP8pnWv+uR16ucjjTwZ0HDp8zqzHX51jHUIVD+h+g=
=D9UJ
-----END PGP SIGNATURE-----

--gka4uuyygtti7jd3--
