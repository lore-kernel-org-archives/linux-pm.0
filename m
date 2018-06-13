From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] PM / core: Fix supplier device runtime PM usage counter
 imbalance
Date: Wed, 13 Jun 2018 08:42:55 +0200
Message-ID: <20180613064258eucas1p2f8a082548d80bbc02f26aaa8773383b9~3pSVbThtx0723907239eucas1p2l@eucas1p2.samsung.com>
References: <CGME20180612110807epcas5p10e076681eac6f50b01840c0052748d12@epcas5p1.samsung.com>
        <10125310.W3e2TP0641@aspire.rjw.lan>
        <20180612124424eucas1p101e61369a42132234d103ce52918b08e~3akoRUwbQ3138731387eucas1p17@eucas1p1.samsung.com>
        <CAPDyKFpSx7Kif_AtrVNtPSW0gy4058VBCfFQgMqMWVQGq+2BXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpSx7Kif_AtrVNtPSW0gy4058VBCfFQgMqMWVQGq+2BXA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Hi Ulf,

On 2018-06-12 21:43, Ulf Hansson wrote:
> On 12 June 2018 at 14:44, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> On 2018-06-12 13:00, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> If a device link is added via device_link_add() by the driver of the
>>> link's consumer device, the supplier's runtime PM usage counter is
>>> going to be dropped by the pm_runtime_put_suppliers() call in
>>> driver_probe_device().  However, in that case it is not incremented
>>> unless the supplier driver is already present and the link is not
>>> stateless.  That leads to a runtime PM usage counter imbalance for
>>> the supplier device in a few cases.
>>>
>>> To prevent that from happening, bump up the supplier runtime
>>> PM usage counter in device_link_add() for all links with the
>>> DL_FLAG_PM_RUNTIME flag set that are added at the consumer probe
>>> time.  Use pm_runtime_get_noresume() for that as the callers of
>>> device_link_add() who want the supplier to be resumed by it should
>>> pass DL_FLAG_RPM_ACTIVE in flags to it anyway.
>>>
>>> Fixes: 21d5c57b3726 (PM / runtime: Use device links)
>>> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>
>>> This is a replacement for commit 1e8378619841 (PM / runtime: Fixup
>>> reference counting of device link suppliers at probe) that is going
>>> to be reverted.
>> Thanks Rafael for the patch. I've applied it and now I'm a bit puzzled.
>> Let's get back to my IOMMU and codec case, mentioned here:
>> https://marc.info/?l=linux-pm&m=152878741527962&w=2
>>
>> Now, after applying your patch, when IOMMU creates a link with
>> DL_FLAG_PM_RUNTIME to the jpeg device (this happens when jpeg device is
>> being probed), it is not IOMMU is not runtime resumed anymore (that's
>> because the patch changes pm_runtime_get_sync to pm_runtime_get_noresume).
> According to your earlier replies, I thought this is what you wanted. No?
>
>> This means that until jpeg driver enables runtime pm for its device and
>> finally performs runtime pm suspends/resume cycle, the supplier won't be
>> resumed.
> What's the problem with that?

Wasted power. IOMMU device is left enabled until first use of JPEG device,
what means that respective power domain is also turned on unnecessarily.

> When does the IOMMU device needs to be
> runtime resumed?

I would like to have IOMMU (supplier) runtime active all the time the JPEG
(consumer) device is runtime active AND all the time between probe() and
remove() if JPEG (consumer) doesn't support runtime PM (if it doesn't
enable runtime PM at all).

>> On the other hand, when I add DL_FLAG_RPM_ACTIVE flag to link
>> creation, the supplier is properly resumed, but then, once the jpeg
>> device probe finishes, the supplier is still in runtime active state
>> until a next runtime suspend/resume cycle of jpeg device.
> Could you elaborate on the what happens in jpeg driver during probe,
> in regards to runtime PM. Perhaps you can also point me to what driver
> it is?

s5p_jpeg_probe() doesn't touch hardware at all and only calls 
pm_runtime_enable(),
see drivers/media/platform/s5p-jpeg/jpeg-core.c

>> If I understand
>> right, the DL_FLAG_RPM_ACTIVE flag should be there from the beginning,
>> but that time it runtime pm part of links worked in a bit different way
>> than now.
> Just to make sure, you also reverted 1e8378619841, before trying
> Rafael's change on top?

Yes

>> Is there any way to keep old behavior?
> I think the old behavior is sub-optimal. I am sure there are users
> that really don't want the driver core to runtime resume the supplier
> unconditionally.
>
> I would rather go and fix the few users of device_link_add(), to use
> DL_FLAG_RPM_ACTIVE, in cases when they need it. Of course I am fine if
> we do these changes in a step by step basis as well.

I also agree that the old behavior is sub-optimal and there are use
cases for the new (corrected) approach. I see no problems to add
DL_FLAG_RPM_ACTIVE to exynos-iommu driver (and probably the 5 other
drivers, which create links with DL_FLAG_PM_RUNTIME flag set to avoid
regressions). The question is what else should be changed/fixed to get
old behavior now.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
