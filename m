From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/9] idle: no more arch_cpu_idle_prepare() users
Date: Mon, 27 Jan 2014 09:24:31 +0100
Message-ID: <52E617BF.4030500@linaro.org>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org> <1390802904-28399-4-git-send-email-nicolas.pitre@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1390802904-28399-4-git-send-email-nicolas.pitre@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On 01/27/2014 07:08 AM, Nicolas Pitre wrote:
> ... so we can get rid of it entirely.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   include/linux/cpu.h | 1 -
>   kernel/cpu/idle.c   | 2 --
>   2 files changed, 3 deletions(-)
>
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index 03e235ad1b..218fab7521 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -221,7 +221,6 @@ void cpu_idle(void);
>   void cpu_idle_poll_ctrl(bool enable);
>
>   void arch_cpu_idle(void);
> -void arch_cpu_idle_prepare(void);
>   void arch_cpu_idle_enter(void);
>   void arch_cpu_idle_exit(void);
>   void arch_cpu_idle_dead(void);
> diff --git a/kernel/cpu/idle.c b/kernel/cpu/idle.c
> index 988573a9a3..4e327e211b 100644
> --- a/kernel/cpu/idle.c
> +++ b/kernel/cpu/idle.c
> @@ -52,7 +52,6 @@ static inline int cpu_idle_poll(void)
>   }
>
>   /* Weak implementations for optional arch specific functions */
> -void __weak arch_cpu_idle_prepare(void) { }
>   void __weak arch_cpu_idle_enter(void) { }
>   void __weak arch_cpu_idle_exit(void) { }
>   void __weak arch_cpu_idle_dead(void) { }
> @@ -136,6 +135,5 @@ void cpu_startup_entry(enum cpuhp_state state)
>   	boot_init_stack_canary();
>   #endif
>   	__current_set_polling();
> -	arch_cpu_idle_prepare();
>   	cpu_idle_loop();
>   }
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

