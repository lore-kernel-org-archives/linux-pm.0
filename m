From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [RFC PATCH v2 4/4] ARM: sun8i: h3: add support for the thermal
 sensor in H3
Date: Sun, 2 Apr 2017 16:34:55 +0200
Message-ID: <3f13c07d-be6a-0350-6d86-de1a4d4e33a8@free-electrons.com>
References: <20170402133304.56824-1-icenowy@aosc.io>
 <20170402133304.56824-5-icenowy@aosc.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:40044 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbdDBOe6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Apr 2017 10:34:58 -0400
In-Reply-To: <20170402133304.56824-5-icenowy@aosc.io>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: icenowy@aosc.io, Lee Jones <lee.jones@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Jonathan Cameron <jic23@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-sunxi@googlegroups.com

Hi Icenowy,

On 02/04/2017 15:33, Icenowy Zheng wrote:
> As we have gained the support for the thermal sensor in H3, we can now
> add its device nodes to the device tree.
> 
> Add them to the H3 device tree.
> 
> The H5 thermal sensor has some differences, and will be added furtherly.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index b36f9f423c39..552217bb9266 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -72,6 +72,32 @@
>  		};
>  	};
>  
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&ths>;
> +	};
> +
> +	soc {
> +		ths: ths@01c25000 {
> +			compatible = "allwinner,sun8i-h3-ths";
> +			reg = <0x01c25000 0x100>;
> +			clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
> +			clock-names = "bus", "ths";
> +			resets = <&ccu RST_BUS_THS>;
> +			#thermal-sensor-cells = <0>;
> +			#io-channel-cells = <0>;
> +		};
> +	};
> +
> +	thermal-zones {
> +		cpu_thermal {
> +			/* milliseconds */
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&ths>;
> +		};

Would it make sense to add the CPU temp trip points in this patch? Or do
we wait to have CPU OPPs and thermal throttling to add them?

I guess you can find them either in the datasheet or in vendor tree.

Thanks,
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
