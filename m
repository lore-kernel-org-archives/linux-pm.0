From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/9] idle: move the cpuidle entry point to the generic
 idle loop
Date: Mon, 27 Jan 2014 09:32:19 +0100
Message-ID: <52E61993.2090705@linaro.org>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org> <1390802904-28399-5-git-send-email-nicolas.pitre@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:45548 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbaA0IcT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2014 03:32:19 -0500
Received: by mail-wg0-f44.google.com with SMTP id l18so5217905wgh.35
        for <linux-pm@vger.kernel.org>; Mon, 27 Jan 2014 00:32:18 -0800 (PST)
In-Reply-To: <1390802904-28399-5-git-send-email-nicolas.pitre@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org

On 01/27/2014 07:08 AM, Nicolas Pitre wrote:
> In order to integrate cpuidle with the scheduler, we must have a bett=
er
> proximity in the core code with what cpuidle is doing and not delegat=
e
> such interaction to arch code.
>
> Architectures implementing arch_cpu_idle() should simply enter
> a cheap idle mode in the absence of a proper cpuidle driver.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

This patch without the next ones will lead to an extra call to=20
cpuidle_idle_call.

	cpuidle_idle_call
		arch_cpu_idle
			cpuidle_idle_call
				x86_idle

But I guess it is acceptable as it is fixed with the next patches of th=
e=20
serie.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   kernel/cpu/idle.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/cpu/idle.c b/kernel/cpu/idle.c
> index 4e327e211b..a6f40ad9f8 100644
> --- a/kernel/cpu/idle.c
> +++ b/kernel/cpu/idle.c
> @@ -3,6 +3,7 @@
>    */
>   #include <linux/sched.h>
>   #include <linux/cpu.h>
> +#include <linux/cpuidle.h>
>   #include <linux/tick.h>
>   #include <linux/mm.h>
>   #include <linux/stackprotector.h>
> @@ -94,7 +95,8 @@ static void cpu_idle_loop(void)
>   				if (!current_clr_polling_and_test()) {
>   					stop_critical_timings();
>   					rcu_idle_enter();
> -					arch_cpu_idle();
> +					if (cpuidle_idle_call())
> +						arch_cpu_idle();
>   					WARN_ON_ONCE(irqs_disabled());
>   					rcu_idle_exit();
>   					start_critical_timings();
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

