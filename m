From: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V4 2/7] PCI: tegra: Use bus->sysdata to store and get host private data
Date: Fri, 8 Dec 2017 14:28:08 +0530
Message-ID: <1512723493-865-3-git-send-email-mmaddireddy@nvidia.com>
References: <1512723493-865-1-git-send-email-mmaddireddy@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1512723493-865-1-git-send-email-mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: cyndis-/1wQRMveznE@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org
Cc: jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, vidyas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kthota-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Tegra host driver is using pci_find_host_bridge() to get private data,
however pci_find_host_bridge() is causing module build failure because
it is not exported. pci_find_host_bridge() can be avoided by using
bus->sysdata to store and get private data.

Signed-off-by: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
V4:
* new patch in V4

 drivers/pci/host/pci-tegra.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 6f2f44539020..a549c5899e26 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -448,8 +448,7 @@ static unsigned long tegra_pcie_conf_offset(unsigned char b, unsigned int devfn,
 
 static int tegra_pcie_add_bus(struct pci_bus *bus)
 {
-	struct pci_host_bridge *host = pci_find_host_bridge(bus);
-	struct tegra_pcie *pcie = pci_host_bridge_priv(host);
+	struct tegra_pcie *pcie = bus->sysdata;
 	struct tegra_pcie_bus *b;
 
 	b = kzalloc(sizeof(*b), GFP_KERNEL);
@@ -466,8 +465,7 @@ static int tegra_pcie_add_bus(struct pci_bus *bus)
 
 static void tegra_pcie_remove_bus(struct pci_bus *child)
 {
-	struct pci_host_bridge *host = pci_find_host_bridge(child);
-	struct tegra_pcie *pcie = pci_host_bridge_priv(host);
+	struct tegra_pcie *pcie = child->sysdata;
 	struct tegra_pcie_bus *bus, *tmp;
 
 	list_for_each_entry_safe(bus, tmp, &pcie->buses, list) {
@@ -483,8 +481,7 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
 					unsigned int devfn,
 					int where)
 {
-	struct pci_host_bridge *host = pci_find_host_bridge(bus);
-	struct tegra_pcie *pcie = pci_host_bridge_priv(host);
+	struct tegra_pcie *pcie = bus->sysdata;
 	void __iomem *addr = NULL;
 	u32 val = 0;
 	u32 offset = 0;
@@ -675,8 +672,7 @@ static int tegra_pcie_request_resources(struct tegra_pcie *pcie)
 
 static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
 {
-	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
-	struct tegra_pcie *pcie = pci_host_bridge_priv(host);
+	struct tegra_pcie *pcie = pdev->bus->sysdata;
 	int irq;
 
 	tegra_cpuidle_pcie_irqs_in_use();
@@ -2570,6 +2566,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pcie = pci_host_bridge_priv(host);
+	host->sysdata = pcie;
 
 	pcie->soc = of_device_get_match_data(dev);
 	INIT_LIST_HEAD(&pcie->buses);
-- 
2.1.4
