From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH v7 4/6] ARM: dts: Exynos: add cpu nodes, opp and cpu clock
 configuration data
Date: Tue, 29 Jul 2014 11:06:56 +0530
Message-ID: <CAJuA9aiuDVWqzx6-w4U7QTKnXgREr5xeqwc6ReGo32pboKpYYQ@mail.gmail.com>
References: <1405345118-4269-1-git-send-email-thomas.ab@samsung.com>
	<1405345118-4269-5-git-send-email-thomas.ab@samsung.com>
	<53CA7008.7000106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <53CA7008.7000106@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Viresh Kumar <viresh.kumar@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Tomasz,

On Sat, Jul 19, 2014 at 6:48 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Thomas,
>
> Please see my comments inline.
>
> On 14.07.2014 15:38, Thomas Abraham wrote:
>> From: Thomas Abraham <thomas.ab@samsung.com>
>>
>> For Exynos 4210/5250/5420 based platforms, add CPU nodes, operating points and
>> cpu clock data for migrating from Exynos specific cpufreq driver to using
>> generic cpufreq drivers.
>
> [snip]
>
>> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
>> index ee3001f..c3a73bf 100644
>> --- a/arch/arm/boot/dts/exynos4210.dtsi
>> +++ b/arch/arm/boot/dts/exynos4210.dtsi
>> @@ -31,6 +31,33 @@
>>               pinctrl2 = &pinctrl_2;
>>       };
>>
>> +     cpus {
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +             cpu@0 {
>
> nit: Missing blank line after last property.
>
> The cluster ID field of MPIDR on Exynos4210 is 0x9 not zero, which means
> that this should be cpu@900.
>
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a9";
>> +                     reg = <0>;
>
>                         reg = <0x900>;
>
>> +                     clocks = <&clock CLK_ARM_CLK>;
>> +                     clock-names = "cpu";
>> +
>> +                     operating-points = <
>> +                             1200000 1250000
>> +                             1000000 1150000
>> +                             800000  1075000
>> +                             500000  975000
>> +                             400000  975000
>> +                             200000  950000
>> +                     >;
>> +             };
>> +
>> +             cpu@1 {
>
>                 cpu@901
>
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a9";
>> +                     reg = <1>;
>
>                         reg = <0x901>;
>
>> +             };
>
> In general this wouldn't have even booted, because there were several
> places where code relied on CPUs being 0, 1, 2... However I have sent
> necessary fixes and they should hit linux-next in few days.
>
>> +     };
>> +
>>       sysram@02020000 {
>>               compatible = "mmio-sram";
>>               reg = <0x02020000 0x20000>;
>
> [snip]
>
>> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
>> index 834fb5a..66b0f98 100644
>> --- a/arch/arm/boot/dts/exynos5250.dtsi
>> +++ b/arch/arm/boot/dts/exynos5250.dtsi
>> @@ -63,6 +63,29 @@
>>                       compatible = "arm,cortex-a15";
>>                       reg = <0>;
>>                       clock-frequency = <1700000000>;
>> +
>> +                     clocks = <&clock CLK_ARM_CLK>;
>> +                     clock-names = "cpu";
>> +
>> +                     operating-points = <
>> +                             1700000 1300000
>> +                             1600000 1250000
>> +                             1500000 1225000
>> +                             1400000 1200000
>> +                             1300000 1150000
>> +                             1200000 1125000
>> +                             1100000 1100000
>> +                             1000000 1075000
>> +                              900000 1050000
>> +                              800000 1025000
>> +                              700000 1012500
>> +                              600000 1000000
>> +                              500000  975000
>> +                              400000  950000
>> +                              300000  937500
>> +                              200000  925000
>> +                     >;
>> +                     clock-latency = <200000>;
>
> I don't see this property specified for Exynos4210. Have you missed it
> there?

Okay, I have specified this for Exynos4210 as well.

Thanks,
Thomas.

>
> Best regards,
> Tomasz
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
