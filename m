From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 01/10] drivers base/arch_topology: free cpumask
 cpus_to_visit
Date: Thu, 6 Jul 2017 15:52:49 +0530
Message-ID: <20170706102249.GA13048@vireshk-i7>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <20170706094948.8779-2-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36624 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751850AbdGFKWy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jul 2017 06:22:54 -0400
Received: by mail-pf0-f172.google.com with SMTP id q86so9251778pfl.3
        for <linux-pm@vger.kernel.org>; Thu, 06 Jul 2017 03:22:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170706094948.8779-2-dietmar.eggemann@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>

On 06-07-17, 10:49, Dietmar Eggemann wrote:
> Free cpumask cpus_to_visit in case registering
> init_cpu_capacity_notifier has failed or the parsing of the cpu
> capacity-dmips-mhz property is done. The cpumask cpus_to_visit is
> only used inside the notifier call init_cpu_capacity_callback.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Juri Lelli <juri.lelli@arm.com>
> Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
> Tested-by: Juri Lelli <juri.lelli@arm.com>
> Reviewed-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  drivers/base/arch_topology.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index d1c33a85059e..f4832c662762 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -206,6 +206,8 @@ static struct notifier_block init_cpu_capacity_notifier = {
>  
>  static int __init register_cpufreq_notifier(void)
>  {
> +	int ret;
> +
>  	/*
>  	 * on ACPI-based systems we need to use the default cpu capacity
>  	 * until we have the necessary code to parse the cpu capacity, so
> @@ -221,13 +223,19 @@ static int __init register_cpufreq_notifier(void)
>  
>  	cpumask_copy(cpus_to_visit, cpu_possible_mask);
>  
> -	return cpufreq_register_notifier(&init_cpu_capacity_notifier,
> -					 CPUFREQ_POLICY_NOTIFIER);
> +	ret = cpufreq_register_notifier(&init_cpu_capacity_notifier,
> +					CPUFREQ_POLICY_NOTIFIER);
> +
> +	if (ret)
> +		free_cpumask_var(cpus_to_visit);
> +
> +	return ret;
>  }
>  core_initcall(register_cpufreq_notifier);
>  
>  static void parsing_done_workfn(struct work_struct *work)
>  {
> +	free_cpumask_var(cpus_to_visit);
>  	cpufreq_unregister_notifier(&init_cpu_capacity_notifier,
>  					 CPUFREQ_POLICY_NOTIFIER);

As a general rule (and good coding practice), it is better to free resources
only after the users are gone. And so we should have changed the order here.
i.e. Unregister the notifier first and then free the cpumask.

And because of that we may end up crashing the kernel here.

Here is an example:

Consider that init_cpu_capacity_callback() is getting called concurrently on big
and LITTLE CPUs.


CPU0 (big)                            CPU4 (LITTLE)

                                      if (cap_parsing_failed || cap_parsing_done)
                                          return 0;

cap_parsing_done = true;
schedule_work(&parsing_done_work);

parsing_done_workfn(work)
  -> free_cpumask_var(cpus_to_visit);
  -> cpufreq_unregister_notifier()


                                      switch (val) {
                                          ...
                                          /* Touch cpus_to_visit and crash */


My assumption here is that the same notifier head can get called in parallel on
two CPUs as all I see there is a down_read() in __blocking_notifier_call_chain()
which shouldn't block parallel calls.

Maybe I am wrong :(

-- 
viresh
