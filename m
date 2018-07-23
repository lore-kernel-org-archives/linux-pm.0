From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 2/3] reset: imx7: Fix always writing bits as 0
Date: Mon, 23 Jul 2018 13:02:54 +0200
Message-ID: <1532343774.3501.8.camel@pengutronix.de>
References: <cover.1532090446.git.leonard.crestez@nxp.com>
         <54f436a1d2a11a379af642a3327312367ef95343.1532090446.git.leonard.crestez@nxp.com>
         <1532338865.3163.95.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532338865.3163.95.camel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, Leonard Crestez <leonard.crestez@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>, Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Joao Pinto <Joao.Pinto@synopsys.com>, Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, kernel@pengutronix.de, linux-imx@nxp.com
List-Id: linux-pm@vger.kernel.org

On Mon, 2018-07-23 at 11:41 +0200, Lucas Stach wrote:
> As this doesn't depend on any other patch in this series, I think it
> would be fine if Philipp takes this patch through the reset tree.
> 
> Regards,
> Lucas
> 
> Am Freitag, den 20.07.2018, 15:47 +0300 schrieb Leonard Crestez:
> > Right now the only user of reset-imx7 is pci-imx6 and the
> > reset_control_assert and deassert calls on pciephy_reset don't toggle
> > the PCIEPHY_BTN and PCIEPHY_G_RST bits as expected. Fix this by writing
> > 1 or 0 respectively.
> > 
> > The reference manual is not very clear regarding SRC_PCIEPHY_RCR but for
> > other registers like MIPIPHY and HSICPHY the bits are explicitly
> > documented as "1 means assert, 0 means deassert".
> > 
> > The values are still reversed for IMX7_RESET_PCIE_CTRL_APPS_EN.
> > 
> > > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Thank you, applied to reset/fixes.

regards
Philipp
