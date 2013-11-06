From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: cpu_cooling: fix return value check in
 cpufreq_cooling_register()
Date: Wed, 06 Nov 2013 13:17:28 +0800
Message-ID: <1383715048.2073.9.camel@rzhang1-mobl4>
References: <CAPgLHd8_-oLvW7ps5way80S10asaN6uy8imjtUaqysQNNTXb7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:20465 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755Ab3KFFRd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 6 Nov 2013 00:17:33 -0500
In-Reply-To: <CAPgLHd8_-oLvW7ps5way80S10asaN6uy8imjtUaqysQNNTXb7A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: eduardo.valentin@ti.com, yongjun_wei@trendmicro.com.cn, linux-pm@vger.kernel.org

On Fri, 2013-10-25 at 21:55 +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function thermal_cooling_device_register() returns
> ERR_PTR() and never returns NULL. The NULL test in the return value check
> should be replaced with IS_ERR().
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

applied.

thanks,
rui
> ---
>  drivers/thermal/cpu_cooling.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index d179028..02a46f2 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -469,10 +469,10 @@ cpufreq_cooling_register(const struct cpumask *clip_cpus)
>  
>  	cool_dev = thermal_cooling_device_register(dev_name, cpufreq_dev,
>  						   &cpufreq_cooling_ops);
> -	if (!cool_dev) {
> +	if (IS_ERR(cool_dev)) {
>  		release_idr(&cpufreq_idr, cpufreq_dev->id);
>  		kfree(cpufreq_dev);
> -		return ERR_PTR(-EINVAL);
> +		return cool_dev;
>  	}
>  	cpufreq_dev->cool_dev = cool_dev;
>  	cpufreq_dev->cpufreq_state = 0;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


