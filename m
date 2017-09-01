From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH] ARM: cpuidle: Avoid memleak if init fail
Date: Fri, 1 Sep 2017 09:33:17 +0800
Message-ID: <20170901013317.GA516@leoy-ThinkPad-T440>
References: <1504211076-2331-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33533 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdIABdZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Aug 2017 21:33:25 -0400
Received: by mail-pf0-f178.google.com with SMTP id n73so3852937pfj.0
        for <linux-pm@vger.kernel.org>; Thu, 31 Aug 2017 18:33:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1504211076-2331-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Stefan,

On Thu, Aug 31, 2017 at 10:24:36PM +0200, Stefan Wahren wrote:
> In case there are no DT idle states defined or
> cpuidle_register_driver() fails, the copy of the idle driver is leaked:
> 
>     unreferenced object 0xede0dc00 (size 1024):
>     comm "swapper/0", pid 1, jiffies 4294937431 (age 744.510s)
>     hex dump (first 32 bytes):
>     94 9e 0b c1 00 00 00 00 00 00 00 00 00 00 00 00 ................
>     57 46 49 00 00 00 00 00 00 00 00 00 00 00 00 00 WFI.............
>     backtrace:
>     [<c1295f04>] arm_idle_init+0x44/0x1ac
>     [<c0301e6c>] do_one_initcall+0x3c/0x16c
>     [<c1200d70>] kernel_init_freeable+0x110/0x1d0
>     [<c0cb3624>] kernel_init+0x8/0x114
>     [<c0307a98>] ret_from_fork+0x14/0x3c
> 
> So fix this by freeing the unregistered copy in error case.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Fixes: d50a7d8acd78 ("ARM: cpuidle: Support asymmetric idle definition")
> ---
>  drivers/cpuidle/cpuidle-arm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> index 7080c38..52a7505 100644
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -104,13 +104,13 @@ static int __init arm_idle_init(void)
>  		ret = dt_init_idle_driver(drv, arm_idle_state_match, 1);
>  		if (ret <= 0) {
>  			ret = ret ? : -ENODEV;
> -			goto out_fail;
> +			goto init_fail;
>  		}
>  
>  		ret = cpuidle_register_driver(drv);
>  		if (ret) {
>  			pr_err("Failed to register cpuidle driver\n");
> -			goto out_fail;
> +			goto init_fail;
>  		}
>  
>  		/*
> @@ -149,6 +149,8 @@ static int __init arm_idle_init(void)
>  	}
>  
>  	return 0;
> +init_fail:
> +	kfree(drv);

The below loop only releases resource for previous CPUs, so should check
two variables 'drv' and 'dev'. If 'dev != NULL', we also need to release
it.

Thanks,
Leo Yan

>  out_fail:
>  	while (--cpu >= 0) {
>  		dev = per_cpu(cpuidle_devices, cpu);
> -- 
> 2.7.4
> 
