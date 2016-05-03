From: Caesar Wang <caesar.upstream@gmail.com>
Subject: Re: [PATCH 1/4] thermal: Add support for hardware-tracked trip points
Date: Tue, 3 May 2016 17:25:47 +0800
Message-ID: <57286E9B.5060804@gmail.com>
References: <1461553367-24744-1-git-send-email-wxt@rock-chips.com>
 <1461553367-24744-2-git-send-email-wxt@rock-chips.com>
 <20160427214843.GA6438@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34602 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932223AbcECJ0E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 May 2016 05:26:04 -0400
In-Reply-To: <20160427214843.GA6438@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Caesar Wang <wxt@rock-chips.com>, huangtao@rock-chips.com, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, dmitry.torokhov@gmail.com, dianders@chromium.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, eddie.cai@rock-chips.com, smbarber@google.com, briannorris@google.com, Zhang Rui <rui.zhang@intel.com>



=E5=9C=A8 2016=E5=B9=B404=E6=9C=8828=E6=97=A5 05:48, Eduardo Valentin =E5=
=86=99=E9=81=93:
> This patch is based on an earlier version from Mikko Perttunen
> <mikko.perttunen@kapsi.fi>
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: linux-pm@vger.kernel.org
> ---
>
>   drivers/thermal/thermal_core.c | 48 +++++++++++++++++++++++++++++++=
+++++++++++
>   include/linux/thermal.h        |  3 +++
>>
>
>   static void update_temperature(struct thermal_zone_device *tz)
>   {
>   	int temp, ret;
> @@ -569,6 +610,8 @@ void thermal_zone_device_update(struct thermal_zo=
ne_device *tz)
>  =20
>   	update_temperature(tz);
>  =20
> +	thermal_zone_set_trips(tz);
> +
>   	for (count =3D 0; count < tz->trips; count++)
>   		handle_thermal_trip(tz, count);
>   }
> @@ -754,6 +797,9 @@ trip_point_hyst_store(struct device *dev, struct =
device_attribute *attr,
>   	 */
>   	ret =3D tz->ops->set_trip_hyst(tz, trip, temperature);
>  =20
> +	if (!ret)
> +		thermal_zone_set_trips(tz);
> +
> You would probably want to do the same on trip_point_temp_store().
>

Sorry, that has been set in thermal_zone_device_update().

static ssize_t trip_point_temp_store()
{
     ..
     thermal_zone_device_update(tz);
     ..
}

> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


--=20
Thanks,
Caesar

