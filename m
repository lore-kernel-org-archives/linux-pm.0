From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant
 load-tracking support
Date: Mon, 10 Jul 2017 12:10:10 +0530
Message-ID: <20170710064010.GF2928@vireshk-i7>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <20170706094948.8779-3-dietmar.eggemann@arm.com>
 <20170706104027.GB13048@vireshk-i7>
 <c92f1bd0-6611-8eec-51d7-f6d7754a5870@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33808 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbdGJGkN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2017 02:40:13 -0400
Received: by mail-pg0-f54.google.com with SMTP id t186so44675069pgb.1
        for <linux-pm@vger.kernel.org>; Sun, 09 Jul 2017 23:40:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <c92f1bd0-6611-8eec-51d7-f6d7754a5870@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>

On 07-07-17, 17:01, Dietmar Eggemann wrote:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 9bf97a366029..77c4d5e7a598 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -301,6 +301,12 @@ static void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci)
>  #endif
>  }
>  
> +#ifndef arch_set_freq_scale
> +static void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
> +                               unsigned long max_freq)
> +{}
> +#endif
> +
>  static void __cpufreq_notify_transition(struct cpufreq_policy *policy,
>                 struct cpufreq_freqs *freqs, unsigned int state)
>  {
> @@ -343,6 +349,8 @@ static void __cpufreq_notify_transition(struct cpufreq_policy *policy,
>                                 CPUFREQ_POSTCHANGE, freqs);
>                 if (likely(policy) && likely(policy->cpu == freqs->cpu))
>                         policy->cur = freqs->new;
> +               arch_set_freq_scale(policy->related_cpus, policy->cur,
> +                                   policy->cpuinfo.max_freq);

This function gets called for-each-cpu-in-policy, so you don't need the first
argument. And the topology code already has max_freq, so not sure if you need
the last parameter as well, specially for the ARM solution.

-- 
viresh
