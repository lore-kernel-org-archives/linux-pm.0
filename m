From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx6ul: Add imx6ul-tempmon
Date: Mon, 12 Jun 2017 14:47:08 +0300
Message-ID: <1497268028.32422.15.camel@nxp.com>
References: <7055ce6095c0b7f026ac6f0dc37e43fc5c0b1793.1496939031.git.leonard.crestez@nxp.com>
         <b9b91617985607f24c4986bcad5199483805d6b7.1496939031.git.leonard.crestez@nxp.com>
         <CAOMZO5BP4fPyzDmSg+DFLRYh3QMf-8T0gqvnZn6mEMt-QqSgfw@mail.gmail.com>
         <1497005895.28352.88.camel@nxp.com>
         <20170609154638.3b64e6d0@karo-electronics.de>
         <1497022484.28352.105.camel@nxp.com>
         <20170612124029.1643469d@karo-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-sn1nam01on0044.outbound.protection.outlook.com ([104.47.32.44]:27520
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751718AbdFLLrR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Jun 2017 07:47:17 -0400
In-Reply-To: <20170612124029.1643469d@karo-electronics.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Bai Ping <ping.bai@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Zhang Rui <rui.zhang@intel.com>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, 2017-06-12 at 12:40 +0200, Lothar Waßmann wrote:
> On Fri, 9 Jun 2017 18:34:44 +0300 Leonard Crestez wrote:
> > 
> > On Fri, 2017-06-09 at 15:46 +0200, Lothar Waßmann wrote:
> > > 
> > > On Fri, 9 Jun 2017 13:58:15 +0300 Leonard Crestez wrote:
> > > > 
> > > > On Thu, 2017-06-08 at 13:45 -0300, Fabio Estevam wrote:
> > > > > 
> > > > > On Thu, Jun 8, 2017 at 1:26 PM, Leonard Crestez  wrote:
> > > > > > 
> > > > > > +                       tempmon: tempmon {
> > > > > > +                               compatible = "fsl,imx6ul-tempmon", "fsl,imx6sx-tempmon";
> > > > > > +                               interrupts = ;
> > > > > > +                               fsl,tempmon = <&anatop>;
> > > > > > +                               fsl,tempmon-data = <&ocotp>;
> > > > > > +                               clocks = <&clks IMX6UL_CLK_PLL3_USB_OTG>;
> > > > > Does the IMX6UL_CLK_PLL3_USB_OTG clock really control tempmon? Please
> > > > > double check.
> > > > Yes, as far as I can tell the tempmon block uses the 480 Mhz PLL3 clock
> > > > directly. This is similar to other imx6 SOCs. This PLL is used for
> > > > stuff like USB but not only that. My understanding is the _USB_OTG
> > > > suffix is descriptive, similar to PLL4_AUDIO and PLL6_ENET. Other non-
> > > > usb components use PLL3 (like UART) but through other gates/dividers.
> > > > 
> > > > Setting this to IMX6UL_CLK_DUMMY will cause temperature reads to fail.
> > > > Even if PLL3 usually ends up being constantly enabled because of uarts
> > > > this is not true at imx_thermal_probe time (or uarts can be disabled).
> > > > 
> > > Since the driver is accessing the OCOTP registers it definitely needs
> > > the IMX6UL_CLK_OCOTP too!
> > > 
> > I don't think so. OCOTP reads fuse values into shadows registers on
> > chip reset and values seem to be available even if it's specific OCOTP
> > 
> Shadow registers are registers nonetheless which require a clock for
> accessing them.
> 
> > 
> > clock is off. I think that clock is only required for writes or shadow
> > updates.
> > 
> Sometimes it helps to read the Reference Manual or take hardware and try
> it out. The i.MX6(Q|UL) Reference Manual lists the required clocks as:
>                                   Table 35-1. OCOTP Clocks
> Clock name       Clock Root           Description
> ipg_clk          ipg_clk_root         Peripheral clock
> ipg_clk_s        ipg_clk_root         Peripheral access clock
> 
> and Table 18-3. "System Clocks, Gating, and Override (continued)"
> for i.MX6UL shows:
> OCOTP IPG_CLK   IPG_CLK_ROOT CCGR2[CG6] (IIM_CLK_ENABLE)
>       IPG_CLK_S IPG_CLK_ROOT CCGR2[CG6] (IIM_CLK_ENABLE)
> 
> while the same table for i.MX6Q shows:
> OCOTP ipg_clk   ipg_clk_root CCGR2[CG6] (iim_clk_enable)
>       ipg_clk_s ipg_clk_root
> 
> with a blank entry in the "Clock Gating" column for the access clock.
> So, for i.MX6Q there is no clock enable necessary for the access clock,
> but for i.MX6UL there is!
> 
> You can simply verify it by trying to read any of the fuse registers
> with the OCOTP clock disabled (which immediately hangs the processor).

I did check this on real hardware and it seems to work. Printing the
values read from OCOTP inside imx_get_sensor_data displays what looks
like valid data.

However it seems that this might be accidental, it just happens that
the OCOTP clock starts as enabled and is only disabled later in the
boot from "clk_disable_unused". But in theory imx-tempmon can be built
as a module so this is a real bug. It currently seems to already affect
imx6sx.

--
Regards,
Leonard
