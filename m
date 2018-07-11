From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v12 1/4] iommu/arm-smmu: Add pm_runtime/sleep ops
Date: Wed, 11 Jul 2018 22:36:09 +0200
Message-ID: <CAJZ5v0g0NwkLmd=tJ0sT4pc8FJSRE8sEu5GRQ7KUUd+YedzjMg@mail.gmail.com>
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
 <20180708173413.1965-2-vivek.gautam@codeaurora.org> <17407514.unFVTGoGrn@aspire.rjw.lan>
 <CAFp+6iHxJucfzJJeEvSToG4p2zADjDb9F0L8h053x-JKAy55mg@mail.gmail.com>
 <CAJZ5v0gbkdkx_+oHYiPz=SFdFCLm38hsi1TmJ2Jdc7j73TNtzg@mail.gmail.com>
 <CGME20180711125157epcas1p3712f4a02f4442287c18e470d0a8d516f@epcas1p3.samsung.com>
 <CAAFQd5Cqd=J+_nqRc_sx=sq2ayxwSRMgygvffuHH9nC5R_LjdA@mail.gmail.com> <20180711134054eucas1p208566383b25dd74787034929b3081901~AVDO-rPhL2314323143eucas1p2n@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180711134054eucas1p208566383b25dd74787034929b3081901~AVDO-rPhL2314323143eucas1p2n@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Tomasz Figa <tfiga@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Rob Clark <robdclark@gmail.com>, Linux PM <linux-pm@vger.kernel.org>, freedreno <freedreno@lists.freedesktop.org>, Stephen Boyd <sboyd@kernel.org>, Sricharan R <sricharan@codeaurora.org>A
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 11, 2018 at 3:40 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hi Tomasz,
>
> On 2018-07-11 14:51, Tomasz Figa wrote:
>> On Wed, Jul 11, 2018 at 8:11 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> On Wed, Jul 11, 2018 at 12:55 PM, Vivek Gautam
>>> <vivek.gautam@codeaurora.org> wrote:
>>>> On Wed, Jul 11, 2018 at 3:20 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>>> On Sunday, July 8, 2018 7:34:10 PM CEST Vivek Gautam wrote:
>>>>>> From: Sricharan R <sricharan@codeaurora.org>
>>>>>>
>>>>>> The smmu needs to be functional only when the respective
>>>>>> master's using it are active. The device_link feature
>>>>>> helps to track such functional dependencies, so that the
>>>>>> iommu gets powered when the master device enables itself
>>>>>> using pm_runtime. So by adapting the smmu driver for
>>>>>> runtime pm, above said dependency can be addressed.
>>>>>>
>>>>>> This patch adds the pm runtime/sleep callbacks to the
>>>>>> driver and also the functions to parse the smmu clocks
>>>>>> from DT and enable them in resume/suspend.
>>>>>>
>>>>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>>>>> Signed-off-by: Archit Taneja <architt@codeaurora.org>
>>>>>> [vivek: Clock rework to request bulk of clocks]
>>>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>>>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>>>>>> ---
>>>>>>
>>>>>>   - No change since v11.
>>>>>>
>>>>>>   drivers/iommu/arm-smmu.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++--
>>>>>>   1 file changed, 58 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>>>>> index f7a96bcf94a6..a01d0dde21dd 100644
>>>>>> --- a/drivers/iommu/arm-smmu.c
>>>>>> +++ b/drivers/iommu/arm-smmu.c
>>>>>> @@ -48,6 +48,7 @@
>>>>>>   #include <linux/of_iommu.h>
>>>>>>   #include <linux/pci.h>
>>>>>>   #include <linux/platform_device.h>
>>>>>> +#include <linux/pm_runtime.h>
>>>>>>   #include <linux/slab.h>
>>>>>>   #include <linux/spinlock.h>
>>>>>>
>>>>>> @@ -205,6 +206,8 @@ struct arm_smmu_device {
>>>>>>        u32                             num_global_irqs;
>>>>>>        u32                             num_context_irqs;
>>>>>>        unsigned int                    *irqs;
>>>>>> +     struct clk_bulk_data            *clks;
>>>>>> +     int                             num_clks;
>>>>>>
>>>>>>        u32                             cavium_id_base; /* Specific to Cavium */
>>>>>>
>>>>>> @@ -1897,10 +1900,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>>>>>>   struct arm_smmu_match_data {
>>>>>>        enum arm_smmu_arch_version version;
>>>>>>        enum arm_smmu_implementation model;
>>>>>> +     const char * const *clks;
>>>>>> +     int num_clks;
>>>>>>   };
>>>>>>
>>>>>>   #define ARM_SMMU_MATCH_DATA(name, ver, imp)  \
>>>>>> -static struct arm_smmu_match_data name = { .version = ver, .model = imp }
>>>>>> +static const struct arm_smmu_match_data name = { .version = ver, .model = imp }
>>>>>>
>>>>>>   ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
>>>>>>   ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
>>>>>> @@ -1919,6 +1924,23 @@ static const struct of_device_id arm_smmu_of_match[] = {
>>>>>>   };
>>>>>>   MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
>>>>>>
>>>>>> +static void arm_smmu_fill_clk_data(struct arm_smmu_device *smmu,
>>>>>> +                                const char * const *clks)
>>>>>> +{
>>>>>> +     int i;
>>>>>> +
>>>>>> +     if (smmu->num_clks < 1)
>>>>>> +             return;
>>>>>> +
>>>>>> +     smmu->clks = devm_kcalloc(smmu->dev, smmu->num_clks,
>>>>>> +                               sizeof(*smmu->clks), GFP_KERNEL);
>>>>>> +     if (!smmu->clks)
>>>>>> +             return;
>>>>>> +
>>>>>> +     for (i = 0; i < smmu->num_clks; i++)
>>>>>> +             smmu->clks[i].id = clks[i];
>>>>>> +}
>>>>>> +
>>>>>>   #ifdef CONFIG_ACPI
>>>>>>   static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
>>>>>>   {
>>>>>> @@ -2001,6 +2023,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>>>>>>        data = of_device_get_match_data(dev);
>>>>>>        smmu->version = data->version;
>>>>>>        smmu->model = data->model;
>>>>>> +     smmu->num_clks = data->num_clks;
>>>>>> +
>>>>>> +     arm_smmu_fill_clk_data(smmu, data->clks);
>>>>>>
>>>>>>        parse_driver_options(smmu);
>>>>>>
>>>>>> @@ -2099,6 +2124,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>>>>>                smmu->irqs[i] = irq;
>>>>>>        }
>>>>>>
>>>>>> +     err = devm_clk_bulk_get(smmu->dev, smmu->num_clks, smmu->clks);
>>>>>> +     if (err)
>>>>>> +             return err;
>>>>>> +
>>>>>> +     err = clk_bulk_prepare(smmu->num_clks, smmu->clks);
>>>>>> +     if (err)
>>>>>> +             return err;
>>>>>> +
>>>>>>        err = arm_smmu_device_cfg_probe(smmu);
>>>>>>        if (err)
>>>>>>                return err;
>>>>>> @@ -2181,6 +2214,9 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>>>>>>
>>>>>>        /* Turn the thing off */
>>>>>>        writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
>>>>>> +
>>>>>> +     clk_bulk_unprepare(smmu->num_clks, smmu->clks);
>>>>>> +
>>>>>>        return 0;
>>>>>>   }
>>>>>>
>>>>>> @@ -2197,7 +2233,27 @@ static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
>>>>>>        return 0;
>>>>>>   }
>>>>>>
>>>>>> -static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
>>>>>> +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
>>>>>> +{
>>>>>> +     struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>>>>>> +
>>>>>> +     return clk_bulk_enable(smmu->num_clks, smmu->clks);
>>>>>> +}
>>>>>> +
>>>>>> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
>>>>>> +{
>>>>>> +     struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>>>>>> +
>>>>>> +     clk_bulk_disable(smmu->num_clks, smmu->clks);
>>>>>> +
>>>>>> +     return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static const struct dev_pm_ops arm_smmu_pm_ops = {
>>>>>> +     SET_SYSTEM_SLEEP_PM_OPS(NULL, arm_smmu_pm_resume)
>>>>> This is suspicious.
>>>>>
>>>>> If you need a runtime suspend method, why do you think that it is not necessary
>>>>> to suspend the device during system-wide transitions?
>>>> Okay, so you suggest to put clock disabling in say arm_smmu_pm_suspend()?
>>>> In that case the clocks have to be enabled in the resume path too.
>>>>
>>>> I remember Tomasz pointed to that we shouldn't need clock enable in resume
>>>> path [1].
>>>>
>>>> [1] https://lkml.org/lkml/2018/3/15/60
>> That was an answer for a different question. I don't remember
>> suggesting having no suspend function. Although, given the PM
>> subsystem internals, the suspend function wouldn't be called on SMMU
>> implementation needed power control (since they would have runtime PM
>> enabled) and on others, it would be called but do nothing (since no
>> clocks).
>>
>>> Honestly, I just don't know. :-)
>>>
>>> It just looks odd the way it is done.  I think the clock should be
>>> gated during system-wide suspend too, because the system can spend
>>> much more time in a sleep state than in the working state, on average.
>>>
>>> And note that you cannot rely on runtime PM to always do it for you,
>>> because it may be disabled at a client device or even blocked by user
>>> space via power/control in sysfs and that shouldn't matter for
>>> system-wide PM.
>> User space blocking runtime PM through sysfs is a good point. I'm not
>> 100% sure how the PM subsystem deals with that in case of system-wide
>> suspend. I guess for consistency and safety, we should have the
>> suspend callback.
>
> Frankly, if there are no other reasons I suggest to wire system
> suspend/resume to pm_runtime_force_* helpers:
> SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>                          pm_runtime_force_resume).

Not a good idea at all IMO.

Use PM driver flags rather I'd say.

> This way you will have everything related to suspending and resuming in
> one place and you would not need to bother about all possible cases (like
> suspending from runtime pm active and suspending from runtime pm suspended
> cases as well as restoring proper device state on resume). This is
> especially important in recent kernel releases, where devices are
> system-suspended regardless their runtime pm states (in older kernels
> devices were first runtime resumed for system suspend, what made code
> simpler, but wasn't best from power consumption perspective).
>
> If you go this way, You only need to ensure that runtime resume will also
> restore proper device state besides enabling all the clocks. This will
> also prepare your driver to properly operate inside power domain, where it
> is possible for device to loose its internal state after runtime suspend
> when respective power domain has been turned off.

I'm not sure if you are aware of the pm_runtime_force_* limitations, though.

Thanks,
Rafael
