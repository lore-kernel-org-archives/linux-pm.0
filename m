From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH] thermal: hisilicon: increase temperature resolution
Date: Thu, 18 Feb 2016 17:39:00 +0800
Message-ID: <20160218093900.GA28887@leoy-linaro>
References: <1451452382-4498-1-git-send-email-leo.yan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36040 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425811AbcBRJjI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 04:39:08 -0500
Received: by mail-pa0-f41.google.com with SMTP id yy13so27871083pab.3
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2016 01:39:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1451452382-4498-1-git-send-email-leo.yan@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kongxinwei <kong.kongxinwei@hisilicon.com>

Hi Rui, Eduardo,

On Wed, Dec 30, 2015 at 01:13:02PM +0800, Leo Yan wrote:
> When calculate temperature, old code firstly do division and then
> convert to "millicelsius" unit. This will lose resolution and only can
> read back temperature with "Celsius" unit.
> 
> So firstly scale step value to "millicelsius" and then do division, so
> finally we can increase resolution for temperature value. Also refine
> the calculation from temperature value to step value.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Could you help merge this patch?

Thanks,
Leo Yan

> ---
>  drivers/thermal/hisi_thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
> index 36d0729..5e820b5 100644
> --- a/drivers/thermal/hisi_thermal.c
> +++ b/drivers/thermal/hisi_thermal.c
> @@ -68,12 +68,12 @@ static inline int _step_to_temp(int step)
>  	 * Every step equals (1 * 200) / 255 celsius, and finally
>  	 * need convert to millicelsius.
>  	 */
> -	return (HISI_TEMP_BASE + (step * 200 / 255)) * 1000;
> +	return (HISI_TEMP_BASE * 1000 + (step * 200000 / 255));
>  }
>  
>  static inline long _temp_to_step(long temp)
>  {
> -	return ((temp / 1000 - HISI_TEMP_BASE) * 255 / 200);
> +	return ((temp - HISI_TEMP_BASE * 1000) * 255) / 200000;
>  }
>  
>  static long hisi_thermal_get_sensor_temp(struct hisi_thermal_data *data,
> -- 
> 1.9.1
> 
