From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 5/5] arm64: dts: rockchip: Enable dmc and dfi nodes on
 gru.
Date: Fri, 26 Apr 2019 13:45:59 -0500
Message-ID: <20190426184559.GA29242@bogus>
References: <20190415212948.7736-1-gael.portay@collabora.com>
 <20190415212948.7736-6-gael.portay@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190415212948.7736-6-gael.portay@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Ga=EBl?= PORTAY <gael.portay@collabora.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lin Huang <hl@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Klaus Goger <klaus.goger@theobroma-systems.com>, Derek Basehore <dbasehore@chromium.org>, Randy Li <ayaka@soulik.info>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 15, 2019 at 05:29:48PM -0400, Gaël PORTAY wrote:
> From: Lin Huang <hl@rock-chips.com>
> 
> Enable the DMC (Dynamic Memory Controller) and the DFI (DDR PHY
> Interface) nodes on gru boards so we can support DDR DVFS.
> 
> The patch also introduces a new file with default DRAM settings.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
> ---
> 
> Changes in v4:
> - [PATCH v3 5/5] Add board related DDR settings (moved from 4/5).
> 
> Changes in v3:
> - [PATCH v2 5/5] Remove display_subsystem nodes.
> 
> Changes in v2:
> - [PATCH 8/8] Move center-supply attribute of dmc node in file
>               rk3399-gru-chromebook.dtsi (where ppvar_centerlogic is
> 	      defined).
> 
> Changes in v1: None
> 
>  .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  4 +
>  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 46 ++++++++++++
>  .../boot/dts/rockchip/rk3399-op1-opp.dtsi     | 29 ++++++++
>  include/dt-bindings/power/rk3399-dram.h       | 73 +++++++++++++++++++
>  4 files changed, 152 insertions(+)
>  create mode 100644 include/dt-bindings/power/rk3399-dram.h
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> index 931640e9aed4..cfb81356c61e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> @@ -400,3 +400,7 @@ ap_i2c_tp: &i2c5 {
>  		rockchip,pins = <0 8 RK_FUNC_GPIO &pcfg_pull_none>;
>  	};
>  };
> +
> +&dmc {
> +	center-supply = <&ppvar_centerlogic>;
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> index da03fa9c5662..40e78186560b 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/power/rk3399-dram.h>
>  #include "rk3399.dtsi"
>  #include "rk3399-op1-opp.dtsi"
>  
> @@ -289,6 +290,12 @@
>  	status = "okay";
>  };
>  
> +&dmc_opp_table {
> +	opp04 {
> +		opp-suspend;
> +	};
> +};
> +
>  /*
>   * Set some suspend operating points to avoid OVP in suspend
>   *
> @@ -489,6 +496,45 @@ ap_i2c_audio: &i2c8 {
>  	status = "okay";
>  };
>  
> +&dfi {
> +	status = "okay";
> +};
> +
> +&dmc {
> +	status = "okay";
> +	upthreshold = <25>;
> +	downdifferential = <15>;
> +	rockchip,ddr3_speed_bin = <21>;
> +	rockchip,pd_idle = <0x40>;
> +	rockchip,sr_idle = <0x2>;
> +	rockchip,sr_mc_gate_idle = <0x3>;
> +	rockchip,srpd_lite_idle	= <0x4>;
> +	rockchip,standby_idle = <0x2000>;
> +	rockchip,dram_dll_dis_freq = <300000000>;
> +	rockchip,phy_dll_dis_freq = <125000000>;
> +	rockchip,auto_pd_dis_freq = <666000000>;
> +	rockchip,ddr3_odt_dis_freq = <333000000>;
> +	rockchip,ddr3_drv = <DDR3_DS_40ohm>;
> +	rockchip,ddr3_odt = <DDR3_ODT_120ohm>;
> +	rockchip,phy_ddr3_ca_drv = <PHY_DRV_ODT_40>;
> +	rockchip,phy_ddr3_dq_drv = <PHY_DRV_ODT_40>;
> +	rockchip,phy_ddr3_odt = <PHY_DRV_ODT_240>;
> +	rockchip,lpddr3_odt_dis_freq = <333000000>;
> +	rockchip,lpddr3_drv = <LP3_DS_34ohm>;
> +	rockchip,lpddr3_odt = <LP3_ODT_240ohm>;
> +	rockchip,phy_lpddr3_ca_drv = <PHY_DRV_ODT_40>;
> +	rockchip,phy_lpddr3_dq_drv = <PHY_DRV_ODT_40>;
> +	rockchip,phy_lpddr3_odt = <PHY_DRV_ODT_240>;
> +	rockchip,lpddr4_odt_dis_freq = <333000000>;
> +	rockchip,lpddr4_drv = <LP4_PDDS_60ohm>;
> +	rockchip,lpddr4_dq_odt = <LP4_DQ_ODT_40ohm>;
> +	rockchip,lpddr4_ca_odt = <LP4_CA_ODT_40ohm>;
> +	rockchip,phy_lpddr4_ca_drv = <PHY_DRV_ODT_40>;
> +	rockchip,phy_lpddr4_ck_cs_drv = <PHY_DRV_ODT_80>;
> +	rockchip,phy_lpddr4_dq_drv = <PHY_DRV_ODT_80>;
> +	rockchip,phy_lpddr4_odt = <PHY_DRV_ODT_60>;
> +};
> +
>  &sdhci {
>  	/*
>  	 * Signal integrity isn't great at 200 MHz and 150 MHz (DDR) gives the
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
> diff --git a/include/dt-bindings/power/rk3399-dram.h b/include/dt-bindings/power/rk3399-dram.h
> new file mode 100644
> index 000000000000..4b3d4a79923b
> --- /dev/null
> +++ b/include/dt-bindings/power/rk3399-dram.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR X11) */
> +/*
> + * Copyright (c) 2016-2018, Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * Author: Lin Huang <hl@rock-chips.com>
> + */
> +
> +#ifndef _DTS_DRAM_ROCKCHIP_RK3399_H
> +#define _DTS_DRAM_ROCKCHIP_RK3399_H
> +
> +#define DDR3_DS_34ohm		34
> +#define DDR3_DS_40ohm		40
> +
> +#define DDR3_ODT_DIS		0
> +#define DDR3_ODT_40ohm		40
> +#define DDR3_ODT_60ohm		60
> +#define DDR3_ODT_120ohm		120

I don't think these defines add much value given the value is in the 
define itself.

Do these get used by the driver? If not, then the header can go with the 
dts file. But I'd just get rid of the header.

Rob
