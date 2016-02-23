From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH v6 07/12] thermal: of-thermal: allow setting trip_temp
 on hardware
Date: Tue, 23 Feb 2016 10:16:37 +0800
Message-ID: <56CBC105.6080703@nvidia.com>
References: <1456128555-29058-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12821 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754795AbcBWCQY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2016 21:16:24 -0500
In-Reply-To: <1456128555-29058-1-git-send-email-wni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: thierry.reding@gmail.com, edubezval@gmail.com, rui.zhang@intel.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Add linux-pm@vger.kernel.org in the CC list.

On 2016=E5=B9=B402=E6=9C=8822=E6=97=A5 16:09, Wei Ni wrote:
> In current of-thermal, the .set_trip_temp only support to
> set trip_temp for SW. But some sensors support to set
> trip_temp on hardware, so that can trigger interrupt,
> shutdown or any other events.
> This patch adds .set_trip_temp() callback in
> thermal_zone_of_device_ops{}, so that the sensor device can
> use it to set trip_temp on hardware.
>=20
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/thermal/of-thermal.c | 8 ++++++++
>  include/linux/thermal.h      | 1 +
>  2 files changed, 9 insertions(+)
>=20
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-therma=
l.c
> index be4eedcb839a..fbfc5a52dc27 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -331,6 +331,14 @@ static int of_thermal_set_trip_temp(struct therm=
al_zone_device *tz, int trip,
>  	if (trip >=3D data->ntrips || trip < 0)
>  		return -EDOM;
> =20
> +	if (data->ops->set_trip_temp) {
> +		int ret;
> +
> +		ret =3D data->ops->set_trip_temp(data->sensor_data, trip, temp);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	/* thermal framework should take care of data->mask & (1 << trip) *=
/
>  	data->trips[trip].temperature =3D temp;
> =20
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index e13a1ace50e9..e69296dc583b 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -338,6 +338,7 @@ struct thermal_zone_of_device_ops {
>  	int (*get_temp)(void *, int *);
>  	int (*get_trend)(void *, long *);
>  	int (*set_emul_temp)(void *, int);
> +	int (*set_trip_temp)(void *, int, int);
>  };
> =20
>  /**
>=20
