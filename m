From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH v2 4/4] ARM: dts: imx6sx: Add DISPLAY power domain support
Date: Wed, 31 Oct 2018 12:17:50 +0000
Message-ID: <AM0PR04MB4290F31234D75AC7029F066FEECD0@AM0PR04MB4290.eurprd04.prod.outlook.com>
References: <cover.1539020938.git.leonard.crestez@nxp.com>
 <a3265a84052a7c11ae96e61e39adc988ca980d66.1539020938.git.leonard.crestez@nxp.com>
 <20181031061134.GB10386@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 10/31/2018 8:12 AM, Shawn Guo wrote:=0A=
> On Mon, Oct 08, 2018 at 06:06:23PM +0000, Leonard Crestez wrote:=0A=
>> This was implemented in the driver but not actually defined and=0A=
>> referenced in dts. This makes it always on.=0A=
>>=0A=
>>  From reference manual in section "10.4.1.4.1 Power Distribution":=0A=
>>=0A=
>> "Display domain - The DISPLAY domain contains GIS, CSI, PXP, LCDIF,=0A=
>> PCIe, DCIC, and LDB. It is supplied by internal regulator."=0A=
>>=0A=
>> The current pd_pcie is actually only for PCIE_PHY, the PCIE ip block is=
=0A=
>> actually inside the DISPLAY domain. Handle this by adding the pcie node=
=0A=
>> in both power domains.=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
> =0A=
> Applied, thanks.=0A=
=0A=
As mentioned in the cover letter this requires multi-PD support in =0A=
imx-pci to be implemented, specifically PATCH 3/4 of this series:=0A=
=0A=
	https://lore.kernel.org/patchwork/patch/996810/=0A=
=0A=
Unless that also gets merged soon via pci I expect issues in linux-next. =
=0A=
The patch already has reviewed-by tags so "merging it soon" is not =0A=
unreasonable.=0A=
=0A=
Link to cover: https://lore.kernel.org/patchwork/cover/996807/=0A=
=0A=
There is also an mxsfb dependency but that's already merged in =0A=
torvalds/master.=0A=
