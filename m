From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] intel_idle: PCI quirk to prevent Lenovo Ideapad s10-3 boot
 hang
Date: Thu, 30 Sep 2010 18:14:35 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009301810380.7033@localhost.localdomain>
References: <alpine.LFD.2.00.1009242122390.8641@localhost.localdomain>
 <20100927135735.GA856@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pci-owner@vger.kernel.org>
In-reply-to: <20100927135735.GA856@srcf.ucam.org>
Sender: linux-pci-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Linux Power Management List <linux-pm@lists.osdl.org>, linux-pci@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> > When the Lenovo Ideapad S10-3 is booted with HT enabled,
> > it hits a boot hang in the intel_idle driver.
> > 
> > This occurs when entering ATM-C4 for the first time,
> > unless BM_STS is first cleared.
> > 
> > acpi_idle doesn't see this because it first checks
> > and clears BM_STS, but it would hit the same hang
> > if that check were disabled.
> 
> If there's hardware that expects BM_STS to be cleared, and if we've 
> previously always cleared BM_STS, shouldn't intel_idle be doing the same 
> thing?

No, we don't always clear BM_STS with acpi_idle --
we check (and clear) that bit only if the acpi tables
tell us to do so.

BM_STS is a status bit, not a control bit.
It is a surprise that the NM10 chip-set requires that it be cleared --
apparently once at boot time.

No, I don't want intel_idle to know about this chip-set quirk,
and I don't want to add an IO access to the idle hot path
if we can possibly avoid it.

thanks,
Len Brown, Intel Open Source Technology Center
