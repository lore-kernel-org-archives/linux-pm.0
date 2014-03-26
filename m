From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 01/19] thermal: allow registering without .get_temp
Date: Wed, 26 Mar 2014 10:23:51 +0800
Message-ID: <1395800631.2330.8.camel@rzhang1-mobl4>
References: <1395744572-20014-1-git-send-email-alex.shi@linaro.org>
	 <1395744572-20014-2-git-send-email-alex.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395744572-20014-2-git-send-email-alex.shi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Shi <alex.shi@linaro.org>
Cc: mark.hambleton@broadcom.com, mark.brown@linaro.org, eduardo.valentin@ti.com, mporter@linaro.org, lsk-interest@linaro.org, linaro-kernel@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2014-03-25 at 18:49 +0800, Alex Shi wrote:
> From: Eduardo Valentin <eduardo.valentin@ti.com>
> 
> This patch changes the thermal core driver to allow
> registration of thermal zones without the .get_temp callback.
> 
> The idea behind this change is to allow lazy registration
> of sensor callbacks.
> 
> The thermal zone will be disabled whenever the ops
> does not contain a .get_temp callback. The sysfs interface
> will be returning -EINVAL on any temperature read operation.
> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> (cherry picked from commit 81bd4e1cebed5efb85bd94a15342ee4d6965a416)
> 
> Signed-off-by: Alex Shi <alex.shi@linaro.org>

why are you sending this patch series?
all of the patches have been in upstream already.
Plus, next time when you send a big patch set, please send with a patch
00/XX to give a general introduction of the whole patch set.

thanks,
rui
> ---
>  drivers/thermal/thermal_core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index d755440..818cd78 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -388,7 +388,7 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned long *temp)
>  	enum thermal_trip_type type;
>  #endif
>  
> -	if (!tz || IS_ERR(tz))
> +	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
>  		goto exit;
>  
>  	mutex_lock(&tz->lock);
> @@ -441,6 +441,9 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
>  {
>  	int count;
>  
> +	if (!tz->ops->get_temp)
> +		return;
> +
>  	update_temperature(tz);
>  
>  	for (count = 0; count < tz->trips; count++)
> @@ -1621,7 +1624,7 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
>  	if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips)
>  		return ERR_PTR(-EINVAL);
>  
> -	if (!ops || !ops->get_temp)
> +	if (!ops)
>  		return ERR_PTR(-EINVAL);
>  
>  	if (trips > 0 && !ops->get_trip_type)
> @@ -1723,6 +1726,9 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
>  
>  	INIT_DELAYED_WORK(&(tz->poll_queue), thermal_zone_device_check);
>  
> +	if (!tz->ops->get_temp)
> +		thermal_zone_device_set_polling(tz, 0);
> +
>  	thermal_zone_device_update(tz);
>  
>  	if (!result)
