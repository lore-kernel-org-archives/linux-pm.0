From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/4][resend] cpuidle : handle clockevent notify from the cpuidle framework
Date: Fri, 22 Mar 2013 01:41:54 +0100
Message-ID: <3146267.BqM2yzpcAH@vostro.rjw.lan>
References: <1363868494-5503-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:59694 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932488Ab3CVAef (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 21 Mar 2013 20:34:35 -0400
In-Reply-To: <1363868494-5503-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org, lenb@kernel.org, linus.walleij@linaro.org, santosh.shilimkar@ti.com, rnayak@ti.com, kernel@pengutronix.de, tglx@linutronix.de

On Thursday, March 21, 2013 01:21:31 PM Daniel Lezcano wrote:
> When a cpu enters a deep idle state, the local timers are stopped and
> the time framework falls back to the timer device used as a broadcast
> timer.
> 
> The different cpuidle drivers are calling clockevents_notify ENTER/EXIT
> when the idle state stops the local timer.
> 
> Add a new flag CPUIDLE_FLAG_TIMER_STOP which can be set by the cpuidle
> drivers. If the flag is set, the cpuidle core code takes care of the
> notification on behalf of the driver to avoid pointless code duplication.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>

All patches in the series applied to linux-pm.git/bleeding-edge and will be
moved to linux-next after build testing.

Thanks,
Rafael


> ---
>  drivers/cpuidle/cpuidle.c |    9 +++++++++
>  include/linux/cpuidle.h   |    1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index eba6929..c500370 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -8,6 +8,7 @@
>   * This code is licenced under the GPL.
>   */
>  
> +#include <linux/clockchips.h>
>  #include <linux/kernel.h>
>  #include <linux/mutex.h>
>  #include <linux/sched.h>
> @@ -146,12 +147,20 @@ int cpuidle_idle_call(void)
>  
>  	trace_cpu_idle_rcuidle(next_state, dev->cpu);
>  
> +	if (drv->states[next_state].flags & CPUIDLE_FLAG_TIMER_STOP)
> +		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER,
> +				   &dev->cpu);
> +
>  	if (cpuidle_state_is_coupled(dev, drv, next_state))
>  		entered_state = cpuidle_enter_state_coupled(dev, drv,
>  							    next_state);
>  	else
>  		entered_state = cpuidle_enter_state(dev, drv, next_state);
>  
> +	if (drv->states[next_state].flags & CPUIDLE_FLAG_TIMER_STOP)
> +		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT,
> +				   &dev->cpu);
> +
>  	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
>  
>  	/* give the governor an opportunity to reflect on the outcome */
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 480c14d..a837b33 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -57,6 +57,7 @@ struct cpuidle_state {
>  /* Idle State Flags */
>  #define CPUIDLE_FLAG_TIME_VALID	(0x01) /* is residency time measurable? */
>  #define CPUIDLE_FLAG_COUPLED	(0x02) /* state applies to multiple cpus */
> +#define CPUIDLE_FLAG_TIMER_STOP (0x04)  /* timer is stopped on this state */
>  
>  #define CPUIDLE_DRIVER_FLAGS_MASK (0xFFFF0000)
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
