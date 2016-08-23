From: hl <hl@rock-chips.com>
Subject: Re: [PATCH v6 6/8] Documentation: bindings: add dt documentation for
 rk3399 dmc
Date: Wed, 24 Aug 2016 02:53:53 +0800
Message-ID: <57BC9BC1.2040100@rock-chips.com>
References: <1471386989-9541-1-git-send-email-hl@rock-chips.com>
 <CGME20160816223730epcas1p32cabad067157428ffee1a2f9c62d9798@epcas1p3.samsung.com>
 <1471386989-9541-7-git-send-email-hl@rock-chips.com>
 <57B3ED11.20003@samsung.com> <57BA2834.6090409@rock-chips.com>
 <57BBD9A7.7090603@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:34328 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752302AbcHWSyW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2016 14:54:22 -0400
In-Reply-To: <57BBD9A7.7090603@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, heiko@sntech.de, myungjoo.ham@samsung.com
Cc: tixy@linaro.org, mark.rutland@arm.com, dbasehore@chromium.org, linux-pm@vger.kernel.org, airlied@linux.ie, mturquette@baylibre.com, typ@rock-chips.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, dianders@chromium.org, linux-rockchip@lists.infradead.org, kyungmin.park@samsung.com, sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org, mark.yao@rock-chips.com

Hi Chanwoo Choi,


