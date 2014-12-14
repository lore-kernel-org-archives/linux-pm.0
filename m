From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v3, 2/4] powerpc/powernv: Enable Offline CPUs to enter deep idle states
Date: Sun, 14 Dec 2014 21:05:58 +1100 (AEDT)
Message-ID: <20141214100558.B40551400B7@ozlabs.org>
References: <1417678103-32571-3-git-send-email-shreyas@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:46632 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbaLNKGA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 14 Dec 2014 05:06:00 -0500
In-Reply-To: <1417678103-32571-3-git-send-email-shreyas@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Paul Mackerras <paulus@samba.org>, "Preeti U. Murthy" <preeti@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org

On Thu, 2014-04-12 at 07:28:21 UTC, "Shreyas B. Prabhu" wrote:
> From: "Preeti U. Murthy" <preeti@linux.vnet.ibm.com>
> 
> The secondary threads should enter deep idle states so as to gain maximum
> powersavings when the entire core is offline. To do so the offline path
> must be made aware of the available deepest idle state. Hence probe the
> device tree for the possible idle states in powernv core code and
> expose the deepest idle state through flags.
> 
> Since the  device tree is probed by the cpuidle driver as well, move
> the parameters required to discover the idle states into an appropriate
> common place to both the driver and the powernv core code.
> 
> Another point is that fastsleep idle state may require workarounds in
> the kernel to function properly. This workaround is introduced in the
> subsequent patches. However neither the cpuidle driver or the hotplug
> path need be bothered about this workaround.
> 
> They will be taken care of by the core powernv code.
 
 ...

> diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
> index 4753958..3dc4cec 100644
> --- a/arch/powerpc/platforms/powernv/smp.c
> +++ b/arch/powerpc/platforms/powernv/smp.c
> @@ -159,13 +160,17 @@ static void pnv_smp_cpu_kill_self(void)
>  	generic_set_cpu_dead(cpu);
>  	smp_wmb();
>  
> +	idle_states = pnv_get_supported_cpuidle_states();
>  	/* We don't want to take decrementer interrupts while we are offline,
>  	 * so clear LPCR:PECE1. We keep PECE2 enabled.
>  	 */
>  	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1);
>  	while (!generic_check_cpu_restart(cpu)) {
>  		ppc64_runlatch_off();
> -		power7_nap(1);
> +		if (idle_states & OPAL_PM_SLEEP_ENABLED)
> +			power7_sleep();
> +		else
> +			power7_nap(1);

So I might be missing something subtle here, but aren't we potentially enabling
sleep here, prior to your next patch which makes it safe to actually use sleep?

Shouldn't we only allow sleep after patch 3? Or in other words shouldn't this
be patch 3 (or 4)?

cheers
