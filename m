From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH v4] ARM
	hibernation/suspend-to-disk	support
Date: Fri, 10 Jun 2011 14:43:11 +0100
Message-ID: <20110610134311.GK24424__32942.5840558999$1307713480$gmane$org@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.00.1106071722040.2236@localhost6.localdomain6>
	<201106072348.44624.rjw@sisk.pl>
	<alpine.DEB.2.00.1106091604180.11513@localhost6.localdomain6>
	<20110609154058.GA24424@n2100.arm.linux.org.uk>
	<4DF0F45A.3030103@ti.com>
	<20110609164024.GB24424@n2100.arm.linux.org.uk>
	<4DF0FA73.8050607@ti.com>
	<20110609171255.GD24424@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106101110130.11513@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1106101110130.11513@localhost6.localdomain6>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frank Hofmann <frank.hofmann@tomtom.com>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 10, 2011 at 01:22:24PM +0100, Frank Hofmann wrote:
> On Thu, 9 Jun 2011, Russell King - ARM Linux wrote:
>
>> On Thu, Jun 09, 2011 at 10:23:07PM +0530, Santosh Shilimkar wrote:
> [ ... ]
>>> 3. Avoid direct write to AUXCTRL in generic suspend code.
>>
>> This is the only problematical one that I can see.  We need to restore
>> this on systems running in secure mode.  What we could do is rather than
>> writing to the register, read it first and compare its value with what
>> was saved to see whether we need to write it.
>>
>> Then, if platforms run in non-secure mode, they are responsible for
>> restoring that register back to its pre-suspend value before their
>> assembly calls cpu_resume().
>
> While this is ok from the point of view of having cpu_suspend / resume  
> being service functions for the platform-specific idle/off-mode code, it  
> also illustrates the difficulty this creates for the hibernation code.
>
> If it's not possible to call cpu_suspend / cpu_resume (or something like  
> it - not tied to names ...) as a full-featured generic interface, then  
> creating a true snapshot capability becomes problematic.

It is not intended to be a full-featured interface.  It is designed to
be an interface to handle the CPU specific part of the suspend/resume
only.

And I use the term CPU as strictly defined not as most people lazily do
to define the entire SoC.  I mean the core processor itself.

A generic interface can not handle the issues of secure mode when there
is no defined secure mode API.  It can't handle the L2 cache crap because
that's outside the scope of the CPU and is platform dependent.  It can't
handle devices because that's again outside the scope of the CPU and is
SoC dependent.

The only thing it can do - and should do - is deal with the CPU specific
part.  That's why it has a cpu_ prefix.

>>> 4. Before MMU is enabled in resume a callback to restore
>>> secure register, setup auxctrl etc.
>>
>> You can do this before your assembly calls cpu_resume().
>
> Only that it's known at the point of call to cpu_suspend/resume.
>
> Again, I admit to being biased regarding the usecase here ...

How can generic CPU code know about all the platform idiotic farces that
people pull?  No, what you're asking for is total madness.

>>> Additionally the L2 cache handling isn't part of
>>> these common suspend hooks.
>>
>> L2 cache handling can't fit into the generic code - it doesn't really
>> belong there either.  It needs to be in the parent or hooked into the
>> syscore_ops stuff as I've said previously.
>
> For the "take things down" side, dode like machine_restart() already is  
> able to flush/inval/disable all these things on the way down, without any 
> SoC-specific knowledge.
>
> OMAP suspend/resume has, just recently, gone half-way there (use the  
> provided flush/inval instead of the home-grown table walker code),
>
> Agree with that. Cache flushing / disabling / invalidation has interfaces 
> (the outer_*, l2* and cache ops) already, and e.g. the OMAP code has  
> recently started to use some of those (kernel_flush instead of the  
> home-grown inval loop). Looks like that part is on its way.
>
> On the resume side, there's actually a problem here - the generic way of  
> enabling a cache is through initcalls - which don't happen on resume, so  
> if the system comes out of a "low enough" state there's some work to do  
> here - which generic cpu_resume() does not do.

And can't do.

>>
>> So:
>>
>> ENTRY(my_soc_suspend)
>>        stmfd   sp!, {r4 - r12, lr}
>>        ldr     r3, =resume
>>        bl      cpu_suspend
>> 	/*
>> 	 * Insert whatever code is required here for suspend
>> 	 * eg, save secure mode, then jump to sram to call WFI function
>> 	 */
>> resume:
>> 	ldmfd	sp!, {r4 - r12, pc}
>> ENDPROC(my_soc_suspend)
>>
>> ENTRY(my_soc_resume)
>> 	/*
>> 	 * Insert whatever other code is required to be run before resume
>> 	 * eg, WFI function returns to this symbol after DDR becomes
>> 	 * accessible.  restore secure mode state
>> 	 */
>> 	b	cpu_resume
>> ENDPROC(my_soc_resume)
>
> That alone doesn't accommodate the following situations:
>
> a) there might be pre-suspend / post-resume activities necessary, i.e.
>    the assumption that any SoC-specific "go down" activity can be done
>    after cpu_suspend() and any SoC-specific "bring up" activity before
>    cpu_resume() might not be sufficient.
>    Case in point: Reenabling L2 caches after resume.

Look, platform code calls cpu_suspend() as part of whatever is required
to do the suspend work.  It deals with the core CPU crap, nothing more.
Platforms have to take care to deal with whatever shite they have before
the CPU core crap is handled, and then do whatever shite they need to
do after the CPU core crap has been handled.

You can't get away from that.  You can't go stuffing L2 shite into the
middle of this.

> b) my bias - snapshotting state (for hibernation).
>    Delegating this to a SoC-specific method risks creating code like
>    the OMAP stuff - where state saving, power management, off mode
>    and whatnot is all interwoven and interdependent.
>    It also creates the problem that _generic_ (platform-independent)
>    hibernation code becomes impossible to do ...
>
>    A clean thing are separate steps:
>
> 	<mach preparation for suspend state snapshot>
> 	<generic state snapshot>
> 	<mach state snapshot>
> 	...
> 	<wfi>	/* or not ... */
> 	...
> 	<mach prep for resume / basic initialization>
> 	<generic resume>
> 	<mach resume>
>
> So why not have those hooks _inside_ cpu_suspend / cpu_resume, i.e. like:

What's the point when platform code has *ALREADY* to call these functions?

Is it really too sodding difficult for platforms to do:

my_suspend_hook()
{
	mach_pre_suspend_hook();
	cpu_suspend();
	mach_post_suspend_hook();
}

?

<not read the rest of the message, this is getting idiotic>
