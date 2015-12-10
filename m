From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 12/19] ARM: dts: Add bus nodes using VDD_INT for
 Exynos3250
Date: Thu, 10 Dec 2015 11:09:27 +0900
Message-ID: <5668DED7.3020403@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
 <1449634091-1842-13-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1449634091-1842-13-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09.12.2015 13:08, Chanwoo Choi wrote:
> This patch adds the bus nodes using VDD_INT for Exynos3250 SoC.
> Exynos3250 has following AXI buses to translate data between
> DRAM and sub-blocks.
> 
> Following list specifies the detailed relation between DRAM and sub-blocks:
> - ACLK400 clock for MCUISP
> - ACLK266 clock for ISP
> - ACLK200 clock for FSYS
> - ACLK160 clock for LCD0
> - ACLK100 clock for PERIL
> - GDL clock for LEFTBUS
> - GDR clock for RIGHTBUS
> - SCLK_MFC clock for MFC
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi | 160 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 160 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> index 7214c5e42150..46dee1951ec1 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -721,6 +721,166 @@
>  				opp-microvolt = <875000>;
>  			};
>  		};
> +
> +		bus_leftbus: bus_leftbus {
> +			compatible = "samsung,exynos-bus";
> +			clocks = <&cmu CLK_DIV_GDL>;
> +			clock-names = "bus";
> +			operating-points-v2 = <&bus_leftbus_opp_table>;
> +			status = "disabled";
> +		};
> +
> +		bus_rightbus: bus_rightbus {
> +			compatible = "samsung,exynos-bus";
> +			clocks = <&cmu CLK_DIV_GDR>;
> +			clock-names = "bus";
> +			operating-points-v2 = <&bus_leftbus_opp_table>;
> +			status = "disabled";
> +		};
> +
> +		bus_lcd0: bus_lcd0 {
> +			compatible = "samsung,exynos-bus";
> +			clocks = <&cmu CLK_DIV_ACLK_160>;
> +			clock-names = "bus";
> +			operating-points-v2 = <&bus_leftbus_opp_table>;
> +			status = "disabled";
> +		};
> +
> +		bus_fsys: bus_fsys {
> +			compatible = "samsung,exynos-bus";
> +			clocks = <&cmu CLK_DIV_ACLK_200>;
> +			clock-names = "bus";
> +			operating-points-v2 = <&bus_leftbus_opp_table>;
> +			status = "disabled";
> +		};
> +
> +		bus_mcuisp: bus_mcuisp {
> +			compatible = "samsung,exynos-bus";
> +			clocks = <&cmu CLK_DIV_ACLK_400_MCUISP>;
> +			clock-names = "bus";
> +			operating-points-v2 = <&bus_mcuisp_opp_table>;
> +			status = "disabled";
> +		};
> +
> +		bus_isp: bus_isp {
> +			compatible = "samsung,exynos-bus";
> +			clocks = <&cmu CLK_DIV_ACLK_266>;
> +			clock-names = "bus";
> +			operating-points-v2 = <&bus_isp_opp_table>;
> +			status = "disabled";
> +		};
> +
> +		bus_peril: bus_peril {
> +			compatible = "samsung,exynos-bus";
> +			clocks = <&cmu CLK_DIV_ACLK_100>;
> +			clock-names = "bus";
> +			operating-points-v2 = <&bus_peril_opp_table>;
> +			status = "disabled";
> +		};
> +
> +		bus_mfc: bus_mfc {
> +			compatible = "samsung,exynos-bus";
> +			clocks = <&cmu CLK_SCLK_MFC>;
> +			clock-names = "bus";
> +			operating-points-v2 = <&bus_leftbus_opp_table>;
> +			status = "disabled";
> +		};
> +
> +		bus_leftbus_opp_table: opp_table2 {
> +			compatible = "operating-points-v2";
> +			opp-shared;
> +
> +			opp00 {
> +				opp-hz = /bits/ 64 <50000000>;
> +				opp-microvolt = <900000>;
> +			};
> +			opp01 {
> +				opp-hz = /bits/ 64 <80000000>;
> +				opp-microvolt = <900000>;
> +			};
> +			opp02 {
> +				opp-hz = /bits/ 64 <100000000>;
> +				opp-microvolt = <1000000>;
> +			};
> +			opp03 {
> +				opp-hz = /bits/ 64 <134000000>;
> +				opp-microvolt = <1000000>;
> +			};
> +			opp04 {
> +				opp-hz = /bits/ 64 <200000000>;
> +				opp-microvolt = <1000000>;
> +			};
> +		};
> +
> +		bus_mcuisp_opp_table: opp_table3 {
> +			compatible = "operating-points-v2";
> +			opp-shared;
> +
> +			opp00 {
> +				opp-hz = /bits/ 64 <50000000>;
> +				opp-microvolt = <900000>;

The voltages for all these INT-block tables have exactly the same value
which of course makes sense because this is the same regulator. However
the opp-microvolt property is an optional property. Do you have to
provide it in each OPP?

Best regards,
Krzysztof
