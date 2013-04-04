From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [PATCH 1/9] ARM: cpuidle: remove useless declaration
Date: Fri, 05 Apr 2013 00:30:30 +0200
Message-ID: <2872594.RzEdba6jp9@vostro.rjw.lan>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1364991322-20585-1-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, deepthi-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, April 03, 2013 02:15:14 PM Daniel Lezcano wrote:
> The noop functions code is not necessary because the header file is
> included in files which are compiled when CONFIG_CPU_IDLE is on.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

I need an ACK for this one.

Thanks,
Rafael


> ---
>  arch/arm/include/asm/cpuidle.h |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
> index 2fca60a..7367787 100644
> --- a/arch/arm/include/asm/cpuidle.h
> +++ b/arch/arm/include/asm/cpuidle.h
> @@ -1,13 +1,8 @@
>  #ifndef __ASM_ARM_CPUIDLE_H
>  #define __ASM_ARM_CPUIDLE_H
>  
> -#ifdef CONFIG_CPU_IDLE
>  extern int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
> -		struct cpuidle_driver *drv, int index);
> -#else
> -static inline int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
> -		struct cpuidle_driver *drv, int index) { return -ENODEV; }
> -#endif
> +				    struct cpuidle_driver *drv, int index);
>  
>  /* Common ARM WFI state */
>  #define ARM_CPUIDLE_WFI_STATE_PWR(p) {\
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
