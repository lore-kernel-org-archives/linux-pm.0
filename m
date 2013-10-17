From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 11/13] arm64: enable generic clockevent broadcast
Date: Thu, 17 Oct 2013 11:15:02 +0200
Message-ID: <525FAA96.90600@linaro.org>
References: <1381748590-14279-1-git-send-email-lorenzo.pieralisi@arm.com> <1381748590-14279-12-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:63576 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144Ab3JQJPI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2013 05:15:08 -0400
Received: by mail-wg0-f46.google.com with SMTP id m15so1934542wgh.25
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2013 02:15:06 -0700 (PDT)
In-Reply-To: <1381748590-14279-12-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Dave Martin <dave.martin@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, Kumar Sankaran <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>

On 10/14/2013 01:03 PM, Lorenzo Pieralisi wrote:
> On platforms with power management capabilities, timers that are shut
> down when a CPU enters deep C-states must be emulated using an always=
-on
> timer and a timer IPI to relay the timer IRQ to target CPUs on an SMP
> system.
>
> This patch enables the generic clockevents broadcast infrastructure f=
or
> arm64, by providing the required Kconfig entries and adding the timer
> IPI infrastructure.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

sidenote: there is more and more duplicated code between arm and arm64.

> ---
>   arch/arm64/Kconfig               |  2 ++
>   arch/arm64/include/asm/hardirq.h |  2 +-
>   arch/arm64/kernel/smp.c          | 17 +++++++++++++++++
>   3 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index bcf88e4..be88acd 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1,6 +1,7 @@
>   config ARM64
>   	def_bool y
>   	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
> +	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>   	select ARCH_WANT_OPTIONAL_GPIOLIB
>   	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
>   	select ARCH_WANT_FRAME_POINTERS
> @@ -12,6 +13,7 @@ config ARM64
>   	select COMMON_CLK
>   	select CPU_PM if (SUSPEND || CPU_IDLE)
>   	select GENERIC_CLOCKEVENTS
> +	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>   	select GENERIC_IOMAP
>   	select GENERIC_IRQ_PROBE
>   	select GENERIC_IRQ_SHOW
> diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/as=
m/hardirq.h
> index 990c051..ae4801d 100644
> --- a/arch/arm64/include/asm/hardirq.h
> +++ b/arch/arm64/include/asm/hardirq.h
> @@ -20,7 +20,7 @@
>   #include <linux/threads.h>
>   #include <asm/irq.h>
>
> -#define NR_IPI	4
> +#define NR_IPI	5
>
>   typedef struct {
>   	unsigned int __softirq_pending;
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index d5488f8..2ed691e 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -61,6 +61,7 @@ enum ipi_msg_type {
>   	IPI_CALL_FUNC,
>   	IPI_CALL_FUNC_SINGLE,
>   	IPI_CPU_STOP,
> +	IPI_TIMER,
>   };
>
>   /*
> @@ -447,6 +448,7 @@ static const char *ipi_types[NR_IPI] =3D {
>   	S(IPI_CALL_FUNC, "Function call interrupts"),
>   	S(IPI_CALL_FUNC_SINGLE, "Single function call interrupts"),
>   	S(IPI_CPU_STOP, "CPU stop interrupts"),
> +	S(IPI_TIMER, "Timer broadcast interrupts"),
>   };
>
>   void show_ipi_list(struct seq_file *p, int prec)
> @@ -532,6 +534,14 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
>   		irq_exit();
>   		break;
>
> +#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
> +	case IPI_TIMER:
> +		irq_enter();
> +		tick_receive_broadcast();
> +		irq_exit();
> +		break;
> +#endif
> +
>   	default:
>   		pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
>   		break;
> @@ -544,6 +554,13 @@ void smp_send_reschedule(int cpu)
>   	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
>   }
>
> +#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
> +void tick_broadcast(const struct cpumask *mask)
> +{
> +	smp_cross_call(mask, IPI_TIMER);
> +}
> +#endif
> +
>   void smp_send_stop(void)
>   {
>   	unsigned long timeout;
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

