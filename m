From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/7] cpufreq: Drop unnecessary label from
 cpufreq_add_dev()
Date: Mon, 27 Jul 2015 20:22:00 +0530
Message-ID: <20150727145200.GE18535@linux>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan>
 <3874727.Jpay9zgokc@vostro.rjw.lan>
 <1899761.i7upQxTcKo@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34380 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbbG0OwF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 10:52:05 -0400
Received: by pdbbh15 with SMTP id bh15so53316651pdb.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2015 07:52:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1899761.i7upQxTcKo@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On 27-07-15, 16:04, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The leftover out_release_rwsem label in cpufreq_add_dev() is not
> necessary any more and confusing, so drop it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -1237,7 +1237,7 @@ static int cpufreq_add_dev(struct device
>  		recover_policy = false;
>  		policy = cpufreq_policy_alloc(dev);
>  		if (!policy)
> -			goto out_release_rwsem;
> +			return -ENOMEM;
>  	}
>  
>  	cpumask_copy(policy->cpus, cpumask_of(cpu));
> @@ -1372,7 +1372,6 @@ out_exit_policy:
>  		cpufreq_driver->exit(policy);
>  out_free_policy:
>  	cpufreq_policy_free(policy, recover_policy);
> -out_release_rwsem:
>  	return ret;

There is no need to initialize ret to -ENOMEM now, please get rid of
that as well and add my

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
