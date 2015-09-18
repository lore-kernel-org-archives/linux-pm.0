From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI / PM: Update runtime PM documentation for PCI devices
Date: Sat, 19 Sep 2015 00:21:04 +0200
Message-ID: <5988070.VHCyqfiYUc@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1509181028130.1681-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1509181028130.1681-100000@iolanthe.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, September 18, 2015 10:31:49 AM Alan Stern wrote:
> On Fri, 18 Sep 2015, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Section 3.2 "Device Runtime Power Management" of pci.txt has become
> > outdated, so update it to correctly reflect the current code flow.
> > 
> > Also update the comment in local_pci_probe() to document the fact
> > that pm_runtime_put_noidle() is not the only runtime PM helper
> > function that can be used to decrement the device's runtime PM
> > usage counter in .probe().
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  Documentation/power/pci.txt |   51 ++++++++++++++++++++++++++++++++------------
> >  drivers/pci/pci-driver.c    |    7 +++---
> >  2 files changed, 42 insertions(+), 16 deletions(-)
> > 
> > Index: linux-pm/Documentation/power/pci.txt
> > ===================================================================
> > --- linux-pm.orig/Documentation/power/pci.txt
> > +++ linux-pm/Documentation/power/pci.txt
> > @@ -979,20 +979,45 @@ every time right after the runtime_resum
> 
> ...
> 
> > +It is important to remember that the driver's runtime_suspend() callback
> > +may be executed right after the usage counter has been decremented, because
> > +user space may already have cuased the pm_runtime_allow() helper function
> 
> s/cuased/caused/.

Fixed.

> Otherwise,
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Thanks a lot!

Rafael
