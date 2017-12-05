From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 2/7] PCI: Export pci_find_host_bridge()
Date: Tue, 5 Dec 2017 14:04:02 -0600
Message-ID: <20171205200402.GF23510@bhelgaas-glaptop.roam.corp.google.com>
References: <1512120007-28088-1-git-send-email-mmaddireddy@nvidia.com>
 <1512120007-28088-3-git-send-email-mmaddireddy@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1512120007-28088-3-git-send-email-mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: cyndis-/1wQRMveznE@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, vidyas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kthota-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 01, 2017 at 02:50:02PM +0530, Manikanta Maddireddy wrote:
> PCI subsystem pass pci_bus pointer to pci_ops callback functions, Tegra

s/PCI subsystem pass/The PCI subsystem passes a/
s/, Tegra/.  The Tegra/

> host driver use pci_find_host_bridge() to get pci_host_bridge from pci_bus.

s/use/uses/

> Export pci_find_host_bridge() to allow Tegra PCIe driver to be compiled as
> loadable kernel module.

s/allow Tegra/allow the Tegra/
s/loadable/a loadable/

But why do you need pci_find_host_bridge() at all?  Most drivers use
the pci_bus.sysdata pointer for this purpose, e.g., see db271747a04d
("PCI: mediatek: Use bus->sysdata to get host private data")

> Signed-off-by: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> V2:
> * commit message update
> V3:
> * EXPORT_SYMBOL is changed to EXPORT_SYMBOL_GPL
> 
>  drivers/pci/host-bridge.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
> index add66236215c..b8c0fcde9bd7 100644
> --- a/drivers/pci/host-bridge.c
> +++ b/drivers/pci/host-bridge.c
> @@ -22,6 +22,7 @@ struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus)
>  
>  	return to_pci_host_bridge(root_bus->bridge);
>  }
> +EXPORT_SYMBOL_GPL(pci_find_host_bridge);
>  
>  struct device *pci_get_host_bridge_device(struct pci_dev *dev)
>  {
> -- 
> 2.1.4
> 
