From: "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH] thermal: imx: Fix race condition in imx_thermal_probe()
Date: Wed, 28 Feb 2018 02:16:41 +0000
Message-ID: <AM3PR04MB3060F3219741769E5CA64DB80C70@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1517595466-23465-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1517595466-23465-1-git-send-email-festevam@gmail.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>
Cc: "edubezval@gmail.com" <edubezval@gmail.com>, "mikhail.lappo@esrlabs.com" <mikhail.lappo@esrlabs.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: linux-pm@vger.kernel.org

> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Sent: Saturday, February 3, 2018 2:18 AM
> To: rui.zhang@intel.com
> Cc: edubezval@gmail.com; mikhail.lappo@esrlabs.com; linux-
> pm@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> p.zabel@pengutronix.de; shawnguo@kernel.org; stable@vger.kernel.org;
> Fabio Estevam <fabio.estevam@nxp.com>
> Subject: [PATCH] thermal: imx: Fix race condition in imx_thermal_probe()
>=20
> From: Mikhail Lappo <mikhail.lappo@esrlabs.com>
>=20
> When device boots with T > T_trip_1 and requests interrupt, the race
> condition takes place. The interrupt comes before
> THERMAL_DEVICE_ENABLED is set. This leads to an attempt to reading
> sensor value from irq and disabling the sensor, based on the data->mode
> field, which expected to be THERMAL_DEVICE_ENABLED, but still stays as
> THERMAL_DEVICE_DISABLED. Afher this issue sensor is never re-enabled, as
> the driver state is wrong.
>=20
> Fix this problem by setting the 'data' members prior to requesting the
> interrupts.
>=20
> Fixes: 37713a1e8e4c ("thermal: imx: implement thermal alarm interrupt
> handling")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Mikhail Lappo <mikhail.lappo@esrlabs.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Looks reasonable to me.
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> ---
>  drivers/thermal/imx_thermal.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.=
c
> index a67781b..ee3a215 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -637,6 +637,9 @@ static int imx_thermal_probe(struct platform_device
> *pdev)
>  	regmap_write(map, TEMPSENSE0 + REG_CLR,
> TEMPSENSE0_POWER_DOWN);
>  	regmap_write(map, TEMPSENSE0 + REG_SET,
> TEMPSENSE0_MEASURE_TEMP);
>=20
> +	data->irq_enabled =3D true;
> +	data->mode =3D THERMAL_DEVICE_ENABLED;
> +
>  	ret =3D devm_request_threaded_irq(&pdev->dev, data->irq,
>  			imx_thermal_alarm_irq,
> imx_thermal_alarm_irq_thread,
>  			0, "imx_thermal", data);
> @@ -649,9 +652,6 @@ static int imx_thermal_probe(struct platform_device
> *pdev)
>  		return ret;
>  	}
>=20
> -	data->irq_enabled =3D true;
> -	data->mode =3D THERMAL_DEVICE_ENABLED;
> -
>  	return 0;
>  }
>=20
> --
> 2.7.4
