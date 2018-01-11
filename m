From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V5 3/7] PCI: tegra: Remove PCI_REASSIGN_ALL_BUS flag for
 Tegra PCIe
Date: Thu, 11 Jan 2018 12:27:03 -0600
Message-ID: <20180111182703.GL241460@bhelgaas-glaptop.roam.corp.google.com>
References: <1515489577-2197-1-git-send-email-mmaddireddy@nvidia.com>
 <1515489577-2197-4-git-send-email-mmaddireddy@nvidia.com>
 <20180111134925.GA10168@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180111134925.GA10168@red-moon>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cyndis-/1wQRMveznE@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, vidyas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kthota-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 11, 2018 at 01:49:25PM +0000, Lorenzo Pieralisi wrote:
> Hi Bjorn,
> 
> On Tue, Jan 09, 2018 at 02:49:33PM +0530, Manikanta Maddireddy wrote:
> > Primary, secondary and subordinate default bus numbers are 0 in Tegra and
> > it is expecting SW to program these numbers in configration space.
> > 
> > pci_scan_bridge_extend() function programs these numbers in configuration
> > space if secondary & subordinate bus numbers are 0 or PCI_REASSIGN_ALL_BUS
> > flag is set. Since secondary & subordinate default bus numbers are 0,
> > PCI_REASSIGN_ALL_BUS flag can be removed for Tegra PCIe.
> > 
> > Signed-off-by: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
> 
> Would you mind applying this patch (NB: it is the patch in the v5
> version - this patch - not the one in v6 that is a rebased version):
> 
> https://patchwork.ozlabs.org/patch/857318/
> 
> to your pci/resource branch please (there is a dependency) ?
> 
> This would allow me to apply the rest of the patches in the series
> that I consider mergeable independently of your tree branches, to
> simplify the dependency.

Applied to pci/resource for v4.16, thanks!

I'd love to remove more of these.  Every one helps.

> > ---
> > V3:
> > * new patch in V3
> > V4:
> > * no change in this patch
> > V5:
> > * no change in this patch
> > 
> >  drivers/pci/host/pci-tegra.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> > index d790a26ad87e..e4b47ebc91fe 100644
> > --- a/drivers/pci/host/pci-tegra.c
> > +++ b/drivers/pci/host/pci-tegra.c
> > @@ -2293,7 +2293,6 @@ static int tegra_pcie_probe(struct platform_device *pdev)
> >  
> >  	tegra_pcie_enable_ports(pcie);
> >  
> > -	pci_add_flags(PCI_REASSIGN_ALL_BUS);
> >  	host->busnr = pcie->busn.start;
> >  	host->dev.parent = &pdev->dev;
> >  	host->ops = &tegra_pcie_ops;
> > -- 
> > 2.1.4
> > 
