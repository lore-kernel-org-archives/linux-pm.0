From: Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH 10/10] cpuidle: cpuidle driver for MIPS CPS
Date: Thu, 27 Feb 2014 09:50:48 +0000
Message-ID: <20140227095047.GB32299@pburton-linux.le.imgtec.org>
References: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com>
 <1389794137-11361-11-git-send-email-paul.burton@imgtec.com>
 <530CB7DA.7060305@linaro.org>
 <20140225221200.GP25765@pburton-linux.le.imgtec.org>
 <530DFC33.1090609@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.89.28.115]:36067 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbaB0Juv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2014 04:50:51 -0500
Content-Disposition: inline
In-Reply-To: <530DFC33.1090609@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-mips@linux-mips.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On Wed, Feb 26, 2014 at 03:37:39PM +0100, Daniel Lezcano wrote:
> >>The convention is to not include headers from arch. These headers shouldn't
> >>appear in this driver.
> >>
> >
> >Without accessing those headers I can't really implement anything useful
> >- entering these idle states by their nature involves architecture
> >specifics. Would you rather the bulk of the driver is implemented under
> >arch/mips & the code in drivers/cpuidle simply calls elsewhere to do the
> >real work?
> 
> Usually, this is how it is done. If you can move the 'asm' code inside eg.
> pm.c somewhere in arch/mips and invoke from pm functions from cpuidle
> through a simple header that would be great.

Ok.

