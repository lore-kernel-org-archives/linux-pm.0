From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/7] power: supply: ab8500_btemp: convert to IIO ADC
Date: Thu, 12 Jan 2017 04:02:40 +0100
Message-ID: <20170112030240.5vzyut7vqbtqnnvf@earth>
References: <20170110234745.29691-1-linus.walleij@linaro.org>
 <20170110234745.29691-2-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3crr2eiqgdupgn4w"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170110234745.29691-2-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Mboumba Cedric Madianga <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--3crr2eiqgdupgn4w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 11, 2017 at 12:47:39AM +0100, Linus Walleij wrote:
> This switches the AB8500 battery temperature driver to using
> the standard IIO ADC channel lookup and conversion routines.
>=20
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Acked-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

-- Sebastian

>  drivers/power/supply/ab8500_btemp.c | 41 ++++++++++++++++++++++++++-----=
------
>  1 file changed, 29 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/a=
b8500_btemp.c
> index 6ffdc18f2599..61161db5cffa 100644
> --- a/drivers/power/supply/ab8500_btemp.c
> +++ b/drivers/power/supply/ab8500_btemp.c
> @@ -26,7 +26,7 @@
>  #include <linux/mfd/abx500.h>
>  #include <linux/mfd/abx500/ab8500.h>
>  #include <linux/mfd/abx500/ab8500-bm.h>
> -#include <linux/mfd/abx500/ab8500-gpadc.h>
> +#include <linux/iio/consumer.h>
> =20
>  #define VTVOUT_V			1800
> =20
> @@ -79,7 +79,8 @@ struct ab8500_btemp_ranges {
>   * @bat_temp:		Dispatched battery temperature in degree Celcius
>   * @prev_bat_temp	Last measured battery temperature in degree Celcius
>   * @parent:		Pointer to the struct ab8500
> - * @gpadc:		Pointer to the struct gpadc
> + * @adc_btemp_ball:	ADC channel for the battery ball temperature
> + * @adc_bat_ctrl:	ADC channel for the battery control
>   * @fg:			Pointer to the struct fg
>   * @bm:           	Platform specific battery management information
>   * @btemp_psy:		Structure for BTEMP specific battery properties
> @@ -96,7 +97,8 @@ struct ab8500_btemp {
>  	int bat_temp;
>  	int prev_bat_temp;
>  	struct ab8500 *parent;
> -	struct ab8500_gpadc *gpadc;
> +	struct iio_channel *btemp_ball;
> +	struct iio_channel *bat_ctrl;
>  	struct ab8500_fg *fg;
>  	struct abx500_bm_data *bm;
>  	struct power_supply *btemp_psy;
> @@ -180,13 +182,13 @@ static int ab8500_btemp_batctrl_volt_to_res(struct =
ab8500_btemp *di,
>   */
>  static int ab8500_btemp_read_batctrl_voltage(struct ab8500_btemp *di)
>  {
> -	int vbtemp;
> +	int vbtemp, ret;
>  	static int prev;
> =20
> -	vbtemp =3D ab8500_gpadc_convert(di->gpadc, BAT_CTRL);
> -	if (vbtemp < 0) {
> +	ret =3D iio_read_channel_processed(di->bat_ctrl, &vbtemp);
> +	if (ret < 0) {
>  		dev_err(di->dev,
> -			"%s gpadc conversion failed, using previous value",
> +			"%s ADC conversion failed, using previous value",
>  			__func__);
>  		return prev;
>  	}
> @@ -501,7 +503,7 @@ static int ab8500_btemp_res_to_temp(struct ab8500_bte=
mp *di,
>   */
>  static int ab8500_btemp_measure_temp(struct ab8500_btemp *di)
>  {
> -	int temp;
> +	int temp, ret;
>  	static int prev;
>  	int rbat, rntc, vntc;
>  	u8 id;
> @@ -526,10 +528,10 @@ static int ab8500_btemp_measure_temp(struct ab8500_=
btemp *di)
>  			di->bm->bat_type[id].r_to_t_tbl,
>  			di->bm->bat_type[id].n_temp_tbl_elements, rbat);
>  	} else {
> -		vntc =3D ab8500_gpadc_convert(di->gpadc, BTEMP_BALL);
> -		if (vntc < 0) {
> +		ret =3D iio_read_channel_processed(di->btemp_ball, &vntc);
> +		if (ret < 0) {
>  			dev_err(di->dev,
> -				"%s gpadc conversion failed,"
> +				"%s ADC conversion failed,"
>  				" using previous value\n", __func__);
>  			return prev;
>  		}
> @@ -1085,7 +1087,22 @@ static int ab8500_btemp_probe(struct platform_devi=
ce *pdev)
>  	/* get parent data */
>  	di->dev =3D &pdev->dev;
>  	di->parent =3D dev_get_drvdata(pdev->dev.parent);
> -	di->gpadc =3D ab8500_gpadc_get("ab8500-gpadc.0");
> +
> +	/* Get ADC channels */
> +	di->btemp_ball =3D devm_iio_channel_get(&pdev->dev, "btemp_ball");
> +	if (IS_ERR(di->btemp_ball)) {
> +		if (PTR_ERR(di->btemp_ball) =3D=3D -ENODEV)
> +                        return -EPROBE_DEFER;
> +		dev_err(&pdev->dev, "failed to get BTEMP BALL ADC channel\n");
> +		return PTR_ERR(di->btemp_ball);
> +	}
> +	di->bat_ctrl =3D devm_iio_channel_get(&pdev->dev, "bat_ctrl");
> +	if (IS_ERR(di->bat_ctrl)) {
> +		if (PTR_ERR(di->bat_ctrl) =3D=3D -ENODEV)
> +                        return -EPROBE_DEFER;
> +		dev_err(&pdev->dev, "failed to get BAT CTRL ADC channel\n");
> +		return PTR_ERR(di->bat_ctrl);
> +	}
> =20
>  	di->initialized =3D false;
> =20
> --=20
> 2.9.3
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--3crr2eiqgdupgn4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh28dAACgkQ2O7X88g7
+pp8ZhAAmw//2D87BKa+tpP7uJbhS8ZL50gnj/v1/iMiy5LYrKnm4B7XLScEZC6Z
H3/duJ2c6Zjcj9NELg4siuswBuyWYPXVmadJ6KD9Q6wPm/v57yYcnKXQE9DCmM9F
FmZ8zDIpQN65Ftji7D1Y64WVD6Pzkb9Z4IyMqmVNhLCJSO9lJ6fQtG4n/oHQiTYo
O7jAGHfxNwm02VyizWBpkDW9dASzWar6rSilYS9IPRHc8cUUjggQgiyZiRD+lMU0
tUtNxamxG38jYz9unGkcz2Oqsg2WVrTyACECRB3CiisIGgip7lm3LaLcYWOmUN9m
MERfd1q1eGOaDK9Uuc/1oqq6ll+BisdSf2ZOCpJOEze3dDWh7DzRFl6AEj6K/ypO
agD+38vA/k0ZG1+I/KhDoUfsg4KtTrWVyQByA1fmUql9e/ja1pLsuRXLM3lCZqxd
dvMp1Kj9Xy6XkZDraQ1eKe3l5xlljUKewpqkrcc07+OXwHrQDghQpYo8/czdvBps
gbemUBIvTmK/H7LebPyGirvk3ISjvcr12TCfn+uvBhuVCJC9lIi5Izm5Cqe55lYg
DUCizAf5YjIniXD+974mx5juJEyJ9OhXRY41sdoh0RrNlaMfqE2ug0VMMdiPjTDv
czkynEqBFM0CPRLX2B+rPLnfslqfwyTfFuxykqS9P1KdnwWbc+0=
=AWWQ
-----END PGP SIGNATURE-----

--3crr2eiqgdupgn4w--
