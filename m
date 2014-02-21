From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH RFC v1 3/3] ARM hibernation / suspend-to-disk
Date: Fri, 21 Feb 2014 10:39:56 -0800
Message-ID: <20140221183956.29890.80931@capellas-linux>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-4-git-send-email-sebastian.capella@linaro.org>
 <20140219161254.GB19343@e102568-lin.cambridge.arm.com>
 <20140219193315.3732.21819@capellas-linux>
 <20140220162754.GC15994@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140220162754.GC15994@e102568-lin.cambridge.arm.com>
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

Quoting Lorenzo Pieralisi (2014-02-20 08:27:55)
> Hi Sebastian,
> 
> On Wed, Feb 19, 2014 at 07:33:15PM +0000, Sebastian Capella wrote:
> > Quoting Lorenzo Pieralisi (2014-02-19 08:12:54)
> > > On Wed, Feb 19, 2014 at 01:52:09AM +0000, Sebastian Capella wrote:
> > > > +static void notrace __swsusp_arch_restore_image(void *unused)
> > > > +{
> > > > +     struct pbe *pbe;
> > > > +
> > > > +     cpu_switch_mm(idmap_pgd, &init_mm);
> > 
> > At restore time, we take the save buffer data and restore it to the same
> > physical locations used in the previous execution.  This will require having
> > write access to all of memory, which may not be generally granted by the
> > current mm.  So we switch to 1-1 init_mm to restore memory.

I can try removing it and seeing if there are side effects.

> 
> I still do not understand why switching to idmap, which is a clone of
> init_mm + 1:1 kernel mappings is required here. Why idmap ?
> And while at it, can't the idmap be overwritten _while_ copying back the
> resume kernel ? Is it safe to use idmap page tables while copying ?

Thanks for finding this!  I'm concerned about this now.  I still
haven't seen where this is handled.  I think we do need to switch
to a page table in safe memory, or at least make sure we're not going to
overwrite the page tables we're using.  I'll focus on this today

> I had a look at x86 and there idmap page tables used to resume are created
> on the fly using safe pages, on ARM idmap is created at boot.

After looking more at the arm code here's what I see:
- swsusp_read, will restore all hibernation pages to the same physical
  pages occupied pre-hibernation if the physical page is free. (get_buffer)
  - Since the page is free, nothing is dependent on it, it's writable
    and available, so we directly save to it, and it's ready for our
    restore.
  - if the original page is not free, we save the page to a different
    physical page that was not part of the physical page set
    pre-hibernation(safe_pages).  These pages are added to the
    restore_pblist along with the original intended physical address
    of the page.
- highmem is handled separately (pages that were not free are swapped
  and the memory map updated) (restore_himem)  Not sure if this affects
  anything, but I thought I'd mention it JIC.
- once we've read all of the hibernation image off of flash, we have a
  bunch of pages that are in the wrong place, linked at restore_pblist.
  We enter the restore image finisher, where everything is frozen,
  irq/fiq disabled and we're ready to suspend, and now we have to copy
  the pages in the wrong places back to their original physical pages.

In this state I believe:
  - our stack is safe because it's in nosave.
  - userspace is frozen, those pages are 'don't care', as we're
    discarding its state.
  - our instructions and globals are ok, because they're in the
    same place as last boot and are not getting restored.  None are in
    modules.
     - Globals: restore_pblist, idmap_pgd, init_mm, swapper_pg_dir
  - restore_pblist chain is allocated from "safe pages"
  - idmap_pgd table is allocated from freepages without worring about
    safe pages -- this is where there may be concern.  Also, not sure
    about 2nd or 3rd level pages if needed.  I'll look into this more.

static void notrace __swsusp_arch_restore_image(void *unused)
{
        struct pbe *pbe;    

        cpu_switch_mm(idmap_pgd, &init_mm);
        for (pbe = restore_pblist; pbe; pbe = pbe->next)
                copy_page(pbe->orig_address, pbe->address);
        
        soft_restart_noirq(virt_to_phys(cpu_resume));
}

As far as I see, where we are in swsusp_arch_init, the remaining risk
area is this page table.  Everything else looks ok?  Do you see any
more gaps?

Thanks Lorenzo!!

Sebastian
