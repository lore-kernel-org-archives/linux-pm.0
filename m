From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 5/9] ARM: remove redundant cpuidle_idle_call()
Date: Mon, 27 Jan 2014 09:33:13 +0100
Message-ID: <52E619C9.4050406@linaro.org>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org> <1390802904-28399-6-git-send-email-nicolas.pitre@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:46728 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbaA0IdN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2014 03:33:13 -0500
Received: by mail-wg0-f52.google.com with SMTP id b13so5124588wgh.31
        for <linux-pm@vger.kernel.org>; Mon, 27 Jan 2014 00:33:12 -0800 (PST)
In-Reply-To: <1390802904-28399-6-git-send-email-nicolas.pitre@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org

On 01/27/2014 07:08 AM, Nicolas Pitre wrote:
> The core idle loop now takes care of it.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> ---
>   arch/arm/kernel/process.c | 16 +++++-----------
>   1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 725b8c95e0..34a59b7614 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -30,7 +30,6 @@
>   #include <linux/uaccess.h>
>   #include <linux/random.h>
>   #include <linux/hw_breakpoint.h>
> -#include <linux/cpuidle.h>
>   #include <linux/leds.h>
>   #include <linux/reboot.h>
>
> @@ -133,7 +132,11 @@ EXPORT_SYMBOL_GPL(arm_pm_restart);
>
>   void (*arm_pm_idle)(void);
>
> -static void default_idle(void)
> +/*
> + * Called from the core idle loop.
> + */
> +
> +void arch_cpu_idle(void)
>   {
>   	if (arm_pm_idle)
>   		arm_pm_idle();
> @@ -163,15 +166,6 @@ void arch_cpu_idle_dead(void)
>   #endif
>
>   /*
> - * Called from the core idle loop.
> - */
> -void arch_cpu_idle(void)
> -{
> -	if (cpuidle_idle_call())
> -		default_idle();
> -}
> -
> -/*
>    * Called by kexec, immediately prior to machine_kexec().
>    *
>    * This must completely disable all secondary CPUs; simply causing =
those CPUs
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

