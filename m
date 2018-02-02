From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v6 4/6] iommu/arm-smmu: Add the device_link between
 masters and smmu
Date: Fri, 2 Feb 2018 11:31:58 +0000
Message-ID: <f8932e2f-75bb-ce30-ae68-1870477fad5f@arm.com>
References: <1516362223-22946-1-git-send-email-vivek.gautam@codeaurora.org>
 <1516362223-22946-5-git-send-email-vivek.gautam@codeaurora.org>
 <6b930150-cb81-b0a5-601c-16cb576c4341@arm.com>
 <b7887b45-774a-2515-4304-227037b9af1f@codeaurora.org>
 <7cc4caec-4264-db9d-3afa-e3d20d3edfa7@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <7cc4caec-4264-db9d-3afa-e3d20d3edfa7@codeaurora.org>
Content-Language: en-GB
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, alex.williamson@redhat.com, robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, sboyd@codeaurora.org
Cc: gregkh@linuxfoundation.org, m.szyprowski@samsung.com, architt@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 02/02/18 05:40, Sricharan R wrote:
> Hi Robin/Vivek,
> 
> On 2/1/2018 2:23 PM, Vivek Gautam wrote:
>> Hi,
>>
>>
>> On 1/31/2018 6:39 PM, Robin Murphy wrote:
>>> On 19/01/18 11:43, Vivek Gautam wrote:
>>>> From: Sricharan R <sricharan@codeaurora.org>
>>>>
>>>> Finally add the device link between the master device and
>>>> smmu, so that the smmu gets runtime enabled/disabled only when the
>>>> master needs it. This is done from add_device callback which gets
>>>> called once when the master is added to the smmu.
>>>
>>> Don't we need to balance this with a device_link_del() in .remove_device (like exynos-iommu does)?
>>
>> Right. Will add device_link_del() call. Thanks for pointing out.
> 
>   The reason for not adding device_link_del from .remove_device was, the core device_del
>   which calls the .remove_device from notifier, calls device_links_purge before that.
>   That does the same thing as device_link_del. So by the time .remove_device is called,
>   device_links for that device is already cleaned up. Vivek, you may want to check once that
>   calling device_link_del from .remove_device has no effect, just to confirm once more.

There is at least one path in which .remove_device is not called via the 
notifier from device_del(), which is in the cleanup path of 
iommu_bus_init(). AFAICS any links created by .add_device during that 
process would be left dangling, because the device(s) would be live but 
otherwise disassociated from the IOMMU afterwards.

 From a maintenance perspective it's easier to have the call in its 
logical place even if it does nothing 99% of the time; that way we 
shouldn't have to keep an eye out for subtle changes in the power 
management code or driver core that might invalidate the device_del() 
reasoning above, and the power management guys shouldn't have to 
comprehend the internals of the IOMMU API to make sense of the 
unbalanced call if they ever want to change their API.

Thanks,
Robin.
