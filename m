From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] ARM: EXYNOS: cpu hotplug: use v7_exit_coherency_flush
 macro for cache disabling
Date: Tue, 22 Apr 2014 16:36:34 +0200
Message-ID: <53567E72.1030201@linaro.org>
References: <1398176280-7258-1-git-send-email-leela.krishna@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:52484 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428AbaDVOgJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Apr 2014 10:36:09 -0400
Received: by mail-we0-f179.google.com with SMTP id x48so5128645wes.10
        for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2014 07:36:08 -0700 (PDT)
In-Reply-To: <1398176280-7258-1-git-send-email-leela.krishna@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leela Krishna Amudala <leela.krishna@linaro.org>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: kgene.kim@samsung.com, amit.kucheria@linaro.org

On 04/22/2014 04:18 PM, Leela Krishna Amudala wrote:
> Remove the duplicated code for cache disabling and use "v7_exit_coher=
ency_flush"
> macro to do the same job.

Hi Leela,

thanks for this patch! It would be nice if you can describe why those=20
macros can be replaced by the generic v7_exit_coherency_flush macro.

>
> Signed-off-by: Leela Krishna Amudala <leela.krishna@linaro.org>
>
> ---
> cpu hotplug is tested with 3.15-rc1 on Origen(which has cortex A9) an=
d
> Arndale octa(which has cortex A7 and A15) boards.
>
>   arch/arm/mach-exynos/hotplug.c |   56 ++---------------------------=
-----------
>   1 file changed, 2 insertions(+), 54 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/ho=
tplug.c
> index 5eead53..9eb8d1b 100644
> --- a/arch/arm/mach-exynos/hotplug.c
> +++ b/arch/arm/mach-exynos/hotplug.c
> @@ -24,56 +24,6 @@
>   #include "common.h"
>   #include "regs-pmu.h"
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
> -	  : "=3D&r" (v)
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
> -	  : "=3D&r" (v)
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
> -	: "=3D&r" (v)
> -	: "Ir" (0x40)
> -	: "cc");
> -
> -	isb();
> -	dsb();
> -}
> -
>   static inline void cpu_leave_lowpower(void)
>   {
>   	unsigned int v;
> @@ -141,10 +91,8 @@ void __ref exynos_cpu_die(unsigned int cpu)
>   	 * appropriate sequence for entering low power.
>   	 */
>   	asm("mrc p15, 0, %0, c0, c0, 0" : "=3Dr"(primary_part) : : "cc");

Can't you remove this asm line above as well as the primary_part variab=
le ?

> -	if ((primary_part & 0xfff0) =3D=3D 0xc0f0)
> -		cpu_enter_lowpower_a15();
> -	else
> -		cpu_enter_lowpower_a9();
> +
> +	v7_exit_coherency_flush(louis);
>
>   	platform_do_lowpower(cpu, &spurious);
>
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

