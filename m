From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 1/2] ARM: cpuidle: refine failure handling in init flow
Date: Mon, 4 Sep 2017 15:00:38 +0800
Message-ID: <20170904070038.GA11253@leoy-ThinkPad-T440>
References: <1504507934-14218-1-git-send-email-leo.yan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:38640 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752064AbdIDHAq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Sep 2017 03:00:46 -0400
Received: by mail-it0-f49.google.com with SMTP id 77so18205994itj.1
        for <linux-pm@vger.kernel.org>; Mon, 04 Sep 2017 00:00:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1504507934-14218-1-git-send-email-leo.yan@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>

Hi Stefan, Daniel,

On Mon, Sep 04, 2017 at 02:52:13PM +0800, Leo Yan wrote:
> After applied Stefan Wahren patch ("ARM: cpuidle: Avoid memleak if init
> fail") there have no memleak issue, but the code is not consistent to
> handle initialization failure between driver registration and device
> registration. And when device registration fails, it misses to
> unregister the driver.
> 
> So this patch is to refine failure handling in init flow, it adds two
> 'goto' tags: when register device fails, it goto 'init_dev_fail' tag and
> free 'dev' structure and unregister driver; when register driver fails,
> it goto 'init_drv_fail' tag and free 'drv' structure.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Just want to reminding, this patch is based on Stefan's patch:
https://patchwork.kernel.org/patch/9932833/

First thing is Stefan patch is not merged so I just want to note here
have some dependency with Stefan patch. BTW, if you think we should
merge this patch with Stefan patch, it's fine for me to merge into
Stefan patch.

Thanks for suggetion.

> ---
>  drivers/cpuidle/cpuidle-arm.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> index 52a7505..f419f6a 100644
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -86,10 +86,13 @@ static int __init arm_idle_init(void)
>  
>  	for_each_possible_cpu(cpu) {
>  
> +		drv = NULL;
> +		dev = NULL;
> +
>  		drv = kmemdup(&arm_idle_driver, sizeof(*drv), GFP_KERNEL);
>  		if (!drv) {
>  			ret = -ENOMEM;
> -			goto out_fail;
> +			goto init_drv_fail;
>  		}
>  
>  		drv->cpumask = (struct cpumask *)cpumask_of(cpu);
> @@ -104,13 +107,13 @@ static int __init arm_idle_init(void)
>  		ret = dt_init_idle_driver(drv, arm_idle_state_match, 1);
>  		if (ret <= 0) {
>  			ret = ret ? : -ENODEV;
> -			goto init_fail;
> +			goto init_drv_fail;
>  		}
>  
>  		ret = cpuidle_register_driver(drv);
>  		if (ret) {
>  			pr_err("Failed to register cpuidle driver\n");
> -			goto init_fail;
> +			goto init_drv_fail;
>  		}
>  
>  		/*
> @@ -128,14 +131,14 @@ static int __init arm_idle_init(void)
>  
>  		if (ret) {
>  			pr_err("CPU %d failed to init idle CPU ops\n", cpu);
> -			goto out_fail;
> +			goto init_dev_fail;
>  		}
>  
>  		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>  		if (!dev) {
>  			pr_err("Failed to allocate cpuidle device\n");
>  			ret = -ENOMEM;
> -			goto out_fail;
> +			goto init_dev_fail;
>  		}
>  		dev->cpu = cpu;
>  
> @@ -143,15 +146,19 @@ static int __init arm_idle_init(void)
>  		if (ret) {
>  			pr_err("Failed to register cpuidle device for CPU %d\n",
>  			       cpu);
> -			kfree(dev);
> -			goto out_fail;
> +			goto init_dev_fail;
>  		}
>  	}
>  
>  	return 0;
> -init_fail:
> +
> +init_dev_fail:
> +	kfree(dev);
> +	cpuidle_unregister_driver(drv);
> +
> +init_drv_fail:
>  	kfree(drv);
> -out_fail:
> +
>  	while (--cpu >= 0) {
>  		dev = per_cpu(cpuidle_devices, cpu);
>  		cpuidle_unregister_device(dev);
> -- 
> 2.7.4
> 
