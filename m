From: Alex Shi <alex.shi@linaro.org>
Subject: Re: 9908859acaa9 cpuidle/menu: add per CPU PM QoS resume latency
 consideration
Date: Fri, 24 Feb 2017 09:49:25 +0800
Message-ID: <55ee4ca6-9369-06b5-b680-f6483ca496af@linaro.org>
References: <1487768197.27533.5.camel@gmx.de>
 <2050688.jCOqd8xbcD@aspire.rjw.lan>
 <e8261472-4338-eab2-98e1-5dd6039899f7@linaro.org>
 <2909793.Vfsrmqmg03@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2909793.Vfsrmqmg03@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>, Rik van Riel <riel@redhat.com>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


> Well, first, please submit this properly (with a proper subject and CC to linux-pm)
> if I'm expected to apply it.
> 

Hi Rafael,

Thanks for reminder!
A raw read function looks better. And maybe useful for others.

Acked-by: Alex Shi <alex.shi@linaro.org>

> 
> 
> 
> ---
>  drivers/base/power/qos.c         |    3 +--
>  drivers/cpuidle/governors/menu.c |    2 +-
>  include/linux/pm_qos.h           |    7 +++++++
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/base/power/qos.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/qos.c
> +++ linux-pm/drivers/base/power/qos.c
> @@ -108,8 +108,7 @@ s32 __dev_pm_qos_read_value(struct devic
>  {
>  	lockdep_assert_held(&dev->power.lock);
>  
> -	return IS_ERR_OR_NULL(dev->power.qos) ?
> -		0 : pm_qos_read_value(&dev->power.qos->resume_latency);
> +	return dev_pm_qos_raw_read_value(dev);
>  }
>  
>  /**
> Index: linux-pm/drivers/cpuidle/governors/menu.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -287,7 +287,7 @@ static int menu_select(struct cpuidle_dr
>  	unsigned int interactivity_req;
>  	unsigned int expected_interval;
>  	unsigned long nr_iowaiters, cpu_load;
> -	int resume_latency = dev_pm_qos_read_value(device);
> +	int resume_latency = dev_pm_qos_raw_read_value(device);
>  
>  	if (data->needs_update) {
>  		menu_update(drv, dev);
> Index: linux-pm/include/linux/pm_qos.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm_qos.h
> +++ linux-pm/include/linux/pm_qos.h
> @@ -172,6 +172,12 @@ static inline s32 dev_pm_qos_requested_f
>  {
>  	return dev->power.qos->flags_req->data.flr.flags;
>  }
> +
> +static inline s32 dev_pm_qos_raw_read_value(struct device *dev)
> +{
> +	return IS_ERR_OR_NULL(dev->power.qos) ?
> +		0 : pm_qos_read_value(&dev->power.qos->resume_latency);
> +}
>  #else
>  static inline enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev,
>  							  s32 mask)
> @@ -236,6 +242,7 @@ static inline void dev_pm_qos_hide_laten
>  
>  static inline s32 dev_pm_qos_requested_resume_latency(struct device *dev) { return 0; }
>  static inline s32 dev_pm_qos_requested_flags(struct device *dev) { return 0; }
> +static inline s32 dev_pm_qos_raw_read_value(struct device *dev) { return 0; }
>  #endif
>  
>  #endif
> 
