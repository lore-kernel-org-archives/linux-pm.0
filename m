From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/8] arm64: dts: mt8183: add thermal zone node
Date: Mon, 6 May 2019 11:43:00 +0200
Message-ID: <8e0fad21-57d1-923c-fd8b-f5f2c47a5c94@linaro.org>
References: <1556793795-25204-1-git-send-email-michael.kao@mediatek.com>
 <1556793795-25204-2-git-send-email-michael.kao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556793795-25204-2-git-send-email-michael.kao@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "michael.kao" <michael.kao@mediatek.com>, fan.chen@mediatek.com, jamesjj.liao@mediatek.com, dawei.chien@mediatek.com, louis.yu@mediatek.com, roger.lu@mediatek.com, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 02/05/2019 12:43, michael.kao wrote:
> Add thermal zone node to Mediatek MT8183 dts file.
> 
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---

Hi Michael,

the device tree binding for thermal specifies the thermal zone must
define a cooling-maps (it is a required field).

All the thermal zones below tzts1, tzts2, etc ... do not have it.


>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 64 ++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 926df75..b92116f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -334,6 +334,67 @@
>  			status = "disabled";
>  		};
>  
> +		thermal: thermal@1100b000 {
> +			#thermal-sensor-cells = <1>;
> +			compatible = "mediatek,mt8183-thermal";
> +			reg = <0 0x1100b000 0 0x1000>;
> +			interrupts = <0 76 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_INFRA_THERM>,
> +				 <&infracfg CLK_INFRA_AUXADC>;
> +			clock-names = "therm", "auxadc";
> +			resets = <&infracfg  MT8183_INFRACFG_AO_THERM_SW_RST>;
> +			mediatek,auxadc = <&auxadc>;
> +			mediatek,apmixedsys = <&apmixedsys>;
> +			mediatek,hw-reset-temp = <117000>;
> +			nvmem-cells = <&thermal_calibration>;
> +			nvmem-cell-names = "calibration-data";
> +		};
> +
> +		thermal-zones {
> +			cpu_thermal: cpu_thermal {
> +				polling-delay-passive = <1000>;
> +				polling-delay = <1000>;
> +
> +				thermal-sensors = <&thermal 0>;
> +				sustainable-power = <1500>;
> +			};
> +
> +			tzts1: tzts1 {
> +				polling-delay-passive = <1000>;
> +				polling-delay = <1000>;
> +				thermal-sensors = <&thermal 1>;
> +			};
> +
> +			tzts2: tzts2 {
> +				polling-delay-passive = <1000>;
> +				polling-delay = <1000>;
> +				thermal-sensors = <&thermal 2>;
> +			};
> +
> +			tzts3: tzts3 {
> +				polling-delay-passive = <1000>;
> +				polling-delay = <1000>;
> +				thermal-sensors = <&thermal 3>;
> +			};
> +
> +			tzts4: tzts4 {
> +				polling-delay-passive = <1000>;
> +				polling-delay = <1000>;
> +				thermal-sensors = <&thermal 4>;
> +			};
> +
> +			tzts5: tzts5 {
> +				polling-delay-passive = <1000>;
> +				polling-delay = <1000>;
> +				thermal-sensors = <&thermal 5>;
> +			};
> +
> +			tztsABB: tztsABB {
> +				polling-delay-passive = <1000>;
> +				polling-delay = <1000>;
> +				thermal-sensors = <&thermal 6>;
> +			};
> +		};
>  		audiosys: syscon@11220000 {
>  			compatible = "mediatek,mt8183-audiosys", "syscon";
>  			reg = <0 0x11220000 0 0x1000>;
> @@ -368,6 +429,9 @@
>  			compatible = "mediatek,mt8183-efuse",
>  				     "mediatek,efuse";
>  			reg = <0 0x11f10000 0 0x1000>;
> +			thermal_calibration: calib@180 {
> +				reg = <0x180 0xc>;
> +			};
>  		};
>  
>  		mfgcfg: syscon@13000000 {
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
