From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH RFC v1 3/3] ARM hibernation / suspend-to-disk
Date: Thu, 20 Feb 2014 17:01:23 -0800
Message-ID: <20140221010123.1302.67558@capellas-linux>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-4-git-send-email-sebastian.capella@linaro.org>
 <20140219161254.GB19343@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140219161254.GB19343@e102568-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Len Brown <len.brown@intel.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Russell King <linux@arm.linux.org.uk>, Jonathan Austin <Jonathan.Austin@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, Nicolas Pitre <nico@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>, Russ Dill <Russ.Dill@ti.com>, Pavel Machek <pavel@ucw.cz>, Cyril Chemparathy <cyril@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Quoting Lorenzo Pieralisi (2014-02-19 08:12:54)
> On Wed, Feb 19, 2014 at 01:52:09AM +0000, Sebastian Capella wrote:
> 
> [...]
> 
> > diff --git a/arch/arm/kernel/hibernate.c b/arch/arm/kernel/hibernate.c
> > new file mode 100644
> > index 0000000..16f406f
> > --- /dev/null
> > +++ b/arch/arm/kernel/hibernate.c
> > @@ -0,0 +1,106 @@
> > +/*
> > + * Hibernation support specific for ARM
> > + *
> > + * Derived from work on ARM hibernation support by:
> > + *
> > + * Ubuntu project, hibernation support for mach-dove
> > + * Copyright (C) 2010 Nokia Corporation (Hiroshi Doyu)
> > + * Copyright (C) 2010 Texas Instruments, Inc. (Teerth Reddy et al.)
> > + *  https://lkml.org/lkml/2010/6/18/4
> > + *  https://lists.linux-foundation.org/pipermail/linux-pm/2010-June/027422.html
> > + *  https://patchwork.kernel.org/patch/96442/
> > + *
> > + * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
> > + *
> > + * License terms: GNU General Public License (GPL) version 2
> > + */
> > +
> > +#include <linux/mm.h>
> > +#include <linux/suspend.h>
> > +#include <asm/tlbflush.h>
> > +#include <asm/cacheflush.h>
> > +#include <asm/system_misc.h>
> > +#include <asm/idmap.h>
> > +#include <asm/suspend.h>
> > +
> > +extern const void __nosave_begin, __nosave_end;
> > +
> > +int pfn_is_nosave(unsigned long pfn)
> > +{
> > +     unsigned long nosave_begin_pfn =
> > +                     __pa_symbol(&__nosave_begin) >> PAGE_SHIFT;
> > +     unsigned long nosave_end_pfn =
> > +                     PAGE_ALIGN(__pa_symbol(&__nosave_end)) >> PAGE_SHIFT;
> > +
> > +     return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
> > +}
> > +
> > +void notrace save_processor_state(void)
> > +{
> > +     WARN_ON(num_online_cpus() != 1);
> > +     flush_thread();
> 
> Can you explain to me please why we need to call flush_thread() here ?
> At this point in time syscore_suspend() was already called and CPU
> peripheral state saved through CPU PM notifiers.

Removed this, and everything seems to function correctly.  I'll remove this
in v2.

> > +     local_fiq_disable();
> 
> To me it looks like we are using this hook to disable fiqs, since it is
> not done in generic code.

Correct.

> > +
> > +/*
> > + * Snapshot kernel memory and reset the system.
> > + * After resume, the hibernation snapshot is written out.
> > + */
> > +static int notrace __swsusp_arch_save_image(unsigned long unused)
> > +{
> > +     int ret;
> > +
> > +     ret = swsusp_save();
> > +     if (ret == 0)
> > +             soft_restart(virt_to_phys(cpu_resume));
> 
> By the time the suspend finisher (ie this function) is run, the
> processor state has been saved and I think that's all you have to do,
> function can just return after calling swsusp_save(), unless I am missing
> something.
> 
> I do not understand why a soft_restart is required here. On a side note,
> finisher is called with irqs disabled so, since you added a function for
> soft restart noirq, it should be used, if needed, but I have to understand
> why in the first place.
	[...]
> If the goal of soft_restart is to return 0 on success from this call,
> you can still do that without requiring a soft_restart in the first
> place. IIUC all you want to achieve is to save processor context
> registers so that when you resume from image you will actually return
> from here.

Returning 0 here produces a return value of 1 to the caller of
cpu_suspend.  The return value is replaced with a literal 1 in
the cpu_suspend_abort handling.  I don't see this being used anywhere;
most places seem to consider it a suspend failure/panic/bug.  It only
happens if the finisher returns 0.

If I check for this literal in swsusp_arch_suspend, everything appears to work well.
The check is a little ugly looking.  I'll plan to add this to v2.
Please let me know if you have any suggestions.

> > +}
> > +
> > +/*
> > + * The framework loads the hibernation image into a linked list anchored
> > + * at restore_pblist, for swsusp_arch_resume() to copy back to the proper
> > + * destinations.
> > + *
> > + * To make this work if resume is triggered from initramfs, the
> > + * pagetables need to be switched to allow writes to kernel mem.
> 
> Can you elaborate a bit more on this please ?
> 
> > + */
> > +static void notrace __swsusp_arch_restore_image(void *unused)
> > +{
> > +     struct pbe *pbe;
> > +
> > +     cpu_switch_mm(idmap_pgd, &init_mm);
> 
> Same here, thanks.

Let's follow this at the head of your comments, since we've had more
discussion on this..

> > +}
> > +
> > +static u8 __swsusp_resume_stk[PAGE_SIZE/2] __nosavedata;
> > +
> > +/*
> > + * Resume from the hibernation image.
> > + * Due to the kernel heap / data restore, stack contents change underneath
> > + * and that would make function calls impossible; switch to a temporary
> > + * stack within the nosave region to avoid that problem.
> > + */
> > +int __naked swsusp_arch_resume(void)
> > +{
> > +     extern void call_with_stack(void (*fn)(void *), void *arg, void *sp);
> 
> Ok, a function with attribute __naked that still calls C functions, is
> attr __naked really needed here ?

With the cpu_init gone, the c functions are no longer called.  I've
removed the __naked and see no issues;  I'll test overnight and see.

BTW, this function is prototyped in kernel/power/power.h as:
  extern asmlinkage int swsusp_arch_resume(void);  I'm not sure
  whether/how to use this, but thought I'd bring it up.

> 
> > +     cpu_init();     /* get a clean PSR */
> 
> cpu_init is called in the cpu_resume path, why is this call needed here ?

Removed and behaves well.

I'm running overnight testing with these changes and will add them to
v2 patch after.

Thanks for your help and comments Lorenzo

Sebastian
