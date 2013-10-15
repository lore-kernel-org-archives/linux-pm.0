From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 08/13] arm64: kernel: implement debug monitors CPU PM
 notifiers
Date: Tue, 15 Oct 2013 12:27:15 +0100
Message-ID: <20131015112715.GC30411@mudshark.cambridge.arm.com>
References: <1381748590-14279-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1381748590-14279-9-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:42909 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753201Ab3JOL1T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2013 07:27:19 -0400
Content-Disposition: inline
In-Reply-To: <1381748590-14279-9-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, "ksankaran@apm.com" <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Mon, Oct 14, 2013 at 12:03:05PM +0100, Lorenzo Pieralisi wrote:
> When a CPU is shutdown either through CPU idle or suspend to RAM, the
> content of debug monitor registers must be reset or restored to proper
> values when CPU resume from low power states. This patch implements a
> CPU PM notifier that allows to restore the content of debug monitor
> registers to allow proper suspend/resume operations.

How do you deal with pstate in this series? In particular, the single-step
state machine is partially driven by bits in the SPSR, so you need to be
careful with preserving that (may even require a dummy exception return...
not sure).

> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm64/kernel/debug-monitors.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> index cbfacf7..28ce685 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -19,6 +19,7 @@
>   */
>  
>  #include <linux/cpu.h>
> +#include <linux/cpu_pm.h>
>  #include <linux/debugfs.h>
>  #include <linux/hardirq.h>
>  #include <linux/init.h>
> @@ -154,6 +155,42 @@ static struct notifier_block os_lock_nb = {
>  	.notifier_call = os_lock_notify,
>  };
>  
> +#ifdef CONFIG_CPU_PM
> +static DEFINE_PER_CPU(u32, mdscr);
> +
> +static int dm_cpu_pm_notify(struct notifier_block *self, unsigned long action,
> +			    void *v)
> +{
> +	switch (action) {
> +	case CPU_PM_ENTER:
> +		__get_cpu_var(mdscr) = mdscr_read();

I'm concerned about simply saving/restoring the mdscr. Both the MDE and KDE
bits are ref-counted for each CPU, so we'd need to guarantee no context
switching between the CPU_PM_ENTER and CPU_PM_EXIT invocations of this
notifier. Is that the case?

> +		break;
> +	case CPU_PM_EXIT:
> +		clear_os_lock(NULL);
> +		mdscr_write(__get_cpu_var(mdscr));

I think you should do this the other way round. Also, back to PSTATE, you
need to take care when clearing the D bit, since you definitely want to
either restore or zero the mdscr first.

Will
