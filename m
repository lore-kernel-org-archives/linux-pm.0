From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: imx6q-pcie: Add multi-pd bindings
 for  imx6sx
Date: Fri, 12 Oct 2018 17:09:41 -0500
Message-ID: <20181012220941.GA13742@bogus>
References: <cover.1539020938.git.leonard.crestez@nxp.com>
 <fb622df91d2e4aa339e8831fb8bcde03327f5bda.1539020938.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fb622df91d2e4aa339e8831fb8bcde03327f5bda.1539020938.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, Richard Zhu <hongxing.zhu@nxp.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Fabio Estevam <fabio.estevam@nxp.com>, Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 8 Oct 2018 18:06:20 +0000, Leonard Crestez wrote:
> The PCIE and PCIE_PHY blocks are in different power domains on imx6sx
> and this needs to be described using multi-pd bindings.
> 
> This was not required until now because the power-domain of the PCIE
> block (DISPLAY) was always on.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
