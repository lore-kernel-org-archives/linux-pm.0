From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V4 4/4] ARM64: dts: imx: add i.MX8QXP thermal support
Date: Thu, 29 Nov 2018 08:50:41 -0800
Message-ID: <20181129165040.GD2688@localhost.localdomain>
References: <1543458696-4741-1-git-send-email-Anson.Huang@nxp.com>
 <1543458696-4741-5-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1543458696-4741-5-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "rui.zhang@intel.com" <rui.zhang@intel.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, Aisheng DONG <aisheng.dong@nxp.com>, Andy Gross <andy.gross@linaro.org>, "heiko@sntech.de" <heiko@sntech.de>, "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>, "arnd@arndb.de" <arnd@arndb.de>, "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>, "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>, "ezequiel@collabora.com" <ezequiel@collabora.com>, "olof@lixom.net" <olof@lixom.net>, "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>, shawnguo@ker
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 29, 2018 at 02:37:47AM +0000, Anson Huang wrote:
> Add i.MX8QXP CPU thermal zone support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> ChangeLog:
> V3->V4:
>   *move the tsens node to inside of SCU node as it is belonging to SCU.
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 9b08688..48f622c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/firmware/imx/rsrc.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/pinctrl/pads-imx8qxp.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  #include "imx8-ca35.dtsi"
>  
> @@ -87,6 +88,12 @@
>  		rtc: rtc {
>  			compatible = "fsl,imx8qxp-sc-rtc";
>  		};
> +
> +		tsens: thermal-sensor {
> +			compatible = "fsl,imx8qxp-sc-thermal";
> +			tsens-num = <1>;
> +			#thermal-sensor-cells = <1>;
> +		};
>  	};
>  
>  	adma_subsys: bus@59000000 {
> @@ -410,4 +417,24 @@
>  		#size-cells = <1>;
>  		ranges = <0x5f000000 0x0 0x5f000000 0x1000000>;
>  	};
> +
> +	thermal_zones: thermal-zones {
> +		cpu-thermal0 {
> +			polling-delay-passive = <250>;
> +			polling-delay = <2000>;
> +			thermal-sensors = <&tsens 355>;
> +			trips {
> +				cpu_alert0: trip0 {
> +					temperature = <107000>;
> +					hysteresis = <2000>;
> +					type = "passive";

Passive, but yet no cooling maps?

> +				};
> +				cpu_crit0: trip1 {
> +					temperature = <127000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
>  };
> -- 
> 2.7.4
> 
