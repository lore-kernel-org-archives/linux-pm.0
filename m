From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 3/5] pci wakeup handler
Date: Tue, 9 Sep 2008 13:09:00 +0200
Message-ID: <200809091309.01433.rjw__41788.3936469027$1220958575$gmane$org@sisk.pl>
References: <20080908091926.785882370@sli10-desk.sh.intel.com>
	<20080908092305.438330804@sli10-desk.sh.intel.com>
	<200809081956.42663.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200809081956.42663.david-b@pacbell.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, 9 of September 2008, David Brownell wrote:
> On Monday 08 September 2008, shaohua.li@intel.com wrote:
> > --- linux.orig/drivers/pci/pci-driver.c	2008-09-08 13:55:56.000000000 +0800
> > +++ linux/drivers/pci/pci-driver.c	2008-09-08 14:24:42.000000000 +0800
> > @@ -472,12 +472,57 @@ static int pci_pm_resume_noirq(struct de
> >  	return error;
> >  }
> >  
> > +/*
> > + * Called when dev is suspected to invoke a wakeup event, return 0 if yes
> > + * */
> > +static int pci_pm_wakeup_event(struct device *dev)
> 
> If wakeup notifications were bus-specific this would
> take "struct pci_dev *pdev" ... and we're missing a
> key part of this stuff, namely the code to sort out
> which devices get this call.
> 
> I think you're assuming ACPI can just use its event
> notification scheme to map from GPE through AML to
> the particular device.  That's partly OK; except, see
> below about bridge nodes.
> 
> 
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	int pme_pos = pci_find_capability(pdev, PCI_CAP_ID_PM);
> 
> Yes, use the cached value here (like Rafael said)...
> 
> 
> > +	struct pci_driver *drv = pdev->driver;
> > +	u16 reg16;
> > +	int spurious = 0;
> > +	int ret = -ENODEV;
> > +
> > +	if (pme_pos == 0) {
> > +		/*
> > +		 * Some USB devices haven't PME, but have specific registers to
> > +		 * control wakeup
> 
> The PCI PM spec has words some like:  "Some PCI devices support legacy
> wakeup mechanisms instead of supporting PCI PM capabilities."  Today
> the best example of that is Intel's UHCI controllers, but it's not
> restricted to USB at all.
> 
> I suspect that this particular path won't often need to handle anything
> other than those Intel controllers, however.  And so I hope that they
> never share GPEs.  ;)
> 
> Another rather important case is bridges.  I observe that with ACPI
> the way PME# is handled for add-in cards _seems_ to be that the bridge
> for that PCI bus segment gets a GPE (presumably matching the PME#
> signal for that bus segment, and maybe for its subsidiaries).  That
> suggests the bridge will need to scan its children to find out which
> one(s) issued PME#.  You didn't include such code here, where that
> notification will be received...

AFAICS, the 'original' PCI PME# (as opposed to the PCI Express native PME)
signal is supposed to be routed _around_ bridges and (presumably) the entire
PME# network would share one GPE in that case.  Then, we'd actually have to
check all of the PCI devices to see which of them caused the event to happen.

Thanks,
Rafael
