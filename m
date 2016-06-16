From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 2/6] arm64: Add .mmuoff.text section
Date: Thu, 16 Jun 2016 14:55:07 +0100
Message-ID: <20160616135507.GA31477@leverpostej>
References: <1466012148-7674-1-git-send-email-james.morse@arm.com>
 <1466012148-7674-3-git-send-email-james.morse@arm.com>
 <20160616111007.GB6073@leverpostej>
 <5762A80D.1030705@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44004 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754805AbcFPNze (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 16 Jun 2016 09:55:34 -0400
Content-Disposition: inline
In-Reply-To: <5762A80D.1030705@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On Thu, Jun 16, 2016 at 02:22:21PM +0100, James Morse wrote:
> Hi Mark,
> 
> On 16/06/16 12:10, Mark Rutland wrote:
> > On Wed, Jun 15, 2016 at 06:35:44PM +0100, James Morse wrote:
> >> Resume from hibernate needs to clean any text executed by the kernel with
> >> the MMU off to the PoC. Collect these functions together into a new
> >> .mmuoff.text section.
> >>
> >> This covers booting of secondary cores and the cpu_suspend() path used
> >> by cpu-idle and suspend-to-ram.
> >>
> >> The bulk of head.S is not included, as the primary boot code is only ever
> >> executed once, the kernel never needs to ensure it is cleaned to a
> >> particular point in the cache.
> 
> 
> >> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> >> index 2c6e598a94dc..ff37231e2054 100644
> >> --- a/arch/arm64/kernel/head.S
> >> +++ b/arch/arm64/kernel/head.S
> >> @@ -656,6 +657,7 @@ ENDPROC(secondary_holding_pen)
> >>  	 * Secondary entry point that jumps straight into the kernel. Only to
> >>  	 * be used where CPUs are brought online dynamically by the kernel.
> >>  	 */
> >> +	.pushsection ".mmuoff.text", "ax"
> >>  ENTRY(secondary_entry)
> >>  	bl	el2_setup			// Drop to EL1
> >>  	bl	set_cpu_boot_mode_flag
> >> @@ -687,7 +689,7 @@ __secondary_switched:
> >>  	mov	x29, #0
> >>  	b	secondary_start_kernel
> >>  ENDPROC(__secondary_switched)
> >> -
> >> +	.popsection
> > 
> > I think we also need to cover set_cpu_boot_mode_flag and
> > __boot_cpu_mode.
> 
> Bother, yes.
> How come cpu_resume doesn't call this? I guess we assume
> psci_cpu_suspend_enter() will bring the core back at the same EL

Hmm. It looks like we only bother to check once at boot time (in
hyp_mode_check as part of smp_cpus_done), and otherwise never inspect
the flag again.

We should probably add checks to the hotplug-on path, and perhaps the
idle cold return path. That's largely orthogonal to this series, though.

I think we should for consistency we should place them in the mmuoff
section regardless.

> > Likewise secondary_holding_pen and secondary_holding_pen_release, in
> > case you booted with maxcpus=1, suspended, resumed, then tried to bring
> > secondaries up with spin-table.
> 
> Whoa! This must never happen!
> With KASLR:
> * relocate to location-1,
> * release the secondary cores from firmware into
>   location-1:secondary_holding_pen,
> * resume from hibernate, at which point we are running from location-2,
>   as the kaslr values are now from the hibernate kernel.
> * location-2:secondary_holding_pen is empty,
> * location-1:secondary_holding_pen now contains a user-space string, or some
>   other horror.

:(

> This didn't come up during testing because maxcpus=1 was permanent before v4.7,
> and we can't bundle cores back into the secondary_holding_pen. Hibernate without
> PSCI (or some other cpu_die()) mechanism fails in the core code:
> > [70648.097242] Disabling non-boot CPUs ...
> > [70648.117277] Error taking CPU1 down: -95
> > [70648.117286] Non-boot CPUs are not disabled
> 
> ... but if we never tried to boot those cpus, we don't hit this check, and the
> cores are left in secondary_holding_pen after smp_prepare_cpus(), called well
> before the late_initcall that kicks of resume.
> 
> This is broken on systems that load the kernel at a different address over a
> reboot, (using KASLR or a fancy boot loader), and use spin-table for secondary
> cores. (probably none in practice, but still worth fixing)
> 
> 
> Thinking aloud:
> cpus_stuck_in_kernel only indicates cores that we failed to fully bring up.
> (incompatible translation granule etc). There could still be cores in the
> kernel's secondary holding pen. We should prevent kexec/hibernate in this case.
> (hibernate because we can't safely resume on such a machine)

This sounds sensible to me.

> kexec[0] currently checks for a cpu_die() call:
> > if (num_online_cpus() > 1)
> 
> Changing this to 'num_possible_cpus() > 1' will cover the above case.
> Similar code will need to be added to hibernate.

That will also catch cases where CPUs failed to even enter the pen, but
I don't think there's any reliable way to distinguish the two, so that's
probably the best we can do.

> An alternative is to increase cpus_stuck_in_kernel in
> smp_spin_table_cpu_prepare(), but it stops being a counter at this point.

I don't think we need it to be a counter. I'm happy to change the
meaning slightly if we update the comment.

> Thoughts?

"Oh no", "aaarargarghargahgasdfsdfs". :(

> Does this make sense, or do I have the wrong end of the stick somewhere!

The above makes sense to me. Thanks for digging into this!

Mark.
