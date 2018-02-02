From: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH v6 4/6] iommu/arm-smmu: Add the device_link between
 masters and smmu
Date: Fri, 2 Feb 2018 18:44:00 +0530
Message-ID: <8476fe51-e6f9-2028-82e0-353182e4032f@codeaurora.org>
References: <1516362223-22946-1-git-send-email-vivek.gautam@codeaurora.org>
 <1516362223-22946-5-git-send-email-vivek.gautam@codeaurora.org>
 <6b930150-cb81-b0a5-601c-16cb576c4341@arm.com>
 <b7887b45-774a-2515-4304-227037b9af1f@codeaurora.org>
 <7cc4caec-4264-db9d-3afa-e3d20d3edfa7@codeaurora.org>
 <f8932e2f-75bb-ce30-ae68-1870477fad5f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55936 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbeBBNOJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Feb 2018 08:14:09 -0500
In-Reply-To: <f8932e2f-75bb-ce30-ae68-1870477fad5f@arm.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Vivek Gautam <vivek.gautam@codeaurora.org>, alex.williamson@redhat.com, robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, sboyd@codeaurora.org
Cc: gregkh@linuxfoundation.org, m.szyprowski@samsung.com, architt@codeaurora.org, linux-arm-msm@vger.kernel.org

Hi Robin,

On 2/2/2018 5:01 PM, Robin Murphy wrote:
> On 02/02/18 05:40, Sricharan R wrote:
>> Hi Robin/Vivek,
>>
>> On 2/1/2018 2:23 PM, Vivek Gautam wrote:
>>> Hi,
>>>
>>>
>>> On 1/31/2018 6:39 PM, Robin Murphy wrote:
>>>> On 19/01/18 11:43, Vivek Gautam wrote:
>>>>> From: Sricharan R <sricharan@codeaurora.org>
>>>>>
>>>>> Finally add the device link between the master device and
>>>>> smmu, so that the smmu gets runtime enabled/disabled only when the
>>>>> master needs it. This is done from add_device callback which gets
>>>>> called once when the master is added to the smmu.
>>>>
>>>> Don't we need to balance this with a device_link_del() in .remove_device (like exynos-iommu does)?
>>>
>>> Right. Will add device_link_del() call. Thanks for pointing out.
>>
>>   The reason for not adding device_link_del from .remove_device was, the core device_del
>>   which calls the .remove_device from notifier, calls device_links_purge before that.
>>   That does the same thing as device_link_del. So by the time .remove_device is called,
>>   device_links for that device is already cleaned up. Vivek, you may want to check once that
>>   calling device_link_del from .remove_device has no effect, just to confirm once more.
> 
> There is at least one path in which .remove_device is not called via the notifier from device_del(), which is in the cleanup path of iommu_bus_init(). AFAICS any links created by .add_device during that process would be left dangling, because the device(s) would be live but otherwise disassociated from the IOMMU afterwards.
> 
> From a maintenance perspective it's easier to have the call in its logical place even if it does nothing 99% of the time; that way we shouldn't have to keep an eye out for subtle changes in the power management code or driver core that might invalidate the device_del() reasoning above, and the power management guys shouldn't have to comprehend the internals of the IOMMU API to make sense of the unbalanced call if they ever want to change their API.

 Ha, for a moment was thinking that with probe deferral add/remove_iommu_group in iommu_bus_init is dummy.
 But that may not be true for all Archs.
 Surely agree for the maintainability reason as well. Thanks.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
