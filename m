From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH 06/11] DT: arm64: exynos: add support for thermal trip
 irq-mode
Date: Tue, 16 Oct 2018 17:48:32 +0200
Message-ID: <20181016154833eucas1p2b2e7cbb90df83737e655bb8a343c4eab~eIXYh7z9r2960029600eucas1p2p@eucas1p2.samsung.com>
References: <CGME20181016145647eucas1p206c068806214535da339588d77cbdfa5@eucas1p2.samsung.com>
        <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
        <20181016145647eucas1p206c068806214535da339588d77cbdfa5~eHqLYh2dR2135021350eucas1p2K@eucas1p2.samsung.com>
        <CAJKOXPe4Jf3QVbQ6BFPFptkgvmmpNu+QCmDoD3JqhyYOidJ7vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPe4Jf3QVbQ6BFPFptkgvmmpNu+QCmDoD3JqhyYOidJ7vA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= <b.zolnierkie@samsung.com>, kgene@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On 10/16/2018 05:09 PM, Krzysztof Kozlowski wrote:
> On Tue, 16 Oct 2018 at 16:56, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
> 
> Hi Lukasz,
> 
> Thanks for patches.
> 
> I did not receive the first patches in the series. It is okay (depends
> on the context) but in such case sending cover letter to all people is
> quite useful. It helps to understand the entire patchset. Since I did
> not get them, I really do not know:
> 1. Whether DTS patches are independent?
> 2. How this fits in the big picture of Exynos thermal?
I have lost your email for my 'cc' command line, my apologies.
I will add you in v2.
Here you can find the cover letter:
https://marc.info/?l=linux-pm&m=153970180314648&w=2
regarding
1. they are independent
2. It will be less confusing and more coherent with documentation
when we use 'passive' for DVFS cooling. Unfortunately, when 'passive'
is set, it registers our trip points for polling and thermal schedules
the work. I had conversation with Daniel regarding this setup,
please check these email:
https://marc.info/?l=linux-kernel&m=153924620318766&w=2
and my response:
https://marc.info/?l=linux-kernel&m=153933708316168&w=2

> 
> 
>> This patch adds support for new flash which indicates
> 
> What is "flash"?
Should be 'flag', thanks for that.
> 
> Please wrap your lines accordingly (75 characters like in
> submitting-patches.rst). Current wrapping makes it more difficult to
> read.
OK
> 
>> that trip point triggers irq when temperature is met.
>> Exynos5433 supports 8 trip point which will trigger irq.
> 
> "Exynos5433 supports 8 trip points which trigger interrupt."
> (or IRQ but not irq)
ACK
> 
>> Above that number other trip points should be registered
>> without 'irq-mode' flag.
> 
> Why they should be registered without irq-mode?
For this HW, only 4 temperatures can be monitored for which IRQ
will fire, AFAIK.
> 
>> That will force the thermal framework to start polling
>> the temperature sensor under configured conditions and
>> handle the trip point.
> 
> How does it fit into existing polling mode?
The existing polling mode is default for 'passive' which does
not have this flag, so nothing changes. The benefit for 'passive'
which are supported by HW IRQ and has this flag is lack of polling
every Xms.
In current situation we are trying to establish this behavior by a
workaround with 'active'. the 'active' in default
does not register polling and waits for IRQs, so the framework is quiet.
This naming tricks are a bit confusing for people, though.

Thank you for comments.

Regards,
Lukasz

> 
>>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Cc: Krzysztof Kozlowski <krzk@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi | 105 ++++++++++++++++---------
>>   1 file changed, 70 insertions(+), 35 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
>> index fe3a0b1..c4330f6 100644
>> --- a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
>> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
>> @@ -17,37 +17,44 @@ thermal-zones {
>>                          atlas0_alert_0: atlas0-alert-0 {
>>                                  temperature = <65000>;  /* millicelsius */
>>                                  hysteresis = <1000>;    /* millicelsius */
>> -                               type = "active";
>> +                               type = "passive";
> 
> Change of active->passive looks irrelevant to this topic. Here and
> everywhere else.
> 
> Best regards,
> Krzysztof
> 
> 
