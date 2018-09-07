From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v16 2/5] iommu/arm-smmu: Invoke pm_runtime during probe,
	add/remove device
Date: Fri, 7 Sep 2018 15:08:02 +0530
Message-ID: <3ccc3690-dc9d-56e7-e2d1-62e73a189bff@codeaurora.org>
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
	<20180830144541.17740-3-vivek.gautam@codeaurora.org>
	<CAAFQd5B7YR03Jm1upOg2nsaKOb1iDD7-WGo-qx7S8m-nounCvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAFQd5B7YR03Jm1upOg2nsaKOb1iDD7-WGo-qx7S8m-nounCvA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Tomasz,


On 9/7/2018 2:46 PM, Tomasz Figa wrote:
> Hi Vivek,
>
> On Thu, Aug 30, 2018 at 11:46 PM Vivek Gautam
> <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>> From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>
>> The smmu device probe/remove and add/remove master device callbacks
>> gets called when the smmu is not linked to its master, that is without
>> the context of the master device. So calling runtime apis in those places
>> separately.
>> Global locks are also initialized before enabling runtime pm as the
>> runtime_resume() calls device_reset() which does tlb_sync_global()
>> that ultimately requires locks to be initialized.
>>
>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> [vivek: Cleanup pm runtime calls]
>> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> Reviewed-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> Tested-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>   drivers/iommu/arm-smmu.c | 89 +++++++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 81 insertions(+), 8 deletions(-)
> [snip]
>> @@ -2215,10 +2281,17 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>>          if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
>>                  dev_err(&pdev->dev, "removing device with active domains!\n");
>>
>> +       arm_smmu_rpm_get(smmu);
>>          /* Turn the thing off */
>>          writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
>> +       arm_smmu_rpm_put(smmu);
>> +
>> +       if (pm_runtime_enabled(smmu->dev))
>> +               pm_runtime_force_suspend(smmu->dev);
>> +       else
>> +               clk_bulk_disable(smmu->num_clks, smmu->clks);
>>
>> -       clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
>> +       clk_bulk_unprepare(smmu->num_clks, smmu->clks);
> Aren't we missing pm_runtime_disable() here? We'll have the enable
> count unbalanced if the driver is removed and probed again.

pm_runtime_force_suspend() does a pm_runtime_disable() also if i am not 
wrong.
And, as mentioned in a previous thread [1], we were seeing a warning 
which we avoided
by keeping force_suspend().

[1] https://lkml.org/lkml/2018/7/8/124

Thanks
Vivek
>
> Also, if we add pm_runtime_disable(), we can reorder things a bit and
> simplify into:
>
>         arm_smmu_rpm_get(smmu);
>
>         /* Turn the thing off */
>         writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
>
>         if (pm_runtime_enabled())
>                 pm_runtime_disable();
>          arm_smmu_rpm_put(smmu);
>
>          clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
>
> Best regards,
> Tomasz
