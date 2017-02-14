From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: PATCH] cpufreq: Do not clear real_cpus mask on policy init
Date: Tue, 14 Feb 2017 09:17:03 +0530
Message-ID: <20170214034703.GC3537@vireshk-i7>
References: <11448597.UpH3K2oSNs@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:37021 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751804AbdBNDrK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Feb 2017 22:47:10 -0500
Received: by mail-it0-f48.google.com with SMTP id x75so16806312itb.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Feb 2017 19:47:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <11448597.UpH3K2oSNs@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>

On 13-02-17, 13:44, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If new_policy is set in cpufreq_online(), the policy object has just
> been created and its real_cpus mask has been zeroed on allocation,
> and the driver's ->init() callback should not touch it.
> 
> It doesn't need to be cleared again, so don't do that.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -1166,8 +1166,6 @@ static int cpufreq_online(unsigned int c
>  	if (new_policy) {
>  		/* related_cpus should at least include policy->cpus. */
>  		cpumask_copy(policy->related_cpus, policy->cpus);
> -		/* Clear mask of registered CPUs */
> -		cpumask_clear(policy->real_cpus);
>  	}
>  
>  	/*

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
