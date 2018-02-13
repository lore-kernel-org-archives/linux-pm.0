From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v7 2/6] iommu/arm-smmu: Add pm_runtime/sleep ops
Date: Tue, 13 Feb 2018 15:55:40 +0530
Message-ID: <CAFp+6iHECNQ_b_rDwNKyHPgNG3xpc+qgpu8cXvqathai6EW9PQ@mail.gmail.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
	<1517999482-17317-3-git-send-email-vivek.gautam@codeaurora.org>
	<CAAFQd5B2u8RL-tdB3qgPxVUcXnsBSEhXRBZWxqO-w6rYKAiOtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAFQd5B2u8RL-tdB3qgPxVUcXnsBSEhXRBZWxqO-w6rYKAiOtg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Tomasz,


Please find my response inline below.

On Tue, Feb 13, 2018 at 1:33 PM, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> Hi Vivek,
>
> Thanks for the patch. Please see some comments inline.
>
> On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
> <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
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
>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> Signed-off-by: Archit Taneja <architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> [vivek: Clock rework to request bulk of clocks]
>> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>  drivers/iommu/arm-smmu.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 54 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 69e7c60792a8..9e2f917e16c2 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -48,6 +48,7 @@
>>  #include <linux/of_iommu.h>
>>  #include <linux/pci.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/slab.h>
>>  #include <linux/spinlock.h>
>>
>> @@ -205,6 +206,8 @@ struct arm_smmu_device {
>>         u32                             num_global_irqs;
>>         u32                             num_context_irqs;
>>         unsigned int                    *irqs;
>> +       struct clk_bulk_data            *clocks;
>> +       int                             num_clks;
>
> nit: Perhaps "num_clocks" to be consistent with "clocks"?
>
>>
>>         u32                             cavium_id_base; /* Specific to Cavium */
>>
>> @@ -1897,10 +1900,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>>  struct arm_smmu_match_data {
>>         enum arm_smmu_arch_version version;
>>         enum arm_smmu_implementation model;
>> +       const char * const *clks;
>> +       int num_clks;
>
> nit: Perhaps s/clks/clocks/ here or s/clocks/clks/ in struct arm_smmu_device?

Sure. Will change to s/clocks/clks/ in struct arm_smmu_device.

>
>>  };
>>
>>  #define ARM_SMMU_MATCH_DATA(name, ver, imp)    \
>> -static struct arm_smmu_match_data name = { .version = ver, .model = imp }
>> +static const struct arm_smmu_match_data name = { .version = ver, .model = imp }
>>
>>  ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
>>  ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
>> @@ -2001,6 +2006,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>>         data = of_device_get_match_data(dev);
>>         smmu->version = data->version;
>>         smmu->model = data->model;
>> +       smmu->num_clks = data->num_clks;
>>
>>         parse_driver_options(smmu);
>>
>> @@ -2039,6 +2045,28 @@ static void arm_smmu_bus_init(void)
>>  #endif
>>  }
>>
>> +static int arm_smmu_init_clks(struct arm_smmu_device *smmu)
>> +{
>> +       int i;
>> +       int num = smmu->num_clks;
>> +       const struct arm_smmu_match_data *data;
>> +
>> +       if (num < 1)
>> +               return 0;
>> +
>> +       smmu->clocks = devm_kcalloc(smmu->dev, num,
>> +                                   sizeof(*smmu->clocks), GFP_KERNEL);
>> +       if (!smmu->clocks)
>> +               return -ENOMEM;
>> +
>> +       data = of_device_get_match_data(smmu->dev);
>> +
>> +       for (i = 0; i < num; i++)
>> +               smmu->clocks[i].id = data->clks[i];
>
> I'd argue that arm_smmu_device_dt_probe() is a better place for all
> the code above, since this function is called regardless of whether
> the device is probed from DT or not. Going further,
> arm_smmu_device_acpi_probe() could fill smmu->num_clks and ->clocks
> using ACPI-like way (as opposed to OF match data) if necessary.

Right, it's valid to fill the data in arm_smmu_device_dt_probe().
Perhaps we can just keep the devm_clk_bulk_get() in arm_smmu_device_probe()
at the point where we are currently doing arm_smmu_init_clks().

Thanks & regards
Vivek

>
> Best regards,
> Tomasz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
