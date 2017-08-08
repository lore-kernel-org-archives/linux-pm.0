From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: core: fix some format issues on critical
 shutdown string
Date: Tue, 08 Aug 2017 17:17:59 +0800
Message-ID: <1502183879.4296.26.camel@intel.com>
References: <20170723142149.43869-1-icenowy@aosc.io>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:39073 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751921AbdHHJSE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Aug 2017 05:18:04 -0400
In-Reply-To: <20170723142149.43869-1-icenowy@aosc.io>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Icenowy Zheng <icenowy@aosc.io>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 2017-07-23 at 22:21 +0800, Icenowy Zheng wrote:
> The critical shutdown notice string used to have some spaces missing,
> which makes it not so pretty.
> 
> Add the spaces to satisfy usual English space rules.
> 
> Reported-by: Mingcong Bai <jeffbai@aosc.io>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

applied.

thanks,
rui
> ---
>  drivers/thermal/thermal_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c
> b/drivers/thermal/thermal_core.c
> index 5a51c740e372..671e4d15599d 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -390,7 +390,7 @@ static void handle_critical_trips(struct
> thermal_zone_device *tz,
>  
>  	if (trip_type == THERMAL_TRIP_CRITICAL) {
>  		dev_emerg(&tz->device,
> -			  "critical temperature reached(%d
> C),shutting down\n",
> +			  "critical temperature reached (%d C),
> shutting down\n",
>  			  tz->temperature / 1000);
>  		mutex_lock(&poweroff_lock);
>  		if (!power_off_triggered) {
