From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/6] drivers base/arch_topology: frequency-invariant
 load-tracking support
Date: Thu, 22 Jun 2017 09:25:18 +0530
Message-ID: <20170622035518.GA6314@vireshk-i7>
References: <20170608075513.12475-1-dietmar.eggemann@arm.com>
 <20170608075513.12475-3-dietmar.eggemann@arm.com>
 <CAOh2x=k1Zr15vAq8LA0+Sg3Cz7o=dL5C-erkEx_py7g56b7BwA@mail.gmail.com>
 <b6ada943-7526-7573-21c4-e773969ebb35@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34705 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752060AbdFVDzW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jun 2017 23:55:22 -0400
Received: by mail-pf0-f174.google.com with SMTP id s66so2921738pfs.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Jun 2017 20:55:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <b6ada943-7526-7573-21c4-e773969ebb35@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaor.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>

On 21-06-17, 17:38, Dietmar Eggemann wrote:
> On 20/06/17 07:17, Viresh Kumar wrote:

> > Any specific reason on why are we doing this from PRECHANGE and
> > not POSTCHANGE ? i.e. we are doing this before the frequency is
> > really updated.
> 
> Not really. In case I get a CPUFREQ_POSTCHANGE all the time the
> frequency actually changed I can switch to CPUFREQ_POSTCHANGE.

Yes, you should always get that. And its not right to do any such
change in PRECHANGE notifier as we may fail to change the frequency as
well..

> > Wanted to make sure that we all understand the constraints this is going to add
> > for the ARM64 platforms.
> > 
> > With the introduction of this transition notifier, we would not be able to use
> > the fast-switch path in the schedutil governor. I am not sure if there are any
> > ARM platforms that can actually use the fast-switch path in future or not
> > though. The requirement of fast-switch path is that the freq can be changed
> > without sleeping in the hot-path.
> 
> That's a good point. The cpufreq transition notifier based Frequency
> Invariance Engine (FIE) can only work if none of the cpufreq policies
> support fast frequency switching. 

At least with the current design, yes.

> What about we still enable cpufreq transition notifier based FIE for
> systems where this is true. This will cover 100% of all arm/arm64
> systems today.

I would suggest having a single solution for everyone if we can.

> In case one day we have a cpufreq driver which allows fast frequency
> switching we would need a FIE based on something else than cpufreq
> transition notifier. Maybe based on performance counters (something
> similar to x86 APERF/MPERF) or cpufreq core could provide a function
> which provides the avg frequency value.
> 
> I could make the current implementation more future-proof by only
> using the notifier based FIE in case all policies use slow frequency
> switching:
> 
> >From afe64b5c0606cad4304b77fc5cff819d3083a88d Mon Sep 17 00:00:00 2001
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Date: Wed, 21 Jun 2017 14:53:26 +0100
> Subject: [PATCH] drivers base/arch_topology: enable cpufreq transistion
>  notifier based FIE only for slow frequency switching
> 
> Fast frequency switching is incompatible with cpufreq transition
> notifiers.
> 
> Enable the cpufreq transition notifier based Frequency Invariance Engine
> (FIE) only in case there are no cpufreq policies able to use fast
> frequency switching.
> 
> Currently there are no cpufreq drivers for arm/arm64 which support fast
> frequency switching. In case such a driver will appear the FEI
> topology_get_freq_scale() has to be extended to provide frequency
> invariance based on something else than cpufreq transition notifiers,
> e.g. performance counters.
> 
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  drivers/base/arch_topology.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index c2539dc584d5..bd14c5e81f63 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -171,6 +171,7 @@ static bool cap_parsing_done;
>  static void parsing_done_workfn(struct work_struct *work);
>  static DECLARE_WORK(parsing_done_work, parsing_done_workfn);
>  static DEFINE_PER_CPU(unsigned long, max_freq);
> +static bool enable_freq_inv = true;
> 
>  static int
>  init_cpu_capacity_callback(struct notifier_block *nb,
> @@ -199,6 +200,8 @@ init_cpu_capacity_callback(struct notifier_block *nb,
>                                             policy->cpuinfo.max_freq / 1000UL;
>                         capacity_scale = max(raw_capacity[cpu], capacity_scale);
>                 }
> +               if (policy->fast_switch_possible)
> +                       enable_freq_inv = false;
>                 if (cpumask_empty(cpus_to_visit)) {
>                         if (!cap_parsing_failed) {
>                                 topology_normalize_cpu_scale();
> @@ -268,21 +271,23 @@ static int __init register_cpufreq_notifier(void)
>         ret = cpufreq_register_notifier(&init_cpu_capacity_notifier,
>                                         CPUFREQ_POLICY_NOTIFIER);
> 
> -       if (ret) {
> +       if (ret)
>                 free_cpumask_var(cpus_to_visit);
> -               return ret;
> -       }
> 
> -       return cpufreq_register_notifier(&set_freq_scale_notifier,
> -                                        CPUFREQ_TRANSITION_NOTIFIER);
> +       return ret;
>  }
>  core_initcall(register_cpufreq_notifier);
> 
>  static void parsing_done_workfn(struct work_struct *work)
>  {
> +
>         free_cpumask_var(cpus_to_visit);
>         cpufreq_unregister_notifier(&init_cpu_capacity_notifier,
>                                          CPUFREQ_POLICY_NOTIFIER);
> +
> +       if (enable_freq_inv)
> +               cpufreq_register_notifier(&set_freq_scale_notifier,
> +                                         CPUFREQ_TRANSITION_NOTIFIER);
>  }

This may work, but lets see if we can find a way of doing this for
everyone at once.

(I will continue to reply on Morten's email now)..

-- 
viresh
