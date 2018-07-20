From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v2 0/3] PCI: imx: Initial imx7d pm support
Date: Fri, 20 Jul 2018 15:47:41 +0300
Message-ID: <cover.1532090446.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, Richard Zhu <hongxing.zhu@nxp.com>, Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Joao Pinto <Joao.Pinto@synopsys.com>, Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, kernel@pengutronix.de, linux-imx@nxp.com
List-Id: linux-pm@vger.kernel.org

Changes since v1:
 * Indentation fixes
 * Use imx6_pcie_establish_link instead of imx6_pcie_wait_for_link
 * Move imx6_pcie_ltssm_disable to suspend
 * Make imx6_pcie_clk_disable a separate function
 * Revert PCI irq mapping (also useful separately)

Link to v1: https://lkml.org/lkml/2018/5/29/1042

Leonard Crestez (3):
  Revert "ARM: dts: imx7d: Invert legacy PCI irq mapping"
  reset: imx7: Fix always writing bits as 0
  PCI: imx: Initial imx7d pm support

 arch/arm/boot/dts/imx7d.dtsi          |  8 +--
 drivers/pci/controller/dwc/pci-imx6.c | 95 +++++++++++++++++++++++++--
 drivers/reset/reset-imx7.c            |  2 +-
 3 files changed, 95 insertions(+), 10 deletions(-)

-- 
2.17.1