On 2016年08月23日 13:05, Chanwoo Choi wrote:
> Hi Lin,
>
> On 2016년 08월 22일 07:16, hl wrote:
>> Hi Chanwoo Choi,
>>
>> On 2016年08月17日 12:50, Chanwoo Choi wrote:
>>> Hi Lin,
>>>
>>> On 2016년 08월 17일 07:36, Lin Huang wrote:
>>>> This patch adds the documentation for rockchip rk3399 dmc driver.
>>>>
>>>> Signed-off-by: Lin Huang <hl@rock-chips.com>
>>>> ---
>>>> Changes in v6:
>>>> -Add more detail in Documentation
>>>>
>>>> Changes in v5:
>>>> -None
>>>>
>>>> Changes in v4:
>>>> -None
>>>>
>>>> Changes in v3:
>>>> -None
>>>>
>>>> Changes in v2:
>>>> -None
>>>>
>>>> Changes in v1:
>>>> -None
>>>>    .../devicetree/bindings/devfreq/rk3399_dmc.txt     | 84 ++++++++++++++++++++++
>>>>    1 file changed, 84 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
>>>> new file mode 100644
>>>> index 0000000..e73067c
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
>>>> @@ -0,0 +1,84 @@
>>>> +* Rockchip rk3399 DMC(Dynamic Memory Controller) device
>>>> +
>>>> +Required properties:
>>>> +- compatible: Must be "rockchip,rk3399-dmc".
>>>> +- devfreq-events: Node to get ddr loading, Refer to
>>>> +          Documentation/devicetree/bindings/devfreq/rockchip-dif.txt
>>>> +- interrupts: The interrupt number to the cpu. The interrupt specifier format
>>>> +          depends on the interrupt controller. it should be dcf interrupts,
>>>> +          when ddr dvfs finish, it will happen.
>>> If possible, you better to keep the indentation with other properties.
>>> s/it->It, dcf->DCF, ddr->DDR
>>>
>>>
>>>> +- clocks: Phandles for clock specified in "clock-names" property
>>>> +- clock-names : The name of clock used by the DFI, must be "pclk_ddr_mon";
>>>> +- operating-points-v2: Refer to Documentation/devicetree/bindings/power/opp.txt
>>>> +               for details.
>>> ditto.
>>>
>>>> +- center-supply: Dmc supply node.
>>> s/Dmc/DMC becaue DMC an abbreviation.
>>>
>>>> +- status: Marks the node enabled/disabled.
>>>> +
>>>> +Optional properties:
>>>> +- ddr_timing: ddr timing need to pass to arm trust firmware
>>>> +- upthreshold: the upthreshold to simpleondeamnd policy
>>>> +- downdifferential: The downdifferential to simpleondeamnd policy
>>>> +
>>>> +Example:
>>>> +    ddr_timing: ddr_timing {
>>>> +        compatible = "rockchip,ddr-timing";
>>> I can't find the 'rockchip,ddr-timing' driver on linux-next git repo (20160816).
>>> If ddr_timing includes the only properties for ddr_timing,
>>> I recommend you make the separate a .dtsi file including
>>> the ddr timing configuration. I add the reference and an example on below.
>>>
>>>> +        ddr3_speed_bin = <21>;
>>>> +        pd_idle = <0>;
>>>> +        sr_idle = <0>;
>>>> +        sr_mc_gate_idle = <0>;
>>>> +        srpd_lite_idle    = <0>;
>>>> +        standby_idle = <0>;
>>>> +        dram_dll_dis_freq = <300>;
>>>> +        phy_dll_dis_freq = <125>;
>>>> +
>>>> +        ddr3_odt_dis_freq = <333>;
>>>> +        ddr3_drv = <DDR3_DS_40ohm>;
>>>> +        ddr3_odt = <DDR3_ODT_120ohm>;
>>>> +        phy_ddr3_ca_drv = <PHY_DRV_ODT_40>;
>>>> +        phy_ddr3_dq_drv = <PHY_DRV_ODT_40>;
>>>> +        phy_ddr3_odt = <PHY_DRV_ODT_240>;
>>>> +
>>>> +        lpddr3_odt_dis_freq = <333>;
>>>> +        lpddr3_drv = <LP3_DS_34ohm>;
>>>> +        lpddr3_odt = <LP3_ODT_240ohm>;
>>>> +        phy_lpddr3_ca_drv = <PHY_DRV_ODT_40>;
>>>> +        phy_lpddr3_dq_drv = <PHY_DRV_ODT_40>;
>>>> +        phy_lpddr3_odt = <PHY_DRV_ODT_240>;
>>>> +
>>>> +        lpddr4_odt_dis_freq = <333>;
>>>> +        lpddr4_drv = <LP4_PDDS_60ohm>;
>>>> +        lpddr4_dq_odt = <LP4_DQ_ODT_40ohm>;
>>>> +        lpddr4_ca_odt = <LP4_CA_ODT_40ohm>;
>>>> +        phy_lpddr4_ca_drv = <PHY_DRV_ODT_40>;
>>>> +        phy_lpddr4_ck_cs_drv = <PHY_DRV_ODT_80>;
>>>> +        phy_lpddr4_dq_drv = <PHY_DRV_ODT_80>;
>>>> +        phy_lpddr4_odt = <PHY_DRV_ODT_60>;
>>>> +    };
>>>> +
>>>> +    dmc_opp_table: dmc_opp_table {
>>>> +        compatible = "operating-points-v2";
>>>> +
>>>> +        opp00 {
>>>> +            opp-hz = /bits/ 64 <300000000>;
>>>> +            opp-microvolt = <900000>;
>>>> +        };
>>>> +        opp01 {
>>>> +            opp-hz = /bits/ 64 <666000000>;
>>>> +            opp-microvolt = <900000>;
>>>> +        };
>>>> +    };
>>>> +
>>>> +    dmc: dmc {
>>>> +        compatible = "rockchip,rk3399-dmc";
>>>> +        devfreq-events = <&dfi>;
>>>> +        interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
>>>> +        clocks = <&cru SCLK_DDRCLK>;
>>>> +        clock-names = "dmc_clk";
>>>> +        ddr_timing = <&ddr_timing>;
>>> You can use the following '#include' instead of 'ddr_timing'
>>> because the ddr_timing is not a device driver. Instead,
>>> the rk3399-dmc must need the ddr timing configuration.
>>>
>>>          #include "rk3399-dmc-timing-conf.dtsi"
>>>
>>> You can refer the similar usage case[1].
>>> The *.conf.dtsi is used on exynos3250 tmu dt node[2].
>>>
>>> [1] arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
>>> [2] arch/arm/boot/dts/exynos3250.dtsi, 224 line.
>>>
>>>> +        operating-points-v2 = <&dmc_opp_table>;
>>>> +        center-supply = <&ppvar_centerlogic>;
>>>> +        upthreshold = <15>;
>>>> +        downdifferential = <10>;
>>>> +        status = "disabled";
>>>> +    };
>>>> +
>>>>
>>> For example,
>>> I think that you can add the following timing .dtsi file.
>>> - arch/arm/boot/dts/rk3399-dmc-timing-conf.dtsi
>>>
>>> /*
>>>    * Device tree sources for RK3399 DDR timing configuration
>>>    *
>>>    * Copyright (c) 2016 Lin Huang <hl@rock-chips.com>
>>>    *
>>>    * This program is free software; you can redistribute it and/or modify
>>>    * it under the terms of the GNU General Public License version 2 as
>>>    * published by the Free Software Foundation.
>>>    */
>>>
>>> rockchip,ddr3_speed_bin = <21>;
>>> rockchip,pd_idle = <0>;
>>> rockchip,sr_idle = <0>;
>>> rockchip,sr_mc_gate_idle = <0>;
>>> rockchip,srpd_lite_idle    = <0>;
>>> rockchip,standby_idle = <0>;
>>> rockchip,dram_dll_dis_freq = <300>;
>>> rockchip,phy_dll_dis_freq = <125>;
>>>
>>> rockchip,ddr3_odt_dis_freq = <333>;
>>> rockchip,ddr3_drv = <DDR3_DS_40ohm>;
>>> rockchip,ddr3_odt = <DDR3_ODT_120ohm>;
>>> rockchip,phy_ddr3_ca_drv = <PHY_DRV_ODT_40>;
>>> rockchip,phy_ddr3_dq_drv = <PHY_DRV_ODT_40>;
>>> rockchip,phy_ddr3_odt = <PHY_DRV_ODT_240>;
>>>
>>> rockchip,lpddr3_odt_dis_freq = <333>;
>>> rockchip,lpddr3_drv = <LP3_DS_34ohm>;
>>> rockchip,lpddr3_odt = <LP3_ODT_240ohm>;
>>> rockchip,phy_lpddr3_ca_drv = <PHY_DRV_ODT_40>;
>>> rockchip,phy_lpddr3_dq_drv = <PHY_DRV_ODT_40>;
>>> rockchip,phy_lpddr3_odt = <PHY_DRV_ODT_240>;
>>>
>>> rockchip,lpddr4_odt_dis_freq = <333>;
>>> rockchip,lpddr4_drv = <LP4_PDDS_60ohm>;
>>> rockchip,lpddr4_dq_odt = <LP4_DQ_ODT_40ohm>;
>>> rockchip,lpddr4_ca_odt = <LP4_CA_ODT_40ohm>;
>>> rockchip,phy_lpddr4_ca_drv = <PHY_DRV_ODT_40>;
>>> rockchip,phy_lpddr4_ck_cs_drv = <PHY_DRV_ODT_80>;
>>> rockchip,phy_lpddr4_dq_drv = <PHY_DRV_ODT_80>;
>>> rockchip,phy_lpddr4_odt = <PHY_DRV_ODT_60>;
>> Actually, i am doing like it on my downstream dtsi, but how to explain it in rk3399_dmc Documentation?
>> Creat a new ddr_timing Documentation? But it is not a driver, just a dtsi, that why i put it on rk3399_dmc.txt
>> now, do you have a better idea?
> I think that you don't need to add the new ddr_timing document.
>
> The ddr_timing value are only used in the rk3399_dmc.c driver.
> So, the description of ddr_timing information should be
> included in rk3399_dmc.txt.
>
> As I already mentioned, please refer the the similiar case[1][2].
> The exynos-thermal.txt[2] include the description of propertis[1].
>
> [1] arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
> [2] Documentation/devicetree/bindings/tmu/exynos-thermal.txt
Got it, will reference it next version, thanks.

-- 
Lin Huang


