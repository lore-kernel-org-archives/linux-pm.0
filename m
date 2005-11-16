From: Adam Belay <abelay@novell.com>
Subject: Re: [RFC][PATCH 2/6] PCI PM: capability probing and setup
Date: Wed, 16 Nov 2005 02:21:01 -0500
Message-ID: <1132125661.3656.7.camel@localhost.localdomain>
References: <1132111878.9809.52.camel@localhost.localdomain>
	 <20051116062154.GB31375@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751302AbVKPHMO@vger.kernel.org>
In-Reply-To: <20051116062154.GB31375@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2005-11-15 at 22:21 -0800, Greg KH wrote:
> On Tue, Nov 15, 2005 at 10:31:17PM -0500, Adam Belay wrote:
> > +int pci_setup_device_pm(struct pci_dev *dev)
> 
> Care to give kernel doc for this new function?

Absolutely.  I was planing to do this but must have forgotten.

> > +	unsigned char	state_mask;	/* a mask of supported power states */
> > +	unsigned char	pme_mask;	/* a mask of power states that allow #PME */ 
> 
> Trailing space, use quilt it strips this :)

Sorry about that :)

> 
> > +	struct pci_dev_pm *pm;		/* power management information */
> 
> Why make this a pointer and not just part of this structure?  Don't all
> pci devices need this?

Actually, not every PCI device supports the PCI PM spec.  There are many
devices, even in modern systems, that can only be in D0.  I was thinking
we could save some memory and allocate this structure when PCI PM is
detected.  Would that be ok?

Thanks,
Adam
