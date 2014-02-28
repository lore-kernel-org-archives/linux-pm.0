From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH v6 2/2] ARM hibernation / suspend-to-disk
Date: Fri, 28 Feb 2014 12:15:57 -0800
Message-ID: <20140228201557.29118.62126@capellas-linux>
References: <1393545478-14908-1-git-send-email-sebastian.capella@linaro.org>
 <1393545478-14908-3-git-send-email-sebastian.capella@linaro.org>
 <20140228095022.GA25090@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140228095022.GA25090@e102568-lin.cambridge.arm.com>
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
Cc: Len Brown <len.brown@intel.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Russell King <linux@arm.linux.org.uk>, Jonathan Austin <Jonathan.Austin@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, Nicolas Pitre <nico@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>, Russ Dill <Russ.Dill@ti.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Sorry, I appear to be having problems with my emails where list emails are
bouncing back to me.  I'm working on correcting this now.

Quoting Lorenzo Pieralisi (2014-02-28 01:50:22)
> On Thu, Feb 27, 2014 at 11:57:58PM +0000, Sebastian Capella wrote:
> 
> [...]
> 
> > diff --git a/arch/arm/kernel/hibernate.c b/arch/arm/kernel/hibernate.c
> > new file mode 100644
> > index 0000000..a41e0e3
> > --- /dev/null
> > +++ b/arch/arm/kernel/hibernate.c
...
> > +#include <linux/suspend.h>
> > +#include <asm/tlbflush.h>
> > +#include <asm/cacheflush.h>
> 
> You can drop tlbflush.h and cacheflush.h, they do not seem to be needed.

Done! Thanks!

> > +
> > +/*
> > + * The framework loads the hibernation image into a linked list anchored
> > + * at restore_pblist, for swsusp_arch_resume() to copy back to the proper
> > + * destinations.
> > + *
> > + * To make this work if resume is triggered from initramfs, the
> > + * pagetables need to be switched to allow writes to kernel mem.
> > + */
> 
> Comment above needs updating. We are switching page tables to a set of
> page tables that are certain to live at the same location in the older
> kernel, that's the only reason, as we discussed. soft_restart will make
> sure (again) to switch to 1:1 page tables so that we can call cpu_resume
> with the MMU off.

How does this look?

The framework loads as much of the hibernation image to final physical
pages as possible.  Any pages that were in use, will need to be restored
prior to the soft_restart.  The pages to restore are maintained in
the list anchored at restore_pblist.  At this point, we can swap the
pages to their final location.  We must switch the mapping to 1:1 to
ensure that when we overwrite the page table physical pages we're using
a known physical location (idmap_pgd) with known contents.

> > +/*
> > + * Resume from the hibernation image.
> > + * Due to the kernel heap / data restore, stack contents change underneath
> > + * and that would make function calls impossible; switch to a temporary
> > + * stack within the nosave region to avoid that problem.
> > + */
> > +int swsusp_arch_resume(void)
> > +{
> > +     extern void call_with_stack(void (*fn)(void *), void *arg, void *sp);
> > +     call_with_stack(arch_restore_image, 0,
> > +             resume_stack + sizeof(resume_stack));
> 
> This does not guarantee your stack is 8-byte aligned, that's not AAPCS
> compliant and might buy you trouble.
> 
> Either you align the stack or you align the pointer you are passing.
> 
> Please have a look at kernel/process.c

I've added this for now, do you see any issues?

-static u8 resume_stack[PAGE_SIZE/2] __nosavedata;
+static u64 resume_stack[PAGE_SIZE/2/sizeof(u64)] __nosavedata;
-               resume_stack + sizeof(resume_stack));
+               resume_stack + ARRAY_SIZE(resume_stack));

Thanks Lorenzo!

Sebastian
