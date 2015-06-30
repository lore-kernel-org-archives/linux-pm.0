From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 2/4] ARM: dts: Exynos5250: add CPU OPP and regulator
 supply property
Date: Tue, 30 Jun 2015 09:13:15 +0900
Message-ID: <5591DF1B.7030006@samsung.com>
References: <1435598772-21708-1-git-send-email-b.zolnierkie@samsung.com>
 <1435598772-21708-3-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:20001 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434AbbF3ANX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2015 20:13:23 -0400
In-reply-to: <1435598772-21708-3-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Andreas Faerber <afaerber@suse.de>, Sachin Kamat <sachin.kamat@linaro.org>

On 30.06.2015 02:26, Bartlomiej Zolnierkiewicz wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> For Exynos5250 platforms, add CPU operating points and CPU
> regulator supply properties for migrating from Exynos specific
> cpufreq driver to using generic cpufreq driver.
> 
> Changes by Bartlomiej:
> - split Exynos5250 support from the original patch
> - added CPU regulator supply property for Google Spring board
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Cc: Andreas Faerber <afaerber@suse.de>
> Cc: Sachin Kamat <sachin.kamat@linaro.org>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250-arndale.dts  |  4 ++++
>  arch/arm/boot/dts/exynos5250-smdk5250.dts |  4 ++++
>  arch/arm/boot/dts/exynos5250-snow.dts     |  4 ++++
>  arch/arm/boot/dts/exynos5250-spring.dts   |  4 ++++
>  arch/arm/boot/dts/exynos5250.dtsi         | 22 ++++++++++++++++++++++
>  5 files changed, 38 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
> index 7e728a1..c64cec3 100644
> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
> @@ -560,3 +560,7 @@
>  	status = "okay";
>  	samsung,exynos-sataphy-i2c-phandle = <&sata_phy_i2c>;
>  };
> +
> +&cpu0 {
> +	cpu0-supply = <&buck2_reg>;
> +};

The patch itself looks good, but:
1. Please remove CC-tag with the old-non-working email address of Sachin
Kamat.
2. Could you put the new cpu node in alphabetical order (at least in DTS
where they are already ordered)?

Best regards,
Krzysztof


> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index 4fe186d..4b9f9ce 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -414,6 +414,10 @@
>  	};
>  };
>  
> +&cpu0 {
> +	cpu0-supply = <&buck2_reg>;
> +};
> +
>  &pinctrl_0 {
>  	max77686_irq: max77686-irq {
>  		samsung,pins = "gpx3-2";
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> index b7f4122..b23deda 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -277,6 +277,10 @@
>  	vdd_pll-supply = <&ldo8_reg>;
>  };
>  
> +&cpu0 {
> +	cpu0-supply = <&buck2_reg>;
> +};
> +
>  &i2c_0 {
>  	status = "okay";
>  	samsung,i2c-sda-delay = <100>;
> diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
> index d03f9b8..38b54d9 100644
> --- a/arch/arm/boot/dts/exynos5250-spring.dts
> +++ b/arch/arm/boot/dts/exynos5250-spring.dts
> @@ -99,6 +99,10 @@
>  	vdd_pll-supply = <&ldo8_reg>;
>  };
>  
> +&cpu0 {
> +	cpu0-supply = <&buck2_reg>;
> +};
> +
>  &i2c_0 {
>  	status = "okay";
>  	samsung,i2c-sda-delay = <100>;
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index bf9bee6..0c7ef12 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -63,6 +63,28 @@
>  			compatible = "arm,cortex-a15";
>  			reg = <0>;
>  			clock-frequency = <1700000000>;
> +			clocks = <&clock CLK_ARM_CLK>;
> +			clock-names = "cpu";
> +			clock-latency = <140000>;
> +
> +			operating-points = <
> +				1700000 1300000
> +				1600000 1250000
> +				1500000 1225000
> +				1400000 1200000
> +				1300000 1150000
> +				1200000 1125000
> +				1100000 1100000
> +				1000000 1075000
> +				 900000 1050000
> +				 800000 1025000
> +				 700000 1012500
> +				 600000 1000000
> +				 500000  975000
> +				 400000  950000
> +				 300000  937500
> +				 200000  925000
> +			>;
>  			cooling-min-level = <15>;
>  			cooling-max-level = <9>;
>  			#cooling-cells = <2>; /* min followed by max */
> 

