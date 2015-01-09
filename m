From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv3 2/8] devfreq: exynos: Add documentation for generic
 exynos memory bus frequency driver
Date: Fri, 09 Jan 2015 11:42:23 +0900
Message-ID: <54AF400F.5020002@samsung.com>
References: <1420681257-3078-1-git-send-email-cw00.choi@samsung.com>
 <1420681257-3078-3-git-send-email-cw00.choi@samsung.com>
 <CAL_Jsq+5sdsm_-VW-ta+qV-NBao-XTHvsYWcbMdZmbP0Nw43Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:12364 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbbAICm1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jan 2015 21:42:27 -0500
In-reply-to: <CAL_Jsq+5sdsm_-VW-ta+qV-NBao-XTHvsYWcbMdZmbP0Nw43Cw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: myungjoo.ham@samsung.com, kgene@kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mark Rutland <mark.rutland@arm.com>, a.kesavan@samsung.com, Tomasz Figa <tomasz.figa@gmail.com>, k.kozlowski@samsung.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, InKi Dae <inki.dae@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rob,

First of all, thanks for your review.

On 01/09/2015 06:18 AM, Rob Herring wrote:
> Adding Viresh.
> 
> On Wed, Jan 7, 2015 at 7:40 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> This patch adds the documentation for generic exynos memory bus frequency
>> driver.
>>
>> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  .../devicetree/bindings/devfreq/exynos-busfreq.txt | 184 +++++++++++++++++++++
>>  1 file changed, 184 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/devfreq/exynos-busfreq.txt
>>
>> diff --git a/Documentation/devicetree/bindings/devfreq/exynos-busfreq.txt b/Documentation/devicetree/bindings/devfreq/exynos-busfreq.txt
>> new file mode 100644
>> index 0000000..c601e88
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/devfreq/exynos-busfreq.txt
>> @@ -0,0 +1,184 @@
>> +
>> +* Generic Exynos Memory Bus device
>> +
>> +The Samsung Exynos SoCs have many memory buses for data transfer between DRAM
>> +memory and MMC/sub-IP in SoC. Almost Exynos SoCs have the common architecture
>> +for memory buses. Generally, Exynos SoC express the memory bus by using memory
>> +bus group and block. The memory bus group has one more memory bus blocks and
>> +OPP table (including frequency and voltage for DVFS), regulator, devfreq-event
>> +devices. Each memory bus block has a clock for own memory bus speen and
>> +frequency table for DVFS. There are a little different among Exynos SoCs
>> +because each Exynos SoC has the different sub-IP and differnt memory bus.
>> +So, this difference should be specified in devicetree file.
>> +
>> +Required properties for memory bus group:
>> +- compatible: Should be "samsung,exynos-memory-bus".
>> +- operating-points: the OPP table including frequency/voltage information to
>> +                  support DVFS (Dynamic Voltage/Frequency Scaling) feature.
>> +- devfreq-events: the devfreq-event device to monitor the curret state of
>> +                  memory bus group.
> 
> I don't understand what goes in here.

CPUFREQ use the cpu utilization data to decide the current state of CPU
by CPUFREQ governor. 

Exynos busfreq with DEVFREQ must need the data to monitor the current state
of memory bus of Exynos SoC. So, the devfreq-events provide the current state
of memory bus like as cpu utilization. Exynos busfreq could decide the state
of memory bus by using the devfreq-events.

