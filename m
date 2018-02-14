From: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v7 6/6] drm/msm: iommu: Replace runtime calls with runtime suppliers
Date: Wed, 14 Feb 2018 10:59:29 +0900
Message-ID: <CAAFQd5BKRumpEfAKNF_RKS-ZZ8D671DfOz4vB2+w1SV3aG9NxQ@mail.gmail.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-7-git-send-email-vivek.gautam@codeaurora.org>
 <CAAFQd5AjopiX6fDgD+mO+-+d0yj-swEnVCNvccWRBSMO+XVJkA@mail.gmail.com> <CAF6AEGs8qcRTvz6srSfc39ybZrPYMVg2w6qkaO2AdWL1GD4mQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:34153 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966424AbeBNB7y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Feb 2018 20:59:54 -0500
Received: by mail-ua0-f193.google.com with SMTP id g5so12789595uac.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Feb 2018 17:59:53 -0800 (PST)
Received: from mail-ua0-f173.google.com (mail-ua0-f173.google.com. [209.85.217.173])
        by smtp.gmail.com with ESMTPSA id d36sm1511818uai.32.2018.02.13.17.59.50
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Feb 2018 17:59:51 -0800 (PST)
Received: by mail-ua0-f173.google.com with SMTP id i5so12769611uai.10
        for <linux-pm@vger.kernel.org>; Tue, 13 Feb 2018 17:59:50 -0800 (PST)
In-Reply-To: <CAF6AEGs8qcRTvz6srSfc39ybZrPYMVg2w6qkaO2AdWL1GD4mQw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, freedreno <freedreno@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, Greg KH <gregkh@linuxfoundation.org>, Stephen

On Wed, Feb 14, 2018 at 3:03 AM, Rob Clark <robdclark@gmail.com> wrote:
> On Tue, Feb 13, 2018 at 4:10 AM, Tomasz Figa <tfiga@chromium.org> wrote:
>> Hi Vivek,
>>
>> Thanks for the patch. Please see my comments inline.
>>
>> On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
>> <vivek.gautam@codeaurora.org> wrote:
>>> While handling the concerned iommu, there should not be a
>>> need to power control the drm devices from iommu interface.
>>> If these drm devices need to be powered around this time,
>>> the respective drivers should take care of this.
>>>
>>> Replace the pm_runtime_get/put_sync(<drm_device>) with
>>> pm_runtime_get/put_suppliers(<drm_device>) calls, to power-up
>>> the connected iommu through the device link interface.
>>> In case the device link is not setup these get/put_suppliers()
>>> calls will be a no-op, and the iommu driver should take care of
>>> powering on its devices accordingly.
>>>
>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>> ---
>>>  drivers/gpu/drm/msm/msm_iommu.c | 16 ++++++++--------
>>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
>>> index b23d33622f37..1ab629bbee69 100644
>>> --- a/drivers/gpu/drm/msm/msm_iommu.c
>>> +++ b/drivers/gpu/drm/msm/msm_iommu.c
>>> @@ -40,9 +40,9 @@ static int msm_iommu_attach(struct msm_mmu *mmu, const char * const *names,
>>>         struct msm_iommu *iommu = to_msm_iommu(mmu);
>>>         int ret;
>>>
>>> -       pm_runtime_get_sync(mmu->dev);
>>> +       pm_runtime_get_suppliers(mmu->dev);
>>>         ret = iommu_attach_device(iommu->domain, mmu->dev);
>>> -       pm_runtime_put_sync(mmu->dev);
>>> +       pm_runtime_put_suppliers(mmu->dev);
>>
>> For me, it looks like a wrong place to handle runtime PM of IOMMU
>> here. iommu_attach_device() calls into IOMMU driver's attach_device()
>> callback and that's where necessary runtime PM gets should happen, if
>> any. In other words, driver A (MSM DRM driver) shouldn't be dealing
>> with power state of device controlled by driver B (ARM SMMU).
>
> Note that we end up having to do the same, because of iommu_unmap()
> while DRM driver is powered off..  it might be cleaner if it was all
> self contained in the iommu driver, but that would make it so other
> drivers couldn't call iommu_unmap() from an irq handler, which is
> apparently something that some of them want to do..

I'd assume that runtime PM status is already guaranteed to be active
when the IRQ handler is running, by some other means (e.g.
pm_runtime_get_sync() called earlier, when queuing some work to the
hardware). Otherwise, I'm not sure how a powered down device could
trigger an IRQ.

So, if the master device power is already on, suppliers should be
powered on as well, thanks to device links.

Best regards,
Tomasz
