From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v6 06/10] dt-bindings: memory-controllers: add
 Exynos5422 DMC device description
Date: Thu, 2 May 2019 20:56:18 +0200
Message-ID: <b2992f0e-3b46-66a6-f1e4-326fb4b0501f@partner.samsung.com>
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141947eucas1p13a27605e04169ab528ef5bfb385eddbc@eucas1p1.samsung.com>
        <1555683568-20882-7-git-send-email-l.luba@partner.samsung.com>
        <babae08b-3ea6-30f4-6a46-85dea0eacd86@samsung.com>
        <32dfc887-5f67-3d61-08c9-0397d6852811@partner.samsung.com>
        <ed07af9b-2d17-23c2-2f3a-dc832570480d@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ed07af9b-2d17-23c2-2f3a-dc832570480d@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com, jroedel@suse.de, treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

On 5/2/19 3:35 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 5. 1. 오전 5:30, Lukasz Luba wrote:
>> Hi Chanwoo,
>>
>> On 4/30/19 6:46 AM, Chanwoo Choi wrote:
>>> On 19. 4. 19. 오후 11:19, Lukasz Luba wrote:
>>>> The patch adds description for DT binding for a new Exynos5422 Dynamic
>>>> Memory Controller device.
>>>>
>>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>>> ---
>>>>    .../bindings/memory-controllers/exynos5422-dmc.txt | 73 ++++++++++++++++++++++
>>>>    1 file changed, 73 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>>>> new file mode 100644
>>>> index 0000000..133b3cc
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>>>> @@ -0,0 +1,73 @@
>>>> +* Exynos5422 frequency and voltage scaling for Dynamic Memory Controller device
>>>> +
>>>> +The Samsung Exynos5422 SoC has DMC (Dynamic Memory Controller) to which the DRAM
>>>> +memory chips are connected. The driver is to monitor the controller in runtime
>>>> +and switch frequency and voltage. To monitor the usage of the controller in
>>>> +runtime, the driver uses the PPMU (Platform Performance Monitoring Unit), which
>>>> +is able to measure the current load of the memory.
>>>> +When 'userspace' governor is used for the driver, an application is able to
>>>> +switch the DMC and memory frequency.
>>>> +
>>>> +Required properties for DMC device for Exynos5422:
>>>> +- compatible: Should be "samsung,exynos5422-bus".
>>>
>>> As I already mentioned on many times, it is not fixed.
>>> You have to fix it as following:
>>> - exynos5422-bus -> exynos5422-dmc
>> I don't know how I missed it on my list. My apologies.
>>>
>>>> +- clock-names : the name of clock used by the bus, "bus".
>>>
>>> The below examples doesn't contain the 'bus' clock name.
>> True. Thank you for pointing this out. I will it.
>>
>> Regards,
>> Lukasz
>>>
>>>> +- clocks : phandles for clock specified in "clock-names" property.
>>>> +- devfreq-events : phandles for PPMU devices connected to this DMC.
>>>> +- vdd-supply : phandle for voltage regulator which is connected.
>>>> +- reg : registers of two CDREX controllers, chip information, clocks subsystem.
>>>> +- operating-points-v2 : phandle for OPPs described in v2 definition.
>>>> +- device-handle : phandle of the connected DRAM memory device. For more
>>>> +	information please refer to Documentation
>>>> +- devfreq-events : phandles of the PPMU events used by the controller.
>>>> +
>>>> +Example:
>>>> +
>>>> +	ppmu_dmc0_0: ppmu@10d00000 {
>>>> +		compatible = "samsung,exynos-ppmu";
>>>> +		reg = <0x10d00000 0x2000>;
>>>> +		clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
>>>> +		clock-names = "ppmu";
>>>> +		status = "okay";
>>>> +		events {
>>>> +			ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
>>>> +				event-name = "ppmu-event3-dmc0_0";
>>>> +			};
>>>> +		};
>>>> +	};
>>>> +
>>>> +	dmc: memory-controller@10c20000 {
>>>> +		compatible = "samsung,exynos5422-dmc";
>>>> +		reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
>>>> +			<0x10000000 0x1000>, <0x10030000 0x1000>;
> 
> As I discussed about the register region of clock subsystem
> with Sylwester on patch[1], I expected that you used the regmap
> interface to control the register region of clock subsystem.
> 
> But, this dt-binding documents doesn't include any information
> about regmap interface.
Right. I will update the doc since the clock and chipid regs will use
phandle in DT and syscon_regmap in the driver code in the v7 patch set.

Regards,
Lukasz

> 
> [1] https://lkml.org/lkml/2019/3/6/878
> 
>>>> +		clocks = 	<&clock CLK_FOUT_SPLL>,
>>>> +				<&clock CLK_MOUT_SCLK_SPLL>,
>>>> +				<&clock CLK_FF_DOUT_SPLL2>,
>>>> +				<&clock CLK_FOUT_BPLL>,
>>>> +				<&clock CLK_MOUT_BPLL>,
>>>> +				<&clock CLK_SCLK_BPLL>,
>>>> +				<&clock CLK_MOUT_MX_MSPLL_CCORE>,
>>>> +				<&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
>>>> +				<&clock CLK_MOUT_MCLK_CDREX>,
>>>> +				<&clock CLK_DOUT_CLK2X_PHY0>,
>>>> +				<&clock CLK_CLKM_PHY0>,
>>>> +				<&clock CLK_CLKM_PHY1>;
>>>> +		clock-names =	"fout_spll",
>>>> +				"mout_sclk_spll",
>>>> +				"ff_dout_spll2",
>>>> +				"fout_bpll",
>>>> +				"mout_bpll",
>>>> +				"sclk_bpll",
>>>> +				"mout_mx_mspll_ccore",
>>>> +				"mout_mx_mspll_ccore_phy",
>>>> +				"mout_mclk_cdrex",
>>>> +				"dout_clk2x_phy0",
>>>> +				"clkm_phy0",
>>>> +			        "clkm_phy1";
>>>> +		status = "okay";
>>>> +		operating-points-v2 = <&dmc_opp_table>;
>>>> +		devfreq-events = <&ppmu_event3_dmc0_0>,	<&ppmu_event3_dmc0_1>,
>>>> +				<&ppmu_event3_dmc1_0>, <&ppmu_event3_dmc1_1>;
>>>> +		operating-points-v2 = <&dmc_opp_table>;
>>>> +		device-handle = <&samsung_K3QF2F20DB>;
>>>> +		vdd-supply = <&buck1_reg>;
>>>> +	};
>>>>
>>>
>>>
>>
>>
> 
> 
