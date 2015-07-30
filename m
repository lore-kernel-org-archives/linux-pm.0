From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Lock CPU online/offline in
 cpufreq_register_driver()
Date: Thu, 30 Jul 2015 11:18:01 +0530
Message-ID: <20150730054801.GJ5100@linux>
References: <2126034.7irFieEIfi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34515 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbbG3FsH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2015 01:48:07 -0400
Received: by pacan13 with SMTP id an13so17969559pac.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2015 22:48:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2126034.7irFieEIfi@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@arm.linux.org.co.uk>

On 30-07-15, 01:45, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> To protect against races with concurrent CPU online/offline, call
> get_online_cpus() before registering a cpufreq driver.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -2471,10 +2471,14 @@ int cpufreq_register_driver(struct cpufr
>  
>  	pr_debug("trying to register driver %s\n", driver_data->name);
>  
> +	/* Protect against concurrent CPU online/offline. */
> +	get_online_cpus();
> +
>  	write_lock_irqsave(&cpufreq_driver_lock, flags);
>  	if (cpufreq_driver) {
>  		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> -		return -EEXIST;
> +		ret = -EEXIST;
> +		goto out;
>  	}
>  	cpufreq_driver = driver_data;
>  	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> @@ -2513,7 +2517,10 @@ int cpufreq_register_driver(struct cpufr
>  	register_hotcpu_notifier(&cpufreq_cpu_notifier);
>  	pr_debug("driver %s up and running\n", driver_data->name);
>  
> -	return 0;
> +out:
> +	put_online_cpus();
> +	return ret;
> +
>  err_if_unreg:
>  	subsys_interface_unregister(&cpufreq_interface);
>  err_boost_unreg:
> @@ -2523,7 +2530,7 @@ err_null_driver:
>  	write_lock_irqsave(&cpufreq_driver_lock, flags);
>  	cpufreq_driver = NULL;
>  	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> -	return ret;
> +	goto out;
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_register_driver);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
