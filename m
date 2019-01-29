From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH 4/8] dt-bindings: devfreq: add DMC device description
Date: Tue, 29 Jan 2019 17:02:49 +0100
Message-ID: <79cd56c4-2415-7db1-be6f-73c03c0902bc@partner.samsung.com>
References: <CGME20190128192153eucas1p2d7a796cb89e68c1789069562e91296be@eucas1p2.samsung.com>
        <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
        <1548703299-15806-5-git-send-email-l.luba@partner.samsung.com>
        <CAJKOXPd2g6rtZpK20emJ0tqHhq0D01=BWbU_9MP30313XHvPHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPd2g6rtZpK20emJ0tqHhq0D01=BWbU_9MP30313XHvPHg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org, =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= <b.zolnierkie@samsung.com>, myungjoo.ham@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On 1/29/19 3:47 PM, Krzysztof Kozlowski wrote:
> On Mon, 28 Jan 2019 at 20:21, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> The patch adds description for DT binding for a new Exynos5 Dynamic Memory
>> Controller device.
>> It also contains needed MAINTAINERS file updates.
>>
>> CC: MyungJoo Ham <myungjoo.ham@samsung.com>
>> CC: Kyungmin Park <kyungmin.park@samsung.com>
>> CC: Chanwoo Choi <cw00.choi@samsung.com>
>> CC: Rob Herring <robh+dt@kernel.org>
>> CC: Mark Rutland <mark.rutland@arm.com>
>> CC: Kukjin Kim <kgene@kernel.org>
>> CC: Krzysztof Kozlowski <krzk@kernel.org>
>> CC: linux-pm@vger.kernel.org
>> CC: linux-samsung-soc@vger.kernel.org
>> CC: devicetree@vger.kernel.org
>> CC: linux-arm-kernel@lists.infradead.org
>> CC: linux-kernel@vger.kernel.org
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   .../devicetree/bindings/devfreq/exynos5-dmc.txt    | 108 +++++++++++++++++++++
>>   MAINTAINERS                                        |   7 ++
>>   2 files changed, 115 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/devfreq/exynos5-dmc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/devfreq/exynos5-dmc.txt b/Documentation/devicetree/bindings/devfreq/exynos5-dmc.txt
>> new file mode 100644
>> index 0000000..914bd85
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/devfreq/exynos5-dmc.txt
>> @@ -0,0 +1,108 @@
>> +* Exynos5 frequency and voltage scaling for Dynamic Memory Controller device
>> +
>> +The Samsung Exynos5 SoC has DMC (Dynamic Memory Controller) to which the DRAM
>> +memory chips are connected. The driver is to monitor the controller in runtime
>> +and switch frequency and voltage. To monitor the usage of the controller in
>> +runtime, the driver uses the PPMU (Platform Performance Monitoring Unit), which
>> +is able to measure the current load of the memory.
>> +When 'userspace' governor is used for the driver, an application is able to
>> +switch the DMC frequency.
>> +
>> +Required properties for DMC device for Exynos5422:
>> +- compatible: Should be "samsung,exynos5422-bus".
>> +- clock-names : the name of clock used by the bus, "bus".
>> +- clocks : phandles for clock specified in "clock-names" property.
>> +- devfreq-events : phandles for PPMU devices connected to this DMC.
>> +
>> +The example definition of a DMC and PPMU devices declared in DT is shown below:
>> +
>> +       ppmu_dmc0_0: ppmu_dmc0_0@10d00000 {
>> +               compatible = "samsung,exynos-ppmu";
>> +               reg = <0x10d00000 0x2000>;
>> +               clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
>> +               clock-names = "ppmu";
>> +               status = "okay";
>> +               events {
>> +                       ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
>> +                               event-name = "ppmu-event3-dmc0_0";
>> +                       };
>> +               };
>> +       };
>> +
>> +
>> +       ppmu_dmc0_1: ppmu_dmc0_1@10d10000 {
>> +               compatible = "samsung,exynos-ppmu";
>> +               reg = <0x10d10000 0x2000>;
>> +               clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
>> +               clock-names = "ppmu";
>> +               status = "okay";
>> +               events {
>> +                       ppmu_event_dmc0_1: ppmu-event3-dmc0_1 {
>> +                               event-name = "ppmu-event3-dmc0_1";
>> +                       };
>> +               };
>> +       };
>> +
>> +       ppmu_dmc1_0: ppmu_dmc1_0@10d10000 {
>> +               compatible = "samsung,exynos-ppmu";
>> +               reg = <0x10d60000 0x2000>;
>> +               clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
>> +               clock-names = "ppmu";
>> +               status = "okay";
>> +               events {
>> +                       ppmu_event_dmc1_0: ppmu-event3-dmc1_0 {
>> +                               event-name = "ppmu-event3-dmc1_0";
>> +                       };
>> +               };
>> +       };
>> +
>> +       ppmu_dmc1_1: ppmu_dmc1_1@10d70000 {
>> +               compatible = "samsung,exynos-ppmu";
>> +               reg = <0x10d70000 0x2000>;
>> +               clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
>> +               clock-names = "ppmu";
>> +               status = "okay";
>> +               events {
>> +                       ppmu_event_dmc1_1: ppmu-event3-dmc1_1 {
>> +                               event-name = "ppmu-event3-dmc1_1";
>> +                       };
>> +               };
>> +       };
>> +
>> +       dmc: dmc@10c20000 {
>> +               compatible = "samsung,exynos5422-dmc";
>> +               reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
>> +                       <0x10030000 0x1000>, <0x10000000 0x1000>;
>> +               clocks =        <&clock CLK_FOUT_SPLL>,
>> +                               <&clock CLK_MOUT_SCLK_SPLL>,
>> +                               <&clock CLK_FF_DOUT_SPLL2>,
>> +                               <&clock CLK_FOUT_BPLL>,
>> +                               <&clock CLK_MOUT_BPLL>,
>> +                               <&clock CLK_SCLK_BPLL>,
>> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE>,
>> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
>> +                               <&clock CLK_MOUT_MCLK_CDREX>,
>> +                               <&clock CLK_DOUT_CLK2X_PHY0>,
>> +                               <&clock CLK_CLKM_PHY0>,
>> +                               <&clock CLK_CLKM_PHY1>
>> +                       ;
> 
> Join with previous line.
> 
>> +               clock-names =   "fout_spll",
>> +                               "mout_sclk_spll",
>> +                               "ff_dout_spll2",
>> +                               "fout_bpll",
>> +                               "mout_bpll",
>> +                               "sclk_bpll",
>> +                               "mout_mx_mspll_ccore",
>> +                               "mout_mx_mspll_ccore_phy",
>> +                               "mout_mclk_cdrex",
>> +                               "dout_clk2x_phy0",
>> +                               "clkm_phy0",
>> +                               "clkm_phy1"
>> +                               ;
> 
> Ditto.
OK, I will fix it.
> 
>> +
>> +               status = "okay";
>> +               devfreq-events = <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
>> +                               <&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
>> +       };
>> +
>> +
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 9f64f8d..3581807 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3310,6 +3310,13 @@ S:       Maintained
>>   F:     drivers/devfreq/exynos-bus.c
>>   F:     Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>>
>> +DMC FREQUENCY DRIVER FOR SAMSUNG EXYNOS5
>> +M:     Lukasz Luba <l.luba@partner.samsung.com>
>> +L:     linux-pm@vger.kernel.org
>> +L:     linux-samsung-soc@vger.kernel.org
>> +S:     Maintained
>> +F:     Documentation/devicetree/bindings/devfreq/exynos5-dmc.txt
> 
> Maintainers change should go with the next change, I think. It looks
> unusual to add an entry for driver... without the driver.
Thank you for the review. I will move the dt-bindings in the patch set
after the dmc driver file. Then the MAINTAINERS file will be updated
only by one entry.

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
> 
