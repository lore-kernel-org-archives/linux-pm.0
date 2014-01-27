From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 8/9] X86: remove redundant cpuidle_idle_call()
Date: Mon, 27 Jan 2014 09:43:12 +0100
Message-ID: <52E61C20.50804@linaro.org>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org> <1390802904-28399-9-git-send-email-nicolas.pitre@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390802904-28399-9-git-send-email-nicolas.pitre@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On 01/27/2014 07:08 AM, Nicolas Pitre wrote:
> The core idle loop now takes care of it.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/x86/kernel/process.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 3fb8d95ab8..4505e2a950 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -298,10 +298,7 @@ void arch_cpu_idle_dead(void)
>    */
>   void arch_cpu_idle(void)
>   {
> -	if (cpuidle_idle_call())
> -		x86_idle();
> -	else
> -		local_irq_enable();

=46or the record, it was pointless to enable the local irq here because=
 it=20
is handled by the cpuidle framework when exiting the idle state.

> +	x86_idle();
>   }
>
>   /*
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
