From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] thermal/drivers/hisi: disable multi alarm support for
 hi3660 SoC
Date: Wed, 18 Oct 2017 17:54:38 +0200
Message-ID: <9685721b-4593-029b-b8e8-d721526b7119@linaro.org>
References: <20171017043941.GE7954@localhost.localdomain>
 <1508318150-108444-1-git-send-email-kevin.wangtao@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56499 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbdJRPyn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Oct 2017 11:54:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id l68so11055117wmd.5
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2017 08:54:42 -0700 (PDT)
In-Reply-To: <1508318150-108444-1-git-send-email-kevin.wangtao@hisilicon.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tao Wang <kevin.wangtao@hisilicon.com>, edubezval@gmail.com
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, sunzhaosheng@hisilicon.com, gengyanping@hisilicon.com, Kevin Wangtao <kevin.wangtao@linaro.org>

On 18/10/2017 11:15, Tao Wang wrote:
> From: Kevin Wangtao <kevin.wangtao@linaro.org>
> 
> multi alarm interrupt forced a re-trigger of power_allocator_throttle
> which changes the PID's actual sampling rate, this isn't optimal for
> IPA, it is best to disable multi alarm support now and sort out this
> issue later.
> 
> Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>

Did you test the series with this change?

> ---
>  drivers/thermal/hisi_thermal.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
> index 133238a..3b74c12 100644
> --- a/drivers/thermal/hisi_thermal.c
> +++ b/drivers/thermal/hisi_thermal.c
> @@ -360,7 +360,6 @@ static int hi3660_thermal_enable_sensor(struct hisi_thermal_data *data)
>  
>  	/* set interrupt threshold */
>  	value = hi3660_thermal_temp_to_step(sensor->thres_temp[0]);
> -	value |= hi3660_thermal_temp_to_step(sensor->thres_temp[1]) << 10;
>  	hi3660_thermal_alarm_set(data->regs, sensor->id, value);
>  
>  	/* enable interrupt */
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
