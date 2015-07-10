From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 5/7] ARM: dts: Exynos4x12: add CPU OPP and regulator
 supply property
Date: Fri, 10 Jul 2015 17:35:34 +0900
Message-ID: <559F83D6.8040409@samsung.com>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <1436456621-29839-6-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1436456621-29839-6-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Andreas Faerber <afaerber@suse.de>
List-Id: linux-pm@vger.kernel.org

On 10.07.2015 00:43, Bartlomiej Zolnierkiewicz wrote:
> For Exynos4x12 platforms, add CPU operating points (using
> opp-v2 bindings) and CPU regulator supply properties for
> migrating from Exynos specific cpufreq driver to using
> generic cpufreq driver.
> 
> Based on the earlier work by Thomas Abraham.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Andreas Faerber <afaerber@suse.de>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4212.dtsi               | 81 ++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi |  4 ++
>  arch/arm/boot/dts/exynos4412-origen.dts         |  5 ++
>  arch/arm/boot/dts/exynos4412-trats2.dts         |  5 ++
>  arch/arm/boot/dts/exynos4412.dtsi               | 83 +++++++++++++++++++++++++
>  5 files changed, 178 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
> index d9c8efee..9dc40d5 100644
> --- a/arch/arm/boot/dts/exynos4212.dtsi
> +++ b/arch/arm/boot/dts/exynos4212.dtsi
> @@ -30,6 +30,9 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a9";
>  			reg = <0xA00>;
> +			clocks = <&clock CLK_ARM_CLK>;
> +			clock-names = "cpu";
> +			operating-points-v2 = <&cpu0_opp_table>;
>  			cooling-min-level = <13>;
>  			cooling-max-level = <7>;
>  			#cooling-cells = <2>; /* min followed by max */
> @@ -39,6 +42,84 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a9";
>  			reg = <0xA01>;
> +			operating-points-v2 = <&cpu0_opp_table>;
> +		};
> +	};
> +
> +	cpu0_opp_table: opp_table0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp00 {
> +			opp-hz = <200000000>;
> +			opp-microvolt = <900000>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp01 {
> +			opp-hz = <300000000>;
> +			opp-microvolt = <900000>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp02 {
> +			opp-hz = <400000000>;
> +			opp-microvolt = <925000>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp03 {
> +			opp-hz = <500000000>;
> +			opp-microvolt = <950000>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp04 {
> +			opp-hz = <600000000>;
> +			opp-microvolt = <975000>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp05 {
> +			opp-hz = <700000000>;
> +			opp-microvolt = <987500>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp06 {
> +			opp-hz = <800000000>;
> +			opp-microvolt = <1000000>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp07 {
> +			opp-hz = <900000000>;
> +			opp-microvolt = <1037500>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp08 {
> +			opp-hz = <1000000000>;
> +			opp-microvolt = <1087500>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp09 {
> +			opp-hz = <1100000000>;
> +			opp-microvolt = <1137500>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp10 {
> +			opp-hz = <1200000000>;
> +			opp-microvolt = <1187500>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp11 {
> +			opp-hz = <1300000000>;
> +			opp-microvolt = <1250000>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp12 {
> +			opp-hz = <1400000000>;
> +			opp-microvolt = <1287500>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp13 {
> +			opp-hz = <1500000000>;
> +			opp-microvolt = <1350000>;
> +			clock-latency-ns = <200000>;
> +			turbo-mode;
>  		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> index ca7d168..1c7811a 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -507,3 +507,7 @@
>  &watchdog {
>  	status = "okay";
>  };
> +
> +&cpu0 {
> +	cpu0-supply = <&buck2_reg>;
> +};

Can you put this in alphabetical order (before ehci node)?

> diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
> index 84c7631..21150b4 100644
> --- a/arch/arm/boot/dts/exynos4412-origen.dts
> +++ b/arch/arm/boot/dts/exynos4412-origen.dts
> @@ -532,3 +532,8 @@
>  &watchdog {
>  	status = "okay";
>  };
> +
> +
> +&cpu0 {
> +	cpu0-supply = <&buck2_reg>;
> +};

Ditto

> diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
> index afc199d..1ee43456 100644
> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
> @@ -1313,3 +1313,8 @@
>  	vtmu-supply = <&ldo10_reg>;
>  	status = "okay";
>  };
> +
> +
> +&cpu0 {
> +	cpu0-supply = <&buck2_reg>;
> +};

The same.

Rest looks fine, so with the re-ordering:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof


> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> index b78ada7..cead3a7 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -30,6 +30,9 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a9";
>  			reg = <0xA00>;
> +			clocks = <&clock CLK_ARM_CLK>;
> +			clock-names = "cpu";
> +			operating-points-v2 = <&cpu0_opp_table>;
>  			cooling-min-level = <13>;
>  			cooling-max-level = <7>;
>  			#cooling-cells = <2>; /* min followed by max */
> @@ -39,18 +42,98 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a9";
>  			reg = <0xA01>;
> +			operating-points-v2 = <&cpu0_opp_table>;
>  		};
>  
>  		cpu@A02 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a9";
>  			reg = <0xA02>;
> +			operating-points-v2 = <&cpu0_opp_table>;
>  		};
>  
>  		cpu@A03 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a9";
>  			reg = <0xA03>;
> +			operating-points-v2 = <&cpu0_opp_table>;
> +		};
> +	};
> +
> +	cpu0_opp_table: opp_table0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp00 {
> +			opp-hz = <200000000>;
> +			opp-microvolt = <900000>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp01 {
> +			opp-hz = <300000000>;
> +			opp-microvolt = <900000>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp02 {
> +			opp-hz = <400000000>;
> +			opp-microvolt = <925000>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp03 {
> +			opp-hz = <500000000>;
> +			opp-microvolt = <950000>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp04 {
> +			opp-hz = <600000000>;
> +			opp-microvolt = <975000>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp05 {
> +			opp-hz = <700000000>;
> +			opp-microvolt = <987500>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp06 {
> +			opp-hz = <800000000>;
> +			opp-microvolt = <1000000>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp07 {
> +			opp-hz = <900000000>;
> +			opp-microvolt = <1037500>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp08 {
> +			opp-hz = <1000000000>;
> +			opp-microvolt = <1087500>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp09 {
> +			opp-hz = <1100000000>;
> +			opp-microvolt = <1137500>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp10 {
> +			opp-hz = <1200000000>;
> +			opp-microvolt = <1187500>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp11 {
> +			opp-hz = <1300000000>;
> +			opp-microvolt = <1250000>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp12 {
> +			opp-hz = <1400000000>;
> +			opp-microvolt = <1287500>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp13 {
> +			opp-hz = <1500000000>;
> +			opp-microvolt = <1350000>;
> +			clock-latency-ns = <200000>;
> +			turbo-mode;
>  		};
>  	};
>  
> 
