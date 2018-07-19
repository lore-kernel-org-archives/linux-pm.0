From: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH 1/5] thermal: exynos: enable core tmu clk on exynos platform
Date: Thu, 19 Jul 2018 15:22:21 +0530
Message-ID: <CANAwSgSmUFYjE1VyqFM87M-6JZH140P9VpnXP2sG6Mw=_1J3Tg@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPdP78VFQgSQ9z9WsgYY_YhEKPUt=0MOra6Pz6smQeiNGg@mail.gmail.com>
 <CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com>
 <CAJKOXPdXYz77Bqyjr3HK+EA0HpEABPqmPOD0f5ew-yq2SFVpVQ@mail.gmail.com>
 <CANAwSgRFehdmYZvPL3yD1=Ng_w1Yhtij=nvZEOqkof7zj8fcwA@mail.gmail.com> <CAJKOXPfRBPgmGc17XEzW5+MK80JcudCbhBfLeMFTQYjWLJ3JeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPfRBPgmGc17XEzW5+MK80JcudCbhBfLeMFTQYjWLJ3JeA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On 18 July 2018 at 15:36, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 18 July 2018 at 11:24, Anand Moon <linux.amoon@gmail.com> wrote:
>> Hi Krzysztof
>>
>> On 18 July 2018 at 11:47, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>> On 17 July 2018 at 22:23, Anand Moon <linux.amoon@gmail.com> wrote:
>>>> Hi Krzysztof
>>>>
>>>> On 17 July 2018 at 17:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>> Hi Anand,
>>>>>
>>>>> Thanks for patch.
>>>>>
>>>>> On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
>>>>>> clk_summary do not show tmu_apbif clk enable, so replace
>>>>>> the clk_prepare with clk_prepare_enables to enable tmu clk.
>>>>>
>>>>> This is not valid reason to do a change. What is clk_summary does not
>>>>> really matter. Your change has negative impact on power consumption as
>>>>> the clock stays enabled all the time. This is not what we want... so
>>>>> please explain it more - why you need the clock to be enabled all the
>>>>> time? What is broken (clk_summary is not broken in this case)?
>>>>>
>>>>
>>>> Opps I could not explain some more in my commit message.
>>>>
>>>> Actually TMU sensor for Exynos process are controlled by so external clk
>>>>
>>>> Exynos4412 have VDD18_TS sensor which controls the CLK_SENSE tmu.
>>>> Exynos5422 have VDD18_TS01 / VDD18_TS23 / VDD18_TS4 sensor which
>>>> control the CLK_SENSE tmu.
>>>>
>>>> So as per my understanding tmu is clk driver which control the flow  PMIC.
>>>>
>>>> clk_prepare_enable combine clk_prepare and clk_enable
>>>> and clk_disable_unprepare combine clk_disable and clk_unprepare.
>>>>
>>>> most of the driver prefer clk_prepare_enable and clk_disable_unprepare.
>>>>
>>>> clk_summary is just a reference looking point where we could check the
>>>> clk is enable/disable.
>>>>
>>>> what is broken ?
>>>> I still few more parameter need to tuned to configure the tmu driver.
>>>
>>> I am sorry but I am still unable to see what is broken and what are
>>> you trying to fix. I asked what is broken and you replied that there
>>> is a sensor, there is a clock, drivers use clk_prepare_enable and some
>>> more parameter need to be tuned... None of these are answers to
>>> question - what is broken. How can I reproduce the problem?
>>>
>>> Best regards,
>>> Krzysztof
>>
>> Basically I use thermal testing.
>>
>> # git clone https://git.linaro.org/power/pm-qa.git
>> # cd pm-qa
>> # make -C thermal check
>>
>> most of the testcase failed on Exynos5422 but some pass on Exynos4412.
>>
>> Attach is the software overview from Exynos5422 user manual.
>>
>> I am not able to explain in deep technically, but I have studied other thermal
>> driver to draw into conclusion that tmu clk's need to be enabled.
>
> That is true in general - the clk has to be enabled in certain cases.
> However you did not say at all when you want this clock to be
> enabled... and the your patch enables it for entire lifetime of
> device.
>
>> If you feel the we should not enable these clk, them I will drop the
>> clk_prepare_enable check
>> and resubmit the changes with better commit message.
>
> I don't know. This was fifth email in this thread and it is the first
> time some real problem is mentioned. Still the issue is not described
> entirely so I really do not have a clue whether this patch fixes
> something or not.
> What is more, you mentioned falling pm-qa tests here (not in commit
> msg) but did not say whether this patch fixes anything or not.
>
> So let me summarize it:
> 1. You did not describe the problem you want to fix.
> 2. The patch looks incorrect because it enables the clock for entire
> lifetime of device which we do not want.
> 3. The patch might or not might fix some problem. We even do not know what...
> 4. The clock not being enabled when not needed... is obviously not a problem.
>
> Please start from beginning. Find the problem, tell us how it can be
> reproduced and deliver a single patch which fixes the problem.
>
> This pattern of your code - fixing something without describing the
> problem - happened many time before. I repeated this some times before
> as well. I would prefer not to repeat to many times. Therefore I would
> be happy if you follow the path mentioned in paragraph before always:
> find the problem, tell how it can be reproduced, deliver single patch
> which fixes the problem.
>
> Best regards,
> Krzysztof

Yes I will try to improve my self to the point commit message
and code as per the documentation.

Let me clear my thoughts on clk's turned on for by driver.
Please correct me If I am wrong.

Exynos support Power domain to control the dynamic power consumption via clk.
Operating voltage
Operating frequency
Toggling ratios of the logic gate

PMU generates power control signal to regulator or PMIC.

To reduce the dynamic power consumption, Exynos SCP uses clock gating
and frequency scaling.

Exynos process support tmu power domain
Power Domain         Power Source         Internal Power Gating Method
           Included Modules

TEMP                     VDD18_TEMP        None
                       TEMP SENSOR

Exynos TMU is directly co-related to CPU frequency scaling module.
as their is increase in CPU clk speed with increase in temperature
TMU will control the flow of cpu speed via clk freq scaling.

It might be a good option to implement pm_runtime for tmu driver.

If you are not satisfied with this series of change lets drop them.
I will just re-submit err-clean up and e-Fuse changes.

Best Regards
-Anand
