From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/2] thermal: exynos_thermal: return a proper error code
 while thermal_zone_device_register fail.
Date: Mon, 11 Mar 2013 22:47:34 +0800
Message-ID: <1363013254.2291.81.camel@rzhang1-mobl4>
References: <1362415968-2210-1-git-send-email-devendra.aaru@gmail.com>
	 <1362415968-2210-2-git-send-email-devendra.aaru@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:50387 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266Ab3CKOrj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Mar 2013 10:47:39 -0400
In-Reply-To: <1362415968-2210-2-git-send-email-devendra.aaru@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Devendra Naga <devendra.aaru@gmail.com>
Cc: linux-pm@vger.kernel.org

On Mon, 2013-03-04 at 11:52 -0500, Devendra Naga wrote:
> we are returning EINVAL while the thermal_zone_device_register function fail.
> instead we can use the return value from the thermal_zone_device_register by
> using PTR_ERR.
> 
> Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>

applied to thermal -next.

thanks,
rui
> ---
>  drivers/thermal/exynos_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
> index e04ebd8..46568c0 100644
> --- a/drivers/thermal/exynos_thermal.c
> +++ b/drivers/thermal/exynos_thermal.c
> @@ -476,7 +476,7 @@ static int exynos_register_thermal(struct thermal_sensor_conf *sensor_conf)
>  
>  	if (IS_ERR(th_zone->therm_dev)) {
>  		pr_err("Failed to register thermal zone device\n");
> -		ret = -EINVAL;
> +		ret = PTR_ERR(th_zone->therm_dev);
>  		goto err_unregister;
>  	}
>  	th_zone->mode = THERMAL_DEVICE_ENABLED;


