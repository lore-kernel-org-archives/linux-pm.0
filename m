From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] thermal: core: make thermal_emergency_poweroff static
Date: Tue, 9 May 2017 09:05:31 +0530
Message-ID: <fa978f44-732b-c7bb-33d6-8d4df8e31155@ti.com>
References: <20170508103643.10748-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:38064 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbdEIDfn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2017 23:35:43 -0400
In-Reply-To: <20170508103643.10748-1-colin.king@canonical.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org



On Monday 08 May 2017 04:06 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Making thermal_emergency_poweroff static fixes sparse warning:
> 
>   drivers/thermal/thermal_core.c:6: warning: symbol
>   'thermal_emergency_poweroff' was not declared. Should it be static?

Acked-by: Keerthy <j-keerthy@ti.com>

> 
> Fixes: ef1d87e06ab4 ("thermal: core: Add a back up thermal shutdown mechanism")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/thermal/thermal_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index b21b9cc2c8d6..5a51c740e372 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -359,7 +359,7 @@ static DECLARE_DELAYED_WORK(thermal_emergency_poweroff_work,
>   * This may be called from any critical situation to trigger a system shutdown
>   * after a known period of time. By default this is not scheduled.
>   */
> -void thermal_emergency_poweroff(void)
> +static void thermal_emergency_poweroff(void)
>  {
>  	int poweroff_delay_ms = CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS;
>  	/*
> 
