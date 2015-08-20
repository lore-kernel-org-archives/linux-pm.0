From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Patch v2] x86, ACPI, irq: Add a quirk to override SCI polarity
 for HyperV
Date: Thu, 20 Aug 2015 11:15:18 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1508201111480.3873@nanos>
References: <alpine.DEB.2.11.1508182133010.3873@nanos> <1439963634-12006-1-git-send-email-jiang.liu@linux.intel.com> <CAJZ5v0g7F+BRMzc9-uuxHAK896B-hoOJ5AW7M4jGpowVG+hujw@mail.gmail.com> <55D42185.1000709@linux.intel.com> <CAJZ5v0gqAX+OEqKPK4b6nz4wpO=HScocTdBqzQsE=ikhA-rcwQ@mail.gmail.com>
 <55D427D3.7040103@linux.intel.com> <alpine.DEB.2.11.1508191025000.3873@nanos> <alpine.DEB.2.11.1508191039470.3873@nanos> <55D57160.40108@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55D57160.40108@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Nick Meier <nmeier@microsoft.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 20 Aug 2015, Jiang Liu wrote:
> On 2015/8/19 16:40, Thomas Gleixner wrote:
> > On Wed, 19 Aug 2015, Thomas Gleixner wrote:
> >> On Wed, 19 Aug 2015, Jiang Liu wrote:
> >>> On 2015/8/19 14:45, Rafael J. Wysocki wrote:
> >>>> Well, the regression at hand has just shown that the assertion in the
> >>>> changelog of that commit ("no need for for special treatment for GSI
> >>>> used by ACPI SCI") does not really hold.  So, if the only motivation
> >>>> for it was to get rid of one extra check in mp_unregister_gsi()
> >>>> (mp_register_gsi() still needs to check if it is dealing with the SCI
> >>>> anyway), I'd vote for reverting it.
> >>> Hi Rafael,
> >>> 	The motivation is to treat SCI as normal IOAPIC interrupt so
> >>> we could enforce stricter pin attribute checking. Now it does reveal
> >>> flaws in ACPI BIOS implementations, but we ran into trouble about how to
> >>> handle those flaws:(
> >>
> >> The intent of this change is entirely correct, though it seems that
> >> reality of ACPI is just different.
> >>
> >> To be on the safe side of things, I agree with Rafael that we should
> >> revert that patch instead of introducing a single platform quirk.
> > 
> > Jiang,
> > 
> > can you please prepare a revert patch for this?
> Hi Rafael and Thomas,
> 	I have tried to revert commit cd68f6bd53cf, but found
> it's not an easy task now.

That's what I feared

> 	When converting to hierarchical irqdomain, the IOAPIC
> internal and interfaces have changed much, and seems no easy
> way to revert cd68f6bd53cf. There may be three possible solutions
> here:
> 1) use quirk to correct SCI polarity, as the patch does.
> 2) change IOAPIC interfaces to provide a special way to
>    handle SCI interrupt.
> 3) change drivers/acpi/pci_link.c to penalize SCI IRQ so it
>    won't be used for PCI IRQ if SCI polarity conflicts with
>    PCI IRQ polarity.

Stupid question. Is the SCI polarity ever the opposite of PCI
polarity? I.e. is such a ACPI override valid at all? 

Thanks,

	tglx
