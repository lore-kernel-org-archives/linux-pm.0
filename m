From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v7 6/6] drm/msm: iommu: Replace runtime calls with runtime
	suppliers
Date: Thu, 15 Feb 2018 13:17:36 +0900
Message-ID: <CAAFQd5A9B-di9svtiJbvk2hz1U1xo61rTY5vt6AD+KR5iMcG-A@mail.gmail.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
	<1517999482-17317-7-git-send-email-vivek.gautam@codeaurora.org>
	<CAAFQd5AjopiX6fDgD+mO+-+d0yj-swEnVCNvccWRBSMO+XVJkA@mail.gmail.com>
	<CAF6AEGs8qcRTvz6srSfc39ybZrPYMVg2w6qkaO2AdWL1GD4mQw@mail.gmail.com>
	<CAAFQd5BKRumpEfAKNF_RKS-ZZ8D671DfOz4vB2+w1SV3aG9NxQ@mail.gmail.com>
	<CAF6AEGuNZJKtwGZ5mLfqNND2jtU+HYM11UONfAtVTzoM0QVpdg@mail.gmail.com>
	<CAAFQd5BZJ1G0RG32hYErNzPRvisBhhiSNCBsjbzfm0WzO=DnsQ@mail.gmail.com>
	<CAFp+6iHaycK=CcE1S15EeuMkaw8LnW0ebptU0hM6tUtWdeEOtA@mail.gmail.com>
	<CAAFQd5Afj-Bj+3wHwmF2tT7y=46EsYEtO_mXfY6stXBgHutEUg@mail.gmail.com>
	<CAFp+6iGX6pr+MdPSSHHG=qOnhHky_8OHiDqAcJ9UudEUv=JMHg@mail.gmail.com>
	<CAAFQd5DiwAugGnPOTw0+XrEfef9x-n-vx59JFuXpNawjiXHwCw@mail.gmail.com>
	<CAFp+6iEW0faeHDfzN_F1bRrHGcVo3sPCk4HSY=t9dnEvHkDkYw@mail.gmail.com>
	<b003ecda-1cbe-4e5f-872b-107154ac40e5@arm.com>
	<CAAFQd5AmG1zSm+CouXOCJbs8SNGFk1-RqfU1nWGjMGJMB-qfvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAFQd5AmG1zSm+CouXOCJbs8SNGFk1-RqfU1nWGjMGJMB-qfvw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 15, 2018 at 12:17 PM, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> On Thu, Feb 15, 2018 at 1:03 AM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>> On 14/02/18 10:33, Vivek Gautam wrote:
