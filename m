From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/3] thermal: core: Reorder
 'thermal_zone_device_register()' error handling code
Date: Tue, 08 Aug 2017 16:49:18 +0800
Message-ID: <1502182158.4296.21.camel@intel.com>
References: <cover.1500187753.git.christophe.jaillet@wanadoo.fr>
         <1b2b2a818d356097d5f6092745086b79d43aeafe.1500187753.git.christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1b2b2a818d356097d5f6092745086b79d43aeafe.1500187753.git.christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, 2017-07-16 at 08:59 +0200, Christophe JAILLET wrote:
> Reorder code in the error handling path in order to match the way
> resources
> have been allocated.
> 
> With this new order, we can avoid a call to 'device_unregister()' if
> 'thermal_zone_create_device_groups'()' fails. At this point,
> 'device_register()' has not been called yet.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/thermal/thermal_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c
> b/drivers/thermal/thermal_core.c
> index 9743f3e65eb0..c58714800660 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1232,7 +1232,7 @@ thermal_zone_device_register(const char *type,
> int trips, int mask,
>  	/* Add nodes that are always present via .groups */
>  	result = thermal_zone_create_device_groups(tz, mask);
>  	if (result)
> -		goto unregister;
> +		goto remove_id;
> 
I agree we should release ida and free tz, like you did in this patch.

But the problem is in the code below, where device_register() fails,
we should free the resources allocated in
thermal_zone_create_device_groups() explicitly.

thanks,
rui

>  	/* A new thermal zone needs to be updated anyway. */
>  	atomic_set(&tz->need_update, 1);
> @@ -1294,8 +1294,9 @@ thermal_zone_device_register(const char *type,
> int trips, int mask,
>  	return tz;
>  
>  unregister:
> -	ida_simple_remove(&thermal_tz_ida, tz->id);
>  	device_unregister(&tz->device);
> +remove_id:
> +	ida_simple_remove(&thermal_tz_ida, tz->id);
>  	kfree(tz);
>  	return ERR_PTR(result);
>  }
