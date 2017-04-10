From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] CPUFREQ: Loongson2: drop set_cpus_allowed_ptr()
Date: Mon, 10 Apr 2017 16:01:53 +0530
Message-ID: <20170410103153.GK24555@vireshk-i7>
References: <20170404154957.19678-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33747 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752475AbdDJKc2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2017 06:32:28 -0400
Received: by mail-pg0-f54.google.com with SMTP id x125so103825901pgb.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2017 03:32:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170404154957.19678-1-bigeasy@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, wuzhangjin@gmail.com
Cc: linux-mips@linux-mips.org, tglx@linutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 04-04-17, 17:49, Sebastian Andrzej Siewior wrote:
> It is pure mystery to me why we need to be on a specific CPU while
> looking up a value in an array.
> My best shot at this is that before commit d4019f0a92ab ("cpufreq: move
> freq change notifications to cpufreq core") it was required to invoke
> cpufreq_notify_transition() on a special CPU.
> 
> Since it looks like a waste, remove it.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/cpufreq/loongson2_cpufreq.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
> index 6bbdac1065ff..9ac27b22476c 100644
> --- a/drivers/cpufreq/loongson2_cpufreq.c
> +++ b/drivers/cpufreq/loongson2_cpufreq.c
> @@ -51,19 +51,12 @@ static int loongson2_cpu_freq_notifier(struct notifier_block *nb,
>  static int loongson2_cpufreq_target(struct cpufreq_policy *policy,
>  				     unsigned int index)
>  {
> -	unsigned int cpu = policy->cpu;
> -	cpumask_t cpus_allowed;
>  	unsigned int freq;
>  
> -	cpus_allowed = current->cpus_allowed;
> -	set_cpus_allowed_ptr(current, cpumask_of(cpu));
> -
>  	freq =
>  	    ((cpu_clock_freq / 1000) *
>  	     loongson2_clockmod_table[index].driver_data) / 8;
>  
> -	set_cpus_allowed_ptr(current, &cpus_allowed);
> -
>  	/* setting the cpu frequency */
>  	clk_set_rate(policy->clk, freq * 1000);

It was Zhangjin who wrote the first version and he may be able to
answer the questions we have. Anyway, it is safe to apply this patch
right now.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
