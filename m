From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v5 4/8] dt-bindings: devfreq: add Exynos5422 DMC device
 description
Date: Wed, 6 Mar 2019 16:50:28 +0900
Message-ID: <07aa779e-1752-0eb2-8fcd-a3d223c952b1@samsung.com>
References: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190305101926eucas1p2eee36b9cb50cbcf511fab7bae59e24bb@eucas1p2.samsung.com>
        <1551781151-5562-5-git-send-email-l.luba@partner.samsung.com>
        <3f413631-1a6f-61f7-58aa-38df3e2ffea4@samsung.com>
        <1800b874-75c3-420d-71df-9b9a8e7ad1c8@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1800b874-75c3-420d-71df-9b9a8e7ad1c8@partner.samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

On 19. 3. 6. 오후 4:14, Lukasz Luba wrote:
> Hi Chanwoo,
> 
> On 3/6/19 5:18 AM, Chanwoo Choi wrote:
>> Hi Lukasz,
>>
>> On 19. 3. 5. 오후 7:19, Lukasz Luba wrote:
>>> The patch adds description for DT binding for a new Exynos5422 Dynamic
>>> Memory Controller device.
>>>
>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>> ---
>>>   .../devicetree/bindings/devfreq/exynos5422-dmc.txt | 177 +++++++++++++++++++++
>>>   1 file changed, 177 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt b/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
>>> new file mode 100644
>>> index 0000000..0e73e98
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
>>> @@ -0,0 +1,177 @@
>>> +* Exynos5422 frequency and voltage scaling for Dynamic Memory Controller device
>>> +
>>> +The Samsung Exynos5422 SoC has DMC (Dynamic Memory Controller) to which the DRAM
>>> +memory chips are connected. The driver is to monitor the controller in runtime
>>> +and switch frequency and voltage. To monitor the usage of the controller in
>>> +runtime, the driver uses the PPMU (Platform Performance Monitoring Unit), which
>>> +is able to measure the current load of the memory.
>>> +When 'userspace' governor is used for the driver, an application is able to
>>> +switch the DMC frequency.
>>> +
>>> +Required properties for DMC device for Exynos5422:
>>> +- compatible: Should be "samsung,exynos5422-bus".
>>> +- clock-names : the name of clock used by the bus, "bus".
>>> +- clocks : phandles for clock specified in "clock-names" property.
>>> +- devfreq-events : phandles for PPMU devices connected to this DMC.
>>
>>
>> I already replied with following comments on v4 patch[1].
>> But, you didn't reply anything. We can reduce the duplicate
>> review by keeping the basic review rule.
> I have lost these changes while I was adding the OPPs, timings into the
> dt-binding.
>>
>> - Re: [PATCH v4 5/8] dt-bindings: devfreq: add Exynos5422 DMC device description
>> [1] https://do-db2.lkml.org/lkml/2019/2/3/64
>>
>>
>> [Following comments were replied on v4 patch[1]]
>>
>>> +- compatible: Should be "samsung,exynos5422-bus".
>>
>> The compatible name is wrong.
>> - exynos5422-bus -> exynos5422-dmc
>>
>>> +- clock-names : the name of clock used by the bus, "bus".
>>
>> 'bus' is right?
> right

As I knew, the clocks of exynos5422-dmc is for DMC.
Why do you think 'bus' is right insted of DMC?.
I think that it is not a 'bus' driver.

