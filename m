From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 2/6] drivers base/arch_topology: frequency-invariant
 load-tracking support
Date: Wed, 14 Jun 2017 15:08:48 +0200
Message-ID: <CAKfTPtBnUWyAWTMJ2H8C+SPT+fVj-NkAs_pdOu+_a1zJ=VXZdA@mail.gmail.com>
References: <20170608075513.12475-1-dietmar.eggemann@arm.com>
 <20170608075513.12475-3-dietmar.eggemann@arm.com> <CAKfTPtDB=5mQnJfzES+iU-nmNjVDM48f_iKuc7WefkRVWW4JOQ@mail.gmail.com>
 <9716a48d-8198-a1d8-9450-de6386338665@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35355 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752282AbdFNNJL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jun 2017 09:09:11 -0400
Received: by mail-lf0-f49.google.com with SMTP id p189so34030lfe.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2017 06:09:10 -0700 (PDT)
In-Reply-To: <9716a48d-8198-a1d8-9450-de6386338665@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, LAK <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>

On 14 June 2017 at 09:55, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 06/12/2017 04:27 PM, Vincent Guittot wrote:
> > On 8 June 2017 at 09:55, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> Hi Vincent,
>
> Thanks for the review!
>
> [...]
>
> >> @@ -225,8 +265,14 @@ static int __init register_cpufreq_notifier(void)
> >>
> >>          cpumask_copy(cpus_to_visit, cpu_possible_mask);
> >>
> >> -       return cpufreq_register_notifier(&init_cpu_capacity_notifier,
> >> -                                        CPUFREQ_POLICY_NOTIFIER);
> >> +       ret = cpufreq_register_notifier(&init_cpu_capacity_notifier,
> >> +                                       CPUFREQ_POLICY_NOTIFIER);
> >> +
> >> +       if (ret)
> >
> > Don't you have to free memory allocated for cpus_to_visit in case of
> > errot ? it was not done before your patch as well
>
> Yes, we should free cpus_to_visit if the policy notifier registration
> fails. But IMHO also, once the parsing of the capacity-dmips-mhz property
> is done. free cpus_to_visit is only used in the notifier call
> init_cpu_capacity_callback() after being allocated and initialized in
> register_cpufreq_notifier().
>
> We could add something like this as the first patch of this set. Only
> mildly tested on Juno. Juri, what do you think?
>
> Author: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Date:   Tue Jun 13 23:21:59 2017 +0100
>
>     drivers base/arch_topology: free cpumask cpus_to_visit
>
>     Free cpumask cpus_to_visit in case registering
>     init_cpu_capacity_notifier has failed or the parsing of the cpu
>     capacity-dmips-mhz property is done. The cpumask cpus_to_visit is
>     only used inside the notifier call init_cpu_capacity_callback.
>
>     Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
>     Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

your proposal for freeing cpus_to_visit looks good for me

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index d1c33a85059e..f4832c662762 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -206,6 +206,8 @@ static struct notifier_block init_cpu_capacity_notifier = {
>
>  static int __init register_cpufreq_notifier(void)
>  {
> +       int ret;
> +
>         /*
>          * on ACPI-based systems we need to use the default cpu capacity
>          * until we have the necessary code to parse the cpu capacity, so
> @@ -221,13 +223,19 @@ static int __init register_cpufreq_notifier(void)
>
>         cpumask_copy(cpus_to_visit, cpu_possible_mask);
>
> -       return cpufreq_register_notifier(&init_cpu_capacity_notifier,
> -                                        CPUFREQ_POLICY_NOTIFIER);
> +       ret = cpufreq_register_notifier(&init_cpu_capacity_notifier,
> +                                       CPUFREQ_POLICY_NOTIFIER);
> +
> +       if (ret)
> +               free_cpumask_var(cpus_to_visit);
> +
> +       return ret;
>  }
>  core_initcall(register_cpufreq_notifier);
>
>  static void parsing_done_workfn(struct work_struct *work)
>  {
> +       free_cpumask_var(cpus_to_visit);
>         cpufreq_unregister_notifier(&init_cpu_capacity_notifier,
>                                          CPUFREQ_POLICY_NOTIFIER);
>  }
>
> >> +               return ret;
> >> +
> >> +       return cpufreq_register_notifier(&set_freq_scale_notifier,
> >> +                                        CPUFREQ_TRANSITION_NOTIFIER);
> >
> > Don't you have to unregister the other cpufreq notifier if an error is
> > returned and free the mem allocated for cpus_to_visit ?
>
> IMHO, that's not necessary.
>
> The transition notifier works completely independent from the policy
> notifier. In case the latter gets registered correctly and the registration
> of the former fails, the notifier call of the policy notifier still parses
> the capacity-dmips-mhz property information and sets per_cpu(max_freq, cpu).
>
> The notifier call set_freq_scale_callback() of the transition notifier will
> not be called so that frequency invariance always returns
> SCHED_CAPACITY_SCALE.
>
> After the policy notifier has finished its work, it schedules
> parsing_done_work() in which it gets unregistered.

Ok so IIUC, the transition notifier is somehow optional and we still
have the cpu invariance.
In this case, you should not return the error code of
cpufreq_register_notifier(&set_freq_scale_notifier,
CPUFREQ_TRANSITION_NOTIFIER) as the error code of the
register_cpufreq_notifier function.
you should better print a warning like " failed to init frequency
invariance" and return 0 for register_cpufreq_notifier()

>
> [...]
