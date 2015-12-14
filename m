From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 8/8 v4] thermal: of-thermal: of_thermal_set_trip_temp()
 call thermal_zone_device_update()
Date: Mon, 14 Dec 2015 13:11:04 -0800
Message-ID: <20151214211103.GB10924@localhost.localdomain>
References: <87vb895x9d.wl%kuninori.morimoto.gx@renesas.com>
 <87io495x3c.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87io495x3c.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Zhang Rui <rui.zhang@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


Hey!

On Tue, Dec 08, 2015 at 05:30:00AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> of_thermal_set_trip_temp() updates trip temperature. It should call
> thermal_zone_device_update() immediately.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v3 -> v4
> 
>  - no change
> 
>  drivers/thermal/of-thermal.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 42b7d42..a1dd7b1 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -334,6 +334,8 @@ static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, int trip,
>  	/* thermal framework should take care of data->mask & (1 << trip) */
>  	data->trips[trip].temperature = temp;
>  
> +	thermal_zone_device_update(tz);
> +

Although I understand the need for this, I would prefer you move this change
to thermal_core.c. The reasoning is to keep the same behavior for
thermal zones created over of thermal and regular thermal zones.

BR,

>  	return 0;
>  }
>  
> -- 
> 1.9.1
> 
