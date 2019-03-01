From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] arm64: dts: ls1088a: add one more thermal zone node
Date: Fri, 1 Mar 2019 21:38:07 +0800
Message-ID: <20190301133805.GQ26041@dragon>
References: <20190225030049.20401-1-andy.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190225030049.20401-1-andy.tang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yuantian Tang <andy.tang@nxp.com>
Cc: leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, edubezval@gmail.com
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 25, 2019 at 11:00:49AM +0800, Yuantian Tang wrote:
> Ls1088a has 2 thermal sensors. This patch adds the second node
> to dts to enable it.

Can you elaborate on these 2 thermal sensors/zones, ccu and plt?

Shawn

> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |   43 +++++++++++++++++++++--
>  1 files changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index 661137f..9f52bc9 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -129,19 +129,19 @@
>  	};
>  
>  	thermal-zones {
> -		cpu_thermal: cpu-thermal {
> +		ccu {
>  			polling-delay-passive = <1000>;
>  			polling-delay = <5000>;
>  			thermal-sensors = <&tmu 0>;
>  
>  			trips {
> -				cpu_alert: cpu-alert {
> +				ccu_alert: ccu-alert {
>  					temperature = <85000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu_crit: cpu-crit {
> +				ccu_crit: ccu-crit {
>  					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "critical";
> @@ -150,7 +150,42 @@
>  
>  			cooling-maps {
>  				map0 {
> -					trip = <&cpu_alert>;
> +					trip = <&ccu_alert>;
> +					cooling-device =
> +						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		plt {
> +			polling-delay-passive = <1000>;
> +			polling-delay = <5000>;
> +			thermal-sensors = <&tmu 1>;
> +
> +			trips {
> +				plt_alert: plt-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				plt_crit: plt-crit {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&plt_alert>;
>  					cooling-device =
>  						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>  						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -- 
> 1.7.1
> 
