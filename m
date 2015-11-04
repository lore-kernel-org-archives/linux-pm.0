From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: mt8173: Add thermal zone node for
 mt8173.
Date: Wed, 4 Nov 2015 11:41:12 -0800
Message-ID: <20151104194111.GD14127@localhost.localdomain>
References: <1445515359-8587-1-git-send-email-dawei.chien@mediatek.com>
 <1445515359-8587-3-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33973 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030750AbbKDTlQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2015 14:41:16 -0500
Content-Disposition: inline
In-Reply-To: <1445515359-8587-3-git-send-email-dawei.chien@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dawei Chien <dawei.chien@mediatek.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>

On Thu, Oct 22, 2015 at 08:02:39PM +0800, Dawei Chien wrote:
> Add thermal zone node to mt8173.dtsi.
> 
> Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
> ---
> This patch is base on
> https://patchwork.kernel.org/patch/7249821/
> https://patchwork.kernel.org/patch/7249861/
> https://patchwork.kernel.org/patch/7249891/
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi |   90 ++++++++++++++++++++++++++++++

This patch adds also the static / dynamic power models too. Can you
please split this patch in two: one for the thermal zones, one for the
models.

>  1 file changed, 90 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 3b18f37..eaf12bf 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -16,6 +16,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/mt8173-power.h>
>  #include <dt-bindings/reset-controller/mt8173-resets.h>
> +#include <dt-bindings/thermal/mt8173.h>
>  #include "mt8173-pinfunc.h"
>  
>  / {
> @@ -54,6 +55,18 @@
>  			reg = <0x000>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&CPU_SLEEP_0>;
> +			static-power-points = <
> +				859000  43
> +				908000  52
> +				983000  86
> +				1009000 123
> +				1028000 138
> +				1083000 172
> +				1110900 180
> +				1125000 192
> +			>;
> +			dynamic-power-coefficient = <263>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		cpu1: cpu@1 {
> @@ -62,6 +75,17 @@
>  			reg = <0x001>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&CPU_SLEEP_0>;
> +			static-power-points = <
> +				859000  43
> +				908000  52
> +				983000  86
> +				1009000 123
> +				1028000 138
> +				1083000 172
> +				1110900 180
> +				1125000 192
> +			>;
> +			dynamic-power-coefficient = <263>;
>  		};
>  
>  		cpu2: cpu@100 {
> @@ -70,6 +94,18 @@
>  			reg = <0x100>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&CPU_SLEEP_0>;
> +			static-power-points = <
> +				828000  72
> +				867000  90
> +				927000  156
> +				968000  181
> +				1007000 298
> +				1049000 435
> +				1089900 533
> +				1125000 533
> +			>;
> +			dynamic-power-coefficient = <530>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		cpu3: cpu@101 {
> @@ -78,6 +114,17 @@
>  			reg = <0x101>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&CPU_SLEEP_0>;
> +			static-power-points = <
> +				828000  72
> +				867000  90
> +				927000  156
> +				968000  181
> +				1007000 298
> +				1049000 435
> +				1089900 533
> +				1125000 533
> +			>;
> +			dynamic-power-coefficient = <530>;
>  		};
>  
>  		idle-states {
> @@ -116,6 +163,49 @@
>  		clock-output-names = "clk32k";
>  	};
>  
> +	thermal-zones {
> +		cpu_thermal: cpu_thermal {
> +			polling-delay-passive = <1000>; /* milliseconds */
> +			polling-delay = <1000>; /* milliseconds */
> +
> +			thermal-sensors = <&thermal MT8173_THERMAL_ZONE_CA57>;
> +			sustainable-power = <1500>;
> +
> +			trips {
> +				threshold: trip-point@0 {
> +					temperature = <68000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				target: trip-point@1 {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit: cpu_crit@0 {
> +					temperature = <115000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map@0 {
> +					trip = <&target>;
> +					cooling-device = <&cpu0 0 0>;
> +					contribution = <1024>;
> +				};
> +				map@1 {
> +					trip = <&target>;
> +					cooling-device = <&cpu2 0 0>;
> +					contribution = <2048>;
> +				};
> +			};
> +		};
> +	};
> +
>  	timer {
>  		compatible = "arm,armv8-timer";
>  		interrupt-parent = <&gic>;
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
