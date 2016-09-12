From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v10 3/5] Documentation: bindings: add dt documentation
 for rk3399 dmc
Date: Mon, 12 Sep 2016 11:31:02 -0500
Message-ID: <20160912163102.GA17262@rob-hp-laptop>
References: <1473051971-5500-1-git-send-email-hl@rock-chips.com>
 <1473051971-5500-4-git-send-email-hl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1473051971-5500-4-git-send-email-hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tixy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, typ-TNX95d0MmH7DzftRWevZcw@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 05, 2016 at 01:06:09PM +0800, Lin Huang wrote:
> This patch adds the documentation for rockchip rk3399 dmc driver.
> 
> Signed-off-by: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> Reviewed-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
> Changes in v10:

And this is the first I see it?

> - add rockchip prefix in property describe
> 
> Changes in v9:
> - add ddr timing property to node
> 
> Changes in v8:
> - add ddr timing properties
> 
> Changes in v7:
> - None
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
>  .../devicetree/bindings/devfreq/rk3399_dmc.txt     | 202 +++++++++++++++++++++
>  1 file changed, 202 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> new file mode 100644
> index 0000000..84660a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> @@ -0,0 +1,210 @@
> +* Rockchip rk3399 DMC(Dynamic Memory Controller) device
> +
> +Required properties:
> +- compatible:		 Must be "rockchip,rk3399-dmc".
> +- devfreq-events:	 Node to get DDR loading, Refer to
> +			 Documentation/devicetree/bindings/devfreq/
> +			 rockchip-dfi.txt
> +- interrupts:		 The interrupt number to the CPU. The interrupt
> +			 specifier format depends on the interrupt controller.
> +			 It should be DCF interrupts, when DDR dvfs finish,
> +			 it will happen.
> +- clocks:		 Phandles for clock specified in "clock-names" property
> +- clock-names :		 The name of clock used by the DFI, must be
> +			 "pclk_ddr_mon";
> +- operating-points-v2:	 Refer to Documentation/devicetree/bindings/power/opp.txt
> +			 for details.
> +- center-supply:	 DMC supply node.
> +- status:		 Marks the node enabled/disabled.

No need to document this.

> +
> +Following properties are ddr timing:

This is a lot of properties. I would prefer to see SPD data embedded 
into DT if there are overlap in what SPD data defines for settings.

> +
> +- rockchip,dram_speed_bin :	  Value reference include/dt-bindings/clock/ddr.h,

Use '-', not '_' throughout.