>>
>>> +- clocks : phandles for clock specified in "clock-names" property.
>>> +- devfreq-events : phandles for PPMU devices connected to this DMC.
>>
>> The dt-binging file doesn't contain the any description for 'reg' properties.
> There are 3 regs: cdrex0, cdrex1, chip_id. I will add this description.
> 
> The patch set has this OPPs and timings coming from DT as you requested
> but I am not sure if it is in the right place in the DT.
> Thus dt-binding you may consider as 'in-progress' till the DT entries
> are fixed
> 
> Regards,
> Lukasz
>>
>>
>>
>>> +
>>> +The example definition of a DMC and PPMU devices declared in DT is shown below:
>>> +
>>> +	ppmu_dmc0_0: ppmu@10d00000 {
>>> +		compatible = "samsung,exynos-ppmu";
>>> +		reg = <0x10d00000 0x2000>;
>>> +		clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
>>> +		clock-names = "ppmu";
>>> +		status = "okay";
>>> +		events {
>>> +			ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
>>> +				event-name = "ppmu-event3-dmc0_0";
>>> +			};
>>> +		};
>>> +	};
>>> +
>>> +
>>> +	ppmu_dmc0_1: ppmu@10d10000 {
>>> +		compatible = "samsung,exynos-ppmu";
>>> +		reg = <0x10d10000 0x2000>;
>>> +		clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
>>> +		clock-names = "ppmu";
>>> +		status = "okay";
>>> +		events {
>>> +			ppmu_event_dmc0_1: ppmu-event3-dmc0_1 {
>>> +				event-name = "ppmu-event3-dmc0_1";
>>> +			};
>>> +		};
>>> +	};
>>> +
>>> +	ppmu_dmc1_0: ppmu@10d10000 {
>>> +		compatible = "samsung,exynos-ppmu";
>>> +		reg = <0x10d60000 0x2000>;
>>> +		clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
>>> +		clock-names = "ppmu";
>>> +		status = "okay";
>>> +		events {
>>> +			ppmu_event_dmc1_0: ppmu-event3-dmc1_0 {
>>> +				event-name = "ppmu-event3-dmc1_0";
>>> +			};
>>> +		};
>>> +	};
>>> +
>>> +	ppmu_dmc1_1: ppmu@10d70000 {
>>> +		compatible = "samsung,exynos-ppmu";
>>> +		reg = <0x10d70000 0x2000>;
>>> +		clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
>>> +		clock-names = "ppmu";
>>> +		status = "okay";
>>> +		events {
>>> +			ppmu_event_dmc1_1: ppmu-event3-dmc1_1 {
>>> +				event-name = "ppmu-event3-dmc1_1";
>>> +			};
>>> +		};
>>> +	};
>>> +
>>> +	dmc: memory-controller@10c20000 {
>>> +		compatible = "samsung,exynos5422-dmc";
>>> +		reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
>>> +			<0x10000000 0x1000>;
>>> +		clocks = 	<&clock CLK_FOUT_SPLL>,
>>> +				<&clock CLK_MOUT_SCLK_SPLL>,
>>> +				<&clock CLK_FF_DOUT_SPLL2>,
>>> +				<&clock CLK_FOUT_BPLL>,
>>> +				<&clock CLK_MOUT_BPLL>,
>>> +				<&clock CLK_SCLK_BPLL>,
>>> +				<&clock CLK_MOUT_MX_MSPLL_CCORE>,
>>> +				<&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
>>> +				<&clock CLK_MOUT_MCLK_CDREX>,
>>> +				<&clock CLK_DOUT_CLK2X_PHY0>,
>>> +				<&clock CLK_CLKM_PHY0>,
>>> +				<&clock CLK_CLKM_PHY1>,
>>> +				<&clock CLK_CDREX_PAUSE>,
>>> +				<&clock CLK_CDREX_TIMING_SET>;
>>> +		clock-names =	"fout_spll",
>>> +				"mout_sclk_spll",
>>> +				"ff_dout_spll2",
>>> +				"fout_bpll",
>>> +				"mout_bpll",
>>> +				"sclk_bpll",
>>> +				"mout_mx_mspll_ccore",
>>> +				"mout_mx_mspll_ccore_phy",
>>> +				"mout_mclk_cdrex",
>>> +				"dout_clk2x_phy0",
>>> +				"clkm_phy0",
>>> +			        "clkm_phy1",
>>> +			        "clk_cdrex_pause",
>>> +			        "clk_cdrex_timing_set";
>>> +		status = "okay";
>>> +		operating-points-v2 = <&dmc_opp_table>;
>>> +		devfreq-events = <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
>>> +				<&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
>>> +	};
>>> +
>>> +The needed timings of DRAM memory are stored in dedicated nodes.
>>> +There are two nodes with regular timings and for bypass mode.
>>> +
>>> +	dmc_bypass_mode: bypass_mode {
>>> +		compatible = "samsung,dmc-bypass-mode";
>>> +
>>> +		freq-hz = <400000000>;
>>> +		volt-uv = <887500>;
>>> +		dram-timing-row = <0x365a9713>;
>>> +		dram-timing-data = <0x4740085e>;
>>> +		dram-timing-power = <0x543a0446>;
>>> +	};
>>> +
>>> +	dram_timing: timing {
>>> +		compatible = "samsung,dram-timing";
>>> +
>>> +		dram-timing-names = "165MHz", "206MHz", "275MHz", "413MHz",
>>> +				    "543MHz", "633MHz", "728MHz", "825MHz";
>>> +		dram-timing-row = <0x11223185>, <0x112331C6>, <0x12244287>,
>>> +				  <0x1B35538A>, <0x244764CD>, <0x2A48758F>,
>>> +				  <0x30598651>, <0x365A9713>;
>>> +		dram-timing-data = <0x2720085E>, <0x2720085E>, <0x2720085E>,
>>> +				   <0x2720085E>, <0x3730085E>, <0x3730085E>,
>>> +				   <0x3730085E>, <0x4740085E>;
>>> +		dram-timing-power = <0x140C0225>, <0x180F0225>, <0x1C140225>,
>>> +				    <0x2C1D0225>, <0x38270335>, <0x402D0335>,
>>> +				    <0x4C330336>, <0x543A0446>;
>>> +	};
>>> +
>>> +The frequencies supported by the DMC are stored in OPP table v2.
>>> +
>>> +	dmc_opp_table: opp_table2 {
>>> +		compatible = "operating-points-v2";
>>> +
>>> +		opp00 {
>>> +			opp-hz = /bits/ 64 <165000000>;
>>> +			opp-microvolt = <875000>;
>>> +		};
>>> +		opp01 {
>>> +			opp-hz = /bits/ 64 <206000000>;
>>> +			opp-microvolt = <875000>;
>>> +		};
>>> +		opp02 {
>>> +			opp-hz = /bits/ 64 <275000000>;
>>> +			opp-microvolt = <875000>;
>>> +		};
>>> +		opp03 {
>>> +			opp-hz = /bits/ 64 <413000000>;
>>> +			opp-microvolt = <887500>;
>>> +		};
>>> +		opp04 {
>>> +			opp-hz = /bits/ 64 <543000000>;
>>> +			opp-microvolt = <937500>;
>>> +		};
>>> +		opp05 {
>>> +			opp-hz = /bits/ 64 <633000000>;
>>> +			opp-microvolt = <1012500>;
>>> +		};
>>> +		opp06 {
>>> +			opp-hz = /bits/ 64 <728000000>;
>>> +			opp-microvolt = <1037500>;
>>> +		};
>>> +		opp07 {
>>> +			opp-hz = /bits/ 64 <825000000>;
>>> +			opp-microvolt = <1050000>;
>>> +		};
>>> +	};
>>> +
>>>
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
