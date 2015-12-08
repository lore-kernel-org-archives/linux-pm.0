From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
Subject: Re: [PATCH 7/8 v3] ARM: shmobile: r8a7791: enable to use thermal-zone
Date: Tue, 8 Dec 2015 10:10:13 +0700
Message-ID: <56664A15.3000209@rvc.renesas.com>
References: <87y4d6672t.wl%kuninori.morimoto.gx@renesas.com> <87oae266yc.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:21606 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932267AbbLHDKU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2015 22:10:20 -0500
In-Reply-To: <87oae266yc.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus <magnus.damm@gmail.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Hien Duy. Dang" <hien.dang.eb@rvc.renesas.com>, Toru Oishi <toru.oishi.zj@rvc.renesas.com>, Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>

Hi Morimoto-san,

Thanks for your patch.
I have same comments as patch 0006.

On 12/7/2015 2:44 PM, Kuninori Morimoto wrote:
>
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> This patch enables to use thermal-zone on r8a7791.
> This thermal sensor can measure temperature from -40000 to 125000,
> but over 117000 can be critical on this chip.
> Thus, default critical temperature is now set as 115000 (this driver
> is using 5000 steps) (Current critical temperature is using it as
> 90000, but there is no big reason about it)
>
> And it doesn't check thermal zone periodically (same as current
> behavior). You can exchange it by modifing polling-delay[-passive]

modifing -> modifying

> property.
>
> You can set trip temp if your kernel has CONFIG_THERMAL_WRITABLE_TRIPS,
> but you need to take care to use it, since it will call
> orderly_poweroff() it it reached to the value.

if it reaches

> echo $temp > /sys/class/thermal/thermal_zone0/trip_point_0_temp
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v2 -> v3
>
>   - compatible "renesas,rcar-thermal-gen2" -> "renesas,rcar-gen2-thermal"
>
>   arch/arm/boot/dts/r8a7791.dtsi | 26 ++++++++++++++++++++++++--
>   1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index 1487d92..d885e5f 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -69,6 +69,25 @@
>   		};
>   	};
>
> +	thermal-zones {
> +		cpu_thermal: cpu-thermal {
> +			polling-delay-passive	= <0>;
> +			polling-delay		= <0>;
> +
> +			thermal-sensors = <&thermal>;
> +
> +			trips {
> +				cpu-crit {
> +					temperature	= <1150000>;

One zero is redundant here. It should be 115000.

> +					hysteresis	= <0>;
> +					type		= "critical";
> +				};
> +			};
> +			cooling-maps {
> +			};
> +		};
> +	};
> +
>   	gic: interrupt-controller@f1001000 {
>   		compatible = "arm,gic-400";
>   		#interrupt-cells = <3>;
> @@ -185,12 +204,15 @@
>   		power-domains = <&cpg_clocks>;
>   	};
>
> -	thermal@e61f0000 {
> -		compatible = "renesas,thermal-r8a7791", "renesas,rcar-thermal";
> +	thermal: thermal@e61f0000 {
> +		compatible =	"renesas,thermal-r8a7791",
> +				"renesas,rcar-gen2-thermal",
> +				"renesas,rcar-thermal";
>   		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
>   		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
>   		clocks = <&mstp5_clks R8A7791_CLK_THERMAL>;
>   		power-domains = <&cpg_clocks>;
> +		#thermal-sensor-cells = <0>;
>   	};
>
>   	timer {
>
