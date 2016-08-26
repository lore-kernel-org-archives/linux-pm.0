From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v7 6/8] Documentation: bindings: add dt documentation for
 rk3399 dmc
Date: Fri, 26 Aug 2016 14:09:04 -0700
Message-ID: <20160826210901.GA22369@localhost>
References: <1471836984-6316-1-git-send-email-hl@rock-chips.com>
 <1471836984-6316-7-git-send-email-hl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1471836984-6316-7-git-send-email-hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tixy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, typ-TNX95d0MmH7DzftRWevZcw@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

+ devicetree list

You should be including devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org on all binding
documents. And as Chanwoo Choi already mentioned, you didn't fix his
comments from v6:

https://lkml.org/lkml/2016/8/16/913

On Mon, Aug 22, 2016 at 11:36:22AM +0800, Lin Huang wrote:
> This patch adds the documentation for rockchip rk3399 dmc driver.
> 
> Signed-off-by: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> Changes in v7:
> -None
> 
> Changes in v6:
> -Add more detail in Documentation
> 
> Changes in v5:
> -None
> 
> Changes in v4:
> -None
> 
> Changes in v3:
> -None
> 
> Changes in v2:
> -None 
> 
> Changes in v1:
> -None
>  .../devicetree/bindings/devfreq/rk3399_dmc.txt     | 85 ++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> new file mode 100644
> index 0000000..b787abb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> @@ -0,0 +1,85 @@
> +* Rockchip rk3399 DMC(Dynamic Memory Controller) device
> +
> +Required properties:
> +- compatible: Must be "rockchip,rk3399-dmc".
> +- devfreq-events: Node to get DDR loading, Refer to
> +		  Documentation/devicetree/bindings/devfreq/rockchip-dfi.txt
> +- interrupts: The interrupt number to the CPU. The interrupt specifier format
> +	      depends on the interrupt controller. It should be DCF interrupts,
> +	      when DDR dvfs finish, it will happen.
> +- clocks: Phandles for clock specified in "clock-names" property
> +- clock-names : The name of clock used by the DFI, must be "pclk_ddr_mon";
> +- operating-points-v2: Refer to Documentation/devicetree/bindings/power/opp.txt
> +		       for details.
> +- center-supply: DMC supply node.
> +- status: Marks the node enabled/disabled.
> +
> +Optional properties:
> +- ddr_timing:  DDR timing need to pass to arm trust firmware

I believe it's "ARM Trusted Firmware", not "arm trust firmware".

> +- upthreshold: The upthreshold to simpleondeamnd policy
> +- downdifferential: The downdifferential to simpleondeamnd policy
> +
> +Example:
> +
> +	ddr_timing: ddr_timing {
> +		compatible = "rockchip,ddr-timing";
> +		ddr3_speed_bin = <21>;
> +		pd_idle = <0>;
> +		sr_idle = <0>;
> +		sr_mc_gate_idle = <0>;
> +		srpd_lite_idle  = <0>;
> +		standby_idle = <0>;
> +		dram_dll_dis_freq = <300>;
> +		phy_dll_dis_freq = <125>;
> +
> +		ddr3_odt_dis_freq = <333>;
> +		ddr3_drv = <DDR3_DS_40ohm>;
> +		ddr3_odt = <DDR3_ODT_120ohm>;
> +		phy_ddr3_ca_drv = <PHY_DRV_ODT_40>;
> +		phy_ddr3_dq_drv = <PHY_DRV_ODT_40>;
> +		phy_ddr3_odt = <PHY_DRV_ODT_240>;
> +
> +		lpddr3_odt_dis_freq = <333>;
> +		lpddr3_drv = <LP3_DS_34ohm>;
> +		lpddr3_odt = <LP3_ODT_240ohm>;
> +		phy_lpddr3_ca_drv = <PHY_DRV_ODT_40>;
> +		phy_lpddr3_dq_drv = <PHY_DRV_ODT_40>;
> +		phy_lpddr3_odt = <PHY_DRV_ODT_240>;
> +
> +		lpddr4_odt_dis_freq = <333>;
> +		lpddr4_drv = <LP4_PDDS_60ohm>;
> +		lpddr4_dq_odt = <LP4_DQ_ODT_40ohm>;
> +		lpddr4_ca_odt = <LP4_CA_ODT_40ohm>;
> +		phy_lpddr4_ca_drv = <PHY_DRV_ODT_40>;
> +		phy_lpddr4_ck_cs_drv = <PHY_DRV_ODT_80>;
> +		phy_lpddr4_dq_drv = <PHY_DRV_ODT_80>;
> +		phy_lpddr4_odt = <PHY_DRV_ODT_60>;
> +	};

Chanwoo suggested this ddr_timing node get moved to be direct properties
instead the dmc node. You also need to document them all in this file.

Also typically, you add "rockchip," prefixes to custom properties like
these.

Brian

> +
> +	dmc_opp_table: dmc_opp_table {
> +		compatible = "operating-points-v2";
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <300000000>;
> +			opp-microvolt = <900000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <666000000>;
> +			opp-microvolt = <900000>;
> +		};
> +	};
> +
> +	dmc: dmc {
> +		compatible = "rockchip,rk3399-dmc";
> +		devfreq-events = <&dfi>;
> +		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru SCLK_DDRCLK>;
> +		clock-names = "dmc_clk";
> +		ddr_timing = <&ddr_timing>;
> +		operating-points-v2 = <&dmc_opp_table>;
> +		center-supply = <&ppvar_centerlogic>;
> +		upthreshold = <15>;
> +		downdifferential = <10>;
> +		status = "disabled";
> +	};
> +
> -- 
> 2.6.6
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
