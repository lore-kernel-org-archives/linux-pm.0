From: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V2 0/9] Add loadable kernel module and power management support
Date: Sun, 26 Nov 2017 01:02:04 +0530
Message-ID: <1511638333-22951-1-git-send-email-mmaddireddy@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
Cc: vidyas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kthota-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This series of patches add loadable kernel module and power management
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
Both these series will complete the loadable module support for Tegra
PCIe host driver.

PM QoS fix is dropped in V2 from this series because the fix is
incorporated in latest 'commit 0759e80b84e3 ("PM / QoS: Fix device resume
latency framework")'. Update commit message of few patches in V2.

Manikanta Maddireddy (9):
  genirq: Export irq_set_msi_desc()
  of: Export of_pci_range_to_resource()
  ARM: tegra: Export tegra_cpuidle_pcie_irqs_in_use()
  PCI: Export pci_find_host_bridge()
  PCI: Export pci_flags
  PCI: tegra: free resources on probe failure
  PCI: tegra: Add loadable kernel module support
  PCI: tegra: Broadcast PME_turn_Off message before link goes to L2
  PCI: tegra: Add power management support

 arch/arm/mach-tegra/cpuidle.c |   1 +
 drivers/of/address.c          |   1 +
 drivers/pci/host-bridge.c     |   1 +
 drivers/pci/host/Kconfig      |   2 +-
 drivers/pci/host/pci-tegra.c  | 359 +++++++++++++++++++++++++++++++++---------
 drivers/pci/setup-bus.c       |   1 +
 kernel/irq/chip.c             |   1 +
 7 files changed, 292 insertions(+), 74 deletions(-)

-- 
2.1.4
