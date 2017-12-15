From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V4 3/7] PCI: tegra: Remove PCI_REASSIGN_ALL_BUS flag for
 Tegra PCIe
Date: Fri, 15 Dec 2017 17:36:43 +0000
Message-ID: <20171215173643.GA1050@red-moon>
References: <1512723493-865-1-git-send-email-mmaddireddy@nvidia.com>
 <1512723493-865-4-git-send-email-mmaddireddy@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1512723493-865-4-git-send-email-mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: cyndis-/1wQRMveznE@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, vidyas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kthota-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 08, 2017 at 02:28:09PM +0530, Manikanta Maddireddy wrote:
> Primary, secondary and subordinate default bus numbers are 0 in Tegra and
> it is expecting SW to program these numbers in configration space.
> 
> pci_scan_bridge_extend() function programs these numbers in configuration
> space if secondary & subordinate bus numbers are 0 or PCI_REASSIGN_ALL_BUS
> flag is set. Since secondary & subordinate default bus numbers are 0,
> PCI_REASSIGN_ALL_BUS flag can be removed for Tegra PCIe.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> V3:
> * new patch in V3
> V4:
> * no change in this patch
> 
>  drivers/pci/host/pci-tegra.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index a549c5899e26..0d91f1a3a6b4 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -2604,7 +2604,6 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>  
>  	tegra_pcie_enable_ports(pcie);
>  
> -	pci_add_flags(PCI_REASSIGN_ALL_BUS);

This looks obviously OK to me but I need Thierry's ACK to queue it.

Lorenzo

>  	host->busnr = pcie->busn.start;
>  	host->dev.parent = &pdev->dev;
>  	host->ops = &tegra_pcie_ops;
> -- 
> 2.1.4
> 
