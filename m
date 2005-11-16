From: Adam Belay <abelay@novell.com>
Subject: Re: [RFC][PATCH 1/6] PCI PM: create pm.c and relocate PM functions
Date: Wed, 16 Nov 2005 02:17:39 -0500
Message-ID: <1132125459.3656.4.camel@localhost.localdomain>
References: <1132111873.9809.50.camel@localhost.localdomain>
	 <20051116061813.GA31375@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751205AbVKPHJA@vger.kernel.org>
In-Reply-To: <20051116061813.GA31375@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2005-11-15 at 22:18 -0800, Greg KH wrote:
> On Tue, Nov 15, 2005 at 10:31:13PM -0500, Adam Belay wrote:
> > pci_save_state(), pci_restore_state(), pci_enable_wake(),
> > pci_choose_state(), and pci_set_power_state() are moved to
> > drivers/pci/pm.c.
> > 
> > This patch makes several code cleanups but no functional changes.
> 
> Looks good but:
> 
> > --- a/drivers/pci/pm.c	1969-12-31 19:00:00.000000000 -0500
> > +++ b/drivers/pci/pm.c	2005-10-24 06:23:15.000000000 -0400
> > @@ -0,0 +1,296 @@
> > +/*
> > + * pm.c - PCI Device Power Management
> > + */ 
> 
> You should say where this came from, and the copyrights for that file.
> 

To be honest I'm not entirely sure where they came from.  As with most
of the PCI files, I'm guessing dozens of patches have touched them.  In
any case, I'll include the original header from pci.c.

Thanks,
Adam
