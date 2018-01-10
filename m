From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: Use power efficient workqueue
Date: Wed, 10 Jan 2018 11:28:05 -0800
Message-ID: <20180110192803.GC3837@localhost.localdomain>
References: <1514971456-2877-1-git-send-email-leo.yan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1514971456-2877-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 03, 2018 at 05:24:16PM +0800, Leo Yan wrote:
> Thermal core framework uses the system_freezable_wq workqueue as its
> workqueue for polling temperature. Using system_freezable_wq workqueue
> prevents the scheduler to make smart decision about the best place to
> schedule the work.
> 
> This commit replaces system_freezable_wq with
> system_freezable_power_efficient_wq. With kernel configuration
> CONFIG_WQ_POWER_EFFICIENT is enabled, the work can be scheduled on the
> best CPU from a power or a performance point of view.
> 
> This commit is inspired by Vincent Guittot patch "netfilter: conntrack:
> use power efficient workqueue" and verified on 96boards Hikey960.

The case may not be the same as for netfilter and for thermal.

what is the worst case scheduling delay here?

More importantly, what problem are you really trying to solve?
Do you have a case in which thermal WQs are consuming too much CPUs?
Do you care describing (also in the commit)?

> 
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/thermal/thermal_core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 2b1b0ba..ba90f71 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -293,11 +293,12 @@ static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
>  					    int delay)
>  {
>  	if (delay > 1000)
> -		mod_delayed_work(system_freezable_wq, &tz->poll_queue,
> +		mod_delayed_work(system_freezable_power_efficient_wq,
> +				 &tz->poll_queue,
>  				 round_jiffies(msecs_to_jiffies(delay)));
>  	else if (delay)
> -		mod_delayed_work(system_freezable_wq, &tz->poll_queue,
> -				 msecs_to_jiffies(delay));
> +		mod_delayed_work(system_freezable_power_efficient_wq,
> +				 &tz->poll_queue, msecs_to_jiffies(delay));
>  	else
>  		cancel_delayed_work(&tz->poll_queue);
>  }
> -- 
> 2.7.4
> 
