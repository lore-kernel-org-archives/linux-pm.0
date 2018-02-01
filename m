From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v6 3/6] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
Date: Thu, 1 Feb 2018 18:01:54 +0530
Message-ID: <f580d22b-972f-3033-7a80-daea308c81f5@codeaurora.org>
References: <1516362223-22946-1-git-send-email-vivek.gautam@codeaurora.org>
 <1516362223-22946-4-git-send-email-vivek.gautam@codeaurora.org>
 <5367e45a-8406-6dd2-1eb8-e1de9095af1a@arm.com>
 <bb9c23ec-c6d8-80fe-a80f-c33c961ab657@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <bb9c23ec-c6d8-80fe-a80f-c33c961ab657-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 2/1/2018 5:03 PM, Sricharan R wrote:
> Hi Robin,
>
> On 1/31/2018 6:36 PM, Robin Murphy wrote:
>> On 19/01/18 11:43, Vivek Gautam wrote:
>>> From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>
>>> The smmu device probe/remove and add/remove master device callbacks
>>> gets called when the smmu is not linked to its master, that is without
>>> the context of the master device. So calling runtime apis in those places
>>> separately.
>>>
>>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>> [vivek: Cleanup pm runtime calls]
>>> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>> ---
>>>    drivers/iommu/arm-smmu.c | 45 +++++++++++++++++++++++++++++++++++++++++----
>>>    1 file changed, 41 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>> index 21acffe91a1c..95478bfb182c 100644
>>> --- a/drivers/iommu/arm-smmu.c
>>> +++ b/drivers/iommu/arm-smmu.c
>>> @@ -914,11 +914,15 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>>>        struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>>        struct arm_smmu_device *smmu = smmu_domain->smmu;
>>>        struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>>> -    int irq;
>>> +    int ret, irq;
>>>          if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
>>>            return;
>>>    +    ret = pm_runtime_get_sync(smmu->dev);
>>> +    if (ret)
>>> +        return;
>>> +
>>>        /*
>>>         * Disable the context bank and free the page tables before freeing
>>>         * it.
>>> @@ -933,6 +937,8 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>>>          free_io_pgtable_ops(smmu_domain->pgtbl_ops);
>>>        __arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
>>> +
>>> +    pm_runtime_put_sync(smmu->dev);
>>>    }
>>>      static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>>> @@ -1408,12 +1414,20 @@ static int arm_smmu_add_device(struct device *dev)
>>>        while (i--)
>>>            cfg->smendx[i] = INVALID_SMENDX;
>>>    -    ret = arm_smmu_master_alloc_smes(dev);
>>> +    ret = pm_runtime_get_sync(smmu->dev);
>>>        if (ret)
>>>            goto out_cfg_free;
>>>    +    ret = arm_smmu_master_alloc_smes(dev);
>>> +    if (ret) {
>>> +        pm_runtime_put_sync(smmu->dev);
>>> +        goto out_cfg_free;
>> Please keep to the existing pattern and put this on the cleanup path with a new label, rather than inline.
>   ok.
>
>>> +    }
>>> +
>>>        iommu_device_link(&smmu->iommu, dev);
>>>    +    pm_runtime_put_sync(smmu->dev);
>>> +
>>>        return 0;
>>>      out_cfg_free:
>>> @@ -1428,7 +1442,7 @@ static void arm_smmu_remove_device(struct device *dev)
>>>        struct iommu_fwspec *fwspec = dev->iommu_fwspec;
>>>        struct arm_smmu_master_cfg *cfg;
>>>        struct arm_smmu_device *smmu;
>>> -
>>> +    int ret;
>>>          if (!fwspec || fwspec->ops != &arm_smmu_ops)
>>>            return;
>>> @@ -1436,8 +1450,21 @@ static void arm_smmu_remove_device(struct device *dev)
>>>        cfg  = fwspec->iommu_priv;
>>>        smmu = cfg->smmu;
>>>    +    /*
>>> +     * The device link between the master device and
>>> +     * smmu is already purged at this point.
>>> +     * So enable the power to smmu explicitly.
>>> +     */
>> I don't understand this comment, especially since we don't even introduce device links until the following patch... :/
>>
>   This is because the core device_del callback, does a device_links_purge for that device,
>   before calling the remove_device notifier. As a result, have to explicitly turn on the
>   power to iommu. Probably the comment should be removed, rest of the places we don't
>   explain why we are turning on explicitly.

Yes, will remove the comment here.

>
>>> +
>>> +    ret = pm_runtime_get_sync(smmu->dev);
>>> +    if (ret)
>>> +        return;
>>> +
>>>        iommu_device_unlink(&smmu->iommu, dev);
>>>        arm_smmu_master_free_smes(fwspec);
>>> +
>>> +    pm_runtime_put_sync(smmu->dev);
>>> +
>>>        iommu_group_remove_device(dev);
>>>        kfree(fwspec->iommu_priv);
>>>        iommu_fwspec_free(dev);
>>> @@ -2130,6 +2157,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>>        if (err)
>>>            return err;
>>>    +    platform_set_drvdata(pdev, smmu);
>>> +
>>> +    pm_runtime_enable(dev);
>>> +
>>> +    err = pm_runtime_get_sync(dev);
>>> +    if (err)
>>> +        return err;
>>> +
>>>        err = arm_smmu_device_cfg_probe(smmu);
>>>        if (err)
>>>            return err;
>>> @@ -2171,9 +2206,9 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>>            return err;
>>>        }
>>>    -    platform_set_drvdata(pdev, smmu);
>>>        arm_smmu_device_reset(smmu);
>>>        arm_smmu_test_smr_masks(smmu);
>>> +    pm_runtime_put_sync(dev);
>>>          /*
>>>         * For ACPI and generic DT bindings, an SMMU will be probed before
>>> @@ -2212,6 +2247,8 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>>>          /* Turn the thing off */
>>>        writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
>>> +    pm_runtime_force_suspend(smmu->dev);
>> Why do we need this? I guess it might be a Qualcomm-ism as I don't see anyone else calling it from .remove other than a couple of other qcom_* drivers. Given that we only get here during system shutdown (or the root user intentionally pissing about with driver unbinding), it doesn't seem like a point where power saving really matters all that much.
>>
>> I'd also naively expect that anything this device was the last consumer off would get turned off by core code anyway once it's removed, but maybe things aren't that slick; I dunno :/
>   hmm, that should not be needed. with turning of all consumers taken care by device_link code before
>   the supplier (iommu) remove gets called should ensure that. So the above force_suspend should
>   not be needed/can be removed. But one more thing is, we do touch the register in the above code.
>   So that should require a additional get/put sync around that writel.

Possibly we can replace the force_suspend() with a pm_runtime_disable() 
to complement pm_runtime_enable in the probe.
I will test the scenario where we are writing the SMMU register in 
.remove path.

regards
Vivek

>
> Regards,
>   Sricharan
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
