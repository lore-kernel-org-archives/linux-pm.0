From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] thermal: Switch mode to enabled once the cooling device
 is bound
Date: Thu, 25 Jun 2015 12:35:30 -0500
Message-ID: <558C3BE2.9020508@ti.com>
References: <1435236635-20830-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33344 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561AbbFYRfd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 25 Jun 2015 13:35:33 -0400
In-Reply-To: <1435236635-20830-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, edubezval@gmail.com
Cc: linux-omap@vger.kernel.org, rui.zhang@intel.com, t-kristo@ti.com, linux-pm@vger.kernel.org, Ravikumar Kattekola <rk@ti.com>

On 06/25/2015 07:50 AM, Keerthy wrote:
> Currently mode is still disabled even after the cooling device is bound
> to the appropriate device. Hence changing the mode to enabled as soon as
> the cooling device is registered successfully.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/thermal/of-thermal.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 04b1be7..bc84485 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -163,6 +163,9 @@ static int of_thermal_bind(struct thermal_zone_device *thermal,
>  		}
>  	}
>  
> +	/* Now that cooling device is bound enable the thermal device*/
> +	data->mode = THERMAL_DEVICE_ENABLED;
> +
>  	return 0;
>  }
>  
> 
This makes sense to me rather than waiting for userspace to enable the
zone -(by which time we might have hit catastrophic thermal events
which may have been prevented if we had the zones enabled and cooling
devices functional.

-- 
Regards,
Nishanth Menon
