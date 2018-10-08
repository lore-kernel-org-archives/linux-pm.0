From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 2/3] PCI: imx: Add multi-pd support
Date: Mon, 8 Oct 2018 11:26:59 +0800
Message-ID: <20181008032657.GF3587@dragon>
References: <cover.1538426534.git.leonard.crestez@nxp.com>
 <5832128f3b1822839a0f0bbd1cf8313cf586f15f.1538426534.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5832128f3b1822839a0f0bbd1cf8313cf586f15f.1538426534.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Fabio Estevam <fabio.estevam@nxp.com>, Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 01, 2018 at 11:56:17PM +0300, Leonard Crestez wrote:
> On some chips the PCIE and PCIE_PHY blocks are in separate power domains
> which can be power-gated independently. The driver needs to handle this
> by keeping both domain active.
> 
> This is intended for imx6sx where PCIE is in DISPMIX and PCIE_PHY in
> it's own domain. Defining the DISPMIX domain requires a way for pcie to
> keep it active or it will break when displays are off.
> 
> The power-domains on imx6sx are meant to look like this:
> 	power-domains = <&pd_disp>, <&pd_pci>;
> 	power-domain-names = "pcie", "pcie_phy";
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 48 +++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

Bindings document fsl,imx6q-pcie.txt should probably be updated for the
new power domain support.

Shawn
