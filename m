From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/4] x86 hibernate: Mark ACPI NVS memory
	region at startup
Date: Tue, 28 Oct 2008 14:30:49 +0100
Message-ID: <200810281430.50441.rjw__2657.07787261835$1225200731$gmane$org@sisk.pl>
References: <200810262048.23468.rjw@sisk.pl> <200810262054.24929.rjw@sisk.pl>
	<86802c440810280217x59357432n52880f75d96bc801@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <86802c440810280217x59357432n52880f75d96bc801@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 28 of October 2008, Yinghai Lu wrote:
> On Sun, Oct 26, 2008 at 12:54 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > Subject: x86 hibernate: Mark ACPI NVS memory region at startup
> >
> > Introduce new initcall for marking the ACPI NVS memory at startup, so
> > that it can be saved/restore during hibernation/resume.
> >
> > Based on a patch by Zhang Rui.
> >
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  arch/x86/kernel/e820.c |   25 +++++++++++++++++++++++++
> >  1 files changed, 25 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> > index ce97bf3..e1e63a8 100644
> > --- a/arch/x86/kernel/e820.c
> > +++ b/arch/x86/kernel/e820.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/pfn.h>
> >  #include <linux/suspend.h>
> >  #include <linux/firmware-map.h>
> > +#include <linux/efi.h>
> >
> >  #include <asm/pgtable.h>
> >  #include <asm/page.h>
> > @@ -665,6 +666,30 @@ void __init e820_mark_nosave_regions(unsigned long limit_pfn)
> >  }
> >  #endif
> >
> > +#ifdef CONFIG_HIBERNATION
> > +/**
> > + * Mark ACPI NVS memory region, so that we can save/restore it during
> > + * hibernation and the subsequent resume.
> > + */
> > +static int __init e820_mark_nvs_memory(void)
> > +{
> > +       int i;
> > +
> > +       if (efi_enabled)
> > +               return 0;
> > +
> > +       for (i = 0; i < e820.nr_map; i++) {
> > +               struct e820entry *ei = &e820.map[i];
> > +
> > +               if (ei->type == E820_NVS)
> > +                       hibernate_nvs_register(ei->addr, ei->size);
> 
> do you need to something to ACPI code too?

No, ACPI NVS only, according to the spec.

> BIOS-provided physical RAM map:
> >  BIOS-e820: 0000000000000100 - 0000000000095800 (usable)
> >  BIOS-e820: 0000000000095800 - 00000000000a0000 (reserved)
> >  BIOS-e820: 0000000000100000 - 00000000d7fa0000 (usable)
> >  BIOS-e820: 00000000d7fae000 - 00000000d7fb0000 (reserved)
> >  BIOS-e820: 00000000d7fb0000 - 00000000d7fbe000 (ACPI data) <================ acpi code
> >  BIOS-e820: 00000000d7fbe000 - 00000000d7ff0000 (ACPI NVS)
> >  BIOS-e820: 00000000d7ff0000 - 00000000d8000000 (reserved)
> >  BIOS-e820: 00000000dc000000 - 00000000f0000000 (reserved)
> >  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
> >  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
> >  BIOS-e820: 00000000ff700000 - 0000000100000000 (reserved)
> >  BIOS-e820: 0000000100000000 - 0000004028000000 (usable)

Thanks,
Rafael
