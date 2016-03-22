From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] cpufreq: Always update current frequency before
 startig governor
Date: Tue, 22 Mar 2016 09:00:32 +0530
Message-ID: <20160322033032.GT27778@vireshk-i7>
References: <1780622.pJaGsuQWcI@vostro.rjw.lan>
 <1847835.ROHO9MEN8J@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36397 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbcCVDag (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2016 23:30:36 -0400
Received: by mail-pf0-f170.google.com with SMTP id u190so291638114pfb.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Mar 2016 20:30:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1847835.ROHO9MEN8J@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 21-03-16, 15:47, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make policy->cur match the current frequency returned by the driver's
> ->get() callback before starting the governor in case they went out of
> sync in the meantime and drop the piece of code attempting to
> resync policy->cur with the real frequency of the boot CPU from
> cpufreq_resume() as it serves no purpose any more (and it's racy and
> super-ugly anyway).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -1680,17 +1680,6 @@ void cpufreq_resume(void)
>  				       __func__, policy);
>  		}
>  	}
> -
> -	/*
> -	 * schedule call cpufreq_update_policy() for first-online CPU, as that
> -	 * wouldn't be hotplugged-out on suspend. It will verify that the
> -	 * current freq is in sync with what we believe it to be.
> -	 */
> -	policy = cpufreq_cpu_get_raw(cpumask_first(cpu_online_mask));
> -	if (WARN_ON(!policy))
> -		return;
> -
> -	schedule_work(&policy->update);
>  }
>  
>  /**
> @@ -2062,6 +2051,9 @@ static int cpufreq_start_governor(struct
>  {
>  	int ret;
>  
> +	if (cpufreq_driver->get && !cpufreq_driver->setpolicy)
> +		cpufreq_update_current_freq(policy);
> +
>  	ret = cpufreq_governor(policy, CPUFREQ_GOV_START);
>  	return ret ? ret : cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
>  }

This looks fine, but I am searching for answers to few doubts, maybe
you can help..

Why we did the same in process context earlier? And why it wouldn't be
a problem now, when we do it in interrupt context? Will IRQs be
disabled here? If so, then will you hit following ?

static void __cpufreq_notify_transition(struct cpufreq_policy *policy,
		struct cpufreq_freqs *freqs, unsigned int state)
{
	BUG_ON(irqs_disabled());

...
}

And will calling notifiers from interrupt-context just fine ?

-- 
viresh
