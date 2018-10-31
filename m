From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 4/4] ARM: dts: imx6sx: Add DISPLAY power domain support
Date: Wed, 31 Oct 2018 15:05:59 +0000
Message-ID: <20181031150559.GA20437@e107981-ln.cambridge.arm.com>
References: <cover.1539020938.git.leonard.crestez@nxp.com>
 <a3265a84052a7c11ae96e61e39adc988ca980d66.1539020938.git.leonard.crestez@nxp.com>
 <20181031061134.GB10386@tiger>
 <AM0PR04MB4290F31234D75AC7029F066FEECD0@AM0PR04MB4290.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4290F31234D75AC7029F066FEECD0@AM0PR04MB4290.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Richard Zhu <hongxing.zhu@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 31, 2018 at 12:17:50PM +0000, Leonard Crestez wrote:
> On 10/31/2018 8:12 AM, Shawn Guo wrote:
> > On Mon, Oct 08, 2018 at 06:06:23PM +0000, Leonard Crestez wrote:
> >> This was implemented in the driver but not actually defined and
> >> referenced in dts. This makes it always on.
> >>
> >>  From reference manual in section "10.4.1.4.1 Power Distribution":
> >>
> >> "Display domain - The DISPLAY domain contains GIS, CSI, PXP, LCDIF,
> >> PCIe, DCIC, and LDB. It is supplied by internal regulator."
> >>
> >> The current pd_pcie is actually only for PCIE_PHY, the PCIE ip block is
> >> actually inside the DISPLAY domain. Handle this by adding the pcie node
> >> in both power domains.
> >>
> >> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > 
> > Applied, thanks.
> 
> As mentioned in the cover letter this requires multi-PD support in 
> imx-pci to be implemented, specifically PATCH 3/4 of this series:
> 
> 	https://lore.kernel.org/patchwork/patch/996810/
> 
> Unless that also gets merged soon via pci I expect issues in linux-next. 

I do not know what you mean by "issues in linux-next" (I assume you mean
when Shawn sends the patches to linux-next in preparation for v4.21); we
have not planned any other PCI pull request for v4.20-rc1 material.

> The patch already has reviewed-by tags so "merging it soon" is not 
> unreasonable.

I can ACK it if Shawn wants to pull it, it may take a while to see it
in -next if it has to go through the PCI tree, I think it is better
to queue the series without splitting the patches across multiple
channels though.

Lorenzo
