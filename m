From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] intel_idle: PCI quirk to prevent Lenovo Ideapad s10-3 boot
 hang
Date: Tue, 05 Oct 2010 01:06:15 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010050104450.23209@localhost.localdomain>
References: <alpine.LFD.2.00.1009242122390.8641@localhost.localdomain>
 <20100927135735.GA856@srcf.ucam.org>
 <alpine.LFD.2.00.1009301810380.7033@localhost.localdomain>
 <20100930222946.GB23084@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pci-owner@vger.kernel.org>
In-reply-to: <20100930222946.GB23084@srcf.ucam.org>
Sender: linux-pci-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Linux Power Management List <linux-pm@lists.osdl.org>, linux-pci@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> > we check (and clear) that bit only if the acpi tables
> > tell us to do so.
> 
> Do the tables tell us to do so on this platform?

In this configuration, yes, otherwise acpi_idle
would have failed in exactly the same way.

-Len Brown, Intel Open Source Technology Center
