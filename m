From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 2/4] PCI: Move PCIe ports to D3 during suspend
Date: Wed, 13 Apr 2016 11:34:54 +0300
Message-ID: <20160413083454.GJ1714@lahna.fi.intel.com>
References: <1460111790-92836-1-git-send-email-mika.westerberg@linux.intel.com>
 <1460111790-92836-3-git-send-email-mika.westerberg@linux.intel.com>
 <20160412174542.GA13637@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160412174542.GA13637@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Qipeng Zha <qipeng.zha@intel.com>, Qi Zheng <qi.zheng@intel.com>, Dave Airlie <airlied@gmail.com>, Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 12, 2016 at 07:45:42PM +0200, Lukas Wunner wrote:
> Hi Mika,
> 
> On Fri, Apr 08, 2016 at 01:36:28PM +0100, Mika Westerberg wrote:
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -744,6 +744,19 @@ static int pci_pm_suspend(struct device *dev)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Check if given device can go to low power state. Currently we allow
> > + * normal PCI devices and PCI bridges if their bridge_d3 is set.
> > + */
> > +static bool pci_can_suspend(struct pci_dev *pdev)
> > +{
> > +	if (!pci_has_subordinate(pdev))
> > +		return true;
> > +	else if (pdev->bridge_d3)
> > +		return true;
> > +	return false;
> > +}
> > +
> >  static int pci_pm_suspend_noirq(struct device *dev)
> >  {
> >  	struct pci_dev *pci_dev = to_pci_dev(dev);
> > @@ -777,7 +790,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
> >  
> >  	if (!pci_dev->state_saved) {
> >  		pci_save_state(pci_dev);
> > -		if (!pci_has_subordinate(pci_dev))
> > +		if (pci_can_suspend(pci_dev))
> >  			pci_prepare_to_sleep(pci_dev);
> >  	}
> 
> pci_can_suspend() is only used by this single function. It may be
> worth to consider folding it into pci_pm_suspend_noirq(), i.e. simply
> 
> 		if (!pci_has_subordinate(pci_dev) || pdev->bridge_d3)
> 
> together with the "Currently we allow..." comment above.

Okay.
