From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v1 1/3] arm64: dts: rockchip: add mmc nodes for rk3328
 evaluation board
Date: Wed, 23 Aug 2017 17:58:10 +0800
Message-ID: <70373b2e-2b2f-215e-04e3-1559a00950f0@rock-chips.com>
References: <1503477632-9661-1-git-send-email-cl@rock-chips.com>
 <1503477632-9661-2-git-send-email-cl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503477632-9661-2-git-send-email-cl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: cl@rock-chips.com
Cc: heiko@sntech.de, shawn.lin@rock-chips.com, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, shawnguo@kernel.org, rocky.hao@rock-chips.com, afaerber@suse.de, fabio.estevam@nxp.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, kever.yang@rock-chips.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


On 2017/8/23 16:40, cl@rock-chips.com wrote:
> From: Liang Chen <cl@rock-chips.com>
> 
> Rockchip's rk3328 evaluation board has 3 mmc controllers for
> sdio/sdmmc/emmc, let's enable them.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>
> ---
>   arch/arm64/boot/dts/rockchip/rk3328-evb.dts | 74 +++++++++++++++++++++++++++++
>   1 file changed, 74 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
> index 86605ae..479f9d9 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
> @@ -60,6 +60,20 @@
>   		regulator-max-microvolt = <12000000>;
>   	};
>   
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_enable_h>;
> +
> +		/*
> +		 * On the module itself this is one of these (depending
> +		 * on the actual card populated):
> +		 * - SDIO_RESET_L_WL_REG_ON
> +		 * - PDN (power down when low)
> +		 */
> +		reset-gpios = <&gpio1 18 GPIO_ACTIVE_LOW>;
> +	};
> +
>   	vcc_sys: vcc-sys {
>   		compatible = "regulator-fixed";
>   		regulator-name = "vcc_sys";
> @@ -69,6 +83,29 @@
>   		regulator-max-microvolt = <5000000>;
>   		vin-supply = <&dc_12v>;
>   	};
> +
> +	vcc_sd: sdmmc-regulator {
> +		compatible = "regulator-fixed";
> +		gpio = <&gpio0 30 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sdmmc0m1_gpio>;
> +		regulator-name = "vcc_sd";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_io>;
> +	};
> +};
> +
> +&emmc {
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	supports-emmc;
> +	disable-wp;

Please remove supports-{emmc,sd, sdio} for all mmc node.

And disable-wp is for SD *only*.

> +	non-removable;
> +	num-slots = <1>;

num-slots is deprecated.

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
> +	status = "okay";
>   };
>   
>   &i2c1 {
> @@ -186,6 +223,43 @@
>   			rockchip,pins = <2 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>;
>   		};
>   	};
> +
> +	sdio-pwrseq {
> +		wifi_enable_h: wifi-enable-h {
> +		rockchip,pins =
> +			<1 18 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&sdio {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cap-sdio-irq;
> +	disable-wp;

Ditto

> +	keep-power-in-suspend;
> +	max-frequency = <150000000>;
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +	non-removable;
> +	num-slots = <1>;

Ditto

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc1_bus4 &sdmmc1_cmd &sdmmc1_clk>;
> +	supports-sdio;

Ditto

> +	status = "okay";
> +};
> +
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;

Ditto

> +	disable-wp;
> +	max-frequency = <150000000>;
> +	num-slots = <1>;

Ditto

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc0_clk &sdmmc0_cmd &sdmmc0_dectn &sdmmc0_bus4>;
> +	supports-sd;

Ditto

> +	vmmc-supply = <&vcc_sd>;
> +	status = "okay";
>   };
>   
>   &tsadc {
> 