The summary of devfreq-event device is as following: (https://lkml.org/lkml/2015/1/7/795)
: This patch add new devfreq_event class for devfreq_event device which provide
raw data (e.g., memory bus utilization/GPU utilization). This raw data from
devfreq_event data would be used for the governor of devfreq subsystem.
- devfreq_event device : Provide raw data for governor of existing devfreq device
- devfreq device       : Monitor device state and change frequency/voltage of device
                         using the raw data from devfreq_event device

> 
>> +- vdd-mem-supply: the regulator to provide memory bus group with the voltage.
>> +
>> +Required properties for memory bus block:
>> +- clock-names : the name of clock used by the memory bus, "memory-bus".
>> +- clocks : phandles for clock specified in "clock-names" property.
>> +- #clock-cells: should be 1.
>> +- frequency: the frequency table to support DVFS feature.
> 
> So you have just defined a new OPP table format. We already have one
> and Viresh is working to create a more extendable one. He asked about
> what's needed in devfreq, so Viresh here you go. :)
> 
>> +
>> +Example1 : Memory bus group/block in exynos3250.dtsi are listed below.
>> +       Exynos3250 has two memory bus group (MIF, INT group). MIF memory bus
>> +       group includes one memory bus block between DRAM and eMMC. Also, INT
>> +       memory bus group includes eight memory bus blocks which support each
>> +       sub-IPs between DRAM and sub-IPs.
>> +
>> +       memory_bus_mif: memory_bus@0 {
>> +               compatible = "samsung,exynos-memory-bus";
>> +
>> +               operating-points = <
>> +                       400000 875000
>> +                       200000 800000
>> +                       133000 800000
>> +                       100000 800000
>> +                       50000  800000>;
>> +               status = "disabled";
> 
> Why is this not part of the DDR controller or /memory node?

Because the memory bus node in this patch was dependent on only Exynos SoC.
I didn't check the memory bus of another SoC except for Exynos SoC.

> 
>> +               blocks {
>> +                       dmc_block: memory_bus_block1 {
>> +                               clocks = <&cmu_dmc CLK_DIV_DMC>;
>> +                               clock-names = "memory-bus";
>> +                               frequency = <
>> +                                       400000
>> +                                       200000
>> +                                       133000
>> +                                       100000
>> +                                       50000>;
> 
> This is just duplicated from the operating-points table.

First of all, I explain the meaning of 'memory bus group' and 'memory bus block'.
- The 'memory bus group' includes various memory bus group and has one regulatot for power.
Also, it must need the devfreq-events device to monitor the current state of memory buses.
- The 'memory bus block' has only one clock for memory bus and different clock rate.
And the memory bus blocks which are included in same 'memory bus group' use the same power rail (regulator).

This patch adds 'frequency' table for each memory bus block because
each memory bus block has different clock rate. Only one operating-point table
cannot support various memory bus blocks.

So, I added the frequency table to each memory bus block.

> 
>> +                       };
>> +               };
>> +       };
>> +
>> +       memory_bus_int: memory_bus@1 {
>> +               compatible = "samsung,exynos-memory-bus";
>> +
>> +               operating-points = <
>> +                       400000 950000
>> +                       200000 950000
>> +                       133000 925000
>> +                       100000 850000
>> +                       80000  850000
>> +                       50000  850000>;
>> +
>> +               status = "disabled";
>> +
>> +               blocks {
>> +                       peri_block: memory_bus_block1 {
> 
> Why is this and the following nodes not part of the respective
> peripheral nodes or buses. If you need more hierarchy in your bus add
> that to DT first.

I explain the hierarchy of Exynos memory buses.

This patch divide the memory bus group according to power rail (regulator).
- MIF (Memory Interface ) memory bus group uses the VDD_MIF regulator.
- INT (Internal) memory bus group uses the VDD_INT regulator.

For example,.
Each memory bus group contains only one power rail(regulator) and one more memory bus blocks as follwing:

- MIF memory bus group                     
power rail(VDD_MIF)-->|--- memory bus for DMC (Dynamic Memory Controller) block (dmc clock)


- INT memory bus group
                      |--- memory bus for PERI block (aclk_100 clock)
                      |
                      |--- memory bus for DISPLAY block (aclk_160 clock)
                      |  
                      |--- memory bus for ISP block (aclk_200 clock)
                      |
                      |--- memory bus for GPS block (aclk_266 clock)
power rail(VDD_INT)-->|
                      |--- memory bus for MCUISP block (aclk_400_mcuisp clock)
                      |
                      |--- memory bus for Leftbus block (gdl clock)
                      |
                      |--- memory bus for Rightbus block (gdr clock)
                      |
                      |--- memory bus for MFC block (mfc clock)


> I'm sure just a flat "simple-bus" was done which
> doesn't reflect the actual bus and now you need it to.

I'm not sure that the memory bus concept of this patch
would support the memory bus of all SoCs. So, I didn't modify common bus driver.

If I misunderstand about your question, please explain in more detail about your opinion.

> 
>> +                               clocks = <&cmu CLK_DIV_ACLK_100>;
>> +                               clock-names = "memory-bus";
>> +                               frequency = <
>> +                                       100000
>> +                                       100000
>> +                                       100000
>> +                                       100000
>> +                                       50000
>> +                                       50000>;
>> +                       };
> 
> This just looks like constraints on the clock frequency. This should
> be added in a standard way to the clock binding.

I explained the 'frequency' table of each memory bus block on upper reply.

> 
> 
>> +
>> +                       display_block: memory_bus_block2 {
>> +                               clocks = <&cmu CLK_DIV_ACLK_160>;
>> +                               clock-names = "memory-bus";
>> +                               frequency = <
>> +                                       200000
>> +                                       160000
>> +                                       100000
>> +                                       80000
>> +                                       80000
>> +                                       50000>;
>> +                       };
>> +
>> +                       isp_block: memory_bus_block3 {
>> +                               clocks = <&cmu CLK_DIV_ACLK_200>;
>> +                               clock-names = "memory-bus";
>> +                               frequency = <
>> +                                       200000
>> +                                       200000
>> +                                       100000
>> +                                       80000
>> +                                       50000
>> +                                       50000>;
>> +                       };
>> +
>> +                       gps_block: memory_bus_block4 {
>> +                               clocks = <&cmu CLK_DIV_ACLK_266>;
>> +                               clock-names = "memory-bus";
>> +                               frequency = <
>> +                                       300000
>> +                                       200000
>> +                                       133000
>> +                                       100000
>> +                                       50000
>> +                                       50000>;
>> +                       };
>> +
>> +                       mcuisp_block: memory_bus_block5 {
>> +                               clocks = <&cmu CLK_DIV_ACLK_400_MCUISP>;
>> +                               clock-names = "memory-bus";
>> +                               frequency = <
>> +                                       400000
>> +                                       200000
>> +                                       50000
>> +                                       50000
>> +                                       50000
>> +                                       50000>;
>> +                       };
>> +
>> +                       leftbus_block: memory_bus_block6 {
>> +                               clocks = <&cmu CLK_DIV_GDL>;
>> +                               clock-names = "memory-bus";
>> +                               frequency = <
>> +                                       200000
>> +                                       200000
>> +                                       133000
>> +                                       100000
>> +                                       100000
>> +                                       100000>;
>> +                       };
>> +
>> +                       rightbus_block: memory_bus_block7 {
>> +                               clocks = <&cmu CLK_DIV_GDR>;
>> +                               clock-names = "memory-bus";
>> +                               frequency = <
>> +                                       200000
>> +                                       200000
>> +                                       133000
>> +                                       100000
>> +                                       100000
>> +                                       100000>;
>> +                       };
>> +
>> +                       mfc_block: memory_bus_block8 {
>> +                               clocks = <&cmu CLK_SCLK_MFC>;
>> +                               clock-names = "memory-bus";
>> +                               frequency = <
>> +                                       200000
>> +                                       200000
>> +                                       200000
>> +                                       133000
>> +                                       100000
>> +                                       80000>;
>> +                       };
>> +               };
>> +       };
>> +
>> +Example2 : Usage case to handle the frequency/voltage of memory bus on runtime
>> +       in exynos3250-rinato.dts are listed below.
>> +
>> +       &memory_bus_mif {
>> +               devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
>> +               vdd-mem-supply = <&buck1_reg>;
>> +               status = "okay";
>> +       };
>> +
>> +       &memory_bus_int {
>> +               devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
>> +               vdd-mem-supply = <&buck3_reg>;
>> +               status = "okay";
>> +       };
>> --

Best Regards,
Chanwoo Choi

