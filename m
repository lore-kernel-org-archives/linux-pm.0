From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 11/13] thermal/drivers/hisi: Convert long to int
Date: Sat, 2 Sep 2017 11:41:56 +0800
Message-ID: <20170902034156.GD3841@leoy-linaro>
References: <1504082857-21702-1-git-send-email-daniel.lezcano@linaro.org>
 <1504082857-21702-11-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33361 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbdIBDmF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Sep 2017 23:42:05 -0400
Received: by mail-pg0-f45.google.com with SMTP id t3so5383223pgt.0
        for <linux-pm@vger.kernel.org>; Fri, 01 Sep 2017 20:42:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1504082857-21702-11-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, kevin.wangtao@linaro.org, open list <linux-kernel@vger.kernel.org>

On Wed, Aug 30, 2017 at 10:47:35AM +0200, Daniel Lezcano wrote:
> There is no point to specify the temperature as long variable, the int is
> enough.
> 
> Replace all long variables to int, so making the code consistent.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  drivers/thermal/hisi_thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
> index 68b625c..9eee82b 100644
> --- a/drivers/thermal/hisi_thermal.c
> +++ b/drivers/thermal/hisi_thermal.c
> @@ -83,12 +83,12 @@ static inline int hisi_thermal_step_to_temp(int step)
>  	return HISI_TEMP_BASE + (step * HISI_TEMP_STEP);
>  }
>  
> -static inline long hisi_thermal_temp_to_step(long temp)
> +static inline int hisi_thermal_temp_to_step(int temp)
>  {
>  	return (temp - HISI_TEMP_BASE) / HISI_TEMP_STEP;
>  }
>  
> -static inline long hisi_thermal_round_temp(int temp)
> +static inline int hisi_thermal_round_temp(int temp)
>  {
>  	return hisi_thermal_step_to_temp(
>  		hisi_thermal_temp_to_step(temp));
> -- 
> 2.7.4
> 
