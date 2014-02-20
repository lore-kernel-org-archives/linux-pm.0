From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 08/10] MIPS: support use of cpuidle
Date: Thu, 20 Feb 2014 09:52:26 +0100
Message-ID: <5305C24A.1070006@linaro.org>
References: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com> <1389794137-11361-9-git-send-email-paul.burton@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:36624 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254AbaBTIw3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2014 03:52:29 -0500
Received: by mail-we0-f179.google.com with SMTP id q58so1191842wes.24
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2014 00:52:27 -0800 (PST)
In-Reply-To: <1389794137-11361-9-git-send-email-paul.burton@imgtec.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 01/15/2014 02:55 PM, Paul Burton wrote:
> This patch lays the groundwork for MIPS platforms to make use of the
> cpuidle framework. The arch_cpu_idle function simply calls cpuidle &
> falls back to the regular cpu_wait path if cpuidle should fail (eg. i=
f
> it's not selected or no driver is registered). A generic cpuidle stat=
e
> for the wait instruction is introduced, intended to ease use of the w=
ait
> instruction from cpuidle drivers and reduce code duplication.

Hi,

What is the status of this patchset ? Still need comments ?

Thanks
   -- Daniel

>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> ---
>   arch/mips/Kconfig            |  2 ++
>   arch/mips/include/asm/idle.h | 14 ++++++++++++++
>   arch/mips/kernel/idle.c      | 20 +++++++++++++++++++-
>   3 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 5bc27c0..95f2f11 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1838,6 +1838,8 @@ config CPU_R4K_CACHE_TLB
>   	bool
>   	default y if !(CPU_R3000 || CPU_R8000 || CPU_SB1 || CPU_TX39XX || =
CPU_CAVIUM_OCTEON)
>
> +source "drivers/cpuidle/Kconfig"
> +
>   choice
>   	prompt "MIPS MT options"
>
> diff --git a/arch/mips/include/asm/idle.h b/arch/mips/include/asm/idl=
e.h
> index d192158..d9f932d 100644
> --- a/arch/mips/include/asm/idle.h
> +++ b/arch/mips/include/asm/idle.h
> @@ -1,6 +1,7 @@
>   #ifndef __ASM_IDLE_H
>   #define __ASM_IDLE_H
>
> +#include <linux/cpuidle.h>
>   #include <linux/linkage.h>
>
>   extern void (*cpu_wait)(void);
> @@ -20,4 +21,17 @@ static inline int address_is_in_r4k_wait_irqoff(un=
signed long addr)
>   	       addr < (unsigned long)__pastwait;
>   }
>
> +extern int mips_cpuidle_wait_enter(struct cpuidle_device *dev,
> +				   struct cpuidle_driver *drv, int index);
> +
> +#define MIPS_CPUIDLE_WAIT_STATE {\
> +	.enter			=3D mips_cpuidle_wait_enter,\
> +	.exit_latency		=3D 1,\
> +	.target_residency	=3D 1,\
> +	.power_usage		=3D UINT_MAX,\
> +	.flags			=3D CPUIDLE_FLAG_TIME_VALID,\
> +	.name			=3D "wait",\
> +	.desc			=3D "MIPS wait",\
> +}
> +
>   #endif /* __ASM_IDLE_H  */
> diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
> index 3553243..64e91e4 100644
> --- a/arch/mips/kernel/idle.c
> +++ b/arch/mips/kernel/idle.c
> @@ -11,6 +11,7 @@
>    * as published by the Free Software Foundation; either version
>    * 2 of the License, or (at your option) any later version.
>    */
> +#include <linux/cpuidle.h>
>   #include <linux/export.h>
>   #include <linux/init.h>
>   #include <linux/irqflags.h>
> @@ -239,7 +240,7 @@ static void smtc_idle_hook(void)
>   #endif
>   }
>
> -void arch_cpu_idle(void)
> +static void mips_cpu_idle(void)
>   {
>   	smtc_idle_hook();
>   	if (cpu_wait)
> @@ -247,3 +248,20 @@ void arch_cpu_idle(void)
>   	else
>   		local_irq_enable();
>   }
> +
> +void arch_cpu_idle(void)
> +{
> +	if (cpuidle_idle_call())
> +		mips_cpu_idle();
> +}
> +
> +#ifdef CONFIG_CPU_IDLE
> +
> +int mips_cpuidle_wait_enter(struct cpuidle_device *dev,
> +			    struct cpuidle_driver *drv, int index)
> +{
> +	mips_cpu_idle();
> +	return index;
> +}
> +
> +#endif
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

