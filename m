From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 3/4] PCI: imx: Add multi-pd support
Date: Mon, 19 Nov 2018 19:38:18 +0800
Message-ID: <20181119113816.GP5829@dragon>
References: <cover.1539020938.git.leonard.crestez@nxp.com>
 <ee0c4ecb4b6bd26f548096e7be90a07d181d50ee.1539020938.git.leonard.crestez@nxp.com>
 <20181116122541.GD3228@e107981-ln.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181116122541.GD3228@e107981-ln.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Leonard Crestez <leonard.crestez@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Richard Zhu <hongxing.zhu@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 16, 2018 at 12:25:41PM +0000, Lorenzo Pieralisi wrote:
> On Mon, Oct 08, 2018 at 06:06:21PM +0000, Leonard Crestez wrote:
> > On some chips the PCIE and PCIE_PHY blocks are in separate power domains
> > which can be power-gated independently. The pci driver needs to handle
> > this by keeping both domain active.
> > 
> > This is intended for imx6sx where PCIE is in DISPLAY and PCIE_PHY in
> > it's own domain. Defining the DISPLAY domain requires a way for pcie to
> > keep it active or it will break when displays are off.
> > 
> > The power-domains on imx6sx are meant to look like this:
> > 	power-domains = <&pd_disp>, <&pd_pci>;
> > 	power-domain-names = "pcie", "pcie_phy";
> > 
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 48 +++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> 
> I expect Shawn to pick the whole series up and therefore I am dropping
> this series from the PCI tree.

Lorenzo,

I think the best approach is that you send patch #2 and #3 for 4.21
through PCI tree, and we will be able to apply patch #4 in 4.22
development cycle.

Queuing patch #3 on IMX tree will stands a good chance for conflicts
with other pci-imx6.c changes on PCI tree.

Shawn
