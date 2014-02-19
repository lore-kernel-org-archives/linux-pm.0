From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH RFC v1 3/3] ARM hibernation / suspend-to-disk
Date: Wed, 19 Feb 2014 11:33:15 -0800
Message-ID: <20140219193315.3732.21819@capellas-linux>
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
> [...]
> > diff --git a/arch/arm/kernel/hibernate.c b/arch/arm/kernel/hibernate.c
> > new file mode 100644
> > index 0000000..16f406f
> > --- /dev/null
> > +++ b/arch/arm/kernel/hibernate.c
> > +void notrace save_processor_state(void)
> > +{
> > +     WARN_ON(num_online_cpus() != 1);
> > +     flush_thread();
> 
> Can you explain to me please why we need to call flush_thread() here ?
> At this point in time syscore_suspend() was already called and CPU
> peripheral state saved through CPU PM notifiers.

Copying Russ' response here: 

"I think the idea here is to get the CPU into a state so that later
when we resume from the resume kernel, the actual CPU state matches
the state we have in kernel. The main thing flush_thread does is clear
out any and all FP state." - Russ Dill

> 
> > +     local_fiq_disable();
> 
> To me it looks like we are using this hook to disable fiqs, since it is
> not done in generic code.
> 
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
> I do not understand why a soft_restart is required here.

Let me try skipping the restart, it sounds like a good idea, thanks!
I'll let you know.

> On a side note,
> finisher is called with irqs disabled so, since you added a function for
> soft restart noirq, it should be used, if needed, but I have to understand
> why in the first place.

Thanks, will have a look at this also

> > +/*
> > + * Save the current CPU state before suspend / poweroff.
> > + */
> > +int notrace swsusp_arch_suspend(void)
> > +{
> > +     return cpu_suspend(0, __swsusp_arch_save_image);
> 
> If the goal of soft_restart is to return 0 on success from this call,
> you can still do that without requiring a soft_restart in the first
> place. IIUC all you want to achieve is to save processor context
> registers so that when you resume from image you will actually return
> from here.

I think you're right, but I need to verify.  Here, we want to snapshot the
system's suspended state to the hibernation buffer, that way when we restore
the image, we resume from the saved suspended state.  This state is
already saved to the buffer after the swsusp_save call in
__swsusp_arch_save_image.  We resume and then write the saved buffer to
the resume partition.  Once we're done saving the image to the buffer I
can't think why we actually need the restart.  There's only one tricky bit
that I can think of, and that's the use of the nosave area to distinguish
the path of completing hibernation entry from resume from hibernation,
but I believe this would be handled correctly without a restart.
Let me try it out and see.

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

At restore time, we take the save buffer data and restore it to the same
physical locations used in the previous execution.  This will require having
write access to all of memory, which may not be generally granted by the
current mm.  So we switch to 1-1 init_mm to restore memory.

At hibernation entry, the system is writing only to save buffer memory,
so we don't have this problem.  It has read access to all of the memory,
and can copy to the save buffer.

Hopefully my comment above addressed this, but please let me know if I
need to provide more info.

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

I will need to look at this more carefully and get back to you.  I can


> 
> > +     cpu_init();     /* get a clean PSR */
> 
> cpu_init is called in the cpu_resume path, why is this call needed here ?

I'll look more into this and get back with further comments.

Thanks Lorenzo!

Sebastian
