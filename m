From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Patch v4 12/16] x86, irq, ACPI: Implement interface to support
 ACPI based IOAPIC hot-addition
Date: Wed, 10 Sep 2014 22:06:02 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1409102202530.4178@nanos>
References: <1409192561-19744-1-git-send-email-jiang.liu@linux.intel.com> <1409192561-19744-13-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.10.1409091417120.11037@nanos> <540FC1C2.40100@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35795 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbaIJUGn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Sep 2014 16:06:43 -0400
In-Reply-To: <540FC1C2.40100@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Grant Likely <grant.likely@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, x86@kernel.org, Prarit Bhargava <prarit@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Tony Luck <tony.luck@intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-pm@vger.kernel.org

On Wed, 10 Sep 2014, Jiang Liu wrote:
> >>  int mp_register_ioapic(int id, u32 address, u32 gsi_base,
> >> @@ -3867,8 +3873,15 @@ int mp_register_ioapic(int id, u32 address, u32 gsi_base,
> >>  	}
> >>  	for_each_ioapic(ioapic)
> >>  		if (ioapics[ioapic].mp_config.apicaddr == address) {
> >> -			pr_warn("address 0x%x conflicts with IOAPIC%d\n",
> >> -				address, ioapic);
> >> +			/*
> >> +			 * IOAPIC unit may also be visible in PCI scope.
> >> +			 * When ioapic PCI driver's probe() is called,
> >> +			 * the IOAPIC unit may have already been initialized
> >> +			 * at boot time.
> >> +			 */
> >> +			if (!ioapic_initialized)
> >> +				pr_warn("address 0x%x conflicts with IOAPIC%d\n",
> >> +					address, ioapic);
> > 
> > Hmm. This smells fishy. Why do we allow multiple initializations of
> > the same IOAPIC in the first place. Either it's done via ACPI or via
> > PCI, but not both.
> The ACPI subsystem will register and initialize all IOAPICs when walking
> ACPI MADT table during boot, before initializing PCI subsystem.
> Later when binding ioapic PCI driver to IOAPIC PCI device, it will try
> to register the IOAPIC device again.
> 
> After this patchset is applied, we could remove the !ioapic_initialized
> check. We check acpi_ioapic_register() before calling
> acpi_register_ioapic(). So the check becomes redundant.
> Or we could remove the temporary code from this patch.

How about removing the disfunctional ioapic PCI driver first and then
implementing the whole thing cleanly?
 
> > 
> >>  			return -EEXIST;
> >>  		}
> >>  
> >> @@ -3918,6 +3931,14 @@ int mp_register_ioapic(int id, u32 address, u32 gsi_base,
> >>  	ioapics[idx].irqdomain = NULL;
> >>  	ioapics[idx].irqdomain_cfg = *cfg;
> >>  
> >> +	if (ioapic_initialized) {
> > 
> > I have a hard time to understand this conditional. Why can't we do
> > that unconditionally?
> How about following comments?
> /*
>  * If mp_register_ioapic() is called during early boot stage when
>  * walking ACPI/SFI/DT tables, it's too early to create irqdomain,
>  * we are still using bootmem allocator. So delay it to setup_IO_APIC().
>  */

Fine, but then the "if (ioapic_initialized)" conditional still does
not make sense. We surely have some global non ioapic specific
indicator that bootmem is done and the proper memory allocator is
available, right?

Aside of that is there a point to walk those tables before we actually
can make any use of their content?

Thanks,

	tglx
