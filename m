From: Anson Huang <anson.huang@nxp.com>
Subject: RE: [PATCH] thermal: of-thermal: disable passive polling when thermal
 zone is disabled
Date: Fri, 24 Aug 2018 07:10:13 +0000
Message-ID: <DB3PR0402MB39168BB2C854A55401D4C648F5360@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1532969809-8300-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532969809-8300-1-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, Nitin Garg <nitin.garg@nxp.com>
List-Id: linux-pm@vger.kernel.org

Gentle Ping...

Anson Huang
Best Regards!


> -----Original Message-----
> From: Anson Huang
> Sent: Tuesday, July 31, 2018 12:57 AM
> To: rui.zhang@intel.com; edubezval@gmail.com; linux-pm@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Cc: dl-linux-imx <linux-imx@nxp.com>; Nitin Garg <nitin.garg@nxp.com>
> Subject: [PATCH] thermal: of-thermal: disable passive polling when therma=
l
> zone is disabled
>=20
> When thermal zone is in passive mode, disabling its mode from sysfs is NO=
T
> taking effect at all, it is still polling the temperature of the disabled=
 thermal
> zone and handling all thermal trips, it makes user confused. The disablin=
g
> operation should disable the thermal zone behavior completely, for both a=
ctive
> and passive mode, this patch clears the passive_delay when thermal zone i=
s
> disabled and restores it when it is enabled.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/thermal/of-thermal.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c =
index
> 977a830..4f28165 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -260,10 +260,13 @@ static int of_thermal_set_mode(struct
> thermal_zone_device *tz,
>=20
>  	mutex_lock(&tz->lock);
>=20
> -	if (mode =3D=3D THERMAL_DEVICE_ENABLED)
> +	if (mode =3D=3D THERMAL_DEVICE_ENABLED) {
>  		tz->polling_delay =3D data->polling_delay;
> -	else
> +		tz->passive_delay =3D data->passive_delay;
> +	} else {
>  		tz->polling_delay =3D 0;
> +		tz->passive_delay =3D 0;
> +	}
>=20
>  	mutex_unlock(&tz->lock);
>=20
> --
> 2.7.4
