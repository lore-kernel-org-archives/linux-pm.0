From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Simplify cpufreq_can_do_remote_dvfs()
Date: Mon, 7 Aug 2017 09:03:53 +0530
Message-ID: <20170807033353.GD28857@vireshk-i7>
References: <1957547.1DvPFJ11E3@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34350 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbdHGDd6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Aug 2017 23:33:58 -0400
Received: by mail-pg0-f47.google.com with SMTP id u185so28764196pgb.1
        for <linux-pm@vger.kernel.org>; Sun, 06 Aug 2017 20:33:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1957547.1DvPFJ11E3@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 04-08-17, 14:57, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The if () in cpufreq_can_do_remote_dvfs() is superfluous, so drop
> it and simply return the value of the expression under it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> On top of the current linux-next.
> 
> ---
>  include/linux/cpufreq.h |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> Index: linux-pm/include/linux/cpufreq.h
> ===================================================================
> --- linux-pm.orig/include/linux/cpufreq.h
> +++ linux-pm/include/linux/cpufreq.h
> @@ -578,11 +578,8 @@ static inline bool cpufreq_can_do_remote
>  	 * - dvfs_possible_from_any_cpu flag is set
>  	 * - the local and remote CPUs share cpufreq policy
>  	 */
> -	if (policy->dvfs_possible_from_any_cpu ||
> -	    cpumask_test_cpu(smp_processor_id(), policy->cpus))
> -		return true;
> -
> -	return false;
> +	return policy->dvfs_possible_from_any_cpu ||
> +		cpumask_test_cpu(smp_processor_id(), policy->cpus);
>  }
>  
>  /*********************************************************************

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
