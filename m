From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 3/3] arm: dts: thermal: add thermal/auxadc node.
Date: Thu, 11 Aug 2016 17:51:24 +0200
Message-ID: <fd3f0c2f-f0ad-dd0f-cf2b-eb658f72d735@gmail.com>
References: <1467882386-40544-1-git-send-email-dawei.chien@mediatek.com>
 <1467882386-40544-4-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35757 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932222AbcHKPv2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Aug 2016 11:51:28 -0400
In-Reply-To: <1467882386-40544-4-git-send-email-dawei.chien@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dawei Chien <dawei.chien@mediatek.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@armlinux.org.uk>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Fan Chen <fan.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Erin Lo <erin.lo@mediatek.com>



On 07/07/16 11:06, Dawei Chien wrote:
> This adds the thermal controller and auxadc nodes
> to the Mediatek MT2701 dtsi file.
>
> Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
> ---
> This patch depned on:
> https://patchwork.kernel.org/patch/9213545/
> ---
>  arch/arm/boot/dts/mt2701.dtsi |   43 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
> index 2ac8b50..0834a23 100644
> --- a/arch/arm/boot/dts/mt2701.dtsi
> +++ b/arch/arm/boot/dts/mt2701.dtsi
> @@ -77,6 +77,36 @@
>  		#clock-cells = <0>;
>  	};
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
>  	timer {
>  		compatible = "arm,armv7-timer";
>  		interrupt-parent = <&gic>;
> @@ -183,4 +213,17 @@
>  		clocks = <&uart_clk>;
>  		status = "disabled";
>  	};
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
>  };
>

what about:
status = "disabled"; ?
