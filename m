From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2] ARM: dts: imx6sx-sdb: Remove OPP override
Date: Wed, 10 May 2017 22:49:04 +0800
Message-ID: <20170510144903.GC5833@dragon>
References: <7b929a65b4893e081c2c04bb0588801f37ac2cca.1493981825.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751430AbdEJOtU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 May 2017 10:49:20 -0400
Content-Disposition: inline
In-Reply-To: <7b929a65b4893e081c2c04bb0588801f37ac2cca.1493981825.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Anson Huang <Anson.Huang@nxp.com>, Robin Gong <yibin.gong@nxp.com>, Peter Chen <peter.chen@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Henri Roosen <henri.roosen@ginzinger.com>, Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Fri, May 05, 2017 at 02:00:17PM +0300, Leonard Crestez wrote:
> The board file for imx6sx-sdb overrides cpufreq operating points to use
> higher voltages. This is done because the board has a shared rail for
> VDD_ARM_IN and VDD_SOC_IN and when using LDO bypass the shared voltage
> needs to be a value suitable for both ARM and SOC.
> 
> This only applies to LDO bypass mode, a feature not present in upstream.
> When LDOs are enabled the effect is to use higher voltages than necessary
> for no good reason.
> 
> Setting these higher voltages can make some boards fail to boot with ugly
> semi-random crashes reminiscent of memory corruption. These failures only
> happen on board rev. C, rev. B is reported to still work.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> CC: stable@vger.kernel.org

It should have the Fixes tag below.  I can add it when applying.

Fixes: 54183bd7f766 ("ARM: imx6sx-sdb: add revb board and make it default")

> 
> ---
> 
> It is not known exactly why setting these higher voltages causes crashes.
> Maybe this means that it's not appropriate to CC stable?

It should depend on whether we care about the crashes on stable kernel
running on Rev C board.  Do we?

Shawn

> 
> Removing this override is a correct change anyway because these OPP
> overrides do not serve a purpose without ldo bypass.
> 
> Changes since v1:
> - Adjusted commit message
> - Link: https://lkml.org/lkml/2017/4/25/636
> 
>  arch/arm/boot/dts/imx6sx-sdb.dts | 17 -----------------
>  1 file changed, 17 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
> index 5bb8fd5..d71da30 100644
> --- a/arch/arm/boot/dts/imx6sx-sdb.dts
> +++ b/arch/arm/boot/dts/imx6sx-sdb.dts
> @@ -12,23 +12,6 @@
>  	model = "Freescale i.MX6 SoloX SDB RevB Board";
>  };
>  
> -&cpu0 {
> -	operating-points = <
> -		/* kHz    uV */
> -		996000  1250000
> -		792000  1175000
> -		396000  1175000
> -		198000  1175000
> -		>;
> -	fsl,soc-operating-points = <
> -		/* ARM kHz      SOC uV */
> -		996000	1250000
> -		792000	1175000
> -		396000	1175000
> -		198000  1175000
> -	>;
> -};
> -
>  &i2c1 {
>  	clock-frequency = <100000>;
>  	pinctrl-names = "default";
> -- 
> 2.7.4
> 