> +				  it select ddr3 cl-trp-trcd type, default value
> +				  "DDR3_DEFAULT".it must selected according to
> +				  "Speed Bin" in ddr3 datasheet, DO NOT use
> +				  smaller "Speed Bin" than ddr3 exactly is.
> +
> +- rockchip,pd_idle :		  Config the PD_IDLE value, defined the power-down
> +				  idle period, memories are places into power-down
> +				  mode if bus is idle for PD_IDLE DFI clocks.
> +
> +- rockchip,sr_idle :		  Configure the SR_IDLE value, defined the
> +				  selfrefresh idle period, memories are places
> +				  into self-refresh mode if bus is idle for
> +				  SR_IDLE*1024 DFI clocks (DFI clocks freq is
> +				  half of dram's clocks), defaule value is "0".
> +
> +- rockchip,sr_mc_gate_idle :	  Defined the self-refresh with memory and
> +				  controller clock gating idle period, memories
> +				  are places into self-refresh mode and memory
> +				  controller clock arg gating if bus is idle for
> +				  sr_mc_gate_idle*1024 DFI clocks.
> +
> +- rockchip,srpd_lite_idle :	  Defined the self-refresh power down idle
> +				  period, memories are places into self-refresh
> +				  power down mode if bus is idle for
> +				  srpd_lite_idle*1024 DFI clocks. This parameter
> +				  is for LPDDR4 only.
> +
> +- rockchip,standby_idle :	  Defined the standby idle period, memories are
> +				  places into self-refresh than controller, pi,
> +				  phy and dram clock will gating if bus is idle
> +				  for standby_idle * DFI clocks.
> +
> +- rockchip,dram_dll_disb_freq :  It's defined the DDR3 dll bypass frequency in
> +				  MHz, when ddr freq less than DRAM_DLL_DISB_FREQ,
> +				  ddr3 dll will bypssed note: if dll was bypassed,
> +				  the odt also stop working.
> +
> +- rockchip,phy_dll_disb_freq :	  Defined the PHY dll bypass frequency in
> +				  MHz (Mega Hz), when ddr freq less than
> +				  DRAM_DLL_DISB_FREQ, phy dll will bypssed.
> +				  note: phy dll and phy odt are independent.
> +
> +- rockchip,ddr3_odt_disb_freq :  When dram type is DDR3, this parameter defined

Please group properties that are required and optional, and also group 
by common, DDR3 only, DDR4L only, etc.

> +				  the odt disable frequency in MHz (Mega Hz),
> +				  when ddr frequency less then ddr3_odt_disb_freq,
> +				  the odt on dram side and controller side are
> +				  both disabled.
> +
> +- rockchip,ddr3_drv :		  When dram type is DDR3, this parameter define
> +				  the dram side driver stength in ohm, default
> +				  value is DDR3_DS_40ohm.
> +
> +- rockchip,ddr3_odt :		  When dram type is DDR3, this parameter define
> +				  the dram side ODT stength in ohm, default value
> +				  is DDR3_ODT_120ohm.
> +
> +- rockchip,phy_ddr3_ca_drv :	  When dram type is DDR3, this parameter define
> +				  the phy side CA line(incluing command line,
> +				  address line and clock line) driver strength.
> +				  Default value is PHY_DRV_ODT_40.
> +
> +- rockchip,phy_ddr3_dq_drv :	  When dram type is DDR3, this parameter define
> +				  the phy side DQ line(incluing DQS/DQ/DM line)
> +				  driver strength. default value is PHY_DRV_ODT_40.

You have the same properties, but they just vary by DDR type. Make the 
property names common. 

> +
> +- rockchip,phy_ddr3_odt : 	  When dram type is DDR3, this parameter define the
> +				  phy side odt strength, default value is
> +				  PHY_DRV_ODT_240.
> +
> +- rockchip,lpddr3_odt_disb_freq : When dram type is LPDDR3, this parameter defined
> +				  then odt disable frequency in MHz (Mega Hz),
> +				  when ddr frequency less then ddr3_odt_disb_freq,
> +				  the odt on dram side and controller side are
> +				  both disabled.
> +
> +- rockchip,lpddr3_drv :	  When dram type is LPDDR3, this parameter define
> +				  the dram side driver stength in ohm, default
> +				  value is LP3_DS_34ohm.
> +
> +- rockchip,lpddr3_odt :	  When dram type is LPDDR3, this parameter define
> +				  the dram side ODT stength in ohm, default value
> +				  is LP3_ODT_240ohm.

Is this in ohms or a register value? Please make it in ohms and add a 
-ohms suffix.

> +Example:
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
> +		operating-points-v2 = <&dmc_opp_table>;
> +		center-supply = <&ppvar_centerlogic>;
> +		upthreshold = <15>;
> +		downdifferential = <10>;
> +		rockchip,ddr3_speed_bin = <21>;
> +		rockchip,pd_idle = <0x40>;
> +		rockchip,sr_idle = <0x2>;
> +		rockchip,sr_mc_gate_idle = <0x3>;
> +		rockchip,srpd_lite_idle	= <0x4>;
> +		rockchip,standby_idle = <0x2000>;
> +		rockchip,dram_dll_dis_freq = <300>;
> +		rockchip,phy_dll_dis_freq = <125>;
> +		rockchip,auto_pd_dis_freq = <666>;
> +		rockchip,ddr3_odt_dis_freq = <333>;
> +		rockchip,ddr3_drv = <DDR3_DS_40ohm>;
> +		rockchip,ddr3_odt = <DDR3_ODT_120ohm>;
> +		rockchip,phy_ddr3_ca_drv = <PHY_DRV_ODT_40>;
> +		rockchip,phy_ddr3_dq_drv = <PHY_DRV_ODT_40>;
> +		rockchip,phy_ddr3_odt = <PHY_DRV_ODT_240>;
> +		rockchip,lpddr3_odt_dis_freq = <333>;
> +		rockchip,lpddr3_drv = <LP3_DS_34ohm>;
> +		rockchip,lpddr3_odt = <LP3_ODT_240ohm>;
> +		rockchip,phy_lpddr3_ca_drv = <PHY_DRV_ODT_40>;
> +		rockchip,phy_lpddr3_dq_drv = <PHY_DRV_ODT_40>;
> +		rockchip,phy_lpddr3_odt = <PHY_DRV_ODT_240>;
> +		rockchip,lpddr4_odt_dis_freq = <333>;
> +		rockchip,lpddr4_drv = <LP4_PDDS_60ohm>;
> +		rockchip,lpddr4_dq_odt = <LP4_DQ_ODT_40ohm>;
> +		rockchip,lpddr4_ca_odt = <LP4_CA_ODT_40ohm>;
> +		rockchip,phy_lpddr4_ca_drv = <PHY_DRV_ODT_40>;
> +		rockchip,phy_lpddr4_ck_cs_drv = <PHY_DRV_ODT_80>;
> +		rockchip,phy_lpddr4_dq_drv = <PHY_DRV_ODT_80>;
> +		rockchip,phy_lpddr4_odt = <PHY_DRV_ODT_60>;

You have DDR3, LPDDR3 and LPDDR4 all populated at the same time? It 
should be one set at a time.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
