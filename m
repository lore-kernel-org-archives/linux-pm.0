From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] power: ltc2941-battery-gauge: Disable continuous
 monitoring on shutdown
Date: Fri, 1 Dec 2017 16:42:10 +0100
Message-ID: <20171201154210.l5wrmqipb5eeamzc@earth>
References: <1511448065-2727-1-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="isxqmumf7c57fyh3"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40500 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbdLAPmO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Dec 2017 10:42:14 -0500
Content-Disposition: inline
In-Reply-To: <1511448065-2727-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ladis@linux-mips.org, Dragos.Bogdan@analog.com


--isxqmumf7c57fyh3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 23, 2017 at 03:41:05PM +0100, Mike Looijmans wrote:
> The driver sets the fuel gauge to continuous monitoring on startup, for
> the models that support this. When the board shuts down, the chip remains
> in that mode, causing a few mA drain on the battery every 2 or 10 seconds.
>=20
> This patch registers a shutdown handler that turns off the monitoring to
> prevent this battery drain.
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---

Thanks, queued. I wonder if you need a second patch to also disable
the monitoring for suspend (and re-enable on resume)?

-- Sebastian

>  drivers/power/supply/ltc2941-battery-gauge.c | 25 ++++++++++++++++++++++=
+++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power=
/supply/ltc2941-battery-gauge.c
> index 08e4fd9..4cfa3f0 100644
> --- a/drivers/power/supply/ltc2941-battery-gauge.c
> +++ b/drivers/power/supply/ltc2941-battery-gauge.c
> @@ -60,6 +60,7 @@ enum ltc294x_id {
>  #define LTC294X_REG_CONTROL_PRESCALER_SET(x) \
>  	((x << 3) & LTC294X_REG_CONTROL_PRESCALER_MASK)
>  #define LTC294X_REG_CONTROL_ALCC_CONFIG_DISABLED	0
> +#define LTC294X_REG_CONTROL_ADC_DISABLE(x)	((x) & ~(BIT(7) | BIT(6)))
> =20
>  struct ltc294x_info {
>  	struct i2c_client *client;	/* I2C Client pointer */
> @@ -523,6 +524,29 @@ static int ltc294x_i2c_probe(struct i2c_client *clie=
nt,
>  	return 0;
>  }
> =20
> +static void ltc294x_i2c_shutdown(struct i2c_client *client)
> +{
> +	struct ltc294x_info *info =3D i2c_get_clientdata(client);
> +	int ret;
> +	u8 value;
> +	u8 control;
> +
> +	/* The LTC2941 does not need any special handling */
> +	if (info->id =3D=3D LTC2941_ID)
> +		return;
> +
> +	/* Read control register */
> +	ret =3D ltc294x_read_regs(info->client, LTC294X_REG_CONTROL, &value, 1);
> +	if (ret < 0)
> +		return;
> +
> +	/* Disable continuous ADC conversion as this drains the battery */
> +	control =3D LTC294X_REG_CONTROL_ADC_DISABLE(value);
> +	if (control !=3D value)
> +		ltc294x_write_regs(info->client, LTC294X_REG_CONTROL,
> +			&control, 1);
> +}
> +
>  #ifdef CONFIG_PM_SLEEP
> =20
>  static int ltc294x_suspend(struct device *dev)
> @@ -589,6 +613,7 @@ static int ltc294x_resume(struct device *dev)
>  	},
>  	.probe		=3D ltc294x_i2c_probe,
>  	.remove		=3D ltc294x_i2c_remove,
> +	.shutdown	=3D ltc294x_i2c_shutdown,
>  	.id_table	=3D ltc294x_i2c_id,
>  };
>  module_i2c_driver(ltc294x_driver);
> --=20
> 1.9.1
>=20

--isxqmumf7c57fyh3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloheFIACgkQ2O7X88g7
+prMAg//ReMNEtmJSfliy8O65DqyngByeET76Ki5QqE/Zc3WcXpzVG0CUANfU5iq
tFYwXyK5WT0rRmnaxWsrnllD4VC6V1iGi63NgEkwlYLsJMXRnLC4b06UgPGibAyQ
geX8S+iYsWjuaW4prWC5XfIQd5+ZE2AOSCCmdCup0o0jvNBJBdf/QBRv4+fQExft
FoDMM/8YmwNbYL6G/neiUt1GXf1nVubM+PCcXuGjKPloarRqu203zsRPf3NdbSj+
ewZzW36mdbGQwmxmQ3g/rp370CSp8oQRcNpOElx/qHbHFtug/XPL3lqdnLvZpUvf
oBrDy6Y8DQs+6+SMXeQVKq6aOa0A1l07QnMTcya4fDhoogTaFnqiXvXzt389Wnfx
/mFY1Ojyr/a7Wo+RHIt2BxXtUUJKPX46c8uyxjXzgwBCFpmaLv4m+/8e6tiaNfnz
iCZvbrHiOd560lWBUcgSTKEsUYYLCd5UUh0AQ6Fpi2FI0JaFIRmtWSZAifqcmIhf
Gp81CuOd0EVnWxbkN3iKJ9smLsOjYvoVN95jcfmLJbhVlhcEaFfhKUPu3QBLmgsD
hJwx261Kcz1YcP4pNlzRnWZpdKgY5ilZqe96LWvrmHCjOoyB8v3i+6NKorc/jzI/
ED7eBEU8+zOXA3F/ArUrBhK7fRcwtyiaSUivA643Al9fwzMh5DQ=
=UTfj
-----END PGP SIGNATURE-----

--isxqmumf7c57fyh3--
