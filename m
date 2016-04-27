From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 2/4] thermal: of: implement .set_trips for device tree
 thermal zones
Date: Wed, 27 Apr 2016 14:52:10 -0700
Message-ID: <20160427215209.GC6438@localhost.localdomain>
References: <1461553367-24744-1-git-send-email-wxt@rock-chips.com>
 <1461553367-24744-3-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33910 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170AbcD0VwO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2016 17:52:14 -0400
Content-Disposition: inline
In-Reply-To: <1461553367-24744-3-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, dmitry.torokhov@gmail.com, huangtao@rock-chips.com, eddie.cai@rock-chips.com, Sascha Hauer <s.hauer@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 25, 2016 at 11:02:45AM +0800, Caesar Wang wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: linux-pm@vger.kernel.org
> ---
> 
>  drivers/thermal/of-thermal.c | 12 ++++++++++++
>  include/linux/thermal.h      |  4 ++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index b8e509c..8722e63 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -101,6 +101,17 @@ static int of_thermal_get_temp(struct thermal_zone_device *tz,
>  	return data->ops->get_temp(data->sensor_data, temp);
>  }
>  
> +static int of_thermal_set_trips(struct thermal_zone_device *tz,
> +				int low, int high)
> +{
> +	struct __thermal_zone *data = tz->devdata;
> +
> +	if (!data->ops || !data->ops->set_trips)
> +		return -EINVAL;
> +
> +	return data->ops->set_trips(data->sensor_data, low, high);
> +}
> +
>  /**
>   * of_thermal_get_ntrips - function to export number of available trip
>   *			   points.
> @@ -427,6 +438,7 @@ thermal_zone_of_add_sensor(struct device_node *zone,
>  
>  	tzd->ops->get_temp = of_thermal_get_temp;
>  	tzd->ops->get_trend = of_thermal_get_trend;
> +	tzd->ops->set_trips = of_thermal_set_trips;
>  	tzd->ops->set_emul_temp = of_thermal_set_emul_temp;
>  	mutex_unlock(&tzd->lock);
>  
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index e258359..cb64866 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -336,12 +336,16 @@ struct thermal_genl_event {
>   *
>   * Optional:
>   * @get_trend: a pointer to a function that reads the sensor temperature trend.
> + * @@set_trips: a pointer to a function that sets a temperature window. When
> + *		this window is left the driver must inform the thermal core via
> + *              thermal_zone_device_update.

Ok. We start to see some documentation and expectation being stated
here. Nice. Please respin the comment on thermal core too, so drivers
that dont use OF will also be aware of this feature and how to use them.

>   * @set_emul_temp: a pointer to a function that sets sensor emulated
>   *		   temperature.
>   */
>  struct thermal_zone_of_device_ops {
>  	int (*get_temp)(void *, int *);
>  	int (*get_trend)(void *, long *);
> +	int (*set_trips)(void *, int, int);
>  	int (*set_emul_temp)(void *, int);
>  	int (*set_trip_temp)(void *, int, int);
>  };
> -- 
> 1.9.1
> 
