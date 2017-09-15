From: Caesar Wang <wxt@rock-chips.com>
Subject: Re: [PATCH 3/5] arm: dts: rockchip: add tsadc node for RV1108 SoC
Date: Fri, 15 Sep 2017 10:25:35 +0800
Message-ID: <89384e20-94d8-c698-135e-f48924c20493@rock-chips.com>
References: <1503570475-7850-1-git-send-email-rocky.hao@rock-chips.com>
 <1503570475-7850-4-git-send-email-rocky.hao@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503570475-7850-4-git-send-email-rocky.hao@rock-chips.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rocky Hao <rocky.hao@rock-chips.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, huangtao@rock-chips.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, shawn.lin@rock-chips.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, cl@rock-chips.com, william.wu@rock-chips.com, jay.xu@rock-chips.com, xxx@rock-chips.com, linux-arm-kernel@lists.infradead.org, wxt@rock-chips.com
List-Id: linux-pm@vger.kernel.org

Rocky,

在 2017年08月24日 18:27, Rocky Hao 写道:
> Add tsadc needed main information for RV1108 SoC.
> 750000Hz is the max clock rate supported by tsadc module.
>
> Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
> ---
>   arch/arm/boot/dts/rv1108.dtsi | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
> index 25fab0b80f53..dbdd8c2180e7 100644
> --- a/arch/arm/boot/dts/rv1108.dtsi
> +++ b/arch/arm/boot/dts/rv1108.dtsi
> @@ -275,6 +275,25 @@
>   		status = "disabled";
>   	};
>   
> +	tsadc: tsadc@10370000 {
> +		compatible = "rockchip,rv1108-tsadc";
> +		reg = <0x10370000 0x100>;
> +		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
> +		assigned-clocks = <&cru SCLK_TSADC>;
> +		assigned-clock-rates = <750000>;
> +		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
> +		clock-names = "tsadc", "apb_pclk";
> +		pinctrl-names = "init", "default", "sleep";
> +		pinctrl-0 = <&otp_gpio>;
> +		pinctrl-1 = <&otp_out>;
> +		pinctrl-2 = <&otp_gpio>;
> +		resets = <&cru SRST_TSADC>;
> +		reset-names = "tsadc-apb";
> +		rockchip,hw-tshut-temp = <120000>;

 From the Patch[4/5], you set the critial temperature is 95 degree. I 
will suggest the Tshut temperature is 100 degree.
Think about the the peripherial devices,  the 120 degree will damage 
some chips.

> +		#thermal-sensor-cells = <1>;
> +		status = "disabled";
> +	};
> +
>   	adc: adc@1038c000 {
>   		compatible = "rockchip,rv1108-saradc", "rockchip,rk3399-saradc";
>   		reg = <0x1038c000 0x100>;
> @@ -642,6 +661,16 @@
>   			};
>   		};
>   
> +		tsadc {
> +			otp_out: otp-out {
> +				rockchip,pins = <0 RK_PB7 RK_FUNC_1 &pcfg_pull_none>;
> +			};
> +
> +			otp_gpio: otp-gpio {
> +				rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> +			};
> +		};
> +
>   		uart0 {
>   			uart0_xfer: uart0-xfer {
>   				rockchip,pins = <3 RK_PA6 RK_FUNC_1 &pcfg_pull_up>,
