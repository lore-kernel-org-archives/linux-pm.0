From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: make ti-cpufreq explicitly non-modular
Date: Tue, 14 Feb 2017 09:19:14 +0530
Message-ID: <20170214034914.GD3537@vireshk-i7>
References: <20170214004502.9181-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:38905 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbdBNDtS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Feb 2017 22:49:18 -0500
Received: by mail-it0-f50.google.com with SMTP id c7so16759633itd.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Feb 2017 19:49:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170214004502.9181-1-paul.gortmaker@windriver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org

On 13-02-17, 19:45, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/cpufreq/Kconfig.arm:config ARM_TI_CPUFREQ
> drivers/cpufreq/Kconfig.arm:    bool "Texas Instruments CPUFreq support"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the couple traces of modular infrastructure use, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> Since module_init translates to device_initcall in the non-modular
> case, the init ordering remains unchanged with this commit.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Dave Gerlach <d-gerlach@ti.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index 7ff7ae3c3911..a7b5658c0460 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -17,7 +17,7 @@
>  #include <linux/cpu.h>
>  #include <linux/io.h>
>  #include <linux/mfd/syscon.h>
> -#include <linux/module.h>
> +#include <linux/init.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/pm_opp.h>
> @@ -265,8 +265,4 @@ static int ti_cpufreq_init(void)
>  
>  	return ret;
>  }
> -module_init(ti_cpufreq_init);
> -
> -MODULE_DESCRIPTION("TI CPUFreq/OPP hw-supported driver");
> -MODULE_AUTHOR("Dave Gerlach <d-gerlach@ti.com>");
> -MODULE_LICENSE("GPL v2");
> +device_initcall(ti_cpufreq_init);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
