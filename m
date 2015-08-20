From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Patch v2] x86, ACPI, irq: Add a quirk to override SCI polarity
 for HyperV
Date: Thu, 20 Aug 2015 13:13:34 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1508201247370.3873@nanos>
References: <alpine.DEB.2.11.1508182133010.3873@nanos> <1439963634-12006-1-git-send-email-jiang.liu@linux.intel.com> <CAJZ5v0g7F+BRMzc9-uuxHAK896B-hoOJ5AW7M4jGpowVG+hujw@mail.gmail.com> <55D42185.1000709@linux.intel.com> <CAJZ5v0gqAX+OEqKPK4b6nz4wpO=HScocTdBqzQsE=ikhA-rcwQ@mail.gmail.com>
 <55D427D3.7040103@linux.intel.com> <alpine.DEB.2.11.1508191025000.3873@nanos> <alpine.DEB.2.11.1508191039470.3873@nanos> <55D57160.40108@linux.intel.com> <alpine.DEB.2.11.1508201111480.3873@nanos> <55D59F6C.9050901@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36244 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbbHTLOM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2015 07:14:12 -0400
In-Reply-To: <55D59F6C.9050901@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Nick Meier <nmeier@microsoft.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thu, 20 Aug 2015, Jiang Liu wrote:
> On 2015/8/20 17:15, Thomas Gleixner wrote:
> > On Thu, 20 Aug 2015, Jiang Liu wrote:
> >> 	When converting to hierarchical irqdomain, the IOAPIC
> >> internal and interfaces have changed much, and seems no easy
> >> way to revert cd68f6bd53cf. There may be three possible solutions
> >> here:
> >> 1) use quirk to correct SCI polarity, as the patch does.
> >> 2) change IOAPIC interfaces to provide a special way to
> >>    handle SCI interrupt.
> >> 3) change drivers/acpi/pci_link.c to penalize SCI IRQ so it
> >>    won't be used for PCI IRQ if SCI polarity conflicts with
> >>    PCI IRQ polarity.
> > 
> > Stupid question. Is the SCI polarity ever the opposite of PCI
> > polarity? I.e. is such a ACPI override valid at all? 
> Hi Thomas,
> 	I have analyzed another system which works:
> 1) SCI(IRQ9) works in level, high mode (so such an ACPI override is valid)
> 2) there's a flag to detect whether system works in PIC or APIC mode.
> 3) IRQ9 may be used for PCI IRQ if system works in PIC mode.

Why?

> 4) IRQ9 won't be used for PCI IRQ if system works in APIC mode.
> Based on the above observation, I feel solution 3) may be the best one.

Can you whip up a patch and test it on hyperv and maybe other machines
which have that SCI override.

Thanks

	tglx
