From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] base: power: runtime: Export pm_runtime_get/put_suppliers
Date: Wed, 03 Jan 2018 13:01:11 +0100
Message-ID: <1775824.eJFJEB3one@aspire.rjw.lan>
References: <1512736247-16538-1-git-send-email-vivek.gautam@codeaurora.org> <CAJZ5v0jfmHHqwZU-x9CMD_CggH5U0Z3=7myfa73XG5916E57AA@mail.gmail.com> <CAFp+6iHLMi_t77602f1EEazcuP_+yJvJ5pEs2ZbtGC3rOsCD5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:60245 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbeACMCQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jan 2018 07:02:16 -0500
In-Reply-To: <CAFp+6iHLMi_t77602f1EEazcuP_+yJvJ5pEs2ZbtGC3rOsCD5A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Rob Clark <robdclark@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>

On Friday, December 8, 2017 6:03:37 PM CET Vivek Gautam wrote:
> On Fri, Dec 8, 2017 at 7:37 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Fri, Dec 8, 2017 at 2:39 PM, Vivek Gautam
> > <vivek.gautam@codeaurora.org> wrote:
> >> Hi Greg,
> >>
> >>
> >> On Fri, Dec 8, 2017 at 6:51 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> >>> On Fri, Dec 08, 2017 at 06:00:47PM +0530, Vivek Gautam wrote:
> >>>> The device link allows the pm framework to tie the supplier and
> >>>> consumer. So, whenever the consumer is powered-on, the supplier
> >>>> is powered-on first.
> >>>>
> >>>> There are however cases in which the consumer wants to power-on
> >>>> the supplier, but not itself.
> >>>> E.g., A Graphics or multimedia driver wants to power-on the SMMU
> >>>> to unmap a buffer and finish the TLB operations without powering
> >>>> on itself. Some of these unmap requests are coming from the
> >>>> user space when the controller itself is not powered-up, and it
> >>>> can be huge penalty in terms of power and latency to power-up
> >>>> the graphics/mm controllers.
> >>>> There can be an argument that the supplier should handle this case
> >>>> on its own and there should not be a need for the consumer to
> >>>> power-on the supplier. But as discussed on the thread [1] about
> >>>> ARM-SMMU runtime pm, we don't want to introduce runtime pm calls
> >>>> in atomic paths, such as in arm_smmu_unmap.
> >>>>
> >>>> [1] https://patchwork.kernel.org/patch/9827825/
> >>>>
> >>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> >>>> ---
> >>>>  drivers/base/power/runtime.c | 2 ++
> >>>>  1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> >>>> index 027d159ac381..af169304ca13 100644
> >>>> --- a/drivers/base/power/runtime.c
> >>>> +++ b/drivers/base/power/runtime.c
> >>>> @@ -1578,6 +1578,7 @@ void pm_runtime_get_suppliers(struct device *dev)
> >>>>
> >>>>       device_links_read_unlock(idx);
> >>>>  }
> >>>> +EXPORT_SYMBOL_GPL(pm_runtime_get_suppliers);
> >>>
> >>> We do not export symbols unless there are in-kernel users of them.
> >>> Where is the patch that adds a user for these functions?
> >>
> >> My apologies for not putting the changes for the user of these APIs.
> >> I will be sending a patch for the user (which would be:
> >> "drivers/gpu/drm/msm/msm_iommu.c"). The patch will be included
> >> with the arm-smmu runtime patch series. Right now I am facing issues
> >> with the use of clk_bulk_*() APIs on 4.15-rc kernel.
> >>
> >> But, I wanted to get opinions about this change since we had been
> >> discussing about this in the arm-smmu runtime patch thread [1].
> >>
> >> [1] https://patchwork.kernel.org/patch/9827825/
> >>
> >>
> >> P.S.: A snippet of the change in the user of these APIs:
> >>
> >>  diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> >>  index b23d33622f37..1ab629bbee69 100644
> >>  --- a/drivers/gpu/drm/msm/msm_iommu.c
> >>  +++ b/drivers/gpu/drm/msm/msm_iommu.c
> >>  @@ -76,9 +76,9 @@ static int msm_iommu_unmap(struct msm_mmu *mmu,
> >> uint64_t iova,
> >>   {
> >>          struct msm_iommu *iommu = to_msm_iommu(mmu);
> >>
> >>  -       pm_runtime_get_sync(mmu->dev);
> >>  +       pm_runtime_get_suppliers(mmu->dev);
> >>          iommu_unmap(iommu->domain, iova, len);
> >>  -       pm_runtime_put_sync(mmu->dev);
> >>  +       pm_runtime_put_suppliers(mmu->dev);
> >>
> >>          return 0;
> >>   }
> >>
> >
> > Well, pm_runtime_get/put_suppliers() were not designed to be used
> > outside of the runtime PM core code.  I need to have a deeper look
> > into things at this point, so give me some time.
> 
> Thanks Rafael.

No problem, sorry for the delay.

It should be OK to export these routines as you proposed, but again,
please post this patch along with the driver changes depending on it.

Thanks,
Rafael
