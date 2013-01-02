From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH RESEND 4/4] thermal: check for invalid trip setup when
 registering thermal device
Date: Wed, 2 Jan 2013 15:53:15 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB59252E5F@BGSMSX101.gar.corp.intel.com>
References: <1357140582-8151-1-git-send-email-eduardo.valentin@ti.com>
 <1357140582-8151-5-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:35386 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752761Ab3ABPxV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jan 2013 10:53:21 -0500
In-Reply-To: <1357140582-8151-5-git-send-email-eduardo.valentin@ti.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> owner@vger.kernel.org] On Behalf Of Eduardo Valentin
> Sent: Wednesday, January 02, 2013 9:00 PM
> To: Zhang, Rui
> Cc: R, Durgadoss; linux-pm@lists.linux-foundation.org; linux-
> pm@vger.kernel.org; Eduardo Valentin
> Subject: [PATCH RESEND 4/4] thermal: check for invalid trip setup when
> registering thermal device
> 
> This patch adds an extra check in the data structure while registering
> a thermal device. The check is to avoid registering zones with a number
> of trips greater than zero, but with no .get_trip_temp nor .get_trip_type
> callbacks. Receiving such data structure may end in wrong data access.

Yes, agreed. we are moving away from this API too :-(
But Nothing hurts to have this fix. So,

Reviewed-by: Durgadoss R <durgadoss.r@intel.com>

Thanks,
Durga

> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
>  drivers/thermal/thermal_sys.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index fba27c3..0a1bf6b 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -1530,6 +1530,9 @@ struct thermal_zone_device
> *thermal_zone_device_register(const char *type,
>  	if (!ops || !ops->get_temp)
>  		return ERR_PTR(-EINVAL);
> 
> +	if (trips > 0 && !ops->get_trip_type)
> +		return ERR_PTR(-EINVAL);
> +
>  	tz = kzalloc(sizeof(struct thermal_zone_device), GFP_KERNEL);
>  	if (!tz)
>  		return ERR_PTR(-ENOMEM);
> --
> 1.7.7.1.488.ge8e1c
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
