From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH V2 1/2] ARM: imx: add vddsoc/pu setpoint info into dts
Date: Wed, 18 Dec 2013 15:05:39 +0800
Message-ID: <20131218070538.GE6691@S2101-09.ap.freescale.net>
References: <1387318102-11070-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:13069
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750905Ab3LRHEf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2013 02:04:35 -0500
Content-Disposition: inline
In-Reply-To: <1387318102-11070-1-git-send-email-b20788@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anson Huang <b20788@freescale.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Tue, Dec 17, 2013 at 05:08:21PM -0500, Anson Huang wrote:
> i.MX6Q needs to update vddarm, vddsoc/pu regulators when cpu freq
> is changed, each setpoint has different voltage, so we need to
> pass vddarm, vddsoc/pu's freq-voltage info from dts together.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-imx6.txt   |   39 ++++++++++++++++++++

The binding doc changes should generally be part of driver changes or a
separate patch, but never be part of dts patch.

>  arch/arm/boot/dts/imx6q.dtsi                       |    7 ++++
>  2 files changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-imx6.txt
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-imx6.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-imx6.txt
> new file mode 100644
> index 0000000..0c71dbf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-imx6.txt
> @@ -0,0 +1,39 @@
> +i.MX6 cpufreq driver
> +-------------------
> +
> +i.MX6 SoC cpufreq driver for CPU frequency scaling.
> +

I think you need to either copy the text from cpufreq-cpu0.txt or refer
to it for some necessary info such as where the properties should be
defined, what required properties should be defined, and what properties
are optional etc.

> +Optional properties:
> +-fsl,soc-operating-points: Specify vddsoc/pu voltage settings that must
> + go with cpu0's operating-points.
> +
> +Examples:
> +
> +	cpu@0 {
> +		compatible = "arm,cortex-a9";
> +		device_type = "cpu";
> +		reg = <0>;
> +		next-level-cache = <&L2>;

Above properties are not related to cpufreq driver, maybe we can save
them.

> +		operating-points = <
> +			/* kHz    uV */
> +			1200000 1275000
> +			996000  1250000
> +			792000  1150000
> +			396000  975000
> +		>;
> +		fsl,soc-operating-points = <
> +			/* ARM kHz  SOC-PU uV */
> +			1200000 1275000
> +			996000	1250000
> +			792000	1175000
> +			396000	1175000
> +		>;
> +		clock-latency = <61036>; /* two CLK32 periods */
> +		clocks = <&clks 104>, <&clks 6>, <&clks 16>,
> +			 <&clks 17>, <&clks 170>;
> +		clock-names = "arm", "pll2_pfd2_396m", "step",
> +			      "pll1_sw", "pll1_sys";
> +		arm-supply = <&reg_arm>;
> +		pu-supply = <&reg_pu>;
> +		soc-supply = <&reg_soc>;

Any properties in the example that are required for a successful driver
probe should be documented in 'Required properties', and others are in
'Optional properties'.

Shawn

> +	};
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index e7e8332..021e0cb 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -30,6 +30,13 @@
>  				792000  1150000
>  				396000  975000
>  			>;
> +			fsl,soc-operating-points = <
> +				/* ARM kHz  SOC-PU uV */
> +				1200000 1275000
> +				996000	1250000
> +				792000	1175000
> +				396000	1175000
> +			>;
>  			clock-latency = <61036>; /* two CLK32 periods */
>  			clocks = <&clks 104>, <&clks 6>, <&clks 16>,
>  				 <&clks 17>, <&clks 170>;
> -- 
> 1.7.9.5
> 
> 

