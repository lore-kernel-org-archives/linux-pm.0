From: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V4 0/7] Add loadable kernel module and power management support
Date: Fri, 8 Dec 2017 14:28:06 +0530
Message-ID: <1512723493-865-1-git-send-email-mmaddireddy@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: cyndis-/1wQRMveznE@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org
Cc: jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, vidyas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kthota-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This series of patches adds loadable kernel module and power management
support to Tegra PCIe host controller driver.

These patches are tested on Jetson TK1, TX1 and TX2 platforms, following
are the verification details.
	- Multiple module insert & remove
	- PCIe device functionality after module insert
	- Free clock, resets, regulators, powergate, iomem and interrupt
	resources after module remove
	- PCIe device functionality after resume from RAM

Tegra PCIe host controller driver is using ioremap_page_range() which is
not exported. This is switched with devm_ioremap() in the series
'https://patchwork.ozlabs.org/project/linux-tegra/list/?series=9907'.

V2: PM QoS fix is dropped in V2 from this series because the fix is
incorporated in latest 'commit 0759e80b84e3 ("PM / QoS: Fix device resume
latency framework")'. Update commit message of few patches in V2.

V3: Patches to export irq_set_msi_desc() and tegra_cpuidle_pcie_irqs_in_use()
are dropped based on review comments. These symbols will be addressed in next
series. Took care of few other review comments.

V4: Dropped pci_find_host_bridge() export patch and added new patch to use
bus->sysdata for private data.

Manikanta Maddireddy (7):
  of: Export of_pci_range_to_resource()
  PCI: tegra: Use bus->sysdata to store and get host private data
  PCI: tegra: Remove PCI_REASSIGN_ALL_BUS flag for Tegra PCIe
  PCI: tegra: Free resources on probe failure
  PCI: tegra: Add loadable kernel module support
  PCI: tegra: Broadcast PME_Turn_Off message before link goes to L2
  PCI: tegra: Add power management support

 drivers/of/address.c         |   1 +
 drivers/pci/host/Kconfig     |   2 +-
 drivers/pci/host/pci-tegra.c | 344 ++++++++++++++++++++++++++++++++-----------
 3 files changed, 261 insertions(+), 86 deletions(-)

-- 
2.1.4
