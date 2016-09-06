From: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 3/3] arm: dts: thermal: add thermal/auxadc node.
Date: Tue, 06 Sep 2016 08:24:07 +0800
Message-ID: <1473121447.2201.20.camel@intel.com>
References: <1471492253-7185-1-git-send-email-dawei.chien@mediatek.com>
         <1471492253-7185-4-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471492253-7185-4-git-send-email-dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dawei Chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fan Chen <fan.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Erin Lo <erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 四, 2016-08-18 at 11:50 +0800, Dawei Chien wrote:
> This adds the thermal controller and auxadc nodes
> to the Mediatek MT2701 dtsi file.
> 
> Signed-off-by: Dawei Chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
> This patch depned on:
> https://patchwork.kernel.org/patch/9249589/
> https://patchwork.kernel.org/patch/9249589/

Hmm, does this mean that I should take all these three patches and hold
the patches in next merge window until the above patch has been merged?

thanks,
rui 
> ---
>  arch/arm/boot/dts/mt2701.dtsi |   44
> +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt2701.dtsi
> b/arch/arm/boot/dts/mt2701.dtsi
> index e9150a4..cee4724 100644
> --- a/arch/arm/boot/dts/mt2701.dtsi
> +++ b/arch/arm/boot/dts/mt2701.dtsi
> @@ -87,6 +87,36 @@
>  		clock-output-names = "rtc32k";
>  	};
>  
> +	thermal-zones {
> +		cpu_thermal: cpu_thermal {
> +			polling-delay-passive = <1000>; /*
> milliseconds */
> +			polling-delay = <1000>; /* milliseconds */
> +
> +			thermal-sensors = <&thermal 0>;
> +			sustainable-power = <1000>;
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
> +		};
> +	};
> +
>  	timer {
>  		compatible = "arm,armv7-timer";
>  		interrupt-parent = <&gic>;
> @@ -222,4 +252,18 @@
>  		clock-names = "baud", "bus";
>  		status = "disabled";
>  	};
> +
> +	thermal: thermal@1100b000 {
> +		#thermal-sensor-cells = <0>;
> +		compatible = "mediatek,mt2701-thermal";
> +		reg = <0 0x1100b000 0 0x1000>;
> +		interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&pericfg CLK_PERI_THERM>, <&pericfg
> CLK_PERI_AUXADC>;
> +		clock-names = "therm", "auxadc";
> +		resets = <&pericfg 0x10>;
> +		reset-names = "therm";
> +		mediatek,auxadc = <&auxadc>;
> +		mediatek,apmixedsys = <&apmixedsys>;
> +	};
> +
>  };
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
