From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 7/9] SH: remove redundant cpuidle_idle_call()
Date: Mon, 27 Jan 2014 09:35:44 +0100
Message-ID: <52E61A60.3030202@linaro.org>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org> <1390802904-28399-8-git-send-email-nicolas.pitre@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:56627 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbaA0Ifo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2014 03:35:44 -0500
Received: by mail-wg0-f49.google.com with SMTP id a1so5301181wgh.16
        for <linux-pm@vger.kernel.org>; Mon, 27 Jan 2014 00:35:43 -0800 (PST)
In-Reply-To: <1390802904-28399-8-git-send-email-nicolas.pitre@linaro.org>
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
>   arch/sh/kernel/idle.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/sh/kernel/idle.c b/arch/sh/kernel/idle.c
> index 2ea4483fd7..be616ee0cf 100644
> --- a/arch/sh/kernel/idle.c
> +++ b/arch/sh/kernel/idle.c
> @@ -16,7 +16,6 @@
>   #include <linux/thread_info.h>
>   #include <linux/irqflags.h>
>   #include <linux/smp.h>
> -#include <linux/cpuidle.h>
>   #include <linux/atomic.h>
>   #include <asm/pgalloc.h>
>   #include <asm/smp.h>
> @@ -40,8 +39,7 @@ void arch_cpu_idle_dead(void)
>
>   void arch_cpu_idle(void)
>   {
> -	if (cpuidle_idle_call())
> -		sh_idle();
> +	sh_idle();
>   }
>
>   void __init select_idle_routine(void)
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

