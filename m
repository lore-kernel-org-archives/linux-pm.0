From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 0/4] ARM: dts: imx6sx: Add DISPLAY power domain support
Date: Tue, 20 Nov 2018 12:34:58 +0000
Message-ID: <20181120123458.GA22597@e107981-ln.cambridge.arm.com>
References: <cover.1539020938.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1539020938.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, Richard Zhu <hongxing.zhu@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 08, 2018 at 06:06:18PM +0000, Leonard Crestez wrote:
> Now that mxsfb has functional runtime_pm support we can enable power
> gating for the DISPLAY power domain on imx6sx.
> 
> Since pci-imx doesn't support runtime power gating this is still
> always-on unless PCI is disabled/unused. But it's reasonable for an imx
> board to not have PCI.
> 
> The current pd_pcie is actually only for PCIE_PHY, the PCIE ip block is
> actually inside the DISPLAY domain. This is handled by adding the pcie
> node in both power domains, using multi-pd support.
> 
> Series is against linux-next. The last patch needs runtime PM in all
> drivers or it will cause hangs. This means Shawn should hold back on it
> until the PCI and mxsfb dependencies get merged (both might take a long
> time). So you can just review that patch and I will resend it later,
> perhaps in another cycle.
> 
> ---
> 
> Changes since v1:
> * Document multi-pd in imx6q-pcie bindings and add DT list
> * Don't refer to "DISPLAY" as "DISPMIX" because the Reference Manual
> doesn't do that.
> * Link to v1: https://lore.kernel.org/patchwork/cover/994092/
> 
> This is independent of other imx6-pci PM patches such as this one:
> * https://lore.kernel.org/patchwork/patch/996806/
> Device links are quite nice!
> 
> Link to mxsfb thread: https://lkml.org/lkml/2018/9/26/1185
> 
> Leonard Crestez (4):
>   soc: imx: gpc: Increase GPC_CLK_MAX to 7
>   dt-bindings: imx6q-pcie: Add multi-pd bindings for imx6sx
>   PCI: imx: Add multi-pd support
>   ARM: dts: imx6sx: Add DISPLAY power domain support
> 
>  .../bindings/pci/fsl,imx6q-pcie.txt           |  4 +-
>  arch/arm/boot/dts/imx6sx.dtsi                 | 19 +++++++-
>  drivers/pci/controller/dwc/pci-imx6.c         | 48 +++++++++++++++++++
>  drivers/soc/imx/gpc.c                         |  2 +-
>  4 files changed, 70 insertions(+), 3 deletions(-)

As agreed with Shawn, I have applied patches 2-3 to pci/dwc for v4.21,
thanks.

Lorenzo
