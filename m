From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [RFC 8/8] ARM: dts: imx6qdl-sabresd: Enable fsl,ldo-bypass
Date: Wed, 22 Mar 2017 18:13:50 +0100
Message-ID: <1490202830.29056.8.camel@pengutronix.de>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
         <8f4dca5609781f0362009dfa7f6d5c0990b5ea6d.1490199005.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60843 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935251AbdCVROL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2017 13:14:11 -0400
In-Reply-To: <8f4dca5609781f0362009dfa7f6d5c0990b5ea6d.1490199005.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Octavian Purdila <octavian.purdila@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Robin Gong <yibin.gong@nxp.com>, linux-arm-kernel@lists.infradead.org

Am Mittwoch, den 22.03.2017, 18:53 +0200 schrieb Leonard Crestez:
> This enables LDO bypass by default on the imx6qdl-sabresd boards. New
> dts files with -ldo suffix are added for users who want to run with LDOs
> enabled on these boards anyway.

Given that using LDO bypass affects the device lifetime negatively (see
AN4724), I think the default should still be to use LDO enabled mode and
have new DTs for people that desire to shorten the lifetime of the SoC
for a minimal drop in power consumption.

Regards,
Lucas
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  arch/arm/boot/dts/imx6dl-sabresd-ldo.dts | 13 +++++++++++++
>  arch/arm/boot/dts/imx6q-sabresd-ldo.dts  | 13 +++++++++++++
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi   | 19 +++++++++++++++++++
>  arch/arm/boot/dts/imx6qdl.dtsi           |  6 +++---
>  arch/arm/boot/dts/imx6qp-sabresd-ldo.dts | 13 +++++++++++++
>  arch/arm/boot/dts/imx6qp-sabresd.dts     |  4 ++--
>  6 files changed, 63 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx6dl-sabresd-ldo.dts
>  create mode 100644 arch/arm/boot/dts/imx6q-sabresd-ldo.dts
>  create mode 100644 arch/arm/boot/dts/imx6qp-sabresd-ldo.dts
> 
> diff --git a/arch/arm/boot/dts/imx6dl-sabresd-ldo.dts b/arch/arm/boot/dts/imx6dl-sabresd-ldo.dts
> new file mode 100644
> index 0000000..1b224d6
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-sabresd-ldo.dts
> @@ -0,0 +1,13 @@
> +/*
> + * Copyright 2017 NXP
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include "imx6dl-sabresd.dts"
> +
> +&gpc {
> +	fsl,ldo-bypass = <0>;
> +};
> diff --git a/arch/arm/boot/dts/imx6q-sabresd-ldo.dts b/arch/arm/boot/dts/imx6q-sabresd-ldo.dts
> new file mode 100644
> index 0000000..4d2e8cc
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-sabresd-ldo.dts
> @@ -0,0 +1,13 @@
> +/*
> + * Copyright 2017 NXP
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include "imx6q-sabresd.dts"
> +
> +&gpc {
> +	fsl,ldo-bypass = <0>;
> +};
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index 63bf95e..5a73d9d 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -182,6 +182,10 @@
>  	status = "okay";
>  };
>  
> +&gpc {
> +	fsl,ldo-bypass = <1>;
> +};
> +
>  &hdmi {
>  	ddc-i2c-bus = <&i2c2>;
>  	status = "okay";
> @@ -548,6 +552,21 @@
>  	status = "okay";
>  };
>  
> +&reg_arm {
> +       vin-supply = <&sw1a_reg>;
> +       regulator-allow-bypass;
> +};
> +
> +&reg_pu {
> +       vin-supply = <&sw1c_reg>;
> +       regulator-allow-bypass;
> +};
> +
> +&reg_soc {
> +       vin-supply = <&sw1c_reg>;
> +       regulator-allow-bypass;
> +};
> +
>  &snvs_poweroff {
>  	status = "okay";
>  };
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 6d7bf64..54fe769 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -677,7 +677,7 @@
>  					compatible = "fsl,anatop-regulator";
>  					regulator-name = "vddarm";
>  					regulator-min-microvolt = <725000>;
> -					regulator-max-microvolt = <1450000>;
> +					regulator-max-microvolt = <1300000>;
>  					regulator-always-on;
>  					anatop-reg-offset = <0x140>;
>  					anatop-vol-bit-shift = <0>;
> @@ -694,7 +694,7 @@
>  					compatible = "fsl,anatop-regulator";
>  					regulator-name = "vddpu";
>  					regulator-min-microvolt = <725000>;
> -					regulator-max-microvolt = <1450000>;
> +					regulator-max-microvolt = <1300000>;
>  					regulator-enable-ramp-delay = <150>;
>  					anatop-reg-offset = <0x140>;
>  					anatop-vol-bit-shift = <9>;
> @@ -711,7 +711,7 @@
>  					compatible = "fsl,anatop-regulator";
>  					regulator-name = "vddsoc";
>  					regulator-min-microvolt = <725000>;
> -					regulator-max-microvolt = <1450000>;
> +					regulator-max-microvolt = <1300000>;
>  					regulator-always-on;
>  					anatop-reg-offset = <0x140>;
>  					anatop-vol-bit-shift = <18>;
> diff --git a/arch/arm/boot/dts/imx6qp-sabresd-ldo.dts b/arch/arm/boot/dts/imx6qp-sabresd-ldo.dts
> new file mode 100644
> index 0000000..c659533
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6qp-sabresd-ldo.dts
> @@ -0,0 +1,13 @@
> +/*
> + * Copyright 2017 NXP
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include "imx6qp-sabresd.dts"
> +
> +&gpc {
> +	fsl,ldo-bypass = <0>;
> +};
> diff --git a/arch/arm/boot/dts/imx6qp-sabresd.dts b/arch/arm/boot/dts/imx6qp-sabresd.dts
> index b234580..a8a5004 100644
> --- a/arch/arm/boot/dts/imx6qp-sabresd.dts
> +++ b/arch/arm/boot/dts/imx6qp-sabresd.dts
> @@ -50,8 +50,8 @@
>  	compatible = "fsl,imx6qp-sabresd", "fsl,imx6qp";
>  };
>  
> -&cpu0 {
> -	arm-supply = <&sw2_reg>;
> +&reg_arm {
> +	vin-supply = <&sw2_reg>;
>  };
>  
>  &iomuxc {
