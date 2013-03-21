From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/4][resend] cpuidle : handle clockevent notify from the
 cpuidle framework
Date: Thu, 21 Mar 2013 18:29:03 +0530
Message-ID: <514B0417.6020401@ti.com>
References: <1363868494-5503-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57106 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754222Ab3CUM5l (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 21 Mar 2013 08:57:41 -0400
In-Reply-To: <1363868494-5503-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org, lenb@kernel.org, linus.walleij@linaro.org, rnayak@ti.com, kernel@pengutronix.de, tglx@linutronix.de

On Thursday 21 March 2013 05:51 PM, Daniel Lezcano wrote:
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
Seems like good clean-up from drivers.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

How about taking care of cpu_pm_notifiers() as well with some
additional flag for CPU and cluster power state. That can help
to reduce and consolidate the code. What you say ?

Regards,
Santosh

Regards,
Santosh

