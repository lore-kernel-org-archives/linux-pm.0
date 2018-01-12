From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V3 0/7] Add loadable kernel module and power management
 support
Date: Fri, 12 Jan 2018 18:10:14 +0000
Message-ID: <20180112181014.GE26438@red-moon>
References: <1512120007-28088-1-git-send-email-mmaddireddy@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1512120007-28088-1-git-send-email-mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: cyndis-/1wQRMveznE@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, vidyas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kthota-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 01, 2017 at 02:50:00PM +0530, Manikanta Maddireddy wrote:
> This series of patches add loadable kernel module and power management
> support to Tegra PCIe host controller driver.
> 
> These patches are tested on Jetson TK1, TX1 and TX2 platforms, following
> are the verification details.
> 	- Multiple module insert & remove
> 	- PCIe device functionality after module insert
> 	- Free clock, resets, regulators, powergate, iomem and interrupt
> 	resources after module remove
> 	- PCIe device functionality after resume from RAM
> 
> Tegra PCIe host controller driver is using ioremap_page_range() which is
> not exported. This is switched with devm_ioremap() in the series
> 'https://patchwork.ozlabs.org/project/linux-tegra/list/?series=9907'.
> 
> V2: PM QoS fix is dropped in V2 from this series because the fix is
> incorporated in latest 'commit 0759e80b84e3 ("PM / QoS: Fix device resume
> latency framework")'. Update commit message of few patches in V2.
> 
> V3: Patches to export irq_set_msi_desc() and tegra_cpuidle_pcie_irqs_in_use()
> are dropped based on review comments. These symbols will be addressed in
> next series. Remove PCI_REASSIGN_ALL_BUS flag for Tegra PCIe and took care
> of few other review comments.
> 
> Manikanta Maddireddy (7):
>   of: Export of_pci_range_to_resource()
>   PCI: Export pci_find_host_bridge()
>   PCI: tegra: Remove PCI_REASSIGN_ALL_BUS flag for Tegra PCIe
>   PCI: tegra: Free resources on probe failure
>   PCI: tegra: Add loadable kernel module support
>   PCI: tegra: Broadcast PME_Turn_Off message before link goes to L2
>   PCI: tegra: Add power management support
> 
>  drivers/of/address.c         |   1 +
>  drivers/pci/host-bridge.c    |   1 +
>  drivers/pci/host/Kconfig     |   2 +-
>  drivers/pci/host/pci-tegra.c | 331 +++++++++++++++++++++++++++++++++----------

Applied patches 1 and 2 to pci/tegra for v4.16.

Bjorn picked up patch 3, the rest of the series needs
Thierry's ACK.

Thanks !
Lorenzo
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
