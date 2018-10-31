From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 4/4] ARM: dts: imx6sx: Add DISPLAY power domain support
Date: Wed, 31 Oct 2018 14:11:36 +0800
Message-ID: <20181031061134.GB10386@tiger>
References: <cover.1539020938.git.leonard.crestez@nxp.com>
 <a3265a84052a7c11ae96e61e39adc988ca980d66.1539020938.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a3265a84052a7c11ae96e61e39adc988ca980d66.1539020938.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, Richard Zhu <hongxing.zhu@nxp.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Fabio Estevam <fabio.estevam@nxp.com>, Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 08, 2018 at 06:06:23PM +0000, Leonard Crestez wrote:
> This was implemented in the driver but not actually defined and
> referenced in dts. This makes it always on.
> 
> From reference manual in section "10.4.1.4.1 Power Distribution":
> 
> "Display domain - The DISPLAY domain contains GIS, CSI, PXP, LCDIF,
> PCIe, DCIC, and LDB. It is supplied by internal regulator."
> 
> The current pd_pcie is actually only for PCIE_PHY, the PCIE ip block is
> actually inside the DISPLAY domain. Handle this by adding the pcie node
> in both power domains.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied, thanks.
