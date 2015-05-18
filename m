From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: Re: [PATCH 2/2] ARM64: mt8173: dts Add MT8173 cpufreq driver support
Date: Mon, 18 May 2015 21:29:37 +0800
Message-ID: <CALx668WZwdTao4o-u4JPLLM3F9nQh0_HpG0es3JNAQBcapOa9g@mail.gmail.com>
References: <1429522047-16675-1-git-send-email-pi-cheng.chen@linaro.org>
	<1429522047-16675-3-git-send-email-pi-cheng.chen@linaro.org>
	<20150423125358.GA29702@leverpostej>
	<CALx668UiU73HAwGdezrXDxTm_4_N0HUJQFYa1E_Guv_j3NG00g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALx668UiU73HAwGdezrXDxTm_4_N0HUJQFYa1E_Guv_j3NG00g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Mike Turquette <mturquette@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Howard Chen <ibanezchen@gmail.com>, "fan.chen@mediatek.com" <fan.chen@mediatek.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 24, 2015 at 3:09 PM, Pi-Cheng Chen <pi-cheng.chen@linaro.org> wrote:
> Hi Mark,
>
> Thanks for reviewing.
>
> On Thu, Apr 23, 2015 at 8:53 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Mon, Apr 20, 2015 at 10:27:27AM +0100, pi-cheng.chen wrote:
>>> This patch adds voltage supplies and clocks used by MT8173 cpufreq driver.
>>>
>>> Signed-off-by: pi-cheng.chen <pi-cheng.chen@linaro.org>
>>
>> This series has no bindings for these properties.
>
> Will add documents for these.
>
>>
>>> ---
>>>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 9 +++++++++
>>>  arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 6 ++++++
>>>  2 files changed, 15 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
>>> index 96e141c..7a00cfe 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
>>> @@ -330,3 +330,12 @@
>>>       status = "okay";
>>>       clock-frequency = <100000>;
>>>  };
>>> +
>>> +&cpu0 {
>>> +     proc-supply = <&mt6397_vpca15_reg>;
>>> +};
>>> +
>>> +&cpu2 {
>>> +     proc-supply = <&da9211_vcpu_reg>;
>>> +     sram-supply = <&mt6397_vsramca7_reg>;
>>> +};
>>
>>
>> Why do only two CPUs have these properties, and why does one need an
>> sram-supply?
>
> For better description of hardware, I think putting these properties in all CPUs
> share the same supplies is logical.
>
> For each cluster of MT8173, we have both PROC and SRAM supplies. But only
> on one cluster (cpu2 and cpu3) we need to control both voltage supplies. The
> SRAM supply on cpu0 cluster is controlled by hardware automatically. Therefore
> I put sram-supply only on cpu2. For better description of hardware, it
> might be a
> good idea to put the SRAM supply in cpu0 also though we don't use it in the
> driver, right?
>
>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>> index d9cc84e..b8a5454 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>> @@ -51,6 +51,9 @@
>>>                       device_type = "cpu";
>>>                       compatible = "arm,cortex-a53";
>>>                       reg = <0x000>;
>>> +                     clocks = <&infracfg INFRA_CA53SEL>,
>>> +                              <&apmixedsys APMIXED_MAINPLL>;
>>> +                     clock-names = "cpu", "intermediate";
>>>               };
>>>
>>>               cpu1: cpu@1 {
>>> @@ -65,6 +68,9 @@
>>>                       compatible = "arm,cortex-a57";
>>>                       reg = <0x100>;
>>>                       enable-method = "psci";
>>> +                     clocks = <&infracfg INFRA_CA57SEL>,
>>> +                              <&apmixedsys APMIXED_MAINPLL>;
>>> +                     clock-names = "cpu", "intermediate";
>>>               };
>>
>> We should really describe this information per-cpu rather than assuming
>> that it's the same for siblings. Arbitrarily making one CPU in each
>> cluster (or other arbitrary grouping) special for the binding is silly.

Hi Mark,

Thanks for Viresh's clarification.

>From a private conversation with Viresh:
"This is because of a shortcoming in OPP bindings that we can't link
them today to all CPUs using them and there is WIP there.
All other platforms are passing it only for one CPU today,
in order not to replicate them..."

Our driver will be using those information for these CPUs only so I didn't
replicate them for all CPUs.

Would you please kindly give me some suggestion about what to do?
Should I replicate those clock and regulator supply information for all CPUs?
And OPP table as well?

Thanks.

>
> Yes, I agree with you and same above. I did these because most of the
> platforms in kernel did these. So should I do it the way you suggest?
>
> Thanks.
>
> Best Regards,
> Pi-Cheng
>
>>
>> Mark.
