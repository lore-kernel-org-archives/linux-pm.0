From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [V3 patch 03/19] ARM: OMAP3: remove cpuidle_wrap_enter
Date: Fri, 19 Apr 2013 15:17:53 -0700
Message-ID: <87vc7iw4fi.fsf@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
	<1365770165-27096-4-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:48248 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933748Ab3DSWR5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Apr 2013 18:17:57 -0400
Received: by mail-pd0-f177.google.com with SMTP id u11so2460341pdi.36
        for <linux-pm@vger.kernel.org>; Fri, 19 Apr 2013 15:17:57 -0700 (PDT)
In-Reply-To: <1365770165-27096-4-git-send-email-daniel.lezcano@linaro.org>
	(Daniel Lezcano's message of "Fri, 12 Apr 2013 14:35:49 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> In a previous commit the en_core_tk_irqen flag has been added but we missed
> the cpuidle_wrap_enter which was doing the job to measure the time for the
> 'omap3_enter_idle' function.
>
> Actually, I don't see any reason to use this wrapper in the code. In the better
> case, the time computation is not correctly done because of the different
> operations done in omap3_enter_idle_bm which were not taken into account
> before the en_core_tk_irqen flag was set.
>
> As the time is reflected for the state overridden by the omap3_enter_idle_bm,
> using the wrapper is pointless now, so removing it.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

The patch itself is fine, but the changelog is confusing, IMO.

I think you just need to say that since the en_core_tk flag is being
used, the wrapper is duplicating the time measurement already being done
by the core, so it should be removed.

Kevin


> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |   30 +++++++++---------------------
>  1 file changed, 9 insertions(+), 21 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 4f67a5b..a56310a 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -99,11 +99,15 @@ static struct omap3_idle_statedata omap3_idle_data[] = {
>  	},
>  };
>  
> -/* Private functions */
> -
> -static int __omap3_enter_idle(struct cpuidle_device *dev,
> -				struct cpuidle_driver *drv,
> -				int index)
> +/**
> + * omap3_enter_idle - Programs OMAP3 to enter the specified state
> + * @dev: cpuidle device
> + * @drv: cpuidle driver
> + * @index: the index of state to be entered
> + */
> +static int omap3_enter_idle(struct cpuidle_device *dev,
> +			    struct cpuidle_driver *drv,
> +			    int index)
>  {
>  	struct omap3_idle_statedata *cx = &omap3_idle_data[index];
>  
> @@ -149,22 +153,6 @@ return_sleep_time:
>  }
>  
>  /**
> - * omap3_enter_idle - Programs OMAP3 to enter the specified state
> - * @dev: cpuidle device
> - * @drv: cpuidle driver
> - * @index: the index of state to be entered
> - *
> - * Called from the CPUidle framework to program the device to the
> - * specified target state selected by the governor.
> - */
> -static inline int omap3_enter_idle(struct cpuidle_device *dev,
> -				struct cpuidle_driver *drv,
> -				int index)
> -{
> -	return cpuidle_wrap_enter(dev, drv, index, __omap3_enter_idle);
> -}
> -
> -/**
>   * next_valid_state - Find next valid C-state
>   * @dev: cpuidle device
>   * @drv: cpuidle driver
