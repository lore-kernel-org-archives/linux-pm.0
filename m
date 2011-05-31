From: Frank Hofmann <frank.hofmann@tomtom.com>
Subject: Re: [RFC PATCH v3] ARM hibernation/suspend-to-disk
	support
Date: Tue, 31 May 2011 12:50:55 +0100 (BST)
Message-ID: <alpine.DEB.2.00.1105311020130.5486__9556.84844307161$1306842890$gmane$org@localhost6.localdomain6>
References: <alpine.DEB.2.00.1105251251330.4319@localhost6.localdomain6>
	<alpine.DEB.2.00.1105271549220.6109@localhost6.localdomain6>
	<alpine.LFD.2.00.1105271501220.3207@xanadu.home>
Reply-To: frank.hofmann@tomtom.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1105271501220.3207@xanadu.home>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Frank Hofmann <frank.hofmann@tomtom.com>, linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



On Fri, 27 May 2011, Nicolas Pitre wrote:

> On Fri, 27 May 2011, Frank Hofmann wrote:
>
>>  /*
>>   * r0 = control register value
>>   * r1 = v:p offset (preserved by cpu_do_resume)
>> + *      if this is zero, do not reenable MMU (it's on)
>
> This is wrong.  It is well possible for this to be zero when the MMU is
> active.
>
> The best way to determine if MMU is on or off is:
>
> 	mrc	p15, 0, rx, c1, c0	@ load ctrl reg
> 	tst	rx, #1			@ test M bit

Ah, thanks. I had thought only MMU-less kernels will run on identity but 
you're right of course there's nothing to stop it as such.

This one:
==============================================================================
diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 6398ead..a793644 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -75,6 +75,9 @@ ENDPROC(cpu_suspend)
   * r3 = L1 section flags
   */
  ENTRY(cpu_resume_mmu)
+	mrc	p15, 0, r4, c1, c0, 0
+	tst	r4, #CR_M
+	bne	0f			@ return if MMU already on
  	adr	r4, cpu_resume_turn_mmu_on
  	mov	r4, r4, lsr #20
  	orr	r3, r3, r4, lsl #20
@@ -96,6 +99,7 @@ cpu_resume_turn_mmu_on:
  ENDPROC(cpu_resume_turn_mmu_on)
  cpu_resume_after_mmu:
  	str	r5, [r2, r4, lsl #2]	@ restore old mapping
+0:
  	mcr	p15, 0, r0, c1, c0, 0	@ turn on D-cache
  	mov	pc, lr
  ENDPROC(cpu_resume_after_mmu)
==============================================================================

does indeed do that part of the job.


>
>> I wonder; is there a proper/suggested way to switch MMU off (and not end in
>> binary nirvana), to have the reentry / reenable work ?
>
> This is slightly complicated.  You first need to turn of and disable the
> caches, and ideally set up a 1:1 mapping for the transition.  There are
> cpu_proc_fin() and cpu_reset(branch_location).

Hmm, just looked through that. One of the issues with this is my usecase - 
ARM11x6 and Cortex-A8/9, for which these are cpu_v[67]_reset() - a no-op 
(in mainline / rmk devel-stable). I.e. neither cpu_proc_fin() nor 
cpu_reset() on v6/v7 currently switch the MMU off. The older chips do ...


Anyway, the setup for resume after hibernation at the moment is:

 	- swsusp_arch_resume switches to swapper_pg_dir
 	  (which is guaranteed to be kernel flat addresses ?!)

 	- image restoration
 	  [ caches should probably be flushed / turned off after this ? ]

 	- cpu_do_resume() restores pre-suspend TTBR
 	  (which in effect is a cpu_switch_mm)

 	- cpu_resume_mmu bypassed because MMU already on

But that means as part of the resume, a context switch is done anyway.

Which sort of leads to the question whether the 1:1 mapping for the switch 
off case is really required; wouldn't it be acceptable to simply turn the 
MMU off and jump to the physical address of cpu_do_resume() instead ?

Something like:

 	[ caches off ... ]

 	@ assume r0 == phys addr of restore buffer (however retrieved)

 	ldr	r1, =virt_addr_of_restore_buffer	@ known
 	sub	r2, r1, r0				@ calc v:p offset
 	ldr	r3, =cpu_do_resume			@ virt func addr
 	sub	r3, r3, r2				@ to phys
 	mrc	p15, 0, r1, cr0, cr1, 0
 	bic	r1, #CR_M
 	adr	lr, =post_resume			@ load virtual
 	mcr	r15, 0, r1, cr0, cr1, 0			@ MMU off
crit:	mov	pc, r3					@ jump phys
post_resume:
 	[ continue processing when done / returned ]

Or is it necessary to have a 1:1 mapping for 'crit:' when switching the 
MMU off, to make sure one actually reaches the jump ?


>
> You may also investigate how kexec is handled which purpose is to let
> the kernel boot another kernel.

machine_kexec() you mean ? I vaguely remember having read that to get this 
working on v6/v7 CPUs one needs non-mainline patches, is that still so ? 
The current fin / reset codepaths for v6/v7 don't turn the MMU off, 
anyway.

Thanks for the pointer. Reading that, it looks like flushing / disabling 
all caches is necessary before entering/resuming the target ?


I'm starting to wonder whether for a first-stab at hibernation support on 
ARM, the ability to resume non-identical kernels / resume not via the 
kernel hibernation restore codepaths (i.e. invocation via bootloader) is 
required.

As Rafael answered a while back, to make that work a temporary MMU 
initialization / setup is necessary for the image restoration. The 
current code assumes swapper_pg_dir has been set up, and maps the entire 
kernel heap; how true is that assumption, actually, at "kernel entry" ?


Thanks,
FrankH.


>
>
> Nicolas
>
