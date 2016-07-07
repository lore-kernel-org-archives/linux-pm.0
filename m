From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/3] arm: dts: thermal: add thermal/auxadc node.
Date: Thu, 7 Jul 2016 17:39:01 +0530
Message-ID: <577E465D.8070004@ti.com>
References: <1467882386-40544-1-git-send-email-dawei.chien@mediatek.com>
 <1467882386-40544-4-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1467882386-40544-4-git-send-email-dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Dawei Chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Erin Lo <erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fan Chen <fan.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On Thursday 07 July 2016 02:36 PM, Dawei Chien wrote:
> This adds the thermal controller and auxadc nodes
> to the Mediatek MT2701 dtsi file.
>
> Signed-off-by: Dawei Chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
> This patch depned on:
> https://patchwork.kernel.org/patch/9213545/
> ---
>   arch/arm/boot/dts/mt2701.dtsi |   43 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
>
> diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
> index 2ac8b50..0834a23 100644
> --- a/arch/arm/boot/dts/mt2701.dtsi
> +++ b/arch/arm/boot/dts/mt2701.dtsi
> @@ -77,6 +77,36 @@
>   		#clock-cells = <0>;
>   	};
>
> +	thermal-zones {
> +		cpu_thermal: cpu_thermal {
> +			polling-delay-passive = <1000>; /* milliseconds */
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

are there any corresponding cooling-maps?

>   	timer {
>   		compatible = "arm,armv7-timer";
>   		interrupt-parent = <&gic>;
> @@ -183,4 +213,17 @@
>   		clocks = <&uart_clk>;
>   		status = "disabled";
>   	};
> +
> +	thermal: thermal@1100b000 {
> +		#thermal-sensor-cells = <0>;
> +		compatible = "mediatek,mt2701-thermal";
> +		reg = <0 0x1100b000 0 0x1000>;
> +		interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
> +		clock-names = "therm", "auxadc";
> +		resets = <&pericfg 0x10>;
> +		reset-names = "therm";
> +		mediatek,auxadc = <&auxadc>;
> +		mediatek,apmixedsys = <&apmixedsys>;
> +	};
>   };
>
