From: Frank Hofmann <frank.hofmann@tomtom.com>
Subject: Re: [RFC PATCH] Current status,
	suspend-to-disk support on ARM
Date: Wed, 13 Apr 2011 14:36:58 +0100 (BST)
Message-ID: <alpine.DEB.2.00.1104131020080.29883__30661.9159215645$1302701967$gmane$org@localhost6.localdomain6>
References: <alpine.DEB.2.00.1104041424310.690@localhost6.localdomain6>
	<20110412055958.GA3507@ucw.cz>
	<alpine.DEB.2.00.1104121636460.29883@localhost6.localdomain6>
	<20110412183208.GC26916@elf.ucw.cz>
Reply-To: frank.hofmann@tomtom.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110412183208.GC26916@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Frank Hofmann <frank.hofmann@tomtom.com>, linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



On Tue, 12 Apr 2011, Pavel Machek wrote:

> Hi!
[ ... ]
>> But then on all architectures in kernels as far back as 2.6.32 it
>> doesn't look like save/restore_processor state are actually
>> adjusting the preempt count; nowhere do they call
>> preempt_enable/disable.
>
> You might need to dig a bit more. IIRC it manipulated FPU or something
> long time ago.

Actually, it's the other way round - kernel_fpu_begin/end are users of 
preempt_disable/enable, quote Documentation/preempt-locking.txt:

 	Note, some FPU functions are already explicitly preempt safe.  For example,
 	kernel_fpu_begin and kernel_fpu_end will disable and enable preemption.
 	However, math_state_restore must be called with preemption disabled.

But kernel_fpu_begin/end functions are x86-specific. At best, that makes 
the comment in hibernate.c (which refers to "needing" preempt_dis/enable) 
misleading.

x86, in this, is an odd one out, though, in ; On ARM, for example, saving 
the FP context happens through a PM notifier.

In addition, it seems that the code (at least in hibernate.c, 
create_image) does anyway:

 	- go single-cpu (disables all but current)
 	- switch interrupts off (local_irq_disable)

before going into save_processor_state - wouldn't that mean all conditions 
for nonpreemptable (or all conditions for a stable FP state) are already 
met by that time ?



>
>> Finally, on things like e.g. the floating point context saves:
>> Wouldn't this happen as part of freezing processes (in the early
>> stages of suspend), and/or as part of device quiesce ?
>
> Are you sure? I thought we have (had?) concept of lazy FPU
> saving... and occassionaly kernel uses FPU too (with some
> precautions).

speaking in particular for ARM, I'd deflect the answer to:

 	http://www.spinics.net/lists/linux-pm/msg22839.html

It's lazy but it does happen ... without any specific need to have the 
"bracketing" that save/restore_processor_state are doing.


Food for thought:

I mean, the code in hibernate.c really looks like this (quote):


static int create_image(int platform_mode)
{
         int error;

         error = arch_prepare_suspend();				<===== platform hook 1
[ ... ]
         error = dpm_suspend_noirq(PMSG_FREEZE);			<===== platform hook 2
[ ... ]
         error = platform_pre_snapshot(platform_mode);		<===== platform hook 3
[ ... ]
         error = disable_nonboot_cpus();				<===== platform hook 4
[ ... ]
         error = sysdev_suspend(PMSG_FREEZE);			<===== ...
         if (!error)
                 error = syscore_suspend();			<===== ...
[ ... ]
         in_suspend = 1;
         save_processor_state();					<===== platform hook N-1
         error = swsusp_arch_suspend();				<===== platform hook N
[ ... ]
         restore_processor_state();				<===== platform hook N+1
[ ... ]

And that's _without_ the platform hibernation ops hooks code in 
hibernate(), which calls this one.

This code is full of places where to plug save/restore code (or any sort 
of "bracketing" begin/finish hooks) into.
It's surprising that with all these hooks existing already, "bracketing" 
of swsusp_arch_suspend() by save/restore_processor state is so sacrosanct.

These are _three_ arch-dependent hooks in three consecutive lines of code.

If a platform requires the bracketing, why can it not do that part in 
syscore_suspend() ? Or why not simply embed it in swsusp_arch_suspend() ?

As said, wrt. to save/restore_processor_state, x86 is definitely the odd 
one out (and not a good example) with the monstrosity of code; all other 
architectures either have trivial or even completely empty code for
save/restore_processor_state().

Should we really force everyone to provide an (as good as) empty hook just 
because x86 at one point had chosen to have it ?

>
>>>> @@ -195,6 +195,14 @@ config VECTORS_BASE
>>>> 	help
>>>> 	  The base address of exception vectors.
>>>>
>>>> +config ARCH_HIBERNATION_POSSIBLE
>>>> +	bool
>>>> +	help
>>>> +	  If the machine architecture supports suspend-to-disk
>>>> +	  it should select this automatically for you.
>>>> +	  Otherwise, say 'Y' at your own peril.
>>>> +
>>>
>>> Good for debugging, but not good for mainline.
>>
>> How would this be done better ?
>
> Just set the ARCH_HIBERNATION_POSSIBLE=y in the ARM code now that ARM
> can do it. No need to ask user.

I.e. preferrably:

 	config ARCH_HIBERNATION_POSSIBLE
 		def_bool n

plus the "select" within the actual platform config subsection for those 
that have it.

To stress the point: "ARM can do it" would be an exaggeration even if 
those changes went in, because only some ARM types will have it.

The situation on ARM is identical to e.g. SuperH, see arch/sh/Kconfig,

config SUPERH32
         def_bool ARCH = "sh"
[ ... various ... ]
         select ARCH_HIBERNATION_POSSIBLE if MMU

config ARCH_HIBERNATION_POSSIBLE
         def_bool n


>
>> @@ -412,8 +413,7 @@ static int resume_target_kernel(bool platform_mode)
>>  	if (error)
>>  		goto Enable_irqs;
>>
>> -	/* We'll ignore saved state, but this gets preempt count (etc) right */
>> -	save_processor_state();
>> +	preempt_disable();
>>  	error = restore_highmem();
>>  	if (!error) {
>>  		error = swsusp_arch_resume();
>
> Yep. save_processor_state() on x86 does kernel_fpu_begin(), and than
> one needs to be balanced IIRC.


The needs of x86 force generic kernel changes ;-)

FrankH.

>
> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
