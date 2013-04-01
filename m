From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: fair_share: check for a valid thermal zone
 device
Date: Mon, 01 Apr 2013 09:05:01 +0800
Message-ID: <1364778301.2178.7.camel@rzhang1-mobl4>
References: <1364637877-28068-1-git-send-email-devendra.aaru@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17688 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756236Ab3DABFF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 31 Mar 2013 21:05:05 -0400
In-Reply-To: <1364637877-28068-1-git-send-email-devendra.aaru@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Devendra Naga <devendra.aaru@gmail.com>
Cc: linux-pm@vger.kernel.org

On Sat, 2013-03-30 at 15:34 +0530, Devendra Naga wrote:
> to be on safe side check for a valid thermal zone device and fail if there
> is no thermal zone device.
> 

> Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
> ---
>  drivers/thermal/fair_share.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
> index 792479f..4cd1d47 100644
> --- a/drivers/thermal/fair_share.c
> +++ b/drivers/thermal/fair_share.c
> @@ -85,7 +85,7 @@ static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
>  	int i;
>  	int cur_trip_level = get_trip_level(tz);
>  
> -	if (!tz->tzp || !tz->tzp->tbp)
> +	if (!tz || !tz->tzp || !tz->tzp->tbp)
>  		return -EINVAL;

when tz equals NULL, it suggests a really serious problem, and IMO, a
NULL pointer dereference or Panic in this case is more meaningful.

thanks,
rui

