From: "rocky.hao" <rocky.hao@rock-chips.com>
Subject: Re: [PATCH 4/5] arm: dts: rockchip: add thermal nodes for RV1108 SoC
Date: Fri, 15 Sep 2017 14:32:07 +0800
Message-ID: <71ddf0e0-c980-90c3-a7b2-dfaf805e1c37@rock-chips.com>
References: <1503570475-7850-1-git-send-email-rocky.hao@rock-chips.com>
 <1503570475-7850-5-git-send-email-rocky.hao@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503570475-7850-5-git-send-email-rocky.hao@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: shawn.lin@rock-chips.com, cl@rock-chips.com, william.wu@rock-chips.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, xxx@rock-chips.com, jay.xu@rock-chips.com, wxt@rock-chips.com, huangtao@rock-chips.com
List-Id: linux-pm@vger.kernel.org



ÔÚ 2017/8/24 18:27, Rocky Hao Ð´µÀ:
> Add thermal zone and dynamic CPU power coefficients for RV1108
> 
> Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
> ---
>   arch/arm/boot/dts/rv1108.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
> index dbdd8c2180e7..cae920b6a145 100644
> --- a/arch/arm/boot/dts/rv1108.dtsi
> +++ b/arch/arm/boot/dts/rv1108.dtsi
> @@ -43,6 +43,7 @@
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/clock/rv1108-cru.h>
>   #include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/thermal/thermal.h>
>   / {
>   	#address-cells = <1>;
>   	#size-cells = <1>;
> @@ -69,6 +70,8 @@
>   			device_type = "cpu";
>   			compatible = "arm,cortex-a7";
>   			reg = <0xf00>;
> +			#cooling-cells = <2>; /* min followed by max */
> +			dynamic-power-coefficient = <75>;
>   		};
>   	};
>   
> @@ -275,6 +278,43 @@
>   		status = "disabled";
>   	};
>   
> +	thermal-zones {
> +		soc_thermal: soc-thermal {
> +			polling-delay-passive = <20>;
> +			polling-delay = <1000>;
> +			sustainable-power = <50>;
> +
> +			thermal-sensors = <&tsadc 0>;
> +
> +			trips {
> +				threshold: trip-point0 {
> +					temperature = <70000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				target: trip-point1 {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				soc_crit: soc-crit {
> +					temperature = <95000>;
Hi Caesar,

For now, dsp is not supported by upstream code, 95000 is proper setting 
for arm core. Arm core is the only cooling device controlled by IPA(a 
good thermal control policy) policy. Once dsp is supported by upstream 
code one day in the feature, its heating is controlled by userspace 
code, initially. So we should change soc-crit from 95000 to 115000.

If dsp is added and control also by IPA(thermal control policy ) policy 
in kernel space, we should update threshold, target, soc_crit settings.

Hi Heiko,
Considering the dsp may be supported, changing soc_crit from 95000 to 
115000 is okay for me. Still it looks strange why target is 85000 but 
soc_crit is 115000.

Thanks & Best Wishes,
Rocky

> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&target>;
> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +					contribution = <4096>;
> +				};
> +			};
> +		};
> +
> +	};
> +
>   	tsadc: tsadc@10370000 {
>   		compatible = "rockchip,rv1108-tsadc";
>   		reg = <0x10370000 0x100>;
> 
