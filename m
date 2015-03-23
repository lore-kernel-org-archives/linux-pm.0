From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 5/7] ARM: dts: enable regulator support for i.MX23/i.MX28
Date: Mon, 23 Mar 2015 07:07:06 +0100
Message-ID: <20150323060706.GB4946@pengutronix.de>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
 <1426984203-9133-6-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33498 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbbCWGOB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2015 02:14:01 -0400
Content-Disposition: inline
In-Reply-To: <1426984203-9133-6-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: shawn.guo@linaro.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, broonie@kernel.org, lgirdwood@gmail.com, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, robh+dt@kernel.org, galak@codeaurora.org, fabio.estevam@freescale.com, marex@denx.de, kernel@pengutronix.de, rjw@rjwysocki.net, viresh.kumar@linaro.org, sebastien.szymanski@armadeus.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On Sun, Mar 22, 2015 at 12:30:01AM +0000, Stefan Wahren wrote:
> This patch enables the on-chip regulator support for all i.MX23 and
> i.MX28 boards.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  arch/arm/boot/dts/imx23.dtsi |   67 +++++++++++++++++++++++++++++++++++++++++-
>  arch/arm/boot/dts/imx28.dtsi |   67 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 132 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
> index bbcfb5a..be0aee8 100644
> --- a/arch/arm/boot/dts/imx23.dtsi
> +++ b/arch/arm/boot/dts/imx23.dtsi
> @@ -404,8 +404,73 @@
>  			};
>  
>  			power@80044000 {
> +				compatible = "fsl,imx23-power";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
>  				reg = <0x80044000 0x2000>;
> -				status = "disabled";
> +				interrupts = <3>;
> +				ranges;
> +
> +				dcdc: regulator@80044010 {
> +					reg = <0x80044010 0x10>,
> +					      <0x80044090 0x10>,
> +					      <0x800440c0 0x10>;
> +					reg-names = "base-address",
> +						    "misc-address",
> +						    "status-address";
> +					compatible = "fsl,imx23-dcdc";
> +					regulator-name = "dcdc";
> +					regulator-boot-on;
> +					regulator-always-on;
> +				};

It is very unusual to describe the regulators of a device on a register
level like this and to iomemap each register individually. I think you
should drop the registers here and put this knowledge into the driver
like (nearly?) all others do.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
