From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] timer: move enum definition out of ifdef section
Date: Tue, 02 Apr 2013 01:24:55 +0200
Message-ID: <5116925.ZeoNyu5C6N@vostro.rjw.lan>
References: <1364379733-23725-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:49675 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757146Ab3DAXRV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 1 Apr 2013 19:17:21 -0400
In-Reply-To: <1364379733-23725-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, linus.walleij@linaro.org, kernel@pengutronix.de, santosh.shilimkar@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org

Hi,

All 5 in this series applied to linux-pm.git/linux-next.

What am I supposed to do with patches [6-15/15] in your previous series?

Are you going to resend the ones that have been ACKed?

Rafael


On Wednesday, March 27, 2013 11:22:09 AM Daniel Lezcano wrote:
> The next patch will setup automatically the broadcast timer for
> the different cpuidle driver when one idle state stops its timer.
> This will be part of the generic code.
> 
> But some ARM boards, like s3c64xx, uses cpuidle but without the
> CONFIG_GENERIC_CLOCKEVENTS_BUILD set. Hence the cpuidle framework
> will be compiled with the code supposed to be generic, that is
> with clockevents_notify and the different enum.
> 
> Also the function clockevents_notify is a noop macro, this is fine
> except the usual code is:
> 
> 	int cpu = smp_processor_id();
> 	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
> 
> and that raises a warning for the variable cpu which is not used.
> 
> Move the clock_event_nofitiers enum definition out of the
> CONFIG_GENERIC_CLOCKEVENTS_BUILD section to prevent a compilation
> error when these are used in the code.
> 
> Change the clockevents_notify macro to a static inline noop function
> to prevent a compilation warning.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  include/linux/clockchips.h |   32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
> index 6634652..f9fd937 100644
> --- a/include/linux/clockchips.h
> +++ b/include/linux/clockchips.h
> @@ -8,6 +8,20 @@
>  #ifndef _LINUX_CLOCKCHIPS_H
>  #define _LINUX_CLOCKCHIPS_H
>  
> +/* Clock event notification values */
> +enum clock_event_nofitiers {
> +	CLOCK_EVT_NOTIFY_ADD,
> +	CLOCK_EVT_NOTIFY_BROADCAST_ON,
> +	CLOCK_EVT_NOTIFY_BROADCAST_OFF,
> +	CLOCK_EVT_NOTIFY_BROADCAST_FORCE,
> +	CLOCK_EVT_NOTIFY_BROADCAST_ENTER,
> +	CLOCK_EVT_NOTIFY_BROADCAST_EXIT,
> +	CLOCK_EVT_NOTIFY_SUSPEND,
> +	CLOCK_EVT_NOTIFY_RESUME,
> +	CLOCK_EVT_NOTIFY_CPU_DYING,
> +	CLOCK_EVT_NOTIFY_CPU_DEAD,
> +};
> +
>  #ifdef CONFIG_GENERIC_CLOCKEVENTS_BUILD
>  
>  #include <linux/clocksource.h>
> @@ -26,20 +40,6 @@ enum clock_event_mode {
>  	CLOCK_EVT_MODE_RESUME,
>  };
>  
> -/* Clock event notification values */
> -enum clock_event_nofitiers {
> -	CLOCK_EVT_NOTIFY_ADD,
> -	CLOCK_EVT_NOTIFY_BROADCAST_ON,
> -	CLOCK_EVT_NOTIFY_BROADCAST_OFF,
> -	CLOCK_EVT_NOTIFY_BROADCAST_FORCE,
> -	CLOCK_EVT_NOTIFY_BROADCAST_ENTER,
> -	CLOCK_EVT_NOTIFY_BROADCAST_EXIT,
> -	CLOCK_EVT_NOTIFY_SUSPEND,
> -	CLOCK_EVT_NOTIFY_RESUME,
> -	CLOCK_EVT_NOTIFY_CPU_DYING,
> -	CLOCK_EVT_NOTIFY_CPU_DEAD,
> -};
> -
>  /*
>   * Clock event features
>   */
> @@ -173,7 +173,7 @@ extern int tick_receive_broadcast(void);
>  #ifdef CONFIG_GENERIC_CLOCKEVENTS
>  extern void clockevents_notify(unsigned long reason, void *arg);
>  #else
> -# define clockevents_notify(reason, arg) do { } while (0)
> +static inline void clockevents_notify(unsigned long reason, void *arg) {}
>  #endif
>  
>  #else /* CONFIG_GENERIC_CLOCKEVENTS_BUILD */
> @@ -181,7 +181,7 @@ extern void clockevents_notify(unsigned long reason, void *arg);
>  static inline void clockevents_suspend(void) {}
>  static inline void clockevents_resume(void) {}
>  
> -#define clockevents_notify(reason, arg) do { } while (0)
> +static inline void clockevents_notify(unsigned long reason, void *arg) {}
>  
>  #endif
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
