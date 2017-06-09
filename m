From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx6ul: Add imx6ul-tempmon
Date: Fri, 9 Jun 2017 13:58:15 +0300
Message-ID: <1497005895.28352.88.camel@nxp.com>
References: <7055ce6095c0b7f026ac6f0dc37e43fc5c0b1793.1496939031.git.leonard.crestez@nxp.com>
         <b9b91617985607f24c4986bcad5199483805d6b7.1496939031.git.leonard.crestez@nxp.com>
         <CAOMZO5BP4fPyzDmSg+DFLRYh3QMf-8T0gqvnZn6mEMt-QqSgfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn3nam01on0085.outbound.protection.outlook.com ([104.47.33.85]:36496
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751528AbdFIK6X (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Jun 2017 06:58:23 -0400
In-Reply-To: <CAOMZO5BP4fPyzDmSg+DFLRYh3QMf-8T0gqvnZn6mEMt-QqSgfw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Bai Ping <ping.bai@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Zhang Rui <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, 2017-06-08 at 13:45 -0300, Fabio Estevam wrote:
> On Thu, Jun 8, 2017 at 1:26 PM, Leonard Crestez  wrote:
> 
> > 
> > +                       tempmon: tempmon {
> > +                               compatible = "fsl,imx6ul-tempmon", "fsl,imx6sx-tempmon";
> > +                               interrupts = ;
> > +                               fsl,tempmon = <&anatop>;
> > +                               fsl,tempmon-data = <&ocotp>;
> > +                               clocks = <&clks IMX6UL_CLK_PLL3_USB_OTG>;
> Does the IMX6UL_CLK_PLL3_USB_OTG clock really control tempmon? Please
> double check.

Yes, as far as I can tell the tempmon block uses the 480 Mhz PLL3 clock
directly. This is similar to other imx6 SOCs. This PLL is used for
stuff like USB but not only that. My understanding is the _USB_OTG
suffix is descriptive, similar to PLL4_AUDIO and PLL6_ENET. Other non-
usb components use PLL3 (like UART) but through other gates/dividers.

Setting this to IMX6UL_CLK_DUMMY will cause temperature reads to fail.
Even if PLL3 usually ends up being constantly enabled because of uarts
this is not true at imx_thermal_probe time (or uarts can be disabled).

--
Regards,
Leonard
