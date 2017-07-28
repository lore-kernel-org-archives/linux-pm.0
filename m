From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 02/10] cpufreq: provide default frequency-invariance
 setter function
Date: Fri, 28 Jul 2017 13:00:36 +0530
Message-ID: <20170728073036.GZ352@vireshk-i7>
References: <20170727193312.9849-1-dietmar.eggemann@arm.com>
 <20170727193312.9849-3-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:37413 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbdG1Haj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jul 2017 03:30:39 -0400
Received: by mail-pg0-f43.google.com with SMTP id y129so107840593pgy.4
        for <linux-pm@vger.kernel.org>; Fri, 28 Jul 2017 00:30:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170727193312.9849-3-dietmar.eggemann@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>

On 27-07-17, 20:33, Dietmar Eggemann wrote:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 9bf97a366029..04e2f7e4964e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2404,6 +2404,17 @@ int cpufreq_boost_enabled(void)
>  EXPORT_SYMBOL_GPL(cpufreq_boost_enabled);
>  
>  /*********************************************************************
> + *               FREQUENCY INVARIANT ACCOUNTING SUPPORT              *
> + *********************************************************************/

We don't need another of these fancy headers :)

Just add below routine somewhere at the top, maybe before
cpufreq_generic_init().

> +
> +__weak void arch_set_freq_scale(struct cpumask *cpus,
> +				unsigned long cur_freq,
> +				unsigned long max_freq)
> +{
> +}
> +EXPORT_SYMBOL_GPL(arch_set_freq_scale);
> +
> +/*********************************************************************
>   *               REGISTER / UNREGISTER CPUFREQ DRIVER                *
>   *********************************************************************/
>  static enum cpuhp_state hp_online;
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index f10a9b3761cd..e38acc1a4d47 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -899,6 +899,9 @@ static inline bool policy_has_boost_freq(struct cpufreq_policy *policy)
>  
>  extern unsigned int arch_freq_get_on_cpu(int cpu);
>  
> +extern void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
> +				unsigned long max_freq);
> +
>  /* the following are really really optional */
>  extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
>  extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
> -- 
> 2.11.0

-- 
viresh
