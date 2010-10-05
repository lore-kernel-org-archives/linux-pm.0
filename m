From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] intel_idle: PCI quirk to prevent Lenovo Ideapad s10-3
	boot hang
Date: Tue, 5 Oct 2010 12:40:47 +0100
Message-ID: <20101005114047.GA29495@srcf.ucam.org>
References: <alpine.LFD.2.00.1009242122390.8641@localhost.localdomain> <20100927135735.GA856@srcf.ucam.org> <alpine.LFD.2.00.1009301810380.7033@localhost.localdomain> <20100930222946.GB23084@srcf.ucam.org> <alpine.LFD.2.00.1010050104450.23209@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1010050104450.23209@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux Power Management List <linux-pm@lists.osdl.org>, linux-pci@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 05, 2010 at 01:06:15AM -0400, Len Brown wrote:
> > > we check (and clear) that bit only if the acpi tables
> > > tell us to do so.
> > 
> > Do the tables tell us to do so on this platform?
> 
> In this configuration, yes, otherwise acpi_idle
> would have failed in exactly the same way.

So why is intel_idle not paying attention to what the platform is 
requesting?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
