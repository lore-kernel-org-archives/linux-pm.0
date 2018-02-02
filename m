From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v6 4/6] iommu/arm-smmu: Add the device_link between
 masters and smmu
Date: Fri, 2 Feb 2018 11:10:25 +0530
Message-ID: <7cc4caec-4264-db9d-3afa-e3d20d3edfa7@codeaurora.org>
References: <1516362223-22946-1-git-send-email-vivek.gautam@codeaurora.org>
 <1516362223-22946-5-git-send-email-vivek.gautam@codeaurora.org>
 <6b930150-cb81-b0a5-601c-16cb576c4341@arm.com>
 <b7887b45-774a-2515-4304-227037b9af1f@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b7887b45-774a-2515-4304-227037b9af1f-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Robin/Vivek,

On 2/1/2018 2:23 PM, Vivek Gautam wrote:
> Hi,
> 
> 
> On 1/31/2018 6:39 PM, Robin Murphy wrote:
>> On 19/01/18 11:43, Vivek Gautam wrote:
>>> From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>
>>> Finally add the device link between the master device and
>>> smmu, so that the smmu gets runtime enabled/disabled only when the
>>> master needs it. This is done from add_device callback which gets
>>> called once when the master is added to the smmu.
>>
>> Don't we need to balance this with a device_link_del() in .remove_device (like exynos-iommu does)?
> 
> Right. Will add device_link_del() call. Thanks for pointing out.

 The reason for not adding device_link_del from .remove_device was, the core device_del 
 which calls the .remove_device from notifier, calls device_links_purge before that.
 That does the same thing as device_link_del. So by the time .remove_device is called,
 device_links for that device is already cleaned up. Vivek, you may want to check once that
 calling device_link_del from .remove_device has no effect, just to confirm once more.

Regards,
 Sricharan
 
> 
> regards
> Vivek
> 
>>
>> Robin.
>>
>>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>> ---
>>>   drivers/iommu/arm-smmu.c | 11 +++++++++++
>>>   1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>> index 95478bfb182c..33bbcfedb896 100644
>>> --- a/drivers/iommu/arm-smmu.c
>>> +++ b/drivers/iommu/arm-smmu.c
>>> @@ -1367,6 +1367,7 @@ static int arm_smmu_add_device(struct device *dev)
>>>       struct arm_smmu_device *smmu;
>>>       struct arm_smmu_master_cfg *cfg;
>>>       struct iommu_fwspec *fwspec = dev->iommu_fwspec;
>>> +    struct device_link *link;
>>>       int i, ret;
>>>         if (using_legacy_binding) {
>>> @@ -1428,6 +1429,16 @@ static int arm_smmu_add_device(struct device *dev)
>>>         pm_runtime_put_sync(smmu->dev);
>>>   +    /*
>>> +     * Establish the link between smmu and master, so that the
>>> +     * smmu gets runtime enabled/disabled as per the master's
>>> +     * needs.
>>> +     */
>>> +    link = device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME);
>>> +    if (!link)
>>> +        dev_warn(smmu->dev, "Unable to create device link between %s and %s\n",
>>> +             dev_name(smmu->dev), dev_name(dev));
>>> +
>>>       return 0;
>>>     out_cfg_free:
>>>
> 

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
