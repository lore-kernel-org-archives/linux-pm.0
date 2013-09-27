From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2] arm: vexpress: tc2: fix hotplug/idle/kexec race on
 cluster power down
Date: Fri, 27 Sep 2013 12:12:25 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309271209450.312@syhkavp.arg>
References: <1380297282-13021-1-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qe0-f42.google.com ([209.85.128.42]:47136 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031Ab3I0QM1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2013 12:12:27 -0400
Received: by mail-qe0-f42.google.com with SMTP id 1so1982226qec.29
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2013 09:12:26 -0700 (PDT)
In-Reply-To: <1380297282-13021-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>, Dave Martin <dave.martin@arm.com>

On Fri, 27 Sep 2013, Lorenzo Pieralisi wrote:

> On the TC2 testchip, when all CPUs in a cluster enter standbywfi
> and commit a power down request, the power controller will wait
> for standbywfil2 coming from L2 cache controller to shut the
> cluster down.
> By the time all CPUs in a cluster commit a power down request
> and enter wfi, the power controller cannot backtrack, or put it
> another way, a CPU must not be allowed to complete execution
> independently of the power controller, the only way for it to
> resume properly must be upon wake-up IRQ pending and subsequent
> reset triggered from the power controller.
> 
> Current MCPM back-end for TC2 disables the GIC CPU IF only when
> power down is committed through the tc2_pm_suspend() method, that
> makes sense since a suspended CPU is still online and can receive
> interrupts whereas a hotplugged CPU, since it is offline,
> migrated all IRQs and shutdown the per-CPU peripherals, hence
> their PPIs.
> 
> The flaw with this reasoning is the following. If all CPUs in
> a clusters are entering a power down state either through CPU
> idle or CPU hotplug, when the last man successfully completes
> the MCPM power down sequence (and executes wfi), power controller
> waits for L2 wfi signal to quiesce the cluster and shut it down.
> If, when all CPUs are sitting in wfi, an online CPU hotplugs back
> in one of the CPUs in the cluster being shutdown, that CPU
> receives an IPI that causes wfi to complete (since tc2_pm_down()
> method does not disable the GIC CPU IF in that case - CPU being
> hotplugged out, not idle) and the power controller will never see
> the stanbywfil2 signal coming from L2 that is required for
> shutdown to happen and the system deadlocks.
> 
> Further to this issue, kexec hotplugs secondary CPUs out during
> kernel reload/restart.
> Because kexec may (deliberately) trash the old kernel text, it is
> not OK for CPUs to follow the MCPM soft reboot path, since
> instructions after the WFI may have been replaced by kexec.
> 
> If tc2_pm_down() does not disable the GIC cpu interface, there is a
> race between CPU powerdown in the old kernel and the IPI from the
> new kernel that triggers secondary boot, particularly if the
> powerdown is slow (due to L2 cache cleaning for example).  If the
> new kernel wins the race, the affected CPU(s) will not really be
> reset and may execute garbage after the WFI.
> 
> The only solution to this problem consists in disabling the GIC
> CPU IF on a CPU committed to power down regardless of the power
> down entry method (CPU hotplug or CPU idle). This way, CPU wake-up
> is under power controller control, which prevents unexpected wfi
> exit caused by a pending IRQ.
> 
> This patch moves the GIC CPU IF disable call in the TC2 MCPM
> implementation from the tc2_pm_suspend() method to the
> tc2_pm_down() method to fix the mentioned race condition(s).
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> Tested-by: Dave Martin <Dave.Martin@arm.com> (for kexec)
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Acked-by: Nicolas Pitre <nico@linaro.org>

ARM-SOC dudes: would you please pick this up?

> ---
>  arch/arm/mach-vexpress/tc2_pm.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_pm.c
> index 7aeb5d6..e6eb481 100644
> --- a/arch/arm/mach-vexpress/tc2_pm.c
> +++ b/arch/arm/mach-vexpress/tc2_pm.c
> @@ -131,6 +131,16 @@ static void tc2_pm_down(u64 residency)
>  	} else
>  		BUG();
>  
> +	/*
> +	 * If the CPU is committed to power down, make sure
> +	 * the power controller will be in charge of waking it
> +	 * up upon IRQ, ie IRQ lines are cut from GIC CPU IF
> +	 * to the CPU by disabling the GIC CPU IF to prevent wfi
> +	 * from completing execution behind power controller back
> +	 */
> +	if (!skip_wfi)
> +		gic_cpu_if_down();
> +
>  	if (last_man && __mcpm_outbound_enter_critical(cpu, cluster)) {
>  		arch_spin_unlock(&tc2_pm_lock);
>  
> @@ -231,7 +241,6 @@ static void tc2_pm_suspend(u64 residency)
>  	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>  	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>  	ve_spc_set_resume_addr(cluster, cpu, virt_to_phys(mcpm_entry_point));
> -	gic_cpu_if_down();
>  	tc2_pm_down(residency);
>  }
>  
> -- 
> 1.8.2.2
> 
> 
