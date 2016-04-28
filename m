From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: arm_big_little: use generic OPP functions
 for {init,free}_opp_table
Date: Thu, 28 Apr 2016 16:56:58 +0530
Message-ID: <20160428112657.GD2915@vireshk-i7>
References: <1461839114-29857-1-git-send-email-sudeep.holla@arm.com>
 <1461839114-29857-2-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:32774 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbcD1L1G (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2016 07:27:06 -0400
Received: by mail-pa0-f52.google.com with SMTP id zm5so34507405pac.0
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2016 04:27:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1461839114-29857-2-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 28-04-16, 11:25, Sudeep Holla wrote:
> Currently when performing random hotplugs and suspend-to-ram(S2R) on
> systems using arm_big_little cpufreq driver, we get warnings similar to:
> 
> cpu cpu1: _opp_add: duplicate OPPs detected. Existing: freq: 600000000,
> 	volt: 800000, enabled: 1. New: freq: 600000000, volt: 800000, enabled: 1
> 
> This is mainly because the OPPs for the shared cpus are not set. We can
> just use dev_pm_opp_of_cpumask_add_table in case the OPPs are obtained
> from DT(arm_big_little_dt.c) or use dev_pm_opp_set_sharing_cpus if the
> OPPs are obtained by other means like firmware(e.g. scpi-cpufreq.c)
> 
> Also now that the generic dev_pm_opp_cpumask_remove_table can handle
> removal of opp table and entries for all associated CPUs, we can reuse
> dev_pm_opp_cpumask_remove_table as free_opp_table in cpufreq_arm_bL_ops.
> 
> This patch makes necessary changes to reuse the generic OPP functions for
> {init,free}_opp_table and thereby eliminating the warnings.
> 
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/arm_big_little.c    | 54 ++++++++++++++++++++-----------------
>  drivers/cpufreq/arm_big_little.h    |  4 +--
>  drivers/cpufreq/arm_big_little_dt.c | 21 ++-------------
>  drivers/cpufreq/scpi-cpufreq.c      | 24 ++++++++++++++---
>  4 files changed, 54 insertions(+), 49 deletions(-)
> 
> Hi Viresh,
> 
> Why is dynamic OPPs not deleted in dev_pm_opp_{,cpumask_}remove_table ?
> It would remove some code in scpi-cpufreq.c but I would like to understand.
> Is there any use in not deleting them there ?

That was intentional, consider this case:
- OPPs are added dynamically from platform code
- insmod cpufreq-dt.ko (add static (dt) OPPs as well, mostly fail)
- rmmod  cpufreq-dt.ko (remove all OPPs)

- insmod cpufreq-dt.ko (no more OPPs available, as we removed them both).

That's bad ?

Now, how to fix platforms which don't add dynamic OPPs from platform code? But
something like the scpi driver, which can get inserted/removed again.

This is what I would suggest:
- Even if dev_pm_opp_of_cpumask_remove_table() isn't doing any OF specific
  stuff, lets not update its name and move it out of the ifdef, as it will be
  used only if the user has created OPPs using DT earlier.
- But rather make those two routines call two new routines in the core (which
  don't depend on OF) and implement what these of-remove routines do.
- Add two more routines for removing OPPs created dynamically and call the two
  routines created in previous step.

I hope you followed that :)

> -static void scpi_free_opp_table(struct device *cpu_dev)
> +static void scpi_free_opp_table(cpumask_var_t cpumask)
>  {
> +	struct device *cpu_dev = get_cpu_device(cpumask_first(cpumask));
> +
> +	cpumask_clear_cpu(cpu_dev->id, cpumask);
> +	dev_pm_opp_cpumask_remove_table(cpumask);
> +	cpumask_set_cpu(cpu_dev->id, cpumask);
> +
>  	scpi_opp_table_ops(cpu_dev, true);
>  }

This was a *really* crazy idea :)

And btw, I think you better move to cpufreq-dt, instead of struggling with this
one :)

-- 
viresh
