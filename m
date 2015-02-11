From: Mason <mpeg.blue@free.fr>
Subject: Re: Delays, clocks, timers, hrtimers, etc
Date: Wed, 11 Feb 2015 13:58:45 -0800
Message-ID: <54DBD095.3040800@free.fr>
References: <54C8E125.3070905@free.fr> <e028a4eb604a491f4438557f4a1373ef@agner.ch> <54D52F84.9050600@free.fr> <266c7b1ff2d1a8ba0ae4866f4fb4eca5@agner.ch> <54D576B1.4000001@free.fr> <54D903F6.3050608@codeaurora.org> <54D93556.9050008@free.fr> <54D93FFA.3090506@codeaurora.org> <54D947B4.4080401@free.fr> <54DB94B0.8020000@free.fr> <20150211184515.GB11190@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:39090 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753004AbbBKV7J (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 11 Feb 2015 16:59:09 -0500
In-Reply-To: <20150211184515.GB11190@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, cpufreq <cpufreq@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>, Stefan Agner <stefan@agner.ch>, Shawn Guo <shawn.guo@linaro.org>, Rob Herring <robh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>

Stephen Boyd wrote:

> Mason wrote:
>
>> Also, you wrote "I don't see any problem with the TWD dropping the
>> dependency on SMP." Would something as simple as this be acceptable?
>> (Most probably NOT; there are a lot of smp* occurrences in smp_twd.c
>> even the file name.) What is the rationale for the dependency?
>>
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index a34698d..47b02c8 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1565,7 +1565,6 @@ config HAVE_ARM_ARCH_TIMER
>>   config HAVE_ARM_TWD
>>          bool
>> -       depends on SMP
>>          select CLKSRC_OF if OF
>>          help
>>            This options enables support for the ARM timer and watchdog unit
>>
>
> Hmm it looks like we would also need to add this to the patch. It
> looks like a holdover from when the local timer APIs were around.
> Back then twd_local_timer_common_register() would fail if
> is_smp() was false or setup_max_cpus was 0. Now it will just
> register a clockevent that may or may not be used depending on
> what other clockevents are in the system and the ratings of those
> other clockevents.
>
> ----8<----
> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index 172c6a05d27f..e8f6d241881f 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -23,7 +23,6 @@
>   #include <linux/of_irq.h>
>   #include <linux/of_address.h>
>
> -#include <asm/smp_plat.h>
>   #include <asm/smp_twd.h>
>
>   /* set up by the platform code */
> @@ -388,9 +387,6 @@ static void __init twd_local_timer_of_register(struct device_node *np)
>   {
>   	int err;
>
> -	if (!is_smp() || !setup_max_cpus)
> -		return;
> -
>   	twd_ppi = irq_of_parse_and_map(np, 0);
>   	if (!twd_ppi) {
>   		err = -EINVAL;

Looking at the difference between OF and !OF registration functions
in smp_twd.c

!OF
   if (twd_base || twd_evt) return -EBUSY;
   assign twd_ppi and twd_base
   twd_local_timer_common_register(NULL)

OF
   if (!is_smp() || !setup_max_cpus) return; // TO BE DELETED
   assign twd_ppi and twd_base
   twd_local_timer_common_register(np)

I suppose OF guarantees that the init code is called only once?
(Hence the !OF guard code would be unnecessary.)

Regards.

