From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/7] power: supply: ab8500_fg: convert to IIO ADC
Date: Thu, 12 Jan 2017 04:03:20 +0100
Message-ID: <20170112030320.yozvhsu2m4lmq2vo@earth>
References: <20170110234745.29691-1-linus.walleij@linaro.org>
 <20170110234745.29691-4-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7hksuxsxd5sezazi"
Return-path: <linux-hwmon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170110234745.29691-4-linus.walleij@linaro.org>
Sender: linux-hwmon-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Mboumba Cedric Madianga <cedric.madianga@gmail.com>, linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--7hksuxsxd5sezazi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 11, 2017 at 12:47:41AM +0100, Linus Walleij wrote:
> This switches the AB8500 fuel gauge driver to using
> the standard IIO ADC channel lookup and conversion routines.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

>  drivers/power/supply/ab8500_fg.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab85=
00_fg.c
> index c569f82a0071..b26122e1da51 100644
> --- a/drivers/power/supply/ab8500_fg.c
> +++ b/drivers/power/supply/ab8500_fg.c
> @@ -32,7 +32,7 @@
>  #include <linux/mfd/abx500.h>
>  #include <linux/mfd/abx500/ab8500.h>
>  #include <linux/mfd/abx500/ab8500-bm.h>
> -#include <linux/mfd/abx500/ab8500-gpadc.h>
> +#include <linux/iio/consumer.h>
>  #include <linux/kernel.h>
> =20
>  #define MILLI_TO_MICRO			1000
> @@ -182,7 +182,7 @@ struct inst_curr_result_list {
>   * @bat_cap:		Structure for battery capacity specific parameters
>   * @avg_cap:		Average capacity filter
>   * @parent:		Pointer to the struct ab8500
> - * @gpadc:		Pointer to the struct gpadc
> + * @main_bat_v:		ADC channel for the main battery voltage
>   * @bm:           	Platform specific battery management information
>   * @fg_psy:		Structure that holds the FG specific battery properties
>   * @fg_wq:		Work queue for running the FG algorithm
> @@ -224,7 +224,7 @@ struct ab8500_fg {
>  	struct ab8500_fg_battery_capacity bat_cap;
>  	struct ab8500_fg_avg_cap avg_cap;
>  	struct ab8500 *parent;
> -	struct ab8500_gpadc *gpadc;
> +	struct iio_channel *main_bat_v;
>  	struct abx500_bm_data *bm;
>  	struct power_supply *fg_psy;
>  	struct workqueue_struct *fg_wq;
> @@ -831,13 +831,13 @@ static void ab8500_fg_acc_cur_work(struct work_stru=
ct *work)
>   */
>  static int ab8500_fg_bat_voltage(struct ab8500_fg *di)
>  {
> -	int vbat;
> +	int vbat, ret;
>  	static int prev;
> =20
> -	vbat =3D ab8500_gpadc_convert(di->gpadc, MAIN_BAT_V);
> -	if (vbat < 0) {
> +	ret =3D iio_read_channel_processed(di->main_bat_v, &vbat);
> +	if (ret < 0) {
>  		dev_err(di->dev,
> -			"%s gpadc conversion failed, using previous value\n",
> +			"%s ADC conversion failed, using previous value\n",
>  			__func__);
>  		return prev;
>  	}
> @@ -3072,7 +3072,14 @@ static int ab8500_fg_probe(struct platform_device =
*pdev)
>  	/* get parent data */
>  	di->dev =3D &pdev->dev;
>  	di->parent =3D dev_get_drvdata(pdev->dev.parent);
> -	di->gpadc =3D ab8500_gpadc_get("ab8500-gpadc.0");
> +
> +	di->main_bat_v =3D devm_iio_channel_get(&pdev->dev, "main_bat_v");
> +	if (IS_ERR(di->main_bat_v)) {
> +		if (PTR_ERR(di->main_bat_v) =3D=3D -ENODEV)
> +                        return -EPROBE_DEFER;
> +		dev_err(&pdev->dev, "failed to get main battery ADC channel\n");
> +		return PTR_ERR(di->main_bat_v);
> +	}
> =20
>  	psy_cfg.supplied_to =3D supply_interface;
>  	psy_cfg.num_supplicants =3D ARRAY_SIZE(supply_interface);
> --=20
> 2.9.3
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--7hksuxsxd5sezazi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh28fgACgkQ2O7X88g7
+ppc1hAApBDx66m1gAqFUcB91aeH4SwSNQF2CVLXKm9JHf9EoaKF4ajiUPDXq9Sd
iQKRvNCc2/ZAnWBmI3noqaigp1cN/SvvtCJ2sXBKt5Ig8jiqfyZLIWV9AiBpuc08
Z9IReZ3SWtiIkseWnrnsedyvJ47NtKa5+XM/KFUlanTXT9a5V2ywj6Sgtw1oWDL6
aA4V5e/qFzq/caFccZUgNyOxZepVwwIlUgkOKl1OdRVkd9IEg/Meb+esD8fq5v6j
uRybkbCXa5oQOiEf0LoFOGEB0BTs2Xd9NrWobTpaqqqGDyHWqzWqFb+EQhM07f95
EtC7GPNCkasGhofnnGI7jHDIngtke7rpRZXcb+ZpBoKLqoxTfEBpFmTlXpdgu4Yq
hZnUpncTTq4grEn9d5eiKkxzyk5jwVg8EcwMuRQUrBHwyqRbXnqe98wWkiIBUQDX
sK88MDs5RQSa3UJv2dl7+//kDipHOlBrefwc5h1WF+3uNigWKt91m/cmICJPVLWE
kfW3wQpHzIFkZIGn57+Rjyn2K0faj1NufEayd9oO3G4dzrsqliLUYCdfs8WtWNFT
W6Sy358UMG0uwW8GVVXCXQtUxjCCDUKyQU9ZIUQIXaSlyCXrq7qGSFtpNK0EkyVB
2aIKnTqWllfyQ0Zi6NdnvmaBjQTVJFvcui+wbGipA3gUUUpaJuU=
=WstT
-----END PGP SIGNATURE-----

--7hksuxsxd5sezazi--
