From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v3 4/5] arm64: dts: rk3399: Add dfi and dmc nodes.
Date: Thu, 11 Apr 2019 15:20:53 +0200
Message-ID: <7786013.gjegOBUKu0@phil>
References: <20190321231440.19031-1-gael.portay@collabora.com> <20190321231440.19031-5-gael.portay@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321231440.19031-5-gael.portay@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Ga=EBl?= PORTAY <gael.portay@collabora.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lin Huang <hl@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Klaus Goger <klaus.goger@theobroma-systems.com>, Derek Basehore <dbasehore@chromium.org>, Randy Li <ayaka@soulik.info>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi Gaël,

Am Freitag, 22. März 2019, 00:14:39 CEST schrieb Gaël PORTAY:
> From: Lin Huang <hl@rock-chips.com>
> 
> These are required to support DDR DVFS on rk3399 platform. The patch also
> introduces a new file with default DRAM settings.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>

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

as Rob mentioned in his review, these values look board-specific,
so should probably move over to the specific board you're using them
on?


Heiko
