From: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V6 3/7] PCI: tegra: Remove PCI_REASSIGN_ALL_BUS flag for Tegra PCIe
Date: Thu, 11 Jan 2018 11:38:04 +0530
Message-ID: <1515650888-9459-4-git-send-email-mmaddireddy@nvidia.com>
References: <1515650888-9459-1-git-send-email-mmaddireddy@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1515650888-9459-1-git-send-email-mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, cyndis-/1wQRMveznE@public.gmane.org
Cc: jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, vidyas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kthota-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Primary, secondary and subordinate default bus numbers are 0 in Tegra and
it is expecting SW to program these numbers in configration space.

pci_scan_bridge_extend() function programs these numbers in configuration
space if secondary & subordinate bus numbers are 0 or PCI_REASSIGN_ALL_BUS
flag is set. Since secondary & subordinate default bus numbers are 0,
PCI_REASSIGN_ALL_BUS flag can be removed for Tegra PCIe.

Signed-off-by: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
V3:
* new patch in V3
V4:
* no change in this patch
V5:
* no change in this patch
V6:
* Rebased on lpieralisi/pci/tegra branch

 drivers/pci/host/pci-tegra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 059aa73d5f76..e4b47ebc91fe 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -2293,7 +2293,6 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 
 	tegra_pcie_enable_ports(pcie);
 
-	pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
 	host->busnr = pcie->busn.start;
 	host->dev.parent = &pdev->dev;
 	host->ops = &tegra_pcie_ops;
-- 
2.1.4