> >Right you are, it should either use GFP_ATOMIC or just not handle the
> >off-stack case (which isn't currently used).
> 
> Why don't you just allocate these cpumasks at init time instead of
> allocating / freeing them in the fast path ?

Also a possibility. Right now nothing using this will have off-stack cpu
masks I was just attempting to be cautious by handling the case anyway.
I'll change it one way or another for v2.

> >>>+	/* Calculate which coupled CPUs (VPEs) are online */
> >>>+#ifdef CONFIG_MIPS_MT
> >>>+	cpumask_and(coupled_mask, cpu_online_mask, &dev->coupled_cpus);
> >>>+	first_cpu = cpumask_first(coupled_mask);
> >>>+	online = cpumask_weight(coupled_mask);
> >>>+	cpumask_clear_cpu(dev->cpu, coupled_mask);
> >>>+	cpumask_shift_right(vpe_mask, coupled_mask,
> >>>+			    cpumask_first(&dev->coupled_cpus));
> >>
> >>What is the purpose of this computation ?
> >
> >If you read through the code generated in cps_gen_entry_code, the
> >vpe_mask is used to indicate the VPEs within the current core which are
> >both online & not the VPE currently running the code.
> 
> Ok, thanks for the clarification.
> 
> Shouldn't 'online = cpumask_weight(coupled_mask)' be after clearing the
> current cpu ? Otherwise, online has also the current cpu which, IIUC,
> shouldn't be included, no ?

No, the generated code actually counts the number of VPEs which have
entered the generated code so that it knows it's safe to proceed to
disable coherence (which would of course be bad if any VPE was still
running C code). That count (nc_ready_count) has to equal online
(including the current CPU/VPE) & the final VPE goes on to disable
coherence whilst the others just halt.

> 
> >>>+#else
> >>>+	cpumask_clear(coupled_mask);
> >>>+	cpumask_clear(vpe_mask);
> >>>+	first_cpu = dev->cpu;
> >>>+	online = 1;
> >>>+#endif
> >>
> >>first_cpu is not used.
> >
> >Right you are. It's used in further work-in-progress patches but I'll
> >remove it from this one.
> >
> >>
> >>>+	/*
> >>>+	 * Run the generated entry code. Note that we assume the number of VPEs
> >>>+	 * within this core does not exceed the width in bits of a long. Since
> >>>+	 * MVPConf0.PVPE is 4 bits wide this seems like a safe assumption.
> >>>+	 */
> >>>+	num_left = per_cpu(ncwait_asm_enter, core)(vpe_mask->bits[0], online);
> >>>+
> >>>+	/*
> >>>+	 * If this VPE is the first to leave the non-coherent wait state then
> >>>+	 * it needs to wake up any coupled VPEs still running their wait
> >>>+	 * instruction so that they return to cpuidle,
> >>
> >>Why is it needed ? Can't the other cpus stay idle ?
> >
> >Not with the current cpuidle code. Please see the end of
> >cpuidle_enter_state_coupled in drivers/cpuidle/coupled.c. The code waits
> >for all coupled CPUs to exit the idle state before any of them proceed.
> >Whilst I suppose it would be possible to modify cpuidle to not require
> >that, it would leave you with inaccurate residence statistics mentioned
> >below.
> >
> >>
> >>>       * which can then complete
> >>>+	 * coordination between the coupled VPEs & provide the governor with
> >>>+	 * a chance to reflect on the length of time the VPEs were in the
> >>>+	 * idle state.
> >>>+	 */
> >>>+	if (coupled_coherence && (num_left == online))
> >>>+		arch_send_call_function_ipi_mask(coupled_mask);
> >>
> >>Except there is no choice due to hardware limitations, I don't think this is
> >>valid.
> >
> >By nature when one CPU (VPE) within a core leaves a non-coherent state
> >the rest do too, because as I mentioned coherence is a property of the
> >core not of individual VPEs. It would be possible to leave the other
> >VPEs idle if we didn't differentiate between the coherent & non-coherent
> >wait states, but again not with cpuidle as it is today (due to the
> >waiting for all CPUs at the end of cpuidle_enter_state_coupled).
> 
> [ ... ]
> 
> >>>+
> >>>+	/*
> >>>+	 * Set the coupled flag on the appropriate states if this system
> >>>+	 * requires it.
> >>>+	 */
> >>>+	if (coupled_coherence)
> >>>+		for (i = 1; i < cps_driver.state_count; i++)
> >>>+			cps_driver.states[i].flags |= CPUIDLE_FLAG_COUPLED;
> >>
> >>I am not sure CPUIDLE_FLAG_COUPLED is the solution for this driver. IIUC,
> >>with the IPI above and the wakeup sync with the couple states, this driver
> >>is waking up everybody instead of sleeping as much as possible.
> >>
> >>I would recommend to have a look at a different approach, like the one used
> >>for cpuidle-ux500.c.
> >
> >Ok it looks like that just counts & performs work only on the last
> >online CPU to run the code.
> 
> Yes, the last-man-standing approach. Usually, the couple idle states are
> used when the processors need to do some extra work or only the cpu0 can
> invoke PM routine for security reason.
> 
> In your case, IIUC, we don't care who will call the PM routine and if a cpu
> wakes up, the other ones (read the VPEs belonging to the same core), can
> stay idle until an interrupt occurs.

Right, we don't care which CPU/VPE disables coherence or which one
re-enables coherence. However when one of them does so it does affect
the rest. So although they could stay idle it's a question of *which*
idle state they're now in. As soon as one VPE has left the idle state
the rest would now be in a coherent wait state. If they don't wake up
then cpuidle continues to believe they are in non-coherent wait.

> 
> >As before that could work but only by
> >disregarding any differentiation between coherent & non-coherent wait
> >states at levels above the driver.
> 
> May be you can use the arch private flags for the idle states to
> differentiate coherent or non-coherent wait states ?

I'm sure the driver could keep the coherent vs non-coherent
differentiation internally, but my point is that the governor would no
longer have access to it. That may or may not be a big issue, but one
other thing to bear in mind is that as I mentioned in the commit message
non-coherent wait is very much just a stepping stone towards entering
lower power states (clock gating or power gating the cores). Those lower
power states also require treating VPEs within a core as coupled, and
whilst the secondary ones could run a wait instruction on resume that
would be to further detriment of the residency statistics.

> Or alternatively create
> two drivers and register the right one.

I'm unsure how that would help here - could you explain what you mean?

Paul
