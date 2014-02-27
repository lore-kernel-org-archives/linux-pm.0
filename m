From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] Thermal: Allow first update of cooling device state
Date: Thu, 27 Feb 2014 14:49:59 +0800
Message-ID: <1393483799.2637.13.camel@rzhang1-mobl4>
References: <1392606175-19635-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32017 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781AbaB0GuC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 27 Feb 2014 01:50:02 -0500
In-Reply-To: <1392606175-19635-1-git-send-email-wni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: durgadoss.r@intel.com, eduardo.valentin@ti.com, linux-pm@vger.kernel.org

On Mon, 2014-02-17 at 11:02 +0800, Wei Ni wrote:
> In initialization, if the cooling device is initialized at
> max cooling state, and the thermal zone temperature is below
> the first trip point, then the cooling state can't be updated
> to the right state, untill the first trip point be triggered.
> 
> To fix this issue, allow first update of cooling device state
> during registration, initialized "updated" device field as
> "false" (instead of "true").
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>

applied.

thanks,
rui
> ---
>  drivers/thermal/thermal_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 338a88b..02f57af 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1107,7 +1107,7 @@ __thermal_cooling_device_register(struct device_node *np,
>  	INIT_LIST_HEAD(&cdev->thermal_instances);
>  	cdev->np = np;
>  	cdev->ops = ops;
> -	cdev->updated = true;
> +	cdev->updated = false;
>  	cdev->device.class = &thermal_class;
>  	cdev->devdata = devdata;
>  	dev_set_name(&cdev->device, "cooling_device%d", cdev->id);


