From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] PM / OPP: Protect updates to list_dev with mutex
Date: Fri, 30 Oct 2015 10:06:04 -0700
Message-ID: <20151030170604.GD19782@codeaurora.org>
References: <5f8fac4ad84716ef68fc50ab0b78e11ad2837524.1446205160.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60891 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbbJ3RGH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2015 13:06:07 -0400
Content-Disposition: inline
In-Reply-To: <5f8fac4ad84716ef68fc50ab0b78e11ad2837524.1446205160.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, mturquette@baylibre.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dan Carpenter <dan.carpenter@oracle.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>

On 10/30, Viresh Kumar wrote:
> dev_opp_list_lock is used everywhere to protect device and OPP lists,
> but dev_pm_opp_set_sharing_cpus() is missed somehow. And instead we used
> rcu-lock, which wouldn't help here as we are adding a new list_dev.
> 
> This also fixes a problem where we have called kzalloc(..., GFP_KERNEL)
> from within rcu-lock, which isn't allowed as kzalloc can sleep when
> called with GFP_KERNEL.

Care to share the splat here?

> diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
> index 7654c5606307..91f15b2e25ee 100644
> --- a/drivers/base/power/opp/cpu.c
> +++ b/drivers/base/power/opp/cpu.c
> @@ -124,12 +124,12 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
>  	struct device *dev;
>  	int cpu, ret = 0;
>  
> -	rcu_read_lock();
> +	mutex_lock(&dev_opp_list_lock);
>  
>  	dev_opp = _find_device_opp(cpu_dev);

So does _find_device_opp() need to be called with rcu_read_lock()
held or not? The comment above the function makes it sound like
we need RCU, but we don't do that here anymore.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
