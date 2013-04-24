From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] SH: cpuidle: use init/exit common routine
Date: Wed, 24 Apr 2013 15:02:15 +0900
Message-ID: <20130424060214.GA7149@verge.net.au>
References: <1366728077-18988-1-git-send-email-daniel.lezcano@linaro.org>
 <1366728077-18988-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:47433 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610Ab3DXGCR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Apr 2013 02:02:17 -0400
Content-Disposition: inline
In-Reply-To: <1366728077-18988-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: ben-linux@fluff.org, kgene.kim@samsung.com, lethal@linux-sh.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On Tue, Apr 23, 2013 at 04:41:17PM +0200, Daniel Lezcano wrote:
> Remove the duplicated code and use the cpuidle common code for initialization.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  arch/sh/kernel/cpu/shmobile/cpuidle.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/arch/sh/kernel/cpu/shmobile/cpuidle.c b/arch/sh/kernel/cpu/shmobile/cpuidle.c
> index fdfe57f4..d306225 100644
> --- a/arch/sh/kernel/cpu/shmobile/cpuidle.c
> +++ b/arch/sh/kernel/cpu/shmobile/cpuidle.c
> @@ -51,7 +51,6 @@ static int cpuidle_sleep_enter(struct cpuidle_device *dev,
>  	return k;
>  }
>  
> -static struct cpuidle_device cpuidle_dev;
>  static struct cpuidle_driver cpuidle_driver = {
>  	.name   = "sh_idle",
>  	.owner  = THIS_MODULE,
> @@ -100,9 +99,5 @@ int __init sh_mobile_setup_cpuidle(void)
>  	if (sh_mobile_sleep_supported & SUSP_SH_STANDBY)
>  		cpuidle_driver.states[2].disabled = false;
>  
> -	ret = cpuidle_register_driver(&cpuidle_driver);
> -	if (ret)
> -		return ret;
> -
> -	return cpuidle_register_device(&cpuidle_dev);
> +	return cpuidle_register(&cpuidle_driver);
>  }
> -- 
> 1.7.9.5
> 
