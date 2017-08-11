From: Caesar Wang <wxt@rock-chips.com>
Subject: Re: [PATCH v2 3/5] arm64: dts: rockchip: add tsadc node for rk3328
 SoC
Date: Fri, 11 Aug 2017 14:38:31 +0800
Message-ID: <1ea7dab5-95c9-9d5f-5d4e-4c5a7f2a6254@rock-chips.com>
References: <1501833976-1100-1-git-send-email-rocky.hao@rock-chips.com>
 <1501833976-1100-4-git-send-email-rocky.hao@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.138]:43253 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751299AbdHKGiz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2017 02:38:55 -0400
In-Reply-To: <1501833976-1100-4-git-send-email-rocky.hao@rock-chips.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rocky Hao <rocky.hao@rock-chips.com>, rui.zhang@intel.com, edubezval@gmail.com, heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: huangtao@rock-chips.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, shawn.lin@rock-chips.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, cl@rock-chips.com, william.wu@rock-chips.com, jay.xu@rock-chips.com, xxx@rock-chips.com, linux-arm-kernel@lists.infradead.org, wxt@rock-chips.com

在 2017年08月04日 16:06, Rocky Hao 写道:
> add tsadc needed main information for rk3328 SoC.
> 50000Hz is the max clock rate supported by tsadc module.
>
> Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
> ---
> Change in v2:
> - remove gerrit Change-Id
>
>   arch/arm64/boot/dts/rockchip/rk3328.dtsi | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index db4b2708084d..186fb93fdffd 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -308,6 +308,26 @@
>   		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
>   	};
>   
> +	tsadc: tsadc@ff250000 {
> +		compatible = "rockchip,rk3328-tsadc";
> +		reg = <0x0 0xff250000 0x0 0x100>;
> +		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH 0>;
> +		rockchip,grf = <&grf>;
> +		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
> +		clock-names = "tsadc", "apb_pclk";
> +		assigned-clocks = <&cru SCLK_TSADC>;
> +		assigned-clock-rates = <50000>;
> +		resets = <&cru SRST_TSADC>;
> +		reset-names = "tsadc-apb";
> +		pinctrl-names = "init", "default", "sleep";
> +		pinctrl-0 = <&otp_gpio>;
> +		pinctrl-1 = <&otp_out>;
> +		pinctrl-2 = <&otp_gpio>;
> +		#thermal-sensor-cells = <1>;

Only one sensor, so maybe the value should be 0.

> +		rockchip,hw-tshut-temp = <100000>;
> +		status = "disabled";
> +	};
> +
>   	saradc: adc@ff280000 {
>   		compatible = "rockchip,rk3328-saradc", "rockchip,rk3399-saradc";
>   		reg = <0x0 0xff280000 0x0 0x100>;
