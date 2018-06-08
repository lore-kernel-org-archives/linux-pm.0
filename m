From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 1/2] reset: imx7: Fix always writing bits as 0
Date: Fri, 08 Jun 2018 16:23:52 +0200
Message-ID: <1528467832.26356.18.camel@pengutronix.de>
References: <cover.1527621510.git.leonard.crestez@nxp.com>
         <c441872d7dd355ae09e945447441389e93e3b888.1527621510.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c441872d7dd355ae09e945447441389e93e3b888.1527621510.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Richard Zhu <hongxing.zhu@nxp.com>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Joao Pinto <Joao.Pinto@synopsys.com>, Abel Vesa <abel.vesa@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Jingoo Han <jingoohan1@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-pm@vger.kernel.org

Am Dienstag, den 29.05.2018, 22:39 +0300 schrieb Leonard Crestez:
> Right now the only user of reset-imx7 is pci-imx6 and the
> reset_control_assert and deassert calls on pciephy_reset don't toggle
> the PCIEPHY_BTN and PCIEPHY_G_RST bits as expected. Fix this by writing
> 1 or 0 respectively.
> 
> The reference manual is not very clear regarding SRC_PCIEPHY_RCR but for
> other registers like MIPIPHY and HSICPHY the bits are explicitly
> documented as "1 means assert, 0 means deassert".
> 
> The values are still reversed for IMX7_RESET_PCIE_CTRL_APPS_EN.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/reset/reset-imx7.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
> index 4db177bc89bc..fdeac1946429 100644
> --- a/drivers/reset/reset-imx7.c
> +++ b/drivers/reset/reset-imx7.c
> @@ -78,11 +78,11 @@ static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
>  static int imx7_reset_set(struct reset_controller_dev *rcdev,
> >  			  unsigned long id, bool assert)
>  {
> >  	struct imx7_src *imx7src = to_imx7_src(rcdev);
> >  	const struct imx7_src_signal *signal = &imx7_src_signals[id];
> > -	unsigned int value = 0;
> > +	unsigned int value = assert ? signal->bit : 0;
>  
> >  	switch (id) {
> >  	case IMX7_RESET_PCIEPHY:
> >  		/*
> >  		 * wait for more than 10us to release phy g_rst and
