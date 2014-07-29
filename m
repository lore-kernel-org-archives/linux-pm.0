From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v8 3/6] ARM: dts: Exynos: add CPU OPP and regulator supply
 property
Date: Tue, 29 Jul 2014 14:10:15 +0200
Message-ID: <53D78F27.7000606@gmail.com>
References: <1406611711-25112-1-git-send-email-thomas.ab@samsung.com>	<1406611711-25112-4-git-send-email-thomas.ab@samsung.com>	<53D77817.7030605@gmail.com> <CAJuA9ahAmPytu0Oncnj7Ytm+UFCfiekdFnsHu1N6js=NNsypJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAJuA9ahAmPytu0Oncnj7Ytm+UFCfiekdFnsHu1N6js=NNsypJQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <ta.omasab@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Doug Anderson <dianders@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>, Sachin Kamat <sachin.kamat@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 29.07.2014 14:00, Thomas Abraham wrote:

[snip]

>>> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
>>> index 492e1ef..876247a 100644
>>> --- a/arch/arm/boot/dts/exynos5250.dtsi
>>> +++ b/arch/arm/boot/dts/exynos5250.dtsi
>>> @@ -63,6 +63,29 @@
>>>                       compatible = "arm,cortex-a15";
>>>                       reg = <0>;
>>>                       clock-frequency = <1700000000>;
>>> +
>>> +                     clocks = <&clock CLK_ARM_CLK>;
>>> +                     clock-names = "cpu";
>>> +                     clock-latency = <200000>;
>>
>> Where does this latency value comes from? How did you calculate it?
>>
>> For example, on Exynos4210, for all operating points added by your
>> patches, the highest PLL locking latency will be 60uS, because the
>> highest PDIV value would be 6 and PLL lock time is PDIV*240 ticks of 24
>> MHz reference clock.
> 
> Since the CPU clock is a composite clock with dividers and muxes, the
> latency includes the settling time for these clock blocks as well. I
> have not made any measurements of the clock transition latency.
> 

It might be more reasonable to find out correct latency values instead
of specifying a rather random number.

>>
>>> +
>>> +                     operating-points = <
>>> +                             1700000 1300000
>>> +                             1600000 1250000
>>
>> [snip]
>>
>>> diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
>>> index 6052aa9..084e587 100644
>>> --- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
>>> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
>>> @@ -24,6 +24,12 @@
>>>               bootargs = "console=ttySAC2,115200 init=/linuxrc";
>>>       };
>>>
>>> +     cpus {
>>
>> Is there no regulator for cpu0?
> 
> This was a mistake. I did not intend to add regulator for cpu4 as well
> but somehow I missed it. I will remove it in the next version.
> 
>>>
>>>               cpu1: cpu@1 {
>>> @@ -69,6 +87,7 @@
>>>                       reg = <0x1>;
>>>                       clock-frequency = <1800000000>;
>>>                       cci-control-port = <&cci_control1>;
>>> +                     clock-latency = <200000>;
>>
>> Do you need to specify this property for every CPU or rather just for
>> those which have operating points specified?
> 
> The big.little cpufreq driver expects each CPU to have the clock
> latency specified.

OK, apparently this is the case, even though it seems a bit
unreasonable, as they all share the same clock.

Best regards,
Tomasz
