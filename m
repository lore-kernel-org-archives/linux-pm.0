From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH 0/3] ARM: dts: imx6sx: Add DISPLAY power domain support
Date: Mon,  1 Oct 2018 23:56:15 +0300
Message-ID: <cover.1538426534.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
List-Id: linux-pm@vger.kernel.org

Now that mxsfb has functional runtime_pm support we can enable power
gating for the DISPLAY power domain on imx6sx.

Since pci-imx doesn't support runtime power gating this is still
always-on unless PCI is disabled/unused. But it's reasonable for an imx
board to not have PCI.

The current pd_pcie is actually only for PCIE_PHY, the PCIE ip block is
actually inside the DISPLAY domain. This is handled by adding the pcie
node in both power domains, using multi-pd support.

Series is against linux-next. The last patch needs runtime PM in all
drivers or it will cause hangs. This means Shawn should hold back on it
until the PCI and mxsfb dependencies get merged (both might take a long
time). So you can just review that patch and I will resend it later,
perhaps in another cycle.

Link to mxsfb thread: https://lkml.org/lkml/2018/9/26/1185

Leonard Crestez (3):
  soc: imx: gpc: Increase GPC_CLK_MAX to 7
  PCI: imx: Add multi-pd support
  ARM: dts: imx6sx: Add DISPLAY power domain support

 arch/arm/boot/dts/imx6sx.dtsi         | 19 ++++++++++-
 drivers/pci/controller/dwc/pci-imx6.c | 48 +++++++++++++++++++++++++++
 drivers/soc/imx/gpc.c                 |  2 +-
 3 files changed, 67 insertions(+), 2 deletions(-)

-- 
2.17.1
