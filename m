From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH] ARM hibernation / suspend-to-disk
	support code
Date: Sat, 21 May 2011 00:27:16 +0200
Message-ID: <201105210027.17159.rjw__22967.5264949494$1305930500$gmane$org@sisk.pl>
References: <3DCE2F529B282E4B8F53D4D8AA406A07014FFE@008-AM1MPN1-022.mgdnok.nokia.com>
	<20110520113758.GA3141@arm.com>
	<alpine.DEB.2.00.1105201255260.8018@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1105201255260.8018@localhost6.localdomain6>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, frank.hofmann@tomtom.com
Cc: Dave Martin <dave.martin@linaro.org>, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Friday, May 20, 2011, Frank Hofmann wrote:
> On Fri, 20 May 2011, Dave Martin wrote:
> 
> [ ... ]
> >> +/*
> >> + * Save the current CPU state before suspend / poweroff.
> >> + */
> >> +ENTRY(swsusp_arch_suspend)
> >> +	ldr	r0, =__swsusp_arch_ctx
> >> +	mrs	r1, cpsr
> >> +	str	r1, [r0], #4		/* CPSR */
> >> +ARM(	msr	cpsr_c, #SYSTEM_MODE					)
> >> +THUMB(	mov	r2, #SYSTEM_MODE					)
> >> +THUMB(	msr	cpsr_c, r2						)
> >
> > For Thumb-2 kernels, you can use the cps instruction to change the CPU
> > mode:
> > 	cps	#SYSTEM_MODE
> >
> > For ARM though, this instruction is only supported for ARMv6 and above,
> > so it's best to keep the msr form for compatibility for that case.
> 
> Ah, ok, no problem will make that change, looks good.
> 
> Do all ARMs have cpsr / spsr as used here ? Or is that code restricted to 
> ARMv5+ ? I don't have the CPU evolution history there, only got involved 
> with ARM when armv6 already was out.
> 
> I've simply done there what the "setmode" macro from <asm/assembler.h> 
> is doing, have chosen not to include that file because it overrides "push" 
> on a global scale for no good reason and that sort of thing makes me 
> cringe.
> 
> 
> >
> >> +	stm	r0!, {r4-r12,lr}	/* nonvolatile regs */
> >
> > Since r12 is allowed to be corrupted across a function call, we
> > probably don't need to save it.
> 
> ah ok thx for clarification. Earlier iterations of the patch just saved 
> r0-r14 there, "just to have it all", doing it right is best as always.
> 
> >
> [ ... ]
> >> +	bl	__save_processor_state
> >
> > <aside>
> >
> > Structurally, we seem to have:
> >
> > swsusp_arch_suspend {
> > 	/* save some processor state */
> > 	__save_processor_state();
> >
> > 	swsusp_save();
> > }
> >
> > Is __save_processor_state() intended to encapsulate all the CPU-model-
> > specific state saving?  Excuse my ignorance of previous conversations...
> >
> > </aside>
> 
> You're right.
> 
> I've attached the codechanges which implement __save/__restore... for 
> TI OMAP3 and Samsung S5P64xx, to illustrate, again (that's the stuff 
> referred to in the earlier mail I mentioned in first post; beware of code 
> churn in there, those diffs don't readily apply to 'just any' kernel).
> 
> These hooks are essentially the same as the machine-specific cpu_suspend() 
> except that we substitute "r0" (the save context after the generic part) 
> as target for where-to-save-the-state, and we make the funcs return 
> instead of switching to OFF mode.
> 
> That's what I meant with "backdoorish". A better way would be to change 
> the cpu_suspend interface so that it returns instead of directly switching 
> to off mode / powering down.
> 
> Russell has lately been making changes in this area; the current kernels 
> are a bit different here since the caller already supplies the 
> state-save-buffer, while the older ones used to choose in some 
> mach-specific way where to store that state.
> 
> (one of the reasons why these mach-dependent enablers aren't part of this 
> patch suggestion ...)
> 
> 
> >
> >> +	pop	{lr}
> >> +	b	swsusp_save
> >> +ENDPROC(swsusp_arch_suspend)
> >
> > I'm not too familiar with the suspend/resume stuff, so I may be asking
> > a dumb question here, but:
> >
> > Where do we save/restore r8_FIQ..r13_FIQ, r13_IRQ, r13_UND and r13_ABT?
> > (I'm assuming there's no reason to save/restore r14 or SPSR for any
> > exception mode, since we presumably aren't going to suspend/resume
> > from inside an exception handler (?))
> >
> > The exception stack pointers might conceivably be reinitialised to
> > sane values on resume, without necessarily needing to save/restore
> > them, providing my assumption in the previous paragraph is correct.
> >
> > r8_FIQ..r12_FIQ can store arbitrary state used by the FIQ handler,
> > if FIQ is in use.  Can we expect any driver using FIQ to save/restore
> > this state itself, rather than doing it globally?  This may be
> > reasonable.
> 
> We don't need to save/restore those, because at the time the snapshot is 
> taken interrupts are off and we cannot be in any trap handler either. On 
> resume, the kernel that has been loaded has initialized them properly 
> already.

I'm not sure if this is a safe assumption in general.  We may decide to
switch to loading hibernate images from boot loaders, for example, and
it may not hold any more.  Generally, please don't assume _anything_ has
been properly initialized during resume, before the image is loaded.
This has already beaten us a couple of times.

Thanks,
Rafael
