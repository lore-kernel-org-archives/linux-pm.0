From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v7 07/13] dt-bindings: memory-controllers: add
 Exynos5422 DMC device description
Date: Wed, 8 May 2019 11:17:43 +0200
Message-ID: <fdcbad67-65c8-36f4-1473-e2c46ccc431a@partner.samsung.com>
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151215eucas1p2c57147edac5671c5ec9a223efb6b4adc@eucas1p2.samsung.com>
        <1557155521-30949-8-git-send-email-l.luba@partner.samsung.com>
        <20190507170422.GA25179@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190507170422.GA25179@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com, jroedel@suse.de, treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On 5/7/19 7:04 PM, Rob Herring wrote:
> On Mon, May 06, 2019 at 05:11:55PM +0200, Lukasz Luba wrote:
>> The patch adds description for DT binding for a new Exynos5422 Dynamic
>> Memory Controller device.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   .../bindings/memory-controllers/exynos5422-dmc.txt | 74 ++++++++++++++++++++++
>>   1 file changed, 74 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>> new file mode 100644
>> index 0000000..be602a9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>> @@ -0,0 +1,74 @@
>> +* Exynos5422 frequency and voltage scaling for Dynamic Memory Controller device
>> +
>> +The Samsung Exynos5422 SoC has DMC (Dynamic Memory Controller) to which the DRAM
>> +memory chips are connected. The driver is to monitor the controller in runtime
>> +and switch frequency and voltage. To monitor the usage of the controller in
>> +runtime, the driver uses the PPMU (Platform Performance Monitoring Unit), which
>> +is able to measure the current load of the memory.
>> +When 'userspace' governor is used for the driver, an application is able to
>> +switch the DMC and memory frequency.
>> +
>> +Required properties for DMC device for Exynos5422:
>> +- compatible: Should be "samsung,exynos5422-dmc".
>> +- clock-names : the name of clock used by the controller.
>> +- clocks : phandles for clock specified in "clock-names" property.
> 
> Need to enumerate the clocks and their order.
OK I will add a list here and above in 'clock-names' in the right order.
> 
>> +- devfreq-events : phandles for PPMU devices connected to this DMC.
>> +- vdd-supply : phandle for voltage regulator which is connected.
>> +- reg : registers of two CDREX controllers.
>> +- operating-points-v2 : phandle for OPPs described in v2 definition.
>> +- device-handle : phandle of the connected DRAM memory device. For more
>> +	information please refer to Documentation
> 
> Documentation... ?
I should have changed it after I moved the lpddr3.txt files in the doc
dir. I missed it, my apologies.
> 
>> +- devfreq-events : phandles of the PPMU events used by the controller.
>> +- samsung,syscon-chipid : phandle of the ChipID used by the controller.
>> +- samsung,syscon-clk : phandle of the clock register set used by the controller.
> 
> Looks like a hack. Can't you get this from the clocks property? What is
> this for?
As Krzysztof commented in the next message, the chipid register contains
information about memory size and the clock register set has some
registers from DMC (timings settings) which are not typical 'clocks'.
Chanwoo suggested to use syscon regmap to access these clock registers
safely. Krzysztof suggested to use syscon regmap similar to Sylwester's
AVS driver while accessing chipid registers.
That's why they are here. Both register sets contain needed information
for proper operation of the driver.

Regards,
Lukasz
> 
>> +
>> +Example:
>> +
>> +	ppmu_dmc0_0: ppmu@10d00000 {
>> +		compatible = "samsung,exynos-ppmu";
>> +		reg = <0x10d00000 0x2000>;
>> +		clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
>> +		clock-names = "ppmu";
>> +		events {
>> +			ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
>> +				event-name = "ppmu-event3-dmc0_0";
>> +			};
>> +		};
>> +	};
>> +
>> +	dmc: memory-controller@10c20000 {
>> +		compatible = "samsung,exynos5422-dmc";
>> +		reg = <0x10c20000 0x100>, <0x10c30000 0x100>,
>> +		clocks = 	<&clock CLK_FOUT_SPLL>,
>> +				<&clock CLK_MOUT_SCLK_SPLL>,
>> +				<&clock CLK_FF_DOUT_SPLL2>,
>> +				<&clock CLK_FOUT_BPLL>,
>> +				<&clock CLK_MOUT_BPLL>,
>> +				<&clock CLK_SCLK_BPLL>,
>> +				<&clock CLK_MOUT_MX_MSPLL_CCORE>,
>> +				<&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
>> +				<&clock CLK_MOUT_MCLK_CDREX>,
>> +				<&clock CLK_DOUT_CLK2X_PHY0>,
>> +				<&clock CLK_CLKM_PHY0>,
>> +				<&clock CLK_CLKM_PHY1>;
>> +		clock-names =	"fout_spll",
>> +				"mout_sclk_spll",
>> +				"ff_dout_spll2",
>> +				"fout_bpll",
>> +				"mout_bpll",
>> +				"sclk_bpll",
>> +				"mout_mx_mspll_ccore",
>> +				"mout_mx_mspll_ccore_phy",
>> +				"mout_mclk_cdrex",
>> +				"dout_clk2x_phy0",
>> +				"clkm_phy0",
>> +			        "clkm_phy1";
>> +		operating-points-v2 = <&dmc_opp_table>;
>> +		devfreq-events = <&ppmu_event3_dmc0_0>,	<&ppmu_event3_dmc0_1>,
>> +				<&ppmu_event3_dmc1_0>, <&ppmu_event3_dmc1_1>;
>> +		operating-points-v2 = <&dmc_opp_table>;
>> +		device-handle = <&samsung_K3QF2F20DB>;
>> +		vdd-supply = <&buck1_reg>;
>> +		samsung,syscon-clk = <&clock>;
>> +		samsung,syscon-chipid = <&chipid>;
>> +	};
>> -- 
>> 2.7.4
>>
> 
> 
