From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v8 2/2] ARM: dts: tango4: Initial thermal support
Date: Wed, 20 Apr 2016 15:45:25 -0700
Message-ID: <20160420224524.GA5807@localhost.localdomain>
References: <56F91A47.9060901@free.fr>
 <20160329020050.GA15721@localhost.localdomain>
 <56FACE0B.9060606@free.fr>
 <20160330000503.GA2625@localhost.localdomain>
 <56FBEE4F.3060106@free.fr>
 <56FD8582.80002@free.fr>
 <20160401015240.GB19409@localhost.localdomain>
 <570254D8.3090406@free.fr>
 <20160406155155.GB326@localhost.localdomain>
 <5716418F.80601@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35500 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbcDTWp3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2016 18:45:29 -0400
Received: by mail-pa0-f48.google.com with SMTP id fs9so22164221pac.2
        for <linux-pm@vger.kernel.org>; Wed, 20 Apr 2016 15:45:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5716418F.80601@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: linux-pm <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Frias <sf84@laposte.net>, arm-soc <arm@kernel.org>

On Tue, Apr 19, 2016 at 04:32:47PM +0200, Mason wrote:
> From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> 
> Define the CPU temperature sensor, and critical trip point.
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>  arch/arm/boot/dts/tango4-smp8758.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/tango4-smp8758.dtsi b/arch/arm/boot/dts/tango4-smp8758.dtsi
> index 7ed88ee629fb..01d5f8f1c71d 100644
> --- a/arch/arm/boot/dts/tango4-smp8758.dtsi
> +++ b/arch/arm/boot/dts/tango4-smp8758.dtsi
> @@ -28,4 +28,27 @@
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
> +			polling-delay = <997>;		/* milliseconds */
> +			polling-delay-passive = <499>;	/* milliseconds */
> +			thermal-sensors = <&cpu_temp>;
> +			trips {
> +				cpu_critical {
> +					temperature = <120000>;
> +					hysteresis = <2500>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
>  };
> -- 
> 2.8.1
