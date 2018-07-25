From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v13 1/4] iommu/arm-smmu: Add pm_runtime/sleep ops
Date: Wed, 25 Jul 2018 23:46:56 +0530
Message-ID: <CAFp+6iF1XzFn1QhWjatxE-1sue-EFS7wNmQ4OB=c3pf1VMLuMA@mail.gmail.com>
References: <20180719101539.6104-1-vivek.gautam@codeaurora.org>
	<20180719101539.6104-2-vivek.gautam@codeaurora.org>
	<e17fdcb7-2632-753f-4e2e-f81bcded36f1@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <e17fdcb7-2632-753f-4e2e-f81bcded36f1-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, robh+dt <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 24, 2018 at 8:51 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> On 19/07/18 11:15, Vivek Gautam wrote:
>>
>> From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>
>> The smmu needs to be functional only when the respective
>> master's using it are active. The device_link feature
>> helps to track such functional dependencies, so that the
>> iommu gets powered when the master device enables itself
>> using pm_runtime. So by adapting the smmu driver for
>> runtime pm, above said dependency can be addressed.
>>
>> This patch adds the pm runtime/sleep callbacks to the
>> driver and also the functions to parse the smmu clocks
>> from DT and enable them in resume/suspend.
>>
>> Also, while we enable the runtime pm add a pm sleep suspend
>> callback that pushes devices to low power state by turning
>> the clocks off in a system sleep.
>> Also add corresponding clock enable path in resume callback.
>>
>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> Signed-off-by: Archit Taneja <architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> [vivek: rework for clock and pm ops]
>> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> Reviewed-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> ---
>>
>> Changes since v12:
>>   - Added pm sleep .suspend callback. This disables the clocks.
>>   - Added corresponding change to enable clocks in .resume
>>    pm sleep callback.
>>
>>   drivers/iommu/arm-smmu.c | 75
>> ++++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 73 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index c73cfce1ccc0..9138a6fffe04 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -48,6 +48,7 @@
>>   #include <linux/of_iommu.h>
>>   #include <linux/pci.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>>   #include <linux/slab.h>
>>   #include <linux/spinlock.h>
>>   @@ -205,6 +206,8 @@ struct arm_smmu_device {
>>         u32                             num_global_irqs;
>>         u32                             num_context_irqs;
>>         unsigned int                    *irqs;
>> +       struct clk_bulk_data            *clks;
>> +       int                             num_clks;
>>         u32                             cavium_id_base; /* Specific to
>> Cavium */
>>   @@ -1897,10 +1900,12 @@ static int arm_smmu_device_cfg_probe(struct
>> arm_smmu_device *smmu)
>>   struct arm_smmu_match_data {
>>         enum arm_smmu_arch_version version;
>>         enum arm_smmu_implementation model;
>> +       const char * const *clks;
>> +       int num_clks;
>>   };
>>     #define ARM_SMMU_MATCH_DATA(name, ver, imp) \
>> -static struct arm_smmu_match_data name = { .version = ver, .model = imp }
>> +static const struct arm_smmu_match_data name = { .version = ver, .model =
>> imp }
>>     ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
>>   ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
>> @@ -1919,6 +1924,23 @@ static const struct of_device_id
>> arm_smmu_of_match[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
>>   +static void arm_smmu_fill_clk_data(struct arm_smmu_device *smmu,
>> +                                  const char * const *clks)
>> +{
>> +       int i;
>> +
>> +       if (smmu->num_clks < 1)
>> +               return;
>> +
>> +       smmu->clks = devm_kcalloc(smmu->dev, smmu->num_clks,
>> +                                 sizeof(*smmu->clks), GFP_KERNEL);
>> +       if (!smmu->clks)
>> +               return;
>> +
>> +       for (i = 0; i < smmu->num_clks; i++)
>> +               smmu->clks[i].id = clks[i];
>> +}
>> +
>>   #ifdef CONFIG_ACPI
>>   static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
>>   {
>> @@ -2001,6 +2023,9 @@ static int arm_smmu_device_dt_probe(struct
>> platform_device *pdev,
>>         data = of_device_get_match_data(dev);
>>         smmu->version = data->version;
>>         smmu->model = data->model;
>> +       smmu->num_clks = data->num_clks;
>> +
>> +       arm_smmu_fill_clk_data(smmu, data->clks);
>>         parse_driver_options(smmu);
>>   @@ -2099,6 +2124,14 @@ static int arm_smmu_device_probe(struct
>> platform_device *pdev)
>>                 smmu->irqs[i] = irq;
>>         }
>>   +     err = devm_clk_bulk_get(smmu->dev, smmu->num_clks, smmu->clks);
>> +       if (err)
>> +               return err;
>> +
>> +       err = clk_bulk_prepare(smmu->num_clks, smmu->clks);
>> +       if (err)
>> +               return err;
>> +
>>         err = arm_smmu_device_cfg_probe(smmu);
>>         if (err)
>>                 return err;
>> @@ -2181,6 +2214,9 @@ static int arm_smmu_device_remove(struct
>> platform_device *pdev)
>>         /* Turn the thing off */
>>         writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
>> +
>> +       clk_bulk_unprepare(smmu->num_clks, smmu->clks);
>> +
>>         return 0;
>>   }
>>   @@ -2189,15 +2225,50 @@ static void arm_smmu_device_shutdown(struct
>> platform_device *pdev)
>>         arm_smmu_device_remove(pdev);
>>   }
>>   +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
>> +{
>> +       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>> +
>> +       return clk_bulk_enable(smmu->num_clks, smmu->clks);
>
>
> If there's a power domain being automatically switched by genpd then we need
> a reset here because we may have lost state entirely. Since I remembered the
> otherwise-useless GPU SMMU on Juno is in a separate power domain, I gave it
> a poking via sysfs with some debug stuff to dump sCR0 in these callbacks,
> and the problem is clear:
>
> ...
> [    4.625551] arm-smmu 2b400000.iommu: genpd_runtime_suspend()
> [    4.631163] arm-smmu 2b400000.iommu: arm_smmu_runtime_suspend: 0x00201936
> [    4.637897] arm-smmu 2b400000.iommu: suspend latency exceeded, 6733980 ns
> [   21.566983] arm-smmu 2b400000.iommu: genpd_runtime_resume()
> [   21.584796] arm-smmu 2b400000.iommu: arm_smmu_runtime_resume: 0x00220101
> [   21.591452] arm-smmu 2b400000.iommu: resume latency exceeded, 6658020 ns
> ...

Qualcomm SoCs have retention enabled for SMMU registers so they don't
lose state.
...
[  256.013367] arm-smmu b40000.arm,smmu: arm_smmu_runtime_suspend
SCR0 = 0x201e36
[  256.013367]
[  256.019160] arm-smmu b40000.arm,smmu: arm_smmu_runtime_resume
SCR0 = 0x201e36
[  256.019160]
[  256.027368] arm-smmu b40000.arm,smmu: arm_smmu_runtime_suspend
SCR0 = 0x201e36
[  256.027368]
[  256.036786] arm-smmu b40000.arm,smmu: arm_smmu_runtime_resume
SCR0 = 0x201e36
...

However after adding arm_smmu_device_reset() in runtime_resume() I observe
some performance degradation when kill an instance of 'kmscube' and
start it again.
The launch time with arm_smmu_device_reset() in runtime_resume() change is
more.
Could this be because of frequent TLB invalidation and sync?

Best regards
Vivek
>
>> +}
>> +
>> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
>> +{
>> +       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>> +
>> +       clk_bulk_disable(smmu->num_clks, smmu->clks);
>> +
>> +       return 0;
>> +}
>> +
>>   static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
>>   {
>>         struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>> +       int ret;
>> +
>> +       if (!pm_runtime_suspended(dev)) {
>> +               ret = arm_smmu_runtime_resume(dev);
>> +               if (ret)
>> +                       return ret;
>> +       }
>>         arm_smmu_device_reset(smmu);
>
>
> This looks a bit off too - if we wake from sleep when the SMMU was also
> runtime-suspended, it appears we might end up trying to restore the register
> state without clocks enabled. Surely we need to always enable clocks for the
> reset, then restore the previous suspended state? Although given my previous
> point, it's probably not worth doing anything at all here for that case.
>
> Robin.
>
>>         return 0;
>>   }
>>   -static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
>> +static int __maybe_unused arm_smmu_pm_suspend(struct device *dev)
>> +{
>> +       if (!pm_runtime_suspended(dev))
>> +               return arm_smmu_runtime_suspend(dev);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct dev_pm_ops arm_smmu_pm_ops = {
>> +       SET_SYSTEM_SLEEP_PM_OPS(arm_smmu_pm_suspend, arm_smmu_pm_resume)
>> +       SET_RUNTIME_PM_OPS(arm_smmu_runtime_suspend,
>> +                          arm_smmu_runtime_resume, NULL)
>> +};
>>     static struct platform_driver arm_smmu_driver = {
>>         .driver = {
>>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
