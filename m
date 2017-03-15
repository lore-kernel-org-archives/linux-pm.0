From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 1/2] power: supply: ltc2941-battery-gauge: Add OF
 device ID table
Date: Wed, 15 Mar 2017 21:55:18 +0100
Message-ID: <20170315205518.sjzijt6likrrau7b@earth>
References: <20170315034349.8494-1-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e5lytywhm6ypxjak"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751822AbdCOVBX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Mar 2017 17:01:23 -0400
Content-Disposition: inline
In-Reply-To: <20170315034349.8494-1-javier@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--e5lytywhm6ypxjak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 15, 2017 at 12:43:48AM -0300, Javier Martinez Canillas wrote:
> The driver doesn't have a struct of_device_id table but supported devices
> are registered via Device Trees. This is working on the assumption that a
> I2C device registered via OF will always match a legacy I2C device ID and
> that the MODALIAS reported will always be of the form i2c:<device>.

I don't get hits for "grep -r ltc294[13]" in arch/.

> But this could change in the future so the correct approach is to have an
> OF device ID table if the devices are registered via OF.
>=20
> The compatible strings don't have a vendor prefix because that's how it's
> used currently, and changing this will be a Device Tree ABI break.

I think the DT strings should have a vendor prefix.
So I will only queue this with an explicit Acked-By from Rob or Mark.

-- Sebastian

> Changes in v3:
> - Don't use of_match_ptr() to avoid build warning when CONFIG_OF is disab=
led.
>=20
> Changes in v2:
>  Fix build warning reported by kbuild test robot.
> - Fix wrong compatible strings due a copy & paste error.
>=20
>  drivers/power/supply/ltc2941-battery-gauge.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power=
/supply/ltc2941-battery-gauge.c
> index 4adf2ba021ce..d3052be1bead 100644
> --- a/drivers/power/supply/ltc2941-battery-gauge.c
> +++ b/drivers/power/supply/ltc2941-battery-gauge.c
> @@ -9,6 +9,7 @@
>   */
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/types.h>
>  #include <linux/errno.h>
>  #include <linux/swab.h>
> @@ -61,7 +62,7 @@ struct ltc294x_info {
>  	struct power_supply *supply;	/* Supply pointer */
>  	struct power_supply_desc supply_desc;	/* Supply description */
>  	struct delayed_work work;	/* Work scheduler */
> -	int num_regs;	/* Number of registers (chip type) */
> +	unsigned long num_regs;	/* Number of registers (chip type) */
>  	int charge;	/* Last charge register content */
>  	int r_sense;	/* mOhm */
>  	int Qlsb;	/* nAh */
> @@ -387,7 +388,7 @@ static int ltc294x_i2c_probe(struct i2c_client *clien=
t,
> =20
>  	np =3D of_node_get(client->dev.of_node);
> =20
> -	info->num_regs =3D id->driver_data;
> +	info->num_regs =3D (unsigned long)of_device_get_match_data(&client->dev=
);
>  	info->supply_desc.name =3D np->name;
> =20
>  	/* r_sense can be negative, when sense+ is connected to the battery
> @@ -497,9 +498,23 @@ static const struct i2c_device_id ltc294x_i2c_id[] =
=3D {
>  };
>  MODULE_DEVICE_TABLE(i2c, ltc294x_i2c_id);
> =20
> +static const struct of_device_id ltc294x_i2c_of_match[] =3D {
> +	{
> +		.compatible =3D "ltc2941",
> +		.data =3D (void *)LTC2941_NUM_REGS
> +	},
> +	{
> +		.compatible =3D "ltc2943",
> +		.data =3D (void *)LTC2943_NUM_REGS
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ltc294x_i2c_of_match);
> +
>  static struct i2c_driver ltc294x_driver =3D {
>  	.driver =3D {
>  		.name	=3D "LTC2941",
> +		.of_match_table =3D ltc294x_i2c_of_match,
>  		.pm	=3D LTC294X_PM_OPS,
>  	},
>  	.probe		=3D ltc294x_i2c_probe,
> --=20
> 2.9.3
>=20

--e5lytywhm6ypxjak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljJqjYACgkQ2O7X88g7
+pqLow//RwjwFyjHY1uMK9EkW8eg3DA/KnG2xa0fKWVFoUR1LQHY/bLNQwSeW7BO
Y5nAI5g8flzlx8EIjgQHbAep6iVbZVUQ8F1HTPdiaU+bC6LUl7IyWgULM7BwIvDu
YwoHhOKdv30RbmaB1Z0KJ8uHfyO7h7Jeih2bZnSqrSP+JhvXh2js7MM7bkj9H3CR
7xWQeEGX9wNPrGLAkRsaP+bhbece7SkSVWOjKbNGFjs4zVFymN+sZKY/zQ0KIvAs
RUPOASmOxwoOcLP+dWlsXeTocsXOn/pi9WoKPoUtf1Nf/jOVZomCLd1YWzM0fj1L
Q012gK2HSGMDJYwpkuehNB9czfBfNaAeDPZM/sqmISY+QxShf22Wzpst/3r8toqi
vwQHdERsR8/IO4nA6wjUkKMyHfmptlS+uQjj8lMhyCu/5+pFpVeqxC1rLLyGIWU0
jCIhvhCoPiKkYAum+F2/S4Br5K7DWHEkZ4DmYX12RsrAkXGFyWXSRAKMjXJmBJSv
i/2acufx+LnEsW5TiMRkfXFkZtbAo/e3Sn6WIGF/HTNssfQGcz4rFUGVbZSSZSXl
x/RL1QFlw8MjYV99WS3cnx1jDEInNr7MVOR1Kla1z/GFbFWZm4Mt7KQhqGR3W0vt
xie+QLuiSLaMpWlZ00EF0FLnqIjP1f+JNwS3gyc6RTbBVBWyEqE=
=r302
-----END PGP SIGNATURE-----

--e5lytywhm6ypxjak--
