From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] thermal: imx: update formula for thermal sensor
Date: Thu, 13 Feb 2014 21:02:54 +0800
Message-ID: <20140213130252.GB20842@S2101-09.ap.freescale.net>
References: <1392199595-1054-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]:29655
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752760AbaBMNCJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 13 Feb 2014 08:02:09 -0500
Content-Disposition: inline
In-Reply-To: <1392199595-1054-1-git-send-email-b20788@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anson Huang <b20788@freescale.com>
Cc: rui.zhang@intel.com, eduardo.valentin@ti.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

Copy LAKML and pengutronix folks in case they have comments.

On Wed, Feb 12, 2014 at 06:06:35PM +0800, Anson Huang wrote:
> Thermal sensor used to need two calibration points which are
> in fuse map to get a slope for converting thermal sensor's raw
> data to real temperature in degree C. Due to the chip calibration
> limitation, hardware team provides an universal formula to get
> real temperature from internal thermal sensor raw data:
>=20
> Slope =3D 0.4297157 - (0.0015976 * 25C fuse);
>=20
> Update the formula, as there will be no hot point calibration
> data in fuse map from now on.
>=20
> Signed-off-by: Anson Huang <b20788@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Shawn

> ---
>  drivers/thermal/imx_thermal.c |   39 ++++++++++++++++++++++++++-----=
--------
>  1 file changed, 26 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_ther=
mal.c
> index 45af765..a99c631 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -62,12 +62,16 @@ enum imx_thermal_trip {
>  #define IMX_POLLING_DELAY		2000 /* millisecond */
>  #define IMX_PASSIVE_DELAY		1000
> =20
> +#define FACTOR0				10000000
> +#define FACTOR1				15976
> +#define FACTOR2				4297157
> +
>  struct imx_thermal_data {
>  	struct thermal_zone_device *tz;
>  	struct thermal_cooling_device *cdev;
>  	enum thermal_device_mode mode;
>  	struct regmap *tempmon;
> -	int c1, c2; /* See formula in imx_get_sensor_data() */
> +	u32 c1, c2; /* See formula in imx_get_sensor_data() */
>  	unsigned long temp_passive;
>  	unsigned long temp_critical;
>  	unsigned long alarm_temp;
> @@ -84,7 +88,7 @@ static void imx_set_alarm_temp(struct imx_thermal_d=
ata *data,
>  	int alarm_value;
> =20
>  	data->alarm_temp =3D alarm_temp;
> -	alarm_value =3D (alarm_temp - data->c2) / data->c1;
> +	alarm_value =3D (data->c2 - alarm_temp) / data->c1;
>  	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_ALARM_VALUE_MASK=
);
>  	regmap_write(map, TEMPSENSE0 + REG_SET, alarm_value <<
>  			TEMPSENSE0_ALARM_VALUE_SHIFT);
> @@ -136,7 +140,7 @@ static int imx_get_temp(struct thermal_zone_devic=
e *tz, unsigned long *temp)
>  	n_meas =3D (val & TEMPSENSE0_TEMP_CNT_MASK) >> TEMPSENSE0_TEMP_CNT_=
SHIFT;
> =20
>  	/* See imx_get_sensor_data() for formula derivation */
> -	*temp =3D data->c2 + data->c1 * n_meas;
> +	*temp =3D data->c2 - n_meas * data->c1;
> =20
>  	/* Update alarm value to next higher trip point */
>  	if (data->alarm_temp =3D=3D data->temp_passive && *temp >=3D data->=
temp_passive)
> @@ -305,6 +309,7 @@ static int imx_get_sensor_data(struct platform_de=
vice *pdev)
>  	int t1, t2, n1, n2;
>  	int ret;
>  	u32 val;
> +	u64 temp64;
> =20
>  	map =3D syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
>  					      "fsl,tempmon-data");
> @@ -330,6 +335,8 @@ static int imx_get_sensor_data(struct platform_de=
vice *pdev)
>  	 *   [31:20] - sensor value @ 25C
>  	 *    [19:8] - sensor value of hot
>  	 *     [7:0] - hot temperature value
> +	 * Use universal formula now and only need sensor value @ 25C
> +	 * slope =3D 0.4297157 - (0.0015976 * 25C fuse)
>  	 */
>  	n1 =3D val >> 20;
>  	n2 =3D (val & 0xfff00) >> 8;
> @@ -337,20 +344,26 @@ static int imx_get_sensor_data(struct platform_=
device *pdev)
>  	t1 =3D 25; /* t1 always 25C */
> =20
>  	/*
> -	 * Derived from linear interpolation,
> -	 * Tmeas =3D T2 + (Nmeas - N2) * (T1 - T2) / (N1 - N2)
> +	 * Derived from linear interpolation:
> +	 * slope =3D 0.4297157 - (0.0015976 * 25C fuse)
> +	 * slope =3D (FACTOR2 - FACTOR1 * n1) / FACTOR0
> +	 * (Nmeas - n1) / (Tmeas - t1) =3D slope
>  	 * We want to reduce this down to the minimum computation necessary
>  	 * for each temperature read.  Also, we want Tmeas in millicelsius
>  	 * and we don't want to lose precision from integer division. So...
> -	 * milli_Tmeas =3D 1000 * T2 + 1000 * (Nmeas - N2) * (T1 - T2) / (N=
1 - N2)
> -	 * Let constant c1 =3D 1000 * (T1 - T2) / (N1 - N2)
> -	 * milli_Tmeas =3D (1000 * T2) + c1 * (Nmeas - N2)
> -	 * milli_Tmeas =3D (1000 * T2) + (c1 * Nmeas) - (c1 * N2)
> -	 * Let constant c2 =3D (1000 * T2) - (c1 * N2)
> -	 * milli_Tmeas =3D c2 + (c1 * Nmeas)
> +	 * Tmeas =3D (Nmeas - n1) / slope + t1
> +	 * milli_Tmeas =3D 1000 * (Nmeas - n1) / slope + 1000 * t1
> +	 * milli_Tmeas =3D -1000 * (n1 - Nmeas) / slope + 1000 * t1
> +	 * Let constant c1 =3D (-1000 / slope)
> +	 * milli_Tmeas =3D (n1 - Nmeas) * c1 + 1000 * t1
> +	 * Let constant c2 =3D n1 *c1 + 1000 * t1
> +	 * milli_Tmeas =3D c2 - Nmeas * c1
>  	 */
> -	data->c1 =3D 1000 * (t1 - t2) / (n1 - n2);
> -	data->c2 =3D 1000 * t2 - data->c1 * n2;
> +	temp64 =3D FACTOR0;
> +	temp64 *=3D 1000;
> +	do_div(temp64, FACTOR1 * n1 - FACTOR2);
> +	data->c1 =3D temp64;
> +	data->c2 =3D n1 * data->c1 + 1000 * t1;
> =20
>  	/*
>  	 * Set the default passive cooling trip point to 20 =B0C below the
> --=20
> 1.7.9.5
>=20
>=20

