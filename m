From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] thermal: Do not log an error if thermal_zone_get_temp
 returns -EAGAIN
Date: Tue, 10 Mar 2015 09:05:46 -0700
Message-ID: <20150310160546.GA28906@dtor-ws>
References: <1426000006-15729-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38235 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbbCJQFv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2015 12:05:51 -0400
Received: by igbhl2 with SMTP id hl2so32382869igb.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2015 09:05:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1426000006-15729-1-git-send-email-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-pm@vger.kernel.org

On Tue, Mar 10, 2015 at 04:06:46PM +0100, Hans de Goede wrote:
> Some temperature sensors only get updated every few seconds and while
> waiting for the first irq reporting a (new) temperature to happen there
> get_temp operand will return -EAGAIN as it does not have any data to report
> yet.
> 
> Not logging an error in this case avoids messages like these from showing
> up in dmesg on affected systems:
> 
> [    1.219353] thermal thermal_zone0: failed to read out thermal zone 0
> [    2.015433] thermal thermal_zone0: failed to read out thermal zone 0
> [    2.416737] thermal thermal_zone0: failed to read out thermal zone 0
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/thermal/thermal_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 48491d1..e3cbf34 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -458,8 +458,10 @@ static void update_temperature(struct thermal_zone_device *tz)
>  
>  	ret = thermal_zone_get_temp(tz, &temp);
>  	if (ret) {
> -		dev_warn(&tz->device, "failed to read out thermal zone %d\n",
> -			 tz->id);
> +		if (ret != -EAGAIN)
> +			dev_warn(&tz->device,
> +				 "failed to read out thermal zone %d\n",
> +				 tz->id);
>  		return;
>  	}
>  
> -- 
> 2.3.1
> 

-- 
Dmitry
