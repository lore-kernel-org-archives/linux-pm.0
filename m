From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v7] thermal: add temperature sensor support for tango SoC
Date: Mon, 4 Apr 2016 19:05:36 -0700
Message-ID: <20160405020534.GA13345@localhost.localdomain>
References: <20160308214846.GA10950@localhost.localdomain>
 <56F84427.1000507@free.fr>
 <56F91A47.9060901@free.fr>
 <20160329020050.GA15721@localhost.localdomain>
 <56FACE0B.9060606@free.fr>
 <20160330000503.GA2625@localhost.localdomain>
 <56FBEE4F.3060106@free.fr>
 <56FD8582.80002@free.fr>
 <20160401015240.GB19409@localhost.localdomain>
 <570254D8.3090406@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35402 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755488AbcDECOL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2016 22:14:11 -0400
Received: by mail-pf0-f175.google.com with SMTP id n1so27027pfn.2
        for <linux-pm@vger.kernel.org>; Mon, 04 Apr 2016 19:13:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <570254D8.3090406@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: linux-pm <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, arm-soc <arm@kernel.org>

On Mon, Apr 04, 2016 at 01:49:44PM +0200, Mason wrote:
> From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> 
> The Tango thermal driver provides support for the primitive temperature
> sensor embedded in Tango chips since the SMP8758.
> 
> This sensor only generates a 1-bit signal to indicate whether the die
> temperature exceeds a programmable threshold.
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
> CCing Rob and Mark for the DT parts
> ---
>  Documentation/devicetree/bindings/thermal/tango-thermal.txt |  17 ++++
>  arch/arm/boot/dts/tango4-smp8758.dtsi                       |  16 ++++
>  drivers/thermal/Kconfig                                     |   9 ++
>  drivers/thermal/Makefile                                    |   1 +
>  drivers/thermal/tango_thermal.c                             | 125 +++++++++++++++++++++++++++
>  5 files changed, 168 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/tango-thermal.txt b/Documentation/devicetree/bindings/thermal/tango-thermal.txt
> new file mode 100644
> index 000000000000..212198d4b937
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/tango-thermal.txt
> @@ -0,0 +1,17 @@
> +* Tango Thermal
> +
> +The SMP8758 SoC includes 3 instances of this temperature sensor
> +(in the CPU, video decoder, and PCIe controller).
> +
> +Required properties:
> +- #thermal-sensor-cells: Should be 0 (see thermal.txt)
> +- compatible: "sigma,smp8758-thermal"
> +- reg: Address range of the thermal registers
> +
> +Example:
> +
> +	cpu_temp: thermal@920100 {
> +		#thermal-sensor-cells = <0>;
> +		compatible = "sigma,smp8758-thermal";
> +		reg = <0x920100 12>;
> +	};
> diff --git a/arch/arm/boot/dts/tango4-smp8758.dtsi b/arch/arm/boot/dts/tango4-smp8758.dtsi
> index 7ed88ee629fb..44d57c02e934 100644
> --- a/arch/arm/boot/dts/tango4-smp8758.dtsi
> +++ b/arch/arm/boot/dts/tango4-smp8758.dtsi
> @@ -28,4 +28,20 @@
>  			<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
>  			<GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>  	};
> +
> +	soc {
> +		cpu_temp: thermal@920100 {
> +			#thermal-sensor-cells = <0>;
> +			compatible = "sigma,smp8758-thermal";
> +			reg = <0x920100 12>;
> +		};
> +	};
> +
> +	thermal-zones {
> +		cpu_thermal: cpu-thermal {
> +			polling-delay-passive = <2003>;	/* ms */
> +			polling-delay = <1009>;		/* ms */
> +			thermal-sensors = <&cpu_temp>;
> +		};

Please add all the required properties for a thermal zone (check the
Documentation for examples or existing dtsi as I mentioned before).

Also, send the diff that adds the dtsi changes into a separated patch.
This recommendation is to avoid conflicts with the tango tree.
I typically I apply the driver changes, and the maintainer of your
platform would apply the DT changes.

BR,

Eduardo Valentin
