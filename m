From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH 2/3] PCI: imx: Add multi-pd support
Date: Mon,  1 Oct 2018 23:56:17 +0300
Message-ID: <5832128f3b1822839a0f0bbd1cf8313cf586f15f.1538426534.git.leonard.crestez@nxp.com>
References: <cover.1538426534.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1538426534.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
List-Id: linux-pm@vger.kernel.org

On some chips the PCIE and PCIE_PHY blocks are in separate power domains
which can be power-gated independently. The driver needs to handle this
by keeping both domain active.

This is intended for imx6sx where PCIE is in DISPMIX and PCIE_PHY in
it's own domain. Defining the DISPMIX domain requires a way for pcie to
keep it active or it will break when displays are off.

The power-domains on imx6sx are meant to look like this:
	power-domains = <&pd_disp>, <&pd_pci>;
	power-domain-names = "pcie", "pcie_phy";

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

---
 drivers/pci/controller/dwc/pci-imx6.c | 48 +++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

Previously sent as RFC: https://lkml.org/lkml/2018/7/24/849

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index d13dae50dc99..6ba16fd1373c 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -25,10 +25,12 @@
 #include <linux/resource.h>
 #include <linux/signal.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/reset.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 
 #include "pcie-designware.h"
 
 #define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)
 
@@ -56,10 +58,15 @@ struct imx6_pcie {
 	u32			tx_deemph_gen2_6db;
 	u32			tx_swing_full;
 	u32			tx_swing_low;
 	int			link_gen;
 	struct regulator	*vpcie;
+
+	/* power domain for pcie itself (dispmix) */
+	struct device		*pd_pcie;
+	/* power domain for pcie phy */
+	struct device		*pd_pcie_phy;
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
 #define PHY_PLL_LOCK_WAIT_MAX_RETRIES	2000
 #define PHY_PLL_LOCK_WAIT_USLEEP_MIN	50
@@ -289,10 +296,47 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 	}
 
 	return 1;
 }
 
+static int imx6_pcie_attach_pd(struct device *dev)
+{
+	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+	struct device_link *link;
+
+	/* Do nothing when in a single power domain */
+	if (dev->pm_domain)
+		return 0;
+
+	imx6_pcie->pd_pcie = dev_pm_domain_attach_by_name(dev, "pcie");
+	if (IS_ERR(imx6_pcie->pd_pcie))
+		return PTR_ERR(imx6_pcie->pd_pcie);
+	link = device_link_add(dev, imx6_pcie->pd_pcie,
+			DL_FLAG_STATELESS |
+			DL_FLAG_PM_RUNTIME |
+			DL_FLAG_RPM_ACTIVE);
+	if (IS_ERR(link)) {
+		dev_err(dev, "Failed to add device_link to pcie pd: %ld\n", PTR_ERR(link));
+		return PTR_ERR(link);
+	}
+
+	imx6_pcie->pd_pcie_phy = dev_pm_domain_attach_by_name(dev, "pcie_phy");
+	if (IS_ERR(imx6_pcie->pd_pcie_phy))
+		return PTR_ERR(imx6_pcie->pd_pcie_phy);
+
+	device_link_add(dev, imx6_pcie->pd_pcie_phy,
+			DL_FLAG_STATELESS |
+			DL_FLAG_PM_RUNTIME |
+			DL_FLAG_RPM_ACTIVE);
+	if (IS_ERR(link)) {
+		dev_err(dev, "Failed to add device_link to pcie_phy pd: %ld\n", PTR_ERR(link));
+		return PTR_ERR(link);
+	}
+
+	return 0;
+}
+
 static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct device *dev = imx6_pcie->pci->dev;
 
 	switch (imx6_pcie->variant) {
@@ -959,10 +1003,14 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		imx6_pcie->vpcie = NULL;
 	}
 
 	platform_set_drvdata(pdev, imx6_pcie);
 
+	ret = imx6_pcie_attach_pd(dev);
+	if (ret)
+		return ret;
+
 	ret = imx6_add_pcie_port(imx6_pcie, pdev);
 	if (ret < 0)
 		return ret;
 
 	return 0;
-- 
2.17.1
