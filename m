From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH] ARM: EXYNOS: cpu hotplug: use v7_exit_coherency_flush
 macro for cache disabling
Date: Tue, 22 Apr 2014 14:14:32 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1404221414060.980@knanqh.ubzr>
References: <1398176280-7258-1-git-send-email-leela.krishna@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:60496 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbaDVSOf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Apr 2014 14:14:35 -0400
Received: by mail-qa0-f54.google.com with SMTP id w8so5424667qac.27
        for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2014 11:14:34 -0700 (PDT)
In-Reply-To: <1398176280-7258-1-git-send-email-leela.krishna@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leela Krishna Amudala <leela.krishna@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, daniel.lezcano@linaro.org, kgene.kim@samsung.com, amit.kucheria@linaro.org

On Tue, 22 Apr 2014, Leela Krishna Amudala wrote:

> Remove the duplicated code for cache disabling and use "v7_exit_coherency_flush"
> macro to do the same job.
> 
> Signed-off-by: Leela Krishna Amudala <leela.krishna@linaro.org>

Acked-by: Nicolas Pitre <nico@linaro.org>


> 
> ---
> cpu hotplug is tested with 3.15-rc1 on Origen(which has cortex A9) and
> Arndale octa(which has cortex A7 and A15) boards.
> 
>  arch/arm/mach-exynos/hotplug.c |   56 ++--------------------------------------
>  1 file changed, 2 insertions(+), 54 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
> index 5eead53..9eb8d1b 100644
> --- a/arch/arm/mach-exynos/hotplug.c
> +++ b/arch/arm/mach-exynos/hotplug.c
> @@ -24,56 +24,6 @@
>  #include "common.h"
>  #include "regs-pmu.h"
>  
> -static inline void cpu_enter_lowpower_a9(void)
> -{
> -	unsigned int v;
> -
> -	asm volatile(
> -	"	mcr	p15, 0, %1, c7, c5, 0\n"
> -	"	mcr	p15, 0, %1, c7, c10, 4\n"
> -	/*
> -	 * Turn off coherency
> -	 */
> -	"	mrc	p15, 0, %0, c1, c0, 1\n"
> -	"	bic	%0, %0, %3\n"
> -	"	mcr	p15, 0, %0, c1, c0, 1\n"
> -	"	mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	bic	%0, %0, %2\n"
> -	"	mcr	p15, 0, %0, c1, c0, 0\n"
> -	  : "=&r" (v)
> -	  : "r" (0), "Ir" (CR_C), "Ir" (0x40)
> -	  : "cc");
> -}
> -
> -static inline void cpu_enter_lowpower_a15(void)
> -{
> -	unsigned int v;
> -
> -	asm volatile(
> -	"	mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	bic	%0, %0, %1\n"
> -	"	mcr	p15, 0, %0, c1, c0, 0\n"
> -	  : "=&r" (v)
> -	  : "Ir" (CR_C)
> -	  : "cc");
> -
> -	flush_cache_louis();
> -
> -	asm volatile(
> -	/*
> -	* Turn off coherency
> -	*/
> -	"	mrc	p15, 0, %0, c1, c0, 1\n"
> -	"	bic	%0, %0, %1\n"
> -	"	mcr	p15, 0, %0, c1, c0, 1\n"
> -	: "=&r" (v)
> -	: "Ir" (0x40)
> -	: "cc");
> -
> -	isb();
> -	dsb();
> -}
> -
>  static inline void cpu_leave_lowpower(void)
>  {
>  	unsigned int v;
> @@ -141,10 +91,8 @@ void __ref exynos_cpu_die(unsigned int cpu)
>  	 * appropriate sequence for entering low power.
>  	 */
>  	asm("mrc p15, 0, %0, c0, c0, 0" : "=r"(primary_part) : : "cc");
> -	if ((primary_part & 0xfff0) == 0xc0f0)
> -		cpu_enter_lowpower_a15();
> -	else
> -		cpu_enter_lowpower_a9();
> +
> +	v7_exit_coherency_flush(louis);
>  
>  	platform_do_lowpower(cpu, &spurious);
>  
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
