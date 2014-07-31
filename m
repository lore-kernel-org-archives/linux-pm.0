From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH v9 3/6] ARM: dts: Exynos: add CPU OPP and regulator supply property
Date: Thu, 31 Jul 2014 08:51:02 +0530
Message-ID: <CAJuA9aiBmM+HF0TJkvdjgOkGKYaL4SHU9JtvqfU2jiV7CP978A@mail.gmail.com>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>
	<1406707663-16656-4-git-send-email-thomas.ab@samsung.com>
	<CAD=FV=WNmREbRLmsusbJ6KKykVzwdBqOUfYkWWOhbc=HmxyTdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=WNmREbRLmsusbJ6KKykVzwdBqOUfYkWWOhbc=HmxyTdA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sachin Kamat <sachin.kamat@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Andreas Faerber <afaerber@suse.de>, Chanwoo Choi <cw00.choi@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Doug,

On Thu, Jul 31, 2014 at 6:07 AM, Doug Anderson <dianders@chromium.org> wrote:
> Thomas,
>
> On Wed, Jul 30, 2014 at 1:07 AM, Thomas Abraham <thomas.ab@samsung.com> wrote:
>> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
>> index d0de1f5..3b12a97 100644
>> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
>> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
>> @@ -575,3 +575,7 @@
>>                 usb-phy = <&usb2_phy>;
>>         };
>>  };
>> +
>> +&cpu0 {
>> +       cpu0-supply = <&buck2_reg>;
>> +};
>> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
>> index b4b35ad..f07e834 100644
>> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
>> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
>> @@ -414,3 +414,7 @@
>>                 };
>>         };
>>  };
>> +
>> +&cpu0 {
>> +       cpu0-supply = <&buck2_reg>;
>> +};
>> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
>> index f2b8c41..91acca7 100644
>> --- a/arch/arm/boot/dts/exynos5250-snow.dts
>> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
>> @@ -509,4 +509,8 @@
>>         };
>>  };
>>
>> +&cpu0 {
>> +       cpu0-supply = <&buck2_reg>;
>> +};
>> +
>>  #include "cros-ec-keyboard.dtsi"
>> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
>> index 492e1ef..97b282c 100644
>> --- a/arch/arm/boot/dts/exynos5250.dtsi
>> +++ b/arch/arm/boot/dts/exynos5250.dtsi
>> @@ -58,11 +58,34 @@
>>                 #address-cells = <1>;
>>                 #size-cells = <0>;
>>
>> -               cpu@0 {
>> +               cpu0: cpu@0 {
>>                         device_type = "cpu";
>>                         compatible = "arm,cortex-a15";
>>                         reg = <0>;
>>                         clock-frequency = <1700000000>;
>> +
>> +                       clocks = <&clock CLK_ARM_CLK>;
>> +                       clock-names = "cpu";
>> +                       clock-latency = <140000>;
>
> Where did the 140000 number come from?  My old calculations show that
> with lock time of 270 ad P up to 6 we were at 67.5us lock time.

I measured the time taken by clk_set_rate call in the cpufreq driver
using do_gettimeofday(). The time taken to change the clock speed was
between 87us to 134us for Exynos5420. So I just took the worst case
time of 140us. Also, the time taken to change the CPU clock speed
includes the settling time for changes to dividers and mux clock
blocks.

>
>
>> +                       operating-points = <
>> +                               1700000 1300000
>> +                               1600000 1250000
>> +                               1500000 1225000
>> +                               1400000 1200000
>> +                               1300000 1150000
>> +                               1200000 1125000
>> +                               1100000 1100000
>> +                               1000000 1075000
>> +                                900000 1050000
>> +                                800000 1025000
>> +                                700000 1012500
>> +                                600000 1000000
>> +                                500000  975000
>> +                                400000  950000
>> +                                300000  937500
>> +                                200000  925000
>> +                       >;
>>                 };
>>                 cpu@1 {
>>                         device_type = "cpu";
>> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
>> index cb2b70e..3154b4c 100644
>> --- a/arch/arm/boot/dts/exynos5420.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420.dtsi
>> @@ -59,8 +59,26 @@
>>                         device_type = "cpu";
>>                         compatible = "arm,cortex-a15";
>>                         reg = <0x0>;
>> +                       clocks = <&clock CLK_ARM_CLK>;
>> +                       clock-names = "cpu-cluster.0";
>>                         clock-frequency = <1800000000>;
>>                         cci-control-port = <&cci_control1>;
>> +                       clock-latency = <140000>;
>> +
>> +                       operating-points = <
>> +                               1800000 1250000
>> +                               1700000 1212500
>> +                               1600000 1175000
>> +                               1500000 1137500
>> +                               1400000 1112500
>> +                               1300000 1062500
>> +                               1200000 1037500
>> +                               1100000 1012500
>> +                               1000000 987500
>> +                                900000 962500
>> +                                800000 937500
>> +                                700000 912500
>> +                       >;
>>                 };
>>
>>                 cpu1: cpu@1 {
>> @@ -69,6 +87,7 @@
>>                         reg = <0x1>;
>>                         clock-frequency = <1800000000>;
>>                         cci-control-port = <&cci_control1>;
>> +                       clock-latency = <140000>;
>>                 };
>>
>>                 cpu2: cpu@2 {
>> @@ -77,6 +96,7 @@
>>                         reg = <0x2>;
>>                         clock-frequency = <1800000000>;
>>                         cci-control-port = <&cci_control1>;
>> +                       clock-latency = <140000>;
>>                 };
>>
>>                 cpu3: cpu@3 {
>> @@ -85,14 +105,29 @@
>>                         reg = <0x3>;
>>                         clock-frequency = <1800000000>;
>>                         cci-control-port = <&cci_control1>;
>> +                       clock-latency = <140000>;
>>                 };
>>
>>                 cpu4: cpu@100 {
>>                         device_type = "cpu";
>>                         compatible = "arm,cortex-a7";
>>                         reg = <0x100>;
>> +                       clocks = <&clock CLK_KFC_CLK>;
>> +                       clock-names = "cpu-cluster.1";
>>                         clock-frequency = <1000000000>;
>
> It does't start out at its maximum?

The A7 CPU clock need not start with the maximum. On the SMDK5420
board, the firmware has set the A7 CPU clock to 1GHz. So I used the
same value here.

>
>
>>                         cci-control-port = <&cci_control0>;
>> +                       clock-latency = <140000>;
>> +
>> +                       operating-points = <
>> +                               1300000 1275000
>> +                               1200000 1212500
>> +                               1100000 1162500
>> +                               1000000 1112500
>> +                                900000 1062500
>> +                                800000 1025000
>> +                                700000 975000
>> +                                600000 937500
>> +                       >;
>>                 };
>>
>>                 cpu5: cpu@101 {
>> @@ -101,6 +136,7 @@
>>                         reg = <0x101>;
>>                         clock-frequency = <1000000000>;
>>                         cci-control-port = <&cci_control0>;
>> +                       clock-latency = <140000>;
>>                 };
>>
>>                 cpu6: cpu@102 {
>> @@ -109,6 +145,7 @@
>>                         reg = <0x102>;
>>                         clock-frequency = <1000000000>;
>>                         cci-control-port = <&cci_control0>;
>> +                       clock-latency = <140000>;
>>                 };
>>
>>                 cpu7: cpu@103 {
>> @@ -117,6 +154,7 @@
>>                         reg = <0x103>;
>>                         clock-frequency = <1000000000>;
>>                         cci-control-port = <&cci_control0>;
>> +                       clock-latency = <140000>;
>>                 };
>>         };
>
> Don't you need to put a reference to the supply in the 5420 board
> files?  ...or is that not possible yet since the max77802 hasn't
> landed yet?

The arm big.little cpufreq driver does not have voltage scaling
support yet. So the supply was not mentioned.

>
> If that's not possible, is there any reason to post the 5420.dtsi
> patch now?  Also: what about 5800?  It's so similar to 5420 that it
> seems a shame not to do them at the same time.

This patch series has support for Exynos5800 as well. But it is A15
clock is restricted to 1.8GHz for now since we do not have a way to
handle the vdd_arm and vdd_int voltage difference with 1.9GHz and
2.0GHZ in upstream yet.

Thanks,
Thomas.

>
>
> -Doug
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
