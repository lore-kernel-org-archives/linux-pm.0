From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/7] power: supply: ab8500_charger: convert to IIO ADC
Date: Thu, 12 Jan 2017 04:03:01 +0100
Message-ID: <20170112030301.j2hx222d4mzd2tsq@earth>
References: <20170110234745.29691-1-linus.walleij@linaro.org>
 <20170110234745.29691-3-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wrmaps5v6sihusbv"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751295AbdALDDQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Jan 2017 22:03:16 -0500
Content-Disposition: inline
In-Reply-To: <20170110234745.29691-3-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Mboumba Cedric Madianga <cedric.madianga@gmail.com>, linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org


--wrmaps5v6sihusbv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 11, 2017 at 12:47:40AM +0100, Linus Walleij wrote:
> This switches the AB8500 battery charger driver to using
> the standard IIO ADC channel lookup and conversion routines.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

>  drivers/power/supply/ab8500_charger.c | 78 ++++++++++++++++++++++++++---=
------
>  1 file changed, 58 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply=
/ab8500_charger.c
> index 5cee9aa87aa3..c1c4873899e9 100644
> --- a/drivers/power/supply/ab8500_charger.c
> +++ b/drivers/power/supply/ab8500_charger.c
> @@ -29,10 +29,10 @@
>  #include <linux/mfd/abx500/ab8500.h>
>  #include <linux/mfd/abx500.h>
>  #include <linux/mfd/abx500/ab8500-bm.h>
> -#include <linux/mfd/abx500/ab8500-gpadc.h>
>  #include <linux/mfd/abx500/ux500_chargalg.h>
>  #include <linux/usb/otg.h>
>  #include <linux/mutex.h>
> +#include <linux/iio/consumer.h>
> =20
>  /* Charger constants */
>  #define NO_PW_CONN			0
> @@ -235,7 +235,10 @@ struct ab8500_charger_max_usb_in_curr {
>   * @current_stepping_sessions:
>   *			Counter for current stepping sessions
>   * @parent:		Pointer to the struct ab8500
> - * @gpadc:		Pointer to the struct gpadc
> + * @adc_main_charger_v	ADC channel for main charger voltage
> + * @adc_main_charger_c	ADC channel for main charger current
> + * @adc_vbus_v		ADC channel for USB charger voltage
> + * @adc_usb_charger_c	ADC channel for USB charger current
>   * @bm:           	Platform specific battery management information
>   * @flags:		Structure for information about events triggered
>   * @usb_state:		Structure for usb stack information
> @@ -285,7 +288,10 @@ struct ab8500_charger {
>  	int is_aca_rid;
>  	atomic_t current_stepping_sessions;
>  	struct ab8500 *parent;
> -	struct ab8500_gpadc *gpadc;
> +	struct iio_channel *adc_main_charger_v;
> +	struct iio_channel *adc_main_charger_c;
> +	struct iio_channel *adc_vbus_v;
> +	struct iio_channel *adc_usb_charger_c;
>  	struct abx500_bm_data *bm;
>  	struct ab8500_charger_event_flags flags;
>  	struct ab8500_charger_usb_state usb_state;
> @@ -461,13 +467,13 @@ static void ab8500_charger_set_usb_connected(struct=
 ab8500_charger *di,
>   */
>  static int ab8500_charger_get_ac_voltage(struct ab8500_charger *di)
>  {
> -	int vch;
> +	int vch, ret;
> =20
>  	/* Only measure voltage if the charger is connected */
>  	if (di->ac.charger_connected) {
> -		vch =3D ab8500_gpadc_convert(di->gpadc, MAIN_CHARGER_V);
> -		if (vch < 0)
> -			dev_err(di->dev, "%s gpadc conv failed,\n", __func__);
> +		ret =3D iio_read_channel_processed(di->adc_main_charger_v, &vch);
> +		if (ret < 0)
> +			dev_err(di->dev, "%s ADC conv failed,\n", __func__);
>  	} else {
>  		vch =3D 0;
>  	}
> @@ -512,13 +518,13 @@ static int ab8500_charger_ac_cv(struct ab8500_charg=
er *di)
>   */
>  static int ab8500_charger_get_vbus_voltage(struct ab8500_charger *di)
>  {
> -	int vch;
> +	int vch, ret;
> =20
>  	/* Only measure voltage if the charger is connected */
>  	if (di->usb.charger_connected) {
> -		vch =3D ab8500_gpadc_convert(di->gpadc, VBUS_V);
> -		if (vch < 0)
> -			dev_err(di->dev, "%s gpadc conv failed\n", __func__);
> +		ret =3D iio_read_channel_processed(di->adc_vbus_v, &vch);
> +		if (ret < 0)
> +			dev_err(di->dev, "%s ADC conv failed,\n", __func__);
>  	} else {
>  		vch =3D 0;
>  	}
> @@ -534,13 +540,13 @@ static int ab8500_charger_get_vbus_voltage(struct a=
b8500_charger *di)
>   */
>  static int ab8500_charger_get_usb_current(struct ab8500_charger *di)
>  {
> -	int ich;
> +	int ich, ret;
> =20
>  	/* Only measure current if the charger is online */
>  	if (di->usb.charger_online) {
> -		ich =3D ab8500_gpadc_convert(di->gpadc, USB_CHARGER_C);
> -		if (ich < 0)
> -			dev_err(di->dev, "%s gpadc conv failed\n", __func__);
> +		ret =3D iio_read_channel_processed(di->adc_usb_charger_c, &ich);
> +		if (ret < 0)
> +			dev_err(di->dev, "%s ADC conv failed,\n", __func__);
>  	} else {
>  		ich =3D 0;
>  	}
> @@ -556,13 +562,13 @@ static int ab8500_charger_get_usb_current(struct ab=
8500_charger *di)
>   */
>  static int ab8500_charger_get_ac_current(struct ab8500_charger *di)
>  {
> -	int ich;
> +	int ich, ret;
> =20
>  	/* Only measure current if the charger is online */
>  	if (di->ac.charger_online) {
> -		ich =3D ab8500_gpadc_convert(di->gpadc, MAIN_CHARGER_C);
> -		if (ich < 0)
> -			dev_err(di->dev, "%s gpadc conv failed\n", __func__);
> +		ret =3D iio_read_channel_processed(di->adc_main_charger_c, &ich);
> +		if (ret < 0)
> +			dev_err(di->dev, "%s ADC conv failed,\n", __func__);
>  	} else {
>  		ich =3D 0;
>  	}
> @@ -3485,7 +3491,39 @@ static int ab8500_charger_probe(struct platform_de=
vice *pdev)
>  	/* get parent data */
>  	di->dev =3D &pdev->dev;
>  	di->parent =3D dev_get_drvdata(pdev->dev.parent);
> -	di->gpadc =3D ab8500_gpadc_get("ab8500-gpadc.0");
> +
> +	/* Get ADC channels */
> +	di->adc_main_charger_v =3D devm_iio_channel_get(&pdev->dev,
> +						      "main_charger_v");
> +	if (IS_ERR(di->adc_main_charger_v)) {
> +		if (PTR_ERR(di->adc_main_charger_v) =3D=3D -ENODEV)
> +                        return -EPROBE_DEFER;
> +		dev_err(&pdev->dev, "failed to get ADC main charger voltage\n");
> +		return PTR_ERR(di->adc_main_charger_v);
> +	}
> +	di->adc_main_charger_c =3D devm_iio_channel_get(&pdev->dev,
> +						      "main_charger_c");
> +	if (IS_ERR(di->adc_main_charger_c)) {
> +		if (PTR_ERR(di->adc_main_charger_c) =3D=3D -ENODEV)
> +                        return -EPROBE_DEFER;
> +		dev_err(&pdev->dev, "failed to get ADC main charger current\n");
> +		return PTR_ERR(di->adc_main_charger_v);
> +	}
> +	di->adc_vbus_v =3D devm_iio_channel_get(&pdev->dev, "vbus_v");
> +	if (IS_ERR(di->adc_vbus_v)) {
> +		if (PTR_ERR(di->adc_vbus_v) =3D=3D -ENODEV)
> +                        return -EPROBE_DEFER;
> +		dev_err(&pdev->dev, "failed to get ADC USB charger voltage\n");
> +		return PTR_ERR(di->adc_vbus_v);
> +	}
> +	di->adc_usb_charger_c =3D devm_iio_channel_get(&pdev->dev,
> +						     "usb_charger_c");
> +	if (IS_ERR(di->adc_usb_charger_c)) {
> +		if (PTR_ERR(di->adc_usb_charger_c) =3D=3D -ENODEV)
> +                        return -EPROBE_DEFER;
> +		dev_err(&pdev->dev, "failed to get ADC USB charger current\n");
> +		return PTR_ERR(di->adc_usb_charger_c);
> +	}
> =20
>  	/* initialize lock */
>  	spin_lock_init(&di->usb_state.usb_lock);
> --=20
> 2.9.3
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--wrmaps5v6sihusbv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh28eUACgkQ2O7X88g7
+pq0kw/8D2NxpUgaHVJ92wOGNWldiskpcT5ZAg00AntDcedPvkMZOwM4KewbMQO5
lQzXBCt4aLQ9OEOfn2jZy4vK/RHLUyyP+L74BhTj69wwIk4I1yX9Kd/hvkkTILG8
7Kt6210e22flM1Lw1syY5ljjVcgdBSEfYeCJa/YMH5XWofPcoFkB5fT1DE88AUIl
v0WmSDy5e6exw07VqwV597OmOK7MFNNwtikfviBlx5PhwxXHrGYqs0p2tJG7pCwU
cKY3/rcfsJ2bZck2YluzElqjQi1TLvPfOSQperbnXeqARHFS9O1OtiCe/6ETPwZ0
kNzce5scCre49RsChtSt+ETBhyCGni3CMLOspmTiKleYxJaWRajy0r3kahkLDu/7
zr/8TIJgLav7Ae83Q/V5l+wMhdYlQzULCrOeUdFx5MDBkdzAjgUHOEjWHXpBxUJg
DpeBrmuB92Pg8AXzVY/0pyX9Rbpdm2Z5rdemSgr4qiAUiQxSYUAaT+vnzk7f2hWl
iviyX2b4YyajWgjjO1mMI+sAOhhWdA2FpfSts/X+A3AxXIkkk3xlY9/qoLXSxhkc
EVHyhCvh5KvsSyGNVNZOxHhYliFEI2sFC1Fx/9Z1iSbBNpIlWpnvE/KTxz8H6i7T
Y0+gQq72iwYnCWGfubX0dhuFLVAqzACLy2ndU6lITIenDzYfJ4c=
=4q+M
-----END PGP SIGNATURE-----

--wrmaps5v6sihusbv--
