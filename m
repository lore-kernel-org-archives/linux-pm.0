From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] intel_idle: PCI quirk to prevent Lenovo Ideapad s10-3 boot
 hang
Date: Sat, 16 Oct 2010 04:25:59 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010160416340.2238@localhost.localdomain>
References: <alpine.LFD.2.00.1009242122390.8641@localhost.localdomain>
 <20100927135735.GA856@srcf.ucam.org>
 <alpine.LFD.2.00.1009301810380.7033@localhost.localdomain>
 <20100930222946.GB23084@srcf.ucam.org>
 <alpine.LFD.2.00.1010050104450.23209@localhost.localdomain>
 <20101005114047.GA29495@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pci-owner@vger.kernel.org>
In-reply-to: <20101005114047.GA29495@srcf.ucam.org>
Sender: linux-pci-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Linux Power Management List <linux-pm@lists.osdl.org>, linux-pci@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


> > > > we check (and clear) that bit only if the acpi tables
> > > > tell us to do so.
> > > 
> > > Do the tables tell us to do so on this platform?
> > 
> > In this configuration, yes, otherwise acpi_idle
> > would have failed in exactly the same way.
> 
> So why is intel_idle not paying attention to what the platform is 
> requesting?

ACPI's BM_STS mechanism is obsolete, and is fundmentally
incompatible with a tickless OS.  The status bit is a NO-OP
on most modern chip-sets under normal conditions.
However, even when not a NO-OP, it is supposed to
be just an indicator and clearing it should have
no functional effect on the hardware except to
re-arm the hardware that looks for BM_STS.

Clearing BM_STS on the NM10 chipset at boot-time to
make the system boot has nothing to do with
"what the platform is requesting".
It is a workaround for a platform bug that is randomly
masked by how the behaviour of the legacy ACPI OS.

intel_idle it knows nothing about ACPI, and it never will.

thanks,
Len Brown, Intel Open Source Technology Center
