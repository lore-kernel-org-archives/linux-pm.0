From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 11/12] cpufreq: governor: Make dbs_data_mutex static
Date: Thu, 18 Feb 2016 11:39:35 +0530
Message-ID: <20160218060935.GQ2610@vireshk-i7>
References: <2938006.67J0esUvOA@vostro.rjw.lan>
 <1655404.H6dIaK3J3n@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33000 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756850AbcBRGJs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 01:09:48 -0500
Received: by mail-pa0-f51.google.com with SMTP id fl4so24962765pad.0
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2016 22:09:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1655404.H6dIaK3J3n@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 18-02-16, 02:33, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> That mutex is only used by cpufreq_governor_dbs() and it doesn't
> need to be exported to modules, so make it static and drop the
> export incantation.
> 
> No functional changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c |    3 +--
>  drivers/cpufreq/cpufreq_governor.h |    1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
> +++ linux-pm/drivers/cpufreq/cpufreq_governor.c
> @@ -24,8 +24,7 @@
>  
>  static DEFINE_PER_CPU(struct cpu_dbs_info, cpu_dbs);
>  
> -DEFINE_MUTEX(dbs_data_mutex);
> -EXPORT_SYMBOL_GPL(dbs_data_mutex);
> +static DEFINE_MUTEX(dbs_data_mutex);
>  
>  /* Common sysfs tunables */
>  /**
> Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
> +++ linux-pm/drivers/cpufreq/cpufreq_governor.h
> @@ -178,7 +178,6 @@ struct od_ops {
>  			unsigned int freq_next, unsigned int relation);
>  };
>  
> -extern struct mutex dbs_data_mutex;
>  unsigned int dbs_update(struct cpufreq_policy *policy);
>  int cpufreq_governor_dbs(struct cpufreq_policy *policy, unsigned int event);
>  void od_register_powersave_bias_handler(unsigned int (*f)


Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
-- 
viresh
