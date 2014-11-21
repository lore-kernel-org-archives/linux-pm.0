From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 1/1] thermal: Exynos: Deletion of unnecessary checks
 before two function calls
Date: Fri, 21 Nov 2014 11:17:15 +0100 (CET)
Message-ID: <alpine.DEB.2.10.1411211116580.2554@hadrien>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <546F1017.5080403@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:46227
	"EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758422AbaKUKRk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Nov 2014 05:17:40 -0500
In-Reply-To: <546F1017.5080403@users.sourceforge.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

On Fri, 21 Nov 2014, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 21 Nov 2014 11:06:33 +0100
>
> The functions cpufreq_cooling_unregister() and thermal_zone_device_unregister()
> test whether their argument is NULL and then return immediately.
> Thus the test around the call is not needed.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/thermal/samsung/exynos_thermal_common.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/samsung/exynos_thermal_common.c b/drivers/thermal/samsung/exynos_thermal_common.c
> index 3f5ad25..1cbb9d0 100644
> --- a/drivers/thermal/samsung/exynos_thermal_common.c
> +++ b/drivers/thermal/samsung/exynos_thermal_common.c
> @@ -417,12 +417,10 @@ void exynos_unregister_thermal(struct thermal_sensor_conf *sensor_conf)
>
>  	th_zone = sensor_conf->pzone_data;
>
> -	if (th_zone->therm_dev)
> -		thermal_zone_device_unregister(th_zone->therm_dev);
> +	thermal_zone_device_unregister(th_zone->therm_dev);
>
>  	for (i = 0; i < th_zone->cool_dev_size; i++) {
> -		if (th_zone->cool_dev[i])
> -			cpufreq_cooling_unregister(th_zone->cool_dev[i]);
> +		cpufreq_cooling_unregister(th_zone->cool_dev[i]);
>  	}

Now you have unnecessary {}

julia

>
>  	dev_info(sensor_conf->dev,
> --
> 2.1.3
>
>
