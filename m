From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 4/5]PCIe native PME support
Date: Thu, 20 Aug 2009 11:10:56 +0800
Message-ID: <20090820031056.GB26357@sli10-desk.sh.intel.com>
References: <1250666659.23178.119.camel@sli10-desk.sh.intel.com> <20090819115811.GD12216@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090819115811.GD12216@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 19, 2009 at 07:58:11PM +0800, Matthew Garrett wrote:
> On Wed, Aug 19, 2009 at 03:24:19PM +0800, Shaohua Li wrote:
> 
> > +static inline void npme_enable_pme(struct pci_dev *pdev, bool enable)
> > +{
> > +	int pos;
> > +	u16 rtctl;
> > +
> > +	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
> > +
> > +	pci_read_config_word(pdev, pos + PCI_EXP_RTCTL, &rtctl);
> > +	if (!enable)
> > +		rtctl &= ~PCI_EXP_RTCTL_PMEIE;
> > +	else
> > +		rtctl |= PCI_EXP_RTCTL_PMEIE;
> > +	pci_write_config_word(pdev, pos + PCI_EXP_RTCTL, rtctl);
> > +}
> 
> This seems to duplicate the existing pci_pme_active() function?
No, these registers are completely different. pci_pme_active is to handle
the PM capability regiser. This routine is to handle the PCI express capability.
 
> > +static inline void npme_clear_pme(struct pci_dev *pdev)
> > +{
> > +	int pos;
> > +	u32 rtsta;
> > +
> > +	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
> > +
> > +	pci_read_config_dword(pdev, pos + PCI_EXP_RTSTA, &rtsta);
> > +	rtsta |= PCI_EXP_RTSTA_PME;
> > +	pci_write_config_dword(pdev, pos + PCI_EXP_RTSTA, rtsta);
> > +}
> 
> Ditto.
Ditto.

> > +static bool npme_pme_target(struct pci_dev *target)
> > +{
> > +	bool ret = false;
> > +	if (target->dev.bus->pm && target->dev.bus->pm->wakeup_event)
> > +		ret = target->dev.bus->pm->wakeup_event(&target->dev);
> > +	return ret;
> > +}
> 
> Is there any situation in which we wouldn't want to just perform a 
> runtime resume of the device here?
The devices pcie-to-pci bridge can send wakeup event, but the event might use
root port or the bridge pci id, so can't directly send the event to the device.

Surely we can move the logic in my patch 3 here if we don't want to duplicate
code, and then we can directly perform a runtime resume for target devices.

Thanks,
Shaohua

