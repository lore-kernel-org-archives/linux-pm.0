From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v12 1/4] iommu/arm-smmu: Add pm_runtime/sleep ops
Date: Wed, 11 Jul 2018 13:11:11 +0200
Message-ID: <CAJZ5v0gbkdkx_+oHYiPz=SFdFCLm38hsi1TmJ2Jdc7j73TNtzg@mail.gmail.com>
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
	<20180708173413.1965-2-vivek.gautam@codeaurora.org>
	<17407514.unFVTGoGrn@aspire.rjw.lan>
	<CAFp+6iHxJucfzJJeEvSToG4p2zADjDb9F0L8h053x-JKAy55mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAFp+6iHxJucfzJJeEvSToG4p2zADjDb9F0L8h053x-JKAy55mg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Boyd <sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, robh+dt <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 11, 2018 at 12:55 PM, Vivek Gautam
<vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> Hi Rafael,
>
>
> On Wed, Jul 11, 2018 at 3:20 PM, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:
>> On Sunday, July 8, 2018 7:34:10 PM CEST Vivek Gautam wrote:
>>> From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>
>>> The smmu needs to be functional only when the respective
>>> master's using it are active. The device_link feature
>>> helps to track such functional dependencies, so that the
>>> iommu gets powered when the master device enables itself
>>> using pm_runtime. So by adapting the smmu driver for
>>> runtime pm, above said dependency can be addressed.
>>>
>>> This patch adds the pm runtime/sleep callbacks to the
>>> driver and also the functions to parse the smmu clocks
>>> from DT and enable them in resume/suspend.
>>>
>>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>> Signed-off-by: Archit Taneja <architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>> [vivek: Clock rework to request bulk of clocks]
>>> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>> Reviewed-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>>> ---
>>>
>>>  - No change since v11.
>>>
>>>  drivers/iommu/arm-smmu.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++--
>>>  1 file changed, 58 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>> index f7a96bcf94a6..a01d0dde21dd 100644
>>> --- a/drivers/iommu/arm-smmu.c
>>> +++ b/drivers/iommu/arm-smmu.c
>>> @@ -48,6 +48,7 @@
>>>  #include <linux/of_iommu.h>
>>>  #include <linux/pci.h>
>>>  #include <linux/platform_device.h>
>>> +#include <linux/pm_runtime.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/spinlock.h>
>>>
>>> @@ -205,6 +206,8 @@ struct arm_smmu_device {
>>>       u32                             num_global_irqs;
>>>       u32                             num_context_irqs;
>>>       unsigned int                    *irqs;
>>> +     struct clk_bulk_data            *clks;
>>> +     int                             num_clks;
>>>
>>>       u32                             cavium_id_base; /* Specific to Cavium */
>>>
>>> @@ -1897,10 +1900,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>>>  struct arm_smmu_match_data {
>>>       enum arm_smmu_arch_version version;
>>>       enum arm_smmu_implementation model;
>>> +     const char * const *clks;
>>> +     int num_clks;
>>>  };
>>>
>>>  #define ARM_SMMU_MATCH_DATA(name, ver, imp)  \
>>> -static struct arm_smmu_match_data name = { .version = ver, .model = imp }
>>> +static const struct arm_smmu_match_data name = { .version = ver, .model = imp }
>>>
>>>  ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
>>>  ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
>>> @@ -1919,6 +1924,23 @@ static const struct of_device_id arm_smmu_of_match[] = {
>>>  };
>>>  MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
>>>
>>> +static void arm_smmu_fill_clk_data(struct arm_smmu_device *smmu,
>>> +                                const char * const *clks)
>>> +{
>>> +     int i;
>>> +
>>> +     if (smmu->num_clks < 1)
>>> +             return;
>>> +
>>> +     smmu->clks = devm_kcalloc(smmu->dev, smmu->num_clks,
>>> +                               sizeof(*smmu->clks), GFP_KERNEL);
>>> +     if (!smmu->clks)
>>> +             return;
>>> +
>>> +     for (i = 0; i < smmu->num_clks; i++)
>>> +             smmu->clks[i].id = clks[i];
>>> +}
>>> +
>>>  #ifdef CONFIG_ACPI
>>>  static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
>>>  {
>>> @@ -2001,6 +2023,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>>>       data = of_device_get_match_data(dev);
>>>       smmu->version = data->version;
>>>       smmu->model = data->model;
>>> +     smmu->num_clks = data->num_clks;
>>> +
>>> +     arm_smmu_fill_clk_data(smmu, data->clks);
>>>
>>>       parse_driver_options(smmu);
>>>
>>> @@ -2099,6 +2124,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>>               smmu->irqs[i] = irq;
>>>       }
>>>
>>> +     err = devm_clk_bulk_get(smmu->dev, smmu->num_clks, smmu->clks);
>>> +     if (err)
>>> +             return err;
>>> +
>>> +     err = clk_bulk_prepare(smmu->num_clks, smmu->clks);
>>> +     if (err)
>>> +             return err;
>>> +
>>>       err = arm_smmu_device_cfg_probe(smmu);
>>>       if (err)
>>>               return err;
>>> @@ -2181,6 +2214,9 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>>>
>>>       /* Turn the thing off */
>>>       writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
>>> +
>>> +     clk_bulk_unprepare(smmu->num_clks, smmu->clks);
>>> +
>>>       return 0;
>>>  }
>>>
>>> @@ -2197,7 +2233,27 @@ static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
>>>       return 0;
>>>  }
>>>
>>> -static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
>>> +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
>>> +{
>>> +     struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>>> +
>>> +     return clk_bulk_enable(smmu->num_clks, smmu->clks);
>>> +}
>>> +
>>> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
>>> +{
>>> +     struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>>> +
>>> +     clk_bulk_disable(smmu->num_clks, smmu->clks);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static const struct dev_pm_ops arm_smmu_pm_ops = {
>>> +     SET_SYSTEM_SLEEP_PM_OPS(NULL, arm_smmu_pm_resume)
>>
>> This is suspicious.
>>
>> If you need a runtime suspend method, why do you think that it is not necessary
>> to suspend the device during system-wide transitions?
>
> Okay, so you suggest to put clock disabling in say arm_smmu_pm_suspend()?
> In that case the clocks have to be enabled in the resume path too.
>
> I remember Tomasz pointed to that we shouldn't need clock enable in resume
> path [1].
>
> [1] https://lkml.org/lkml/2018/3/15/60

Honestly, I just don't know. :-)

It just looks odd the way it is done.  I think the clock should be
gated during system-wide suspend too, because the system can spend
much more time in a sleep state than in the working state, on average.

And note that you cannot rely on runtime PM to always do it for you,
because it may be disabled at a client device or even blocked by user
space via power/control in sysfs and that shouldn't matter for
system-wide PM.

Thanks,
Rafael