>>>
>>> On Wed, Feb 14, 2018 at 2:46 PM, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>>>
>>> Adding Jordan to this thread as well.
>>>
>>>> On Wed, Feb 14, 2018 at 6:13 PM, Vivek Gautam
>>>> <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>>>>>
>>>>> Hi Tomasz,
>>>>>
>>>>> On Wed, Feb 14, 2018 at 11:08 AM, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>>>>> wrote:
>>>>>>
>>>>>> On Wed, Feb 14, 2018 at 1:17 PM, Vivek Gautam
>>>>>> <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>>>>>>>
>>>>>>> Hi Tomasz,
>>>>>>>
>>>>>>> On Wed, Feb 14, 2018 at 8:31 AM, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>> On Wed, Feb 14, 2018 at 11:13 AM, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>> On Tue, Feb 13, 2018 at 8:59 PM, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>>>>>>>>> wrote:
>>>>>>>>>>
>>>>>>>>>> On Wed, Feb 14, 2018 at 3:03 AM, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>>>>>>>> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On Tue, Feb 13, 2018 at 4:10 AM, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>>>>>>>>>>> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Hi Vivek,
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks for the patch. Please see my comments inline.
>>>>>>>>>>>>
>>>>>>>>>>>> On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
>>>>>>>>>>>> <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> While handling the concerned iommu, there should not be a
>>>>>>>>>>>>> need to power control the drm devices from iommu interface.
>>>>>>>>>>>>> If these drm devices need to be powered around this time,
>>>>>>>>>>>>> the respective drivers should take care of this.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Replace the pm_runtime_get/put_sync(<drm_device>) with
>>>>>>>>>>>>> pm_runtime_get/put_suppliers(<drm_device>) calls, to power-up
>>>>>>>>>>>>> the connected iommu through the device link interface.
>>>>>>>>>>>>> In case the device link is not setup these get/put_suppliers()
>>>>>>>>>>>>> calls will be a no-op, and the iommu driver should take care of
>>>>>>>>>>>>> powering on its devices accordingly.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>>   drivers/gpu/drm/msm/msm_iommu.c | 16 ++++++++--------
>>>>>>>>>>>>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/msm/msm_iommu.c
>>>>>>>>>>>>> b/drivers/gpu/drm/msm/msm_iommu.c
>>>>>>>>>>>>> index b23d33622f37..1ab629bbee69 100644
>>>>>>>>>>>>> --- a/drivers/gpu/drm/msm/msm_iommu.c
>>>>>>>>>>>>> +++ b/drivers/gpu/drm/msm/msm_iommu.c
>>>>>>>>>>>>> @@ -40,9 +40,9 @@ static int msm_iommu_attach(struct msm_mmu
>>>>>>>>>>>>> *mmu, const char * const *names,
>>>>>>>>>>>>>          struct msm_iommu *iommu = to_msm_iommu(mmu);
>>>>>>>>>>>>>          int ret;
>>>>>>>>>>>>>
>>>>>>>>>>>>> -       pm_runtime_get_sync(mmu->dev);
>>>>>>>>>>>>> +       pm_runtime_get_suppliers(mmu->dev);
>>>>>>>>>>>>>          ret = iommu_attach_device(iommu->domain, mmu->dev);
>>>>>>>>>>>>> -       pm_runtime_put_sync(mmu->dev);
>>>>>>>>>>>>> +       pm_runtime_put_suppliers(mmu->dev);
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> For me, it looks like a wrong place to handle runtime PM of IOMMU
>>>>>>>>>>>> here. iommu_attach_device() calls into IOMMU driver's
>>>>>>>>>>>> attach_device()
>>>>>>>>>>>> callback and that's where necessary runtime PM gets should
>>>>>>>>>>>> happen, if
>>>>>>>>>>>> any. In other words, driver A (MSM DRM driver) shouldn't be
>>>>>>>>>>>> dealing
>>>>>>>>>>>> with power state of device controlled by driver B (ARM SMMU).
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Note that we end up having to do the same, because of
>>>>>>>>>>> iommu_unmap()
>>>>>>>>>>> while DRM driver is powered off..  it might be cleaner if it was
>>>>>>>>>>> all
>>>>>>>>>>> self contained in the iommu driver, but that would make it so
>>>>>>>>>>> other
>>>>>>>>>>> drivers couldn't call iommu_unmap() from an irq handler, which is
>>>>>>>>>>> apparently something that some of them want to do..
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I'd assume that runtime PM status is already guaranteed to be
>>>>>>>>>> active
>>>>>>>>>> when the IRQ handler is running, by some other means (e.g.
>>>>>>>>>> pm_runtime_get_sync() called earlier, when queuing some work to the
>>>>>>>>>> hardware). Otherwise, I'm not sure how a powered down device could
>>>>>>>>>> trigger an IRQ.
>>>>>>>>>>
>>>>>>>>>> So, if the master device power is already on, suppliers should be
>>>>>>>>>> powered on as well, thanks to device links.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> umm, that is kindof the inverse of the problem..  the problem is
>>>>>>>>> things like gpu driver (and v4l2 drivers that import dma-buf's,
>>>>>>>>> afaict).. they will potentially call iommu->unmap() when device is
>>>>>>>>> not
>>>>>>>>> active (due to userspace or things beyond the control of the
>>>>>>>>> driver)..
>>>>>>>>> so *they* would want iommu to do pm get/put calls.
>>>>>>>>
>>>>>>>>
>>>>>>>> Which is fine and which is actually already done by one of the
>>>>>>>> patches
>>>>>>>> in this series, not for map/unmap, but probe, add_device,
>>>>>>>> remove_device. Having parts of the API doing it inside the callback
>>>>>>>> and other parts outside sounds at least inconsistent.
>>>>>>>>
>>>>>>>>> But other drivers
>>>>>>>>> trying to unmap from irq ctx would not.  Which is the contradictory
>>>>>>>>> requirement that lead to the idea of iommu user powering up iommu
>>>>>>>>> for
>>>>>>>>> unmap.
>>>>>>>>
>>>>>>>>
>>>>>>>> Sorry, maybe I wasn't clear. My last message was supposed to show
>>>>>>>> that
>>>>>>>> it's not contradictory at all, because "other drivers trying to unmap
>>>>>>>> from irq ctx" would already have called pm_runtime_get_*() earlier
>>>>>>>> from a non-irq ctx, which would have also done the same on all the
>>>>>>>> linked suppliers, including the IOMMU. The ultimate result would be
>>>>>>>> that the map/unmap() of the IOMMU driver calling
>>>>>>>> pm_runtime_get_sync()
>>>>>>>> would do nothing besides incrementing the reference count.
>>>>>>>
>>>>>>>
>>>>>>> The entire point was to avoid the slowpath that
>>>>>>> pm_runtime_get/put_sync()
>>>>>>> would add in map/unmap. It would not be correct to add a slowpath in
>>>>>>> irq_ctx
>>>>>>> for taking care of non-irq_ctx and for the situations where master is
>>>>>>> already
>>>>>>> powered-off.
>>>>>>
>>>>>>
>>>>>> Correct me if I'm wrong, but I believe that with what I'm proposing
>>>>>> there wouldn't be any slow path.
>>>>>
>>>>>
>>>>> Yea, but only when the power domain is irq-safe? And not all platforms
>>>>> enable irq-safe power domains. For instance, msm doesn't enable its
>>>>> gdsc power domains as irq-safe.
>>>>> Is it something i am missing?
>>>>
>>>>
>>>> irq-safe would matter if there would exist a case when the call is
>>>> done from IRQ context and the power is off. As I explained in a), it
>>>> shouldn't happen.
>>>
>>>
>>> Hi Robin, Will
>>>
>>> Does adding pm_runtime_get() in map/unmap sounds good to you?
>>
>>
>> Given that we spent significant effort last year removing as much locking as
>> we possibly could from the map/unmap path to minimise the significant
>> performance impact it was having on networking/storage/etc. workloads, I
>> really don't want to introduce more for the sake of one specific use-case,
>> so no.
>
> Could you elaborate on what kind of locking you are concerned about?
> As I explained before, the normally happening fast path would lock
> dev->power_lock only for the brief moment of incrementing the runtime
> PM usage counter.

My bad, that's not even it.

The atomic usage counter is incremented beforehands, without any
locking [1] and the spinlock is acquired only for the sake of
validating that device's runtime PM state remained valid indeed [2],
which would be the case in the fast path of the same driver doing two
mappings in parallel, with the master powered on (and so the SMMU,
through device links; if master was not powered on already, powering
on the SMMU is unavoidable anyway and it would add much more latency
than the spinlock itself).

[1] http://elixir.free-electrons.com/linux/v4.16-rc1/source/drivers/base/power/runtime.c#L1028
[2] http://elixir.free-electrons.com/linux/v4.16-rc1/source/drivers/base/power/runtime.c#L613

In any case, I can't imagine this working with V4L2 or anything else
relying on any memory management more generic than calling IOMMU API
directly from the driver, with the IOMMU device having runtime PM
enabled, but without managing the runtime PM from the IOMMU driver's
callbacks that need access to the hardware. As I mentioned before,
only the IOMMU driver knows when exactly the real hardware access
needs to be done (e.g. Rockchip/Exynos don't need to do that for
map/unmap if the power is down, but some implementations of SMMU with
TLB powered separately might need to do so).

Best regards,
Tomasz
