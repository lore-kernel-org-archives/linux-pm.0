From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 14/19] ARM: dts: Add bus nodes using VDD_INT for
 Exynos4x12
Date: Thu, 10 Dec 2015 14:57:44 +0900
Message-ID: <56691458.9000000@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
 <1449634091-1842-15-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1449634091-1842-15-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09.12.2015 13:08, Chanwoo Choi wrote:
> This patch adds the bus noes using VDD_INT for Exynos4x12 SoC.
> Exynos4x12 has the following AXI buses to translate data between
> DRAM and sub-blocks.
> 
> Following list specifies the detailed relation between DRAM and sub-blocks:
> - ACLK100 clock for PERIL/PERIR/MFC(PCLK)
> - ACLK160 clock for CAM/TV/LCD
> : The minimum clock of ACLK160 should be over 160MHz.
>   When drop the clock under 160MHz, show the broken image.
> - ACLK133 clock for FSYS
> - GDL clock for LEFTBUS
> - GDR clock for RIGHTBUS
> - SCLK_MFC clock for MFC
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4x12.dtsi | 112 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
> index 3bcf0939755e..8bc4aee156b5 100644
> --- a/arch/arm/boot/dts/exynos4x12.dtsi
> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
> @@ -354,6 +354,118 @@
>  			opp-microvolt = <950000>;
>  		};
>  	};
> +
> +	bus_leftbus: bus_leftbus {
> +		compatible = "samsung,exynos-bus";
> +		clocks = <&clock CLK_DIV_GDL>;
> +		clock-names = "bus";
> +		operating-points-v2 = <&bus_leftbus_opp_table>;
> +		status = "disabled";
> +	};
> +
> +	bus_rightbus: bus_rightbus {
> +		compatible = "samsung,exynos-bus";
> +		clocks = <&clock CLK_DIV_GDR>;
> +		clock-names = "bus";
> +		operating-points-v2 = <&bus_leftbus_opp_table>;
> +		status = "disabled";
> +	};

These two nodes are symmetrical. The MFC below and other buses in other
DTS share opps. How about changing the binding so multiple clocks could
be specified at once ("bus0", "bus1")? I think there is no need for a
bus device for each clock.

Best regards,
Krzysztof

> +
> +	bus_display: bus_display {
> +		compatible = "samsung,exynos-bus";
> +		clocks = <&clock CLK_ACLK160>;
> +		clock-names = "bus";
> +		operating-points-v2 = <&bus_display_opp_table>;
> +		status = "disabled";
> +	};
> +
> +	bus_fsys: bus_fsys {
> +		compatible = "samsung,exynos-bus";
> +		clocks = <&clock CLK_ACLK133>;
> +		clock-names = "bus";
> +		operating-points-v2 = <&bus_fsys_opp_table>;
> +		status = "disabled";
> +	};
> +
> +	bus_peri: bus_peri {
> +		compatible = "samsung,exynos-bus";
> +		clocks = <&clock CLK_ACLK100>;
> +		clock-names = "bus";
> +		operating-points-v2 = <&bus_peri_opp_table>;
> +		status = "disabled";
> +	};
> +
> +	bus_mfc: bus_mfc {
> +		compatible = "samsung,exynos-bus";
> +		clocks = <&clock CLK_SCLK_MFC>;
> +		clock-names = "bus";
> +		operating-points-v2 = <&bus_leftbus_opp_table>;
> +		status = "disabled";
> +	};
> +
> +	bus_leftbus_opp_table: opp_table3 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <100000000>;
> +			opp-microvolt = <900000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <134000000>;
> +			opp-microvolt = <925000>;
> +		};
> +		opp02 {
> +			opp-hz = /bits/ 64 <160000000>;
> +			opp-microvolt = <950000>;
> +		};
> +		opp03 {
> +			opp-hz = /bits/ 64 <200000000>;
> +			opp-microvolt = <1000000>;
> +		};
> +	};
> +
> +	bus_display_opp_table: opp_table4 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <160000000>;
> +			opp-microvolt = <950000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <200000000>;
> +			opp-microvolt = <1000000>;
> +		};
> +	};
> +
> +	bus_fsys_opp_table: opp_table5 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <100000000>;
> +			opp-microvolt = <900000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <134000000>;
> +			opp-microvolt = <925000>;
> +		};
> +	};
> +
> +	bus_peri_opp_table: opp_table6 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <50000000>;
> +			opp-microvolt = <900000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <100000000>;
> +			opp-microvolt = <925000>;
> +		};
> +	};
>  };
>  
>  &combiner {
> 
