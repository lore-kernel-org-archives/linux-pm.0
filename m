From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 2/7] PCI: Export pci_find_host_bridge()
Date: Fri, 8 Dec 2017 08:38:52 -0600
Message-ID: <20171208143852.GA2386@bhelgaas-glaptop.roam.corp.google.com>
References: <1512120007-28088-1-git-send-email-mmaddireddy@nvidia.com>
 <1512120007-28088-3-git-send-email-mmaddireddy@nvidia.com>
 <20171205200402.GF23510@bhelgaas-glaptop.roam.corp.google.com>
 <aebabb88-d894-2b1f-d3e8-63a2acad9665@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <aebabb88-d894-2b1f-d3e8-63a2acad9665-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: cyndis-/1wQRMveznE@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, vidyas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kthota-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 08, 2017 at 02:07:54PM +0530, Manikanta Maddireddy wrote:
> 
> 
> On 06-Dec-17 1:34 AM, Bjorn Helgaas wrote:
> > On Fri, Dec 01, 2017 at 02:50:02PM +0530, Manikanta Maddireddy wrote:
> >> PCI subsystem pass pci_bus pointer to pci_ops callback functions, Tegra
> > 
> > s/PCI subsystem pass/The PCI subsystem passes a/
> > s/, Tegra/.  The Tegra/
> > 
> >> host driver use pci_find_host_bridge() to get pci_host_bridge from pci_bus.
> > 
> > s/use/uses/
> > 
> >> Export pci_find_host_bridge() to allow Tegra PCIe driver to be compiled as
> >> loadable kernel module.
> > 
> > s/allow Tegra/allow the Tegra/
> > s/loadable/a loadable/
> > 
> > But why do you need pci_find_host_bridge() at all?  Most drivers use
> > the pci_bus.sysdata pointer for this purpose, e.g., see db271747a04d
> > ("PCI: mediatek: Use bus->sysdata to get host private data")
> 
> I will send a patch to use bus->sysdata instead of pci_find_host_bridge().

That would be excellent!  Thank you!

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
