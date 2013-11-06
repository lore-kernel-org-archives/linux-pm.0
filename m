From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: Fix binding problem when there is thermal zone
 params
Date: Wed, 06 Nov 2013 13:29:12 +0800
Message-ID: <1383715752.2073.11.camel@rzhang1-mobl4>
References: <1382090587-9602-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:4126 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747Ab3KFF3S (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 6 Nov 2013 00:29:18 -0500
In-Reply-To: <1382090587-9602-1-git-send-email-wni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: durgadoss.r@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Jinyoung Park <jinyoungp@nvidia.com>

On Fri, 2013-10-18 at 18:03 +0800, Wei Ni wrote:
> The thermal zone params can be used to set governor
> to specific thermal governor for thermal zone device.
> But if the thermal zone params has only governor name
> without thermal bind params, then the thermal zone device
> will not be binding to cooling device. Because tz->ops->bind
> operator is not invoked in bind_tz() and bind_cdev() when
> there is thermal zone params.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> Signed-off-by: Jinyoung Park <jinyoungp@nvidia.com>
> ---
>  drivers/thermal/thermal_core.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 4962a6a..2ea41d3 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -247,7 +247,7 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
>  		if (!pos->tzp && !pos->ops->bind)
>  			continue;
>  
> -		if (!pos->tzp && pos->ops->bind) {
> +		if (pos->ops->bind) {
>  			ret = pos->ops->bind(pos, cdev);
>  			if (ret)
>  				print_bind_err_msg(pos, cdev, ret);
IMO, we should also add
+		continue;
after binding with pos->ops->bind(), to void binding via pos->tzp->tbp
again, no?

thanks,
rui
> @@ -282,8 +282,8 @@ static void bind_tz(struct thermal_zone_device *tz)
>  
>  	mutex_lock(&thermal_list_lock);
>  
> -	/* If there is no platform data, try to use ops->bind */
> -	if (!tzp && tz->ops->bind) {
> +	/* If there is ops->bind, try to use ops->bind */
> +	if (tz->ops->bind) {
>  		list_for_each_entry(pos, &thermal_cdev_list, node) {
>  			ret = tz->ops->bind(tz, pos);
>  			if (ret)


