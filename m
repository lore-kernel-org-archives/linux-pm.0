From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 08/13] PCI/portdrv: Simplify PCIe feature permission
 checking
Date: Tue, 7 May 2019 07:49:48 -0500
Message-ID: <20190507124948.GC156478@google.com>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152062203293.77693.8159909590216160503.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <0c7ed46e4a8cf4cea544a7e62c32428b31cdea4e.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0c7ed46e4a8cf4cea544a7e62c32428b31cdea4e.camel@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-pci@vger.kernel.org, "Chocron, Jonathan" <jonnyc@amazon.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Keith Busch <keith.busch@intel.com>, Sinan Kaya <okaya@codeaurora.org>, Lukas Wunner <lukas@wunner.de>, Frederick Lawler <fred@fredlawl.com>
List-Id: linux-pm@vger.kernel.org

On Tue, May 07, 2019 at 01:00:03PM +0100, David Woodhouse wrote:
> On Fri, 2018-03-09 at 13:00 -0600, Bjorn Helgaas wrote:
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -540,6 +540,16 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
> >         INIT_LIST_HEAD(&bridge->windows);
> >         bridge->dev.release = pci_release_host_bridge_dev;
> >  
> > +       /*
> > +        * We assume we can manage these PCIe features.  Some systems may
> > +        * reserve these for use by the platform itself, e.g., an ACPI BIOS
> > +        * may implement its own AER handling and use _OSC to prevent the
> > +        * OS from interfering.
> > +        */
> > +       bridge->use_aer = 1;
> > +       bridge->use_hotplug = 1;
> > +       bridge->use_pme = 1;
> > +
> >         return bridge;
> >  }
> >  EXPORT_SYMBOL(pci_alloc_host_bridge);
> 
> Is there a good reason why you've done this only for
> pci_alloc_host_bridge() and not also for devm_pci_alloc_host_bridge()? 

No good reason; I just screwed up.  Should be fixed in v5.2 (and marked for
stable):

https://lore.kernel.org/linux-pci/20190318160718.10925-1-jean-philippe.brucker@arm.com

Sorry about that.

Bjorn
