From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V1] PM: In kernel power management domain_pm created for async schedules
Date: Wed, 06 Dec 2017 14:50:16 +0100
Message-ID: <2799044.UXHTlt2n3n@aspire.rjw.lan>
References: <CGME20171206120714epcms5p70081d5bc518c3bb5f9cca4f56b203abf@epcms5p7> <20171206120714epcms5p70081d5bc518c3bb5f9cca4f56b203abf@epcms5p7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206120714epcms5p70081d5bc518c3bb5f9cca4f56b203abf@epcms5p7>
Sender: linux-kernel-owner@vger.kernel.org
To: vikas.bansal@samsung.com, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Greg, I'll take care of this if you don't mind.

On Wednesday, December 6, 2017 1:07:14 PM CET Vikas Bansal wrote:
> Description:
> 
> If there is a driver in system which starts creating async schedules
> just after resume (Same as our case, in which we faced issue).
> Then async_synchronize_full API in PM cores starts waiting for completion
> of async schedules created by that driver (Even though those are in a domain).
> Because of this kernel resume time is increased (We faces the same issue)
> and whole system is delayed.
> This problem can be solved by creating a domain for
> async schedules in PM core (As we solved in our case).
> Below patch is for solving this problem.

OK, it is more clear what's going on here.

First question, is the driver using the async things in the tree?

> Changelog:
> 1. Created Async domain domain_pm.
> 2. Converted async_schedule to async_schedule_domain.
> 3. Converted async_synchronize_full to async_synchronize_full_domain

This still isn't a proper changelog, but I can fix it up.

> Signed-off-by: Vikas Bansal <vikas.bansal@samsung.com>
> Signed-off-by: Anuj Gupta <anuj01.gupta@samsung.com>
> ---
>  drivers/base/power/main.c |   27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index db2f044..042b034 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -39,6 +39,7 @@
>  #include "power.h"
>  
>  typedef int (*pm_callback_t)(struct device *);
> +static ASYNC_DOMAIN(domain_pm);

Rename this to async_pm or similar (just use the word "async" in the name
at least or it will be super-confusing).

>  
>  /*
>   * The entries in the dpm_list list are in a depth first order, simply
> @@ -615,7 +616,8 @@ void dpm_noirq_resume_devices(pm_message_t state)
>  		reinit_completion(&dev->power.completion);
>  		if (is_async(dev)) {
>  			get_device(dev);
> -			async_schedule(async_resume_noirq, dev);
> +			async_schedule_domain(async_resume_noirq, dev, 
> +			&domain_pm);

This is not the right way to format the line above and you don't need to break
it (yes, it will be longer than 80 chars, but it will look better anyway).

>  		}
>  	}
>  
> @@ -641,7 +643,7 @@ void dpm_noirq_resume_devices(pm_message_t state)
>  		put_device(dev);
>  	}
>  	mutex_unlock(&dpm_list_mtx);
> -	async_synchronize_full();
> +	async_synchronize_full_domain(&domain_pm);
>  	dpm_show_time(starttime, state, 0, "noirq");
>  	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, false);
>  }
> @@ -755,7 +757,8 @@ void dpm_resume_early(pm_message_t state)
>  		reinit_completion(&dev->power.completion);
>  		if (is_async(dev)) {
>  			get_device(dev);
> -			async_schedule(async_resume_early, dev);
> +			async_schedule_domain(async_resume_early, dev, 
> +			&domain_pm);

Same here.

>  		}
>  	}
>  

Thanks,
Rafael
