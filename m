From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH 1/1] base: power: runtime: Export pm_runtime_get/put_suppliers
Date: Fri, 8 Dec 2017 22:33:37 +0530
Message-ID: <CAFp+6iHLMi_t77602f1EEazcuP_+yJvJ5pEs2ZbtGC3rOsCD5A@mail.gmail.com>
References: <1512736247-16538-1-git-send-email-vivek.gautam@codeaurora.org>
 <20171208132136.GA26631@kroah.com> <CAFp+6iHp5dt80p6-cMKLbcoHLfkRjVztFn8N2kiB24dUeeHpMA@mail.gmail.com>
 <CAJZ5v0jfmHHqwZU-x9CMD_CggH5U0Z3=7myfa73XG5916E57AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jfmHHqwZU-x9CMD_CggH5U0Z3=7myfa73XG5916E57AA@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Rob Clark <robdclark@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 8, 2017 at 7:37 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Dec 8, 2017 at 2:39 PM, Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>> Hi Greg,
>>
>>
>> On Fri, Dec 8, 2017 at 6:51 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>>> On Fri, Dec 08, 2017 at 06:00:47PM +0530, Vivek Gautam wrote:
>>>> The device link allows the pm framework to tie the supplier and
>>>> consumer. So, whenever the consumer is powered-on, the supplier
>>>> is powered-on first.
>>>>
>>>> There are however cases in which the consumer wants to power-on
>>>> the supplier, but not itself.
>>>> E.g., A Graphics or multimedia driver wants to power-on the SMMU
>>>> to unmap a buffer and finish the TLB operations without powering
>>>> on itself. Some of these unmap requests are coming from the
>>>> user space when the controller itself is not powered-up, and it
>>>> can be huge penalty in terms of power and latency to power-up
>>>> the graphics/mm controllers.
>>>> There can be an argument that the supplier should handle this case
>>>> on its own and there should not be a need for the consumer to
>>>> power-on the supplier. But as discussed on the thread [1] about
>>>> ARM-SMMU runtime pm, we don't want to introduce runtime pm calls
>>>> in atomic paths, such as in arm_smmu_unmap.
>>>>
>>>> [1] https://patchwork.kernel.org/patch/9827825/
>>>>
>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>> ---
>>>>  drivers/base/power/runtime.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>>>> index 027d159ac381..af169304ca13 100644
>>>> --- a/drivers/base/power/runtime.c
>>>> +++ b/drivers/base/power/runtime.c
>>>> @@ -1578,6 +1578,7 @@ void pm_runtime_get_suppliers(struct device *dev)
>>>>
>>>>       device_links_read_unlock(idx);
>>>>  }
>>>> +EXPORT_SYMBOL_GPL(pm_runtime_get_suppliers);
>>>
>>> We do not export symbols unless there are in-kernel users of them.
>>> Where is the patch that adds a user for these functions?
>>
>> My apologies for not putting the changes for the user of these APIs.
>> I will be sending a patch for the user (which would be:
>> "drivers/gpu/drm/msm/msm_iommu.c"). The patch will be included
>> with the arm-smmu runtime patch series. Right now I am facing issues
>> with the use of clk_bulk_*() APIs on 4.15-rc kernel.
>>
>> But, I wanted to get opinions about this change since we had been
>> discussing about this in the arm-smmu runtime patch thread [1].
>>
>> [1] https://patchwork.kernel.org/patch/9827825/
>>
>>
>> P.S.: A snippet of the change in the user of these APIs:
>>
>>  diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
>>  index b23d33622f37..1ab629bbee69 100644
>>  --- a/drivers/gpu/drm/msm/msm_iommu.c
>>  +++ b/drivers/gpu/drm/msm/msm_iommu.c
>>  @@ -76,9 +76,9 @@ static int msm_iommu_unmap(struct msm_mmu *mmu,
>> uint64_t iova,
>>   {
>>          struct msm_iommu *iommu = to_msm_iommu(mmu);
>>
>>  -       pm_runtime_get_sync(mmu->dev);
>>  +       pm_runtime_get_suppliers(mmu->dev);
>>          iommu_unmap(iommu->domain, iova, len);
>>  -       pm_runtime_put_sync(mmu->dev);
>>  +       pm_runtime_put_suppliers(mmu->dev);
>>
>>          return 0;
>>   }
>>
>
> Well, pm_runtime_get/put_suppliers() were not designed to be used
> outside of the runtime PM core code.  I need to have a deeper look
> into things at this point, so give me some time.

Thanks Rafael.

regards
Vivek

>
> Thanks,
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
