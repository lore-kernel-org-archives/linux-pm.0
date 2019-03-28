From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 4/5] arm64: dts: rk3399: Add dfi and dmc nodes.
Date: Thu, 28 Mar 2019 12:59:52 -0500
Message-ID: <20190328175952.GA21288@bogus>
References: <20190321231440.19031-1-gael.portay@collabora.com>
 <20190321231440.19031-5-gael.portay@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190321231440.19031-5-gael.portay@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Ga=EBl?= PORTAY <gael.portay@collabora.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lin Huang <hl@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Klaus Goger <klaus.goger@theobroma-systems.com>, Derek Basehore <dbasehore@chromium.org>, Randy Li <ayaka@soulik.info>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 21, 2019 at 07:14:39PM -0400, Gaël PORTAY wrote:
> From: Lin Huang <hl@rock-chips.com>
> 
> These are required to support DDR DVFS on rk3399 platform. The patch also
> introduces a new file with default DRAM settings.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
> ---
> 
> Changes in v3: None
> 
> Changes in v2:
> - [PATCH 7/8] Reword the commit message to reflect the removal of
>               rk3390-dram-default-timing.dts in v1.
> 
> Changes in v1:
> - [RFC 8/10] Move rk3399-dram.h to dt-includes.
> - [RFC 8/10] Put sdram default values under the dmc node.
> - [RFC 8/10] Removed rk3399-dram-default-timing.dts
> 
>  .../boot/dts/rockchip/rk3399-op1-opp.dtsi     | 29 ++++++++
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi      | 49 +++++++++++++
>  include/dt-bindings/power/rk3399-dram.h       | 73 +++++++++++++++++++
>  3 files changed, 151 insertions(+)
>  create mode 100644 include/dt-bindings/power/rk3399-dram.h
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
> index 69cc9b05baa5..c9e7032b01a8 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
> @@ -110,6 +110,31 @@
>  			opp-microvolt = <1075000>;
>  		};
>  	};
> +
> +	dmc_opp_table: dmc_opp_table {
> +		compatible = "operating-points-v2";
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <200000000>;
> +			opp-microvolt = <900000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <400000000>;
> +			opp-microvolt = <900000>;
> +		};
> +		opp02 {
> +			opp-hz = /bits/ 64 <666000000>;
> +			opp-microvolt = <900000>;
> +		};
> +		opp03 {
> +			opp-hz = /bits/ 64 <800000000>;
> +			opp-microvolt = <900000>;
> +		};
> +		opp04 {
> +			opp-hz = /bits/ 64 <928000000>;
> +			opp-microvolt = <900000>;
> +		};
> +	};
>  };
>  
>  &cpu_l0 {
> @@ -139,3 +164,7 @@
>  &gpu {
>  	operating-points-v2 = <&gpu_opp_table>;
>  };
> +
> +&dmc {
> +	operating-points-v2 = <&dmc_opp_table>;
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index db9d948c0b03..8fe86a3e7658 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/power/rk3399-dram.h>
>  #include <dt-bindings/power/rk3399-power.h>
>  #include <dt-bindings/thermal/thermal.h>
>  
> @@ -1885,6 +1886,54 @@
>  		status = "disabled";
>  	};
>  
> +	dfi: dfi@ff630000 {
> +		reg = <0x00 0xff630000 0x00 0x4000>;
> +		compatible = "rockchip,rk3399-dfi";
> +		rockchip,pmu = <&pmugrf>;
> +		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks = <&cru PCLK_DDR_MON>;
> +		clock-names = "pclk_ddr_mon";
> +		status = "disabled";
> +	};
> +
> +	dmc: dmc {
> +		compatible = "rockchip,rk3399-dmc";
> +		rockchip,pmu = <&pmugrf>;
> +		devfreq-events = <&dfi>;
> +		clocks = <&cru SCLK_DDRC>;
> +		clock-names = "dmc_clk";
> +		status = "disabled";
> +		rockchip,ddr3_speed_bin = <21>;
> +		rockchip,pd_idle = <0x40>;
> +		rockchip,sr_idle = <0x2>;
> +		rockchip,sr_mc_gate_idle = <0x3>;
> +		rockchip,srpd_lite_idle	= <0x4>;
> +		rockchip,standby_idle = <0x2000>;
> +		rockchip,dram_dll_dis_freq = <300000000>;
> +		rockchip,phy_dll_dis_freq = <125000000>;
> +		rockchip,auto_pd_dis_freq = <666000000>;
> +		rockchip,ddr3_odt_dis_freq = <333000000>;
> +		rockchip,ddr3_drv = <DDR3_DS_40ohm>;
> +		rockchip,ddr3_odt = <DDR3_ODT_120ohm>;
> +		rockchip,phy_ddr3_ca_drv = <PHY_DRV_ODT_40>;
> +		rockchip,phy_ddr3_dq_drv = <PHY_DRV_ODT_40>;
> +		rockchip,phy_ddr3_odt = <PHY_DRV_ODT_240>;
> +		rockchip,lpddr3_odt_dis_freq = <333000000>;
> +		rockchip,lpddr3_drv = <LP3_DS_34ohm>;
> +		rockchip,lpddr3_odt = <LP3_ODT_240ohm>;
> +		rockchip,phy_lpddr3_ca_drv = <PHY_DRV_ODT_40>;
> +		rockchip,phy_lpddr3_dq_drv = <PHY_DRV_ODT_40>;
> +		rockchip,phy_lpddr3_odt = <PHY_DRV_ODT_240>;
> +		rockchip,lpddr4_odt_dis_freq = <333000000>;
> +		rockchip,lpddr4_drv = <LP4_PDDS_60ohm>;
> +		rockchip,lpddr4_dq_odt = <LP4_DQ_ODT_40ohm>;
> +		rockchip,lpddr4_ca_odt = <LP4_CA_ODT_40ohm>;
> +		rockchip,phy_lpddr4_ca_drv = <PHY_DRV_ODT_40>;
> +		rockchip,phy_lpddr4_ck_cs_drv = <PHY_DRV_ODT_80>;
> +		rockchip,phy_lpddr4_dq_drv = <PHY_DRV_ODT_80>;
> +		rockchip,phy_lpddr4_odt = <PHY_DRV_ODT_60>;

These settings aren't board specific?

Rob
