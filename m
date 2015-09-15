From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: cpufreq_cpu_get_raw() isn't a static function
 anymore
Date: Tue, 15 Sep 2015 13:44:45 +0530
Message-ID: <20150915081445.GD6350@linux>
References: <d7e3e729d09d15cfc73ebaf251a2bb4d33ec54a9.1442303903.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33328 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbbIOIOt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2015 04:14:49 -0400
Received: by pacex6 with SMTP id ex6so170243477pac.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2015 01:14:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <d7e3e729d09d15cfc73ebaf251a2bb4d33ec54a9.1442303903.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, alexandra.yates@linux.intel.com, open list <linux-kernel@vger.kernel.org>

On 15-09-15, 13:40, Viresh Kumar wrote:
> Its used outside of the core file and is exported as well. Drop the
> 'static' keyword from its declaration and fix below build error:
> 
> linux/drivers/cpufreq/cpufreq.c:241:31: error: static declaration of
> 'cpufreq_cpu_get_raw' follows non-static declaration
> 
> Fixes: 503655f70d9b ("cpufreq: acpi-cpufreq: Use cpufreq_cpu_get_raw() in ->get()")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Urg, sorry for spamming wrong people (Thomas/Alexandra) for an
unrelated patch.

Have sent the relevant patch with this subject now:
"PM / sleep: Fix broken builds without CONFIG_PM_SLEEP_DEBUG"

Though, this fix was also relevant, just sent it to wrong people :(

> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a8252bb0f80c..ef5ed9470de9 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -238,7 +238,7 @@ int cpufreq_generic_init(struct cpufreq_policy *policy,
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_generic_init);
>  
> -static struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
> +struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
>  {
>  	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
>  
> -- 
> 2.4.0
> 

-- 
viresh
