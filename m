From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] Thermal: imx: correct critical trip temperature setting
Date: Mon, 30 Jun 2014 10:24:27 +0800
Message-ID: <1404095067.2289.6.camel@rzhang1-toshiba>
References: <1403247786-19899-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15934 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753472AbaF3CYb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 29 Jun 2014 22:24:31 -0400
In-Reply-To: <1403247786-19899-1-git-send-email-b20788@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anson Huang <b20788@freescale.com>
Cc: eduardo.valentin@ti.com, linux-pm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>

On Fri, 2014-06-20 at 15:03 +0800, Anson Huang wrote:
> On latest i.MX6 SOC with thermal calibration data of 0x5A100000,
> the critical trip temperature will be an invalid value and
> cause system auto shutdown as below log:
>=20
> thermal thermal_zone0: critical temperature reached(42 C),shutting do=
wn
>=20
> So, with universal formula for thermal sensor, only room
> temperature point is calibrated, which means the calibration
> data read from fuse only has valid data of bit [31:20], others
> are all 0, the critical trip point temperature can NOT depend
> on the hot point calibration data, here we set it to 20 C higher
> than default passive temperature.
>=20
> Signed-off-by: Anson Huang <b20788@freescale.com>

Shawn,
what do you think of this patch?

Eduardo,
have you picked this patch? If not, I will queue it for rc4.

thanks,
rui
> ---
>  drivers/thermal/imx_thermal.c |   18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_ther=
mal.c
> index a99c631..2c516f2 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -306,7 +306,7 @@ static int imx_get_sensor_data(struct platform_de=
vice *pdev)
>  {
>  	struct imx_thermal_data *data =3D platform_get_drvdata(pdev);
>  	struct regmap *map;
> -	int t1, t2, n1, n2;
> +	int t1, n1;
>  	int ret;
>  	u32 val;
>  	u64 temp64;
> @@ -333,14 +333,10 @@ static int imx_get_sensor_data(struct platform_=
device *pdev)
>  	/*
>  	 * Sensor data layout:
>  	 *   [31:20] - sensor value @ 25C
> -	 *    [19:8] - sensor value of hot
> -	 *     [7:0] - hot temperature value
>  	 * Use universal formula now and only need sensor value @ 25C
>  	 * slope =3D 0.4297157 - (0.0015976 * 25C fuse)
>  	 */
>  	n1 =3D val >> 20;
> -	n2 =3D (val & 0xfff00) >> 8;
> -	t2 =3D val & 0xff;
>  	t1 =3D 25; /* t1 always 25C */
> =20
>  	/*
> @@ -366,16 +362,16 @@ static int imx_get_sensor_data(struct platform_=
device *pdev)
>  	data->c2 =3D n1 * data->c1 + 1000 * t1;
> =20
>  	/*
> -	 * Set the default passive cooling trip point to 20 =C2=B0C below t=
he
> -	 * maximum die temperature. Can be changed from userspace.
> +	 * Set the default passive cooling trip point,
> +	 * can be changed from userspace.
>  	 */
> -	data->temp_passive =3D 1000 * (t2 - 20);
> +	data->temp_passive =3D IMX_TEMP_PASSIVE;
> =20
>  	/*
> -	 * The maximum die temperature is t2, let's give 5 =C2=B0C cushion
> -	 * for noise and possible temperature rise between measurements.
> +	 * The maximum die temperature set to 20 C higher than
> +	 * IMX_TEMP_PASSIVE.
>  	 */
> -	data->temp_critical =3D 1000 * (t2 - 5);
> +	data->temp_critical =3D 1000 * 20 + data->temp_passive;
> =20
>  	return 0;
>  }


