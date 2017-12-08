From: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V4 6/7] PCI: tegra: Broadcast PME_Turn_Off message before link goes to L2
Date: Fri, 8 Dec 2017 14:28:12 +0530
Message-ID: <1512723493-865-7-git-send-email-mmaddireddy@nvidia.com>
References: <1512723493-865-1-git-send-email-mmaddireddy@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1512723493-865-1-git-send-email-mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: cyndis-/1wQRMveznE@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org
Cc: jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, vidyas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kthota-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Per PCIe r3.0, sec 5.3.3.2.1, PCIe root port shoould broadcast PME_Turn_Off
message before PCIe link goes to L2. PME_Turn_Off broadcast mechanism is
implemented in AFI module. Each Tegra PCIe root port has its own
PME_Turn_Off and PME_TO_Ack bitmap in AFI_PME register, program this
register to broadcast PME_Turn_Off message.

Signed-off-by: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
V2:
* no change in this patch
V3:
* add PME bitmap in soc data instead of using compatible string
* replace while loop with readl_poll_timeout() for polling
* commit log correction
V4:
* no change in this patch

 drivers/pci/host/pci-tegra.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 06d62122b269..1972081322c4 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -31,6 +31,7 @@
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
+#include <linux/iopoll.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
@@ -154,6 +155,8 @@
 #define  AFI_INTR_EN_FPCI_TIMEOUT	(1 << 7)
 #define  AFI_INTR_EN_PRSNT_SENSE	(1 << 8)
 
+#define AFI_PCIE_PME		0xf0
+
 #define AFI_PCIE_CONFIG					0x0f8
 #define  AFI_PCIE_CONFIG_PCIE_DISABLE(x)		(1 << ((x) + 1))
 #define  AFI_PCIE_CONFIG_PCIE_DISABLE_ALL		0xe
@@ -288,6 +291,7 @@
 #define PADS_REFCLK_CFG_DRVI_SHIFT		12 /* 15:12 */
 
 #define LINK_RETRAIN_TIMEOUT 100000
+#define PME_ACK_TIMEOUT 10000
 
 struct tegra_msi {
 	struct msi_controller chip;
@@ -315,6 +319,8 @@ struct tegra_pcie_soc {
 	u32 rp_ectl_4_r2;
 	u32 rp_ectl_5_r2;
 	u32 rp_ectl_6_r2;
+	u8 pme_turnoff_bit[3];
+	u8 pme_ack_bit[3];
 	bool has_pex_clkreq_en;
 	bool has_pex_bias_ctrl;
 	bool has_intr_prsnt_sense;
@@ -1461,6 +1467,31 @@ static int tegra_pcie_put_resources(struct tegra_pcie *pcie)
 	return 0;
 }
 
+static void tegra_pcie_pme_turnoff(struct tegra_pcie_port *port)
+{
+	struct tegra_pcie *pcie = port->pcie;
+	const struct tegra_pcie_soc *soc = pcie->soc;
+	int err;
+	u32 val;
+
+	val = afi_readl(pcie, AFI_PCIE_PME);
+	val |= (0x1 << soc->pme_turnoff_bit[port->index]);
+	afi_writel(pcie, val, AFI_PCIE_PME);
+
+	err = readl_poll_timeout(pcie->afi + AFI_PCIE_PME, val,
+				 val & (0x1 << soc->pme_ack_bit[port->index]),
+				 1, PME_ACK_TIMEOUT);
+	if (err)
+		dev_err(pcie->dev, "PME Ack is not received on port: %d\n",
+			port->index);
+
+	usleep_range(10000, 11000);
+
+	val = afi_readl(pcie, AFI_PCIE_PME);
+	val &= ~(0x1 << soc->pme_turnoff_bit[port->index]);
+	afi_writel(pcie, val, AFI_PCIE_PME);
+}
+
 static int tegra_msi_alloc(struct tegra_msi *chip)
 {
 	int msi;
@@ -2389,6 +2420,8 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.pads_pll_ctl = PADS_PLL_CTL_TEGRA20,
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_DIV10,
 	.pads_refclk_cfg0 = 0xfa5cfa5c,
+	.pme_turnoff_bit = {0, 8},
+	.pme_ack_bit = {5, 10},
 	.has_pex_clkreq_en = false,
 	.has_pex_bias_ctrl = false,
 	.has_intr_prsnt_sense = false,
@@ -2411,6 +2444,8 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
 	.pads_refclk_cfg0 = 0xfa5cfa5c,
 	.pads_refclk_cfg1 = 0xfa5cfa5c,
+	.pme_turnoff_bit = {0, 8, 16},
+	.pme_ack_bit = {5, 10, 18},
 	.has_pex_clkreq_en = true,
 	.has_pex_bias_ctrl = true,
 	.has_intr_prsnt_sense = true,
@@ -2432,6 +2467,8 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
 	.pads_refclk_cfg0 = 0x44ac44ac,
+	.pme_turnoff_bit = {0, 8},
+	.pme_ack_bit = {5, 10},
 	.has_pex_clkreq_en = true,
 	.has_pex_bias_ctrl = true,
 	.has_intr_prsnt_sense = true,
@@ -2453,6 +2490,8 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
 	.pads_refclk_cfg0 = 0x90b890b8,
+	.pme_turnoff_bit = {0, 8},
+	.pme_ack_bit = {5, 10},
 	.rp_ectl_2_r1 = 0x0000000f,
 	.rp_ectl_4_r1 = 0x00000067,
 	.rp_ectl_5_r1 = 0x55010000,
@@ -2483,6 +2522,8 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
 	.pads_refclk_cfg0 = 0x80b880b8,
 	.pads_refclk_cfg1 = 0x000480b8,
+	.pme_turnoff_bit = {0, 8, 12},
+	.pme_ack_bit = {5, 10, 14},
 	.has_pex_clkreq_en = true,
 	.has_pex_bias_ctrl = true,
 	.has_intr_prsnt_sense = true,
@@ -2722,6 +2763,7 @@ static int tegra_pcie_remove(struct platform_device *pdev)
 {
 	struct tegra_pcie *pcie = platform_get_drvdata(pdev);
 	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
+	struct tegra_pcie_port *port, *tmp;
 
 	if (IS_ENABLED(CONFIG_DEBUG_FS))
 		tegra_pcie_debugfs_exit(pcie);
@@ -2729,6 +2771,8 @@ static int tegra_pcie_remove(struct platform_device *pdev)
 	pci_remove_root_bus(host->bus);
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		tegra_pcie_disable_msi(pcie);
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+		tegra_pcie_pme_turnoff(port);
 	tegra_pcie_disable_ports(pcie);
 	tegra_pcie_free_resources(pcie);
 	tegra_pcie_disable_controller(pcie);
-- 
2.1.4
