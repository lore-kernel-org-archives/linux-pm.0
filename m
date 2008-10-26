From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/4] x86 hibernate: Mark ACPI NVS memory
	region at startup
Date: Sun, 26 Oct 2008 13:29:15 +0100
Message-ID: <200810261329.16260.rjw__11107.37974891$1225023997$gmane$org@sisk.pl>
References: <200810222249.20629.rjw@sisk.pl> <200810222253.16264.rjw@sisk.pl>
	<20081026121404.GC1607@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081026121404.GC1607@ucw.cz>
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
To: Pavel Machek <pavel@suse.cz>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sunday, 26 of October 2008, Pavel Machek wrote:
> On Wed 2008-10-22 22:53:15, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > x86 hibernate: Mark ACPI NVS memory region at startup
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
> >  1 file changed, 25 insertions(+)
> > 
> > Index: linux-2.6/arch/x86/kernel/e820.c
> > ===================================================================
> > --- linux-2.6.orig/arch/x86/kernel/e820.c
> > +++ linux-2.6/arch/x86/kernel/e820.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/pfn.h>
> >  #include <linux/suspend.h>
> >  #include <linux/firmware-map.h>
> > +#include <linux/efi.h>
> >  
> >  #include <asm/pgtable.h>
> >  #include <asm/page.h>
> 
> Unrelated chunk?
> 
> > @@ -665,6 +666,30 @@ void __init e820_mark_nosave_regions(uns
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
> > +	int i;
> > +
> > +	if (efi_enabled)
> > +		return 0;
> 
> Aha, not unrelated... why is that? EFI does not use acpi? 

With EFI we are not supposed to do that.  Rui knows the details.  Rui?

> > +	for (i = 0; i < e820.nr_map; i++) {
> > +		struct e820entry *ei = &e820.map[i];
> > +
> > +		if (ei->type == E820_NVS)
> > +			hibernate_nvs_register(ei->addr, ei->size);
> 
> can nvs_register fail? (OOM?)

It can, in which case it will do the cleanup.

Thanks,
Rafael
