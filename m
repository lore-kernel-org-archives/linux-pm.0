From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 2/5] ARM: dts: Exynos4x12: add CPU OPP and regulator
 supply property
Date: Sat, 1 Aug 2015 16:18:25 +0530
Message-ID: <20150801104825.GF899@linux>
References: <1438368557-2352-1-git-send-email-b.zolnierkie@samsung.com>
 <1438368557-2352-3-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438368557-2352-3-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Andreas Faerber <afaerber@suse.de>
List-Id: linux-pm@vger.kernel.org

On 31-07-15, 20:49, Bartlomiej Zolnierkiewicz wrote:
> For Exynos4x12 platforms, add CPU operating points (using
> opp-v2 bindings) and CPU regulator supply properties for
> migrating from Exynos specific cpufreq driver to using
> generic cpufreq driver.
> 
> Based on the earlier work by Thomas Abraham.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Andreas Faerber <afaerber@suse.de>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4212.dtsi               | 81 ++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi |  4 ++
>  arch/arm/boot/dts/exynos4412-origen.dts         |  4 ++
>  arch/arm/boot/dts/exynos4412-trats2.dts         |  4 ++
>  arch/arm/boot/dts/exynos4412.dtsi               | 83 +++++++++++++++++++++++++
>  5 files changed, 176 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
> index d9c8efee..5389011 100644
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
> +			opp-hz = /bits/ 64 <200000000>;
> +			opp-microvolt = <900000>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <300000000>;
> +			opp-microvolt = <900000>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp02 {
> +			opp-hz = /bits/ 64 <400000000>;
> +			opp-microvolt = <925000>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp03 {
> +			opp-hz = /bits/ 64 <500000000>;
> +			opp-microvolt = <950000>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp04 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt = <975000>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp05 {
> +			opp-hz = /bits/ 64 <700000000>;
> +			opp-microvolt = <987500>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp06 {
> +			opp-hz = /bits/ 64 <800000000>;
> +			opp-microvolt = <1000000>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp07 {
> +			opp-hz = /bits/ 64 <900000000>;
> +			opp-microvolt = <1037500>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp08 {
> +			opp-hz = /bits/ 64 <1000000000>;
> +			opp-microvolt = <1087500>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp09 {
> +			opp-hz = /bits/ 64 <1100000000>;
> +			opp-microvolt = <1137500>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp10 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt = <1187500>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp11 {
> +			opp-hz = /bits/ 64 <1300000000>;
> +			opp-microvolt = <1250000>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp12 {
> +			opp-hz = /bits/ 64 <1400000000>;
> +			opp-microvolt = <1287500>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp13 {
> +			opp-hz = /bits/ 64 <1500000000>;
> +			opp-microvolt = <1350000>;
> +			clock-latency-ns = <200000>;
> +			turbo-mode;
>  		};
>  	};
>  };

I'm lovin' it :)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
