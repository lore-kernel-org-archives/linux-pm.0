From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx6ul: Add imx6ul-tempmon
Date: Fri, 9 Jun 2017 18:34:44 +0300
Message-ID: <1497022484.28352.105.camel@nxp.com>
References: <7055ce6095c0b7f026ac6f0dc37e43fc5c0b1793.1496939031.git.leonard.crestez@nxp.com>
         <b9b91617985607f24c4986bcad5199483805d6b7.1496939031.git.leonard.crestez@nxp.com>
         <CAOMZO5BP4fPyzDmSg+DFLRYh3QMf-8T0gqvnZn6mEMt-QqSgfw@mail.gmail.com>
         <1497005895.28352.88.camel@nxp.com>
         <20170609154638.3b64e6d0@karo-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170609154638.3b64e6d0@karo-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Fabio Estevam <festevam@gmail.com>, Bai Ping <ping.bai@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Zhang Rui <rui.zhang@intel.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2017-06-09 at 15:46 +0200, Lothar Waßmann wrote:
> On Fri, 9 Jun 2017 13:58:15 +0300 Leonard Crestez wrote:
> > On Thu, 2017-06-08 at 13:45 -0300, Fabio Estevam wrote:
> > > On Thu, Jun 8, 2017 at 1:26 PM, Leonard Crestez  wrote:
> > > > +                       tempmon: tempmon {
> > > > +                               compatible = "fsl,imx6ul-tempmon", "fsl,imx6sx-tempmon";
> > > > +                               interrupts = ;
> > > > +                               fsl,tempmon = <&anatop>;
> > > > +                               fsl,tempmon-data = <&ocotp>;
> > > > +                               clocks = <&clks IMX6UL_CLK_PLL3_USB_OTG>;
> > > Does the IMX6UL_CLK_PLL3_USB_OTG clock really control tempmon? Please
> > > double check.
> > Yes, as far as I can tell the tempmon block uses the 480 Mhz PLL3 clock
> > directly. This is similar to other imx6 SOCs. This PLL is used for
> > stuff like USB but not only that. My understanding is the _USB_OTG
> > suffix is descriptive, similar to PLL4_AUDIO and PLL6_ENET. Other non-
> > usb components use PLL3 (like UART) but through other gates/dividers.
> > 
> > Setting this to IMX6UL_CLK_DUMMY will cause temperature reads to fail.
> > Even if PLL3 usually ends up being constantly enabled because of uarts
> > this is not true at imx_thermal_probe time (or uarts can be disabled).
> > 
> Since the driver is accessing the OCOTP registers it definitely needs
> the IMX6UL_CLK_OCOTP too!
> 
I don't think so. OCOTP reads fuse values into shadows registers on
chip reset and values seem to be available even if it's specific OCOTP
clock is off. I think that clock is only required for writes or shadow
updates.

In theory perhaps tempmon could be made to read ocotp through the imx-
ocotp nvmem driver? It is not clear in what scenario this would
actually be required.

This discussion is not specific to 6ul/6ull. There are other reads from
ocotp which don't enable it's clock, for example
imx6q_opp_check_speed_grading.

--
Regards,
Leonard
