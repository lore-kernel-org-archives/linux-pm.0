From: Frank Hofmann <frank.hofmann@tomtom.com>
Subject: Re: [RFC PATCH] ARM hibernation / suspend-to-disk
 support code
Date: Mon, 23 May 2011 14:37:19 +0100 (BST)
Message-ID: <alpine.DEB.2.00.1105231239270.8018__49411.8508221165$1306157920$gmane$org@localhost6.localdomain6>
References: <3DCE2F529B282E4B8F53D4D8AA406A07014FFE@008-AM1MPN1-022.mgdnok.nokia.com>
	<20110520113758.GA3141@arm.com>
	<alpine.DEB.2.00.1105201255260.8018@localhost6.localdomain6>
	<201105210027.17159.rjw@sisk.pl> <20110523095232.GB2370@arm.com>
Reply-To: frank.hofmann@tomtom.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110523095232.GB2370@arm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dave Martin <dave.martin@linaro.org>
Cc: frank.hofmann@tomtom.com, linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, 23 May 2011, Dave Martin wrote:

> On Sat, May 21, 2011 at 12:27:16AM +0200, Rafael J. Wysocki wrote:
>> On Friday, May 20, 2011, Frank Hofmann wrote:
[ ... ]
>>>> r8_FIQ..r12_FIQ can store arbitrary state used by the FIQ handler,
>>>> if FIQ is in use.  Can we expect any driver using FIQ to save/restore
>>>> this state itself, rather than doing it globally?  This may be
>>>> reasonable.
>>>
>>> We don't need to save/restore those, because at the time the snapshot is
>>> taken interrupts are off and we cannot be in any trap handler either. On
>>> resume, the kernel that has been loaded has initialized them properly
>>> already.
>>
>> I'm not sure if this is a safe assumption in general.  We may decide to
>> switch to loading hibernate images from boot loaders, for example, and
>> it may not hold any more.  Generally, please don't assume _anything_ has
>> been properly initialized during resume, before the image is loaded.
>> This has already beaten us a couple of times.
>
> Surely when resuming via the bootloader, the bootloader must still
> branch to some resume entry point in the kernel?
>
> That resume code would be responsible for doing any OS-specific
> initialisation and waking up the kernel; plus, the kernel should
> not re-enable interrupts until the kernel state has been restored
> anyway.  It wouldn't be the responsibility of the bootloader to
> set up the relevant state.

What is whose' responsibility ...

It's as easy to say "you can't assume anything" as it is "you must assume 
that ...". Hopefully, this isn't going to become philosophical ;-)

There are two things in the context of hibernation that were mentioned:

a) CPU interrupt stacks (FIQ/IRQ/UND/ABT stacks and reg sets)
b) swapper_pg_dir

Regarding the latter:

As far as swsusp_arch_resume() is concerned, by the time that function is 
called one thing definitely has happened - the loading of the image.

That on the other hand requires some form of MMU setup having happened 
before, because the resume image metadata (restore_pglist and the virtual 
addresses used in the linked "struct pbe") have been created.
Also, since the code somehow ended up in swsusp_arch_resume, that part of 
the kernel text must have been loaded, and mapped.

(If it weren't so, then how did whichever entity loaded the image manage 
to create the list linkage ? How did it enter swsusp_arch_resume ?)

Am I understanding that part correctly ?

If so, then that part at least concedes that on ARM, one can safely switch 
to swapper_pg_dir. Because on ARM, those are the tables which are supplied 
by bootloader and/or kernel decompressor anyway.

That's why I consider it safe to switch to swapper_pg_dir mappings. Note 
the second arg to cpu_switch_mm() is an "output context", I've moved that 
now from using the current thread's (current->active_mm) to the temporary 
global (init_mm), so there's no longer any reliance on having a kernel 
thread context at the time swsusp_arch_resume() is entered.



Regarding interrupt stacks:

cpu_init() looks like the way to go for those. That takes care of them.

Seems better to do that as well than to enforce saving this context over a 
power transition; if the kernel might find a good reason to have different 
FIQ/IRQ/UND/ABT stacks after power transitions (just hypothetically) the 
hibernate code should get out of its way.

I've added the call to cpu_init() at the end of swsusp_arch_resume(); that 
again brings it in line with the existing cpu idle code for various ARM 
incarnations.

I've also, for good measure, added a local_fiq_disable() / enable() 
bracked within save/restore_processor_state(). Again, no more than the 
cpu_idle code does, so hibernation should as well.


What I've found necessary to save/restore via swsusp_arch_suspend/resume 
are the SYSTEM_MODE and SVC_MODE registers.
Yesterday, I had thought that cpu_init() resets SVC_MODE sufficiently but 
that doesn't seem to be the case, if I leave that out, resume-from-disk 
doesn't work anymore.




Regarding other state:

In the first email on this thread, I've said "let's talk the generic code 
only (and ignore what's in __save/__restore_processor_state for now)".

Maybe it's a good idea to look into the machine type code again at this 
point ...
The CPU idle code for various ARM incarnations does state saves for 
subsystems beyond just the core; e.g. omap_sram_idle() does:

 	omap3_core_restore_context();
 	omap3_prcm_restore_context();
 	omap3_sram_restore_context();
 	omap2_sms_restore_context();

Samsung ARM11's do in their cpu_idle:

 	s3c_pm_restore_core();
 	s3c_pm_restore_uarts();
 	s3c_pm_restore_gpios();

and so on; this is currently not covered by the resume-from-disk code that 
I have; the lack of that might be a possible cause for e.g. the omap video 
restore issues I've seen. That's speculation, though.


Is this stuff needed (for suspend-to/resume-from-disk) ?

If so:
>From the way the the suspend-to-ram code is currently modeled, such state 
is saved before the "SoC ARM context" parts, and restored after that and 
the cpu_init() call. All ARM machines seem to do like:

...pm_enter():

 	local_irq_disable()
 	local_fiq_disable();
 	... maybe: save "machine-specific" stuff ...

 	... enter idle
 		==> save SoC state (CP regs)
 		<== restore
 	cpu_init()

 	... maybe: restore "machine-specific" stuff ...
 	local_fiq_enable()
 	local_irq_enable()

Anyway, that given, I wonder whether it makes sense to give the machines a 
hook into save/restore_processor_state.
The other option of course it to be lazy (call it "flexible" if you 
wish) and leave the cpu_init() call to the (single) existing machine-hook.


Thanks,
FrankH.
