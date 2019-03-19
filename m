From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH 3/3] firmware: imx: scu-pd: decouple the SS information
 from domain names
Date: Tue, 19 Mar 2019 12:28:33 +0000
Message-ID: <AM0PR04MB4211BA9F691DE18F3BFA426380400@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1550673013-21462-1-git-send-email-aisheng.dong@nxp.com>
 <1550673013-21462-4-git-send-email-aisheng.dong@nxp.com>
 <20190319090441.GA28063@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190319090441.GA28063@dragon>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "dongas86@gmail.com" <dongas86@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

> >  	/* HSIO SS */
> > -	{ "hsio-pcie-b", IMX_SC_R_PCIE_B, 1, false, 0 },
> > -	{ "hsio-serdes-1", IMX_SC_R_SERDES_1, 1, false, 0 },
> > +	{ "pcie-b", IMX_SC_R_PCIE_B, 1, false, 0 },
> > +	{ "serdes-1", IMX_SC_R_SERDES_1, 1, false, 0 },
> >  	{ "hsio-gpio", IMX_SC_R_HSIO_GPIO, 1, false, 0 },
> 
> Why is gpio so special that we need to keep the SS indicator?
> 

GPIO also exists on other SS like LSIO.
For those special resources in special SS, we add the SS indicator,
Just like how SC firmware does when defining resource ID.

Regards
Dong Aisheng

> Shawn
> 
> >
> > -	/* MIPI/LVDS SS */
> > +	/* MIPI SS */
> >  	{ "mipi0", IMX_SC_R_MIPI_0, 1, false, 0 },
> >  	{ "mipi0-pwm0", IMX_SC_R_MIPI_0_PWM_0, 1, false, 0 },
> >  	{ "mipi0-i2c", IMX_SC_R_MIPI_0_I2C_0, 2, true, 0 },
> > +
> > +	/* LVDS SS */
> >  	{ "lvds0", IMX_SC_R_LVDS_0, 1, false, 0 },
> >
> >  	/* DC SS */
> > --
> > 2.7.4
> >
