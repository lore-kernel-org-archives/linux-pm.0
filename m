From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Simplify switch () in cpufreq_cpu_callback()
Date: Thu, 7 Apr 2016 09:58:49 +0530
Message-ID: <20160407042849.GB14903@vireshk-i7>
References: <4473117.ktOSeKFDYJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35450 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbcDGE2w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 00:28:52 -0400
Received: by mail-pa0-f54.google.com with SMTP id td3so46806927pab.2
        for <linux-pm@vger.kernel.org>; Wed, 06 Apr 2016 21:28:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4473117.ktOSeKFDYJ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 07-04-16, 03:30, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Merge two switch entries that do the same thing in
> cpufreq_cpu_callback().
> 
> No functional changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -2312,16 +2312,13 @@ static int cpufreq_cpu_callback(struct n
>  
>  	switch (action & ~CPU_TASKS_FROZEN) {
>  	case CPU_ONLINE:
> +	case CPU_DOWN_FAILED:
>  		cpufreq_online(cpu);
>  		break;
>  
>  	case CPU_DOWN_PREPARE:
>  		cpufreq_offline(cpu);
>  		break;
> -
> -	case CPU_DOWN_FAILED:
> -		cpufreq_online(cpu);
> -		break;
>  	}
>  	return NOTIFY_OK;
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
