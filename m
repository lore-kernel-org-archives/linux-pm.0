From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] make kASLR vs hibernation boot-time selectable
Date: Mon, 16 Jun 2014 01:16:05 +0200
Message-ID: <2415013.PxG9yLJ1ji@vostro.rjw.lan>
References: <1402602419-27934-1-git-send-email-keescook@chromium.org> <13135927.OjVm86GPrt@vostro.rjw.lan> <CAGXu5j+2bGNN0THZcMua7ft9EMbhQJnVYOX4v7W5-0BdjyQrOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAGXu5j+2bGNN0THZcMua7ft9EMbhQJnVYOX4v7W5-0BdjyQrOw@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, Len Brown <len.brown@intel.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday, June 14, 2014 12:37:49 AM Kees Cook wrote:
> On Fri, Jun 13, 2014 at 5:39 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Friday, June 13, 2014 05:08:21 PM Kees Cook wrote:
> >> On Fri, Jun 13, 2014 at 5:14 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> > On Friday, June 13, 2014 03:59:57 PM Kees Cook wrote:
> >> >> On Fri, Jun 13, 2014 at 3:54 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> >> > On Friday, June 13, 2014 03:07:19 PM Kees Cook wrote:
> >> >
> >> > [cut]
> >> >
> >> >> > I'll have a closer look at that shortly (it's been quite some time since
> >> >> > I wrote that code).
> >> >>
> >> >> Thanks; I'm trying to get a test environment instrumented too so I can
> >> >> look at this. (At the very least, it sounds like we'll still need my
> >> >> patch series for other architectures.)
> >> >
> >> > How can I obtain a kernel address of the beginning of a given page
> >> > (as represented by struct page) on x86_64 today?
> >>
> >> I don't know off the top of my head. I've used virt_to_phys, but
> >> things like PFN_PHYS(page_to_pfn(page)) maybe? I'm not entirely clear
> >> which you need, but mm.h seems to have the bulk of what I've seen.
> >
> > OK, I'm not sure how much sense this makes, but at least it should
> > illustrate the direction. :-)
> >
> > ---
> >  arch/x86/power/hibernate_64.c |    7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > Index: linux-pm/arch/x86/power/hibernate_64.c
> > ===================================================================
> > --- linux-pm.orig/arch/x86/power/hibernate_64.c
> > +++ linux-pm/arch/x86/power/hibernate_64.c
> > @@ -115,7 +115,7 @@ struct restore_data_record {
> >         unsigned long magic;
> >  };
> >
> > -#define RESTORE_MAGIC  0x0123456789ABCDEFUL
> > +#define RESTORE_MAGIC  0x0123456789ABCDF0UL
> >
> >  /**
> >   *     arch_hibernation_header_save - populate the architecture specific part
> > @@ -128,7 +128,8 @@ int arch_hibernation_header_save(void *a
> >
> >         if (max_size < sizeof(struct restore_data_record))
> >                 return -EOVERFLOW;
> > -       rdr->jump_address = restore_jump_address;
> > +
> > +       rdr->jump_address = virt_to_phys((void *)restore_jump_address);
> >         rdr->cr3 = restore_cr3;
> >         rdr->magic = RESTORE_MAGIC;
> >         return 0;
> > @@ -143,7 +144,7 @@ int arch_hibernation_header_restore(void
> >  {
> >         struct restore_data_record *rdr = addr;
> >
> > -       restore_jump_address = rdr->jump_address;
> > +       restore_jump_address = (unsigned long)phys_to_virt(rdr->jump_address);
> >         restore_cr3 = rdr->cr3;
> >         return (rdr->magic == RESTORE_MAGIC) ? 0 : -EINVAL;
> >  }
> >
> 
> Hrm, well, at least for me, it doesn't look to be that simple. I tried
> phys_to_virt, page_to_virt, and pfn_to_virt -- but it always fell
> over.

That's because of a missing piece I forgot about (below).

> Is jump_address page aligned?

It should be.

> Does the translation happen after the image page tables have been flushed?

I believe so, but it happens in the boot kernel still.

> It seems to me like we do actually want to virtual address, so this
> should already work without changes -- we want the image's expected
> entry point, which has already been read out of the saved image? I
> suspect there's some other assumption in the code that isn't jumping
> out at me yet.

We're jumping from the boot kernel into the image kernel.  The virtual address
comes from the image kernel, but the boot kernel has to use it.  The only way
we can ensure that we'll jump to the right place is to pass the physical address
in the header (otherwise we de facto assume that the virtual address of the
target page frame will be the same in both the boot and the image kernels).

The missing piece is that the code in swsusp_arch_resume() sets up temporary
page tables to ensure that they won't be overwritten while copying the last
remaining image kernel pages to the right page frames (those page tables
have to be stored in page frames that are free from the kernel image perspective).

But if the kernel address space is randomized, set_up_temporary_mappings()
really should duplicate the existing layout instead of creating a new one from
scratch.  Otherwise, virtual addresses before set_up_temporary_mappings() may
be different from the ones after it.

Rafael

