From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 04/12][RFC v3] x86, hibernate: Extract the common code of
 64/32 bit system
Date: Wed, 19 Sep 2018 12:15:04 +0200
Message-ID: <CAJZ5v0iOEyxcxA7=X_4GO-giXsqEf5XmmfV=AgwJPZwSKHRm2w@mail.gmail.com>
References: <cover.1537275915.git.yu.c.chen@intel.com> <020db877db6a8d39808dfaef2a5162f541f0853b.1537275915.git.yu.c.chen@intel.com>
 <CAJZ5v0jvB5zF-LqYsB1ughaZbRhZW1RjVSvY87q_W_pNkmqBeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jvB5zF-LqYsB1ughaZbRhZW1RjVSvY87q_W_pNkmqBeQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, kookoo.gu@intel.com
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 19, 2018 at 11:03 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Sep 19, 2018 at 9:32 AM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > From: Zhimin Gu <kookoo.gu@intel.com>
> >
> > Reduce the hibernation code duplication between x86-32 and x86-64
> > by extracting the common code into hibernate.c.
> >
> > No functional change.
> >
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  arch/x86/include/asm/suspend.h |   8 ++
> >  arch/x86/power/Makefile        |   2 +-
> >  arch/x86/power/hibernate.c     | 249 +++++++++++++++++++++++++++++++++
> >  arch/x86/power/hibernate_32.c  |  15 +-
> >  arch/x86/power/hibernate_64.c  | 221 -----------------------------
> >  5 files changed, 259 insertions(+), 236 deletions(-)
> >  create mode 100644 arch/x86/power/hibernate.c
> >
> > diff --git a/arch/x86/include/asm/suspend.h b/arch/x86/include/asm/suspend.h
> > index ecffe81ff65c..40b02558749f 100644
> > --- a/arch/x86/include/asm/suspend.h
> > +++ b/arch/x86/include/asm/suspend.h
> > @@ -4,3 +4,11 @@
> >  #else
> >  # include <asm/suspend_64.h>
> >  #endif
> > +extern unsigned long restore_jump_address __visible;
> > +extern unsigned long jump_address_phys;
> > +extern unsigned long restore_cr3 __visible;
> > +extern unsigned long temp_level4_pgt __visible;
> > +extern unsigned long relocated_restore_code __visible;
> > +extern int relocate_restore_code(void);
> > +/* Defined in hibernate_asm_32/64.S */
> > +extern asmlinkage __visible int restore_image(void);
> > diff --git a/arch/x86/power/Makefile b/arch/x86/power/Makefile
> > index a4701389562c..37923d715741 100644
> > --- a/arch/x86/power/Makefile
> > +++ b/arch/x86/power/Makefile
> > @@ -7,4 +7,4 @@ nostackp := $(call cc-option, -fno-stack-protector)
> >  CFLAGS_cpu.o   := $(nostackp)
> >
> >  obj-$(CONFIG_PM_SLEEP)         += cpu.o
> > -obj-$(CONFIG_HIBERNATION)      += hibernate_$(BITS).o hibernate_asm_$(BITS).o
> > +obj-$(CONFIG_HIBERNATION)      += hibernate_$(BITS).o hibernate_asm_$(BITS).o hibernate.o
> > diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
> > new file mode 100644
> > index 000000000000..fbde8f0e8fe0
> > --- /dev/null
> > +++ b/arch/x86/power/hibernate.c
> > @@ -0,0 +1,249 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Hibernation support for x86
> > + *
> > + * Copyright (c) 2007 Rafael J. Wysocki <rjw@sisk.pl>
> > + * Copyright (c) 2002 Pavel Machek <pavel@ucw.cz>
> > + * Copyright (c) 2001 Patrick Mochel <mochel@osdl.org>
>
> I don't think this "copyright" information has any legal bearing any
> more at this point.
>
> I would just write it as
>
>  * Authors:
>  *  2007 Rafael J. Wysocki <rjw@sisk.pl>
>  *  2002 Pavel Machek <pavel@ucw.cz>
>  *  2001 Patrick Mochel <mochel@osdl.org>
>
> as a matter of credits to the people who originally developed this code.
>
> > + */
> > +
> > +#include <linux/gfp.h>
> > +#include <linux/smp.h>
> > +#include <linux/suspend.h>
> > +#include <linux/scatterlist.h>
> > +#include <linux/kdebug.h>
> > +
> > +#include <crypto/hash.h>
> > +
> > +#include <asm/e820/api.h>
> > +#include <asm/init.h>
> > +#include <asm/proto.h>
> > +#include <asm/page.h>
> > +#include <asm/pgtable.h>
> > +#include <asm/mtrr.h>
> > +#include <asm/sections.h>
> > +#include <asm/suspend.h>
> > +#include <asm/tlbflush.h>
> > +
> > +/*
> > + * Address to jump to in the last phase of restore in order to get to the image
> > + * kernel's text (this value is passed in the image header).
> > + */
> > +unsigned long restore_jump_address __visible;
> > +unsigned long jump_address_phys;
> > +
> > +/*
> > + * Value of the cr3 register from before the hibernation (this value is passed
> > + * in the image header).
> > + */
> > +unsigned long restore_cr3 __visible;
> > +unsigned long temp_level4_pgt __visible;
> > +unsigned long relocated_restore_code __visible;
> > +
> > +#ifdef CONFIG_X86_64
> > +#define RESTORE_MAGIC  0x23456789ABCDEF01UL
> > +#else
> > +#define RESTORE_MAGIC  0x12345678UL
> > +#endif
> > +
> > +/**
> > + *     pfn_is_nosave - check if given pfn is in the 'nosave' section
> > + */
> > +int pfn_is_nosave(unsigned long pfn)
> > +{
> > +       unsigned long nosave_begin_pfn;
> > +       unsigned long nosave_end_pfn;
> > +
> > +       nosave_begin_pfn = __pa_symbol(&__nosave_begin) >> PAGE_SHIFT;
> > +       nosave_end_pfn = PAGE_ALIGN(__pa_symbol(&__nosave_end)) >> PAGE_SHIFT;
> > +
> > +       return pfn >= nosave_begin_pfn && pfn < nosave_end_pfn;
> > +}
> > +
>
> Since the majority of the code below in this new file is only going to
> be used on 64-bit to start with, I will put it under #ifdef

I should have said "I would put it under #ifdef" here, sorry for the
possible confusion.

> CONFIG_X86_64 at this point and remove the #ifdef in one of the
> subsequent patches when 32-bit actually starts to use it.

Thanks,
Rafael
