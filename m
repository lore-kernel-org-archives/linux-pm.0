From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 3/7] power: supply: olpc_battery: Use DT to get
 battery version
Date: Wed, 23 Jan 2019 21:38:05 +0100
Message-ID: <20190123203805.qhmilqqozkgrchoy@earth.universe>
References: <20190110174005.1202564-1-lkundrak@v3.sk>
 <20190110174005.1202564-4-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6h6uhi6mqvm2kbpb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190110174005.1202564-4-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, x86@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--6h6uhi6mqvm2kbpb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 10, 2019 at 06:40:01PM +0100, Lubomir Rintel wrote:
> Avoid using the x86 OLPC platform specific call to get the board
> version. That wouldn't work on FDT-based ARM MMP2 platform.
>=20
> Add the XO 1.5 compatible string too. This is actually not completely
> necessary as the battery nodes on XO 1.5 claim to be compatible with
> "olpc,xo1-battery", but there are, in fact, differencies.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> ---
> Changes since v2:
> - Clarify the XO 1 compatibility in the commit message.
>=20
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

of_device_is_compatible(...)

-- Sebastian

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
> 2.20.1
>=20

--6h6uhi6mqvm2kbpb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxI0KoACgkQ2O7X88g7
+pqb9g//Sl82KeYO3saUbSr7qshHZkKLWKj+rS928qqwf3eBjclKlSPzV1gHHJAD
P5Y3IOSNKyMT5do0rSeDJYF82z9cOQbJnC3IGz6tHC8Lak6aC1eEVBBAPRf098e3
ihrzgbF9OLINhCh5I8J1Zz7DaEv9bZpbxEWKnAO8zJaI37UhhYKA/LVoMIM9/3pT
3+06zdmL5GdrOvC2xak45En0Lst+pmUpn2OtXoakzZ4SgMMvDInj0PIlg078pURp
tjQhSlMZLFns7Wvf1AJxzTCtSNVp3Mz1wDa38u1smn0dB4EyFwC5ccv2FaiE7yp1
iuTM2G1x7pTBzdjBqr7SY6qhfBji9Pr2lvrLywdVdTHc5krGSqIAiMxF18iIIzT+
z9lqm5i6sNenGdOjDoS1ho1j7ttYKnyxaTVgCO+zLajaPjwOTzO+bPcEtwIKeooZ
sdpa86bf9dfitMHafwpE0JdN0OOx6WiQx4N2YYUIPt4sxQcICWQmjkm6SqyfmM9h
Xaht1qnBX6nYaDheRrsnKQeKsUu6K1lV0xCHDhJlxRaC9SwhtVfovawsZhJB0LE0
mPVzPOaNQcU7gGAQIPwZ3quA4oNbWaobnm2K5wByIfZu54I+nXbxDqoucvdI8wmm
LpWQW73C7pB5b7/wrjW+kD2qUpIsLjZOG108LEegWcZT3pFx3kE=
=vWen
-----END PGP SIGNATURE-----

--6h6uhi6mqvm2kbpb--
