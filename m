From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v7 3/6] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
Date: Tue, 13 Feb 2018 22:52:53 +0900
Message-ID: <CAAFQd5DJtQYPg5S3Ep2bK27+D5rQiKuA-uPfMDUon3FudmGF0w@mail.gmail.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-4-git-send-email-vivek.gautam@codeaurora.org>
 <CAAFQd5DxYhkK61VDAesby6bT+FtG2nqsbHQRvxkhrsSS0KWtog@mail.gmail.com> <906051dd-8898-ec6f-5ad4-3f37716292cf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <906051dd-8898-ec6f-5ad4-3f37716292cf-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 13, 2018 at 9:57 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> On 13/02/18 08:24, Tomasz Figa wrote:
>>
>> Hi Vivek,
>>
>> Thanks for the patch. Please see my comments inline.
>>
>> On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
>> <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>>>
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
>>>   drivers/iommu/arm-smmu.c | 42
>>> ++++++++++++++++++++++++++++++++++++++----
>>>   1 file changed, 38 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>> index 9e2f917e16c2..c024f69c1682 100644
>>> --- a/drivers/iommu/arm-smmu.c
>>> +++ b/drivers/iommu/arm-smmu.c
>>> @@ -913,11 +913,15 @@ static void arm_smmu_destroy_domain_context(struct
>>> iommu_domain *domain)
>>>          struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>>          struct arm_smmu_device *smmu = smmu_domain->smmu;
>>>          struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>>> -       int irq;
>>> +       int ret, irq;
>>>
>>>          if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
>>>                  return;
>>>
>>> +       ret = pm_runtime_get_sync(smmu->dev);
>>> +       if (ret)
>>> +               return;
>>
>>
>> pm_runtime_get_sync() will return 0 if the device was powered off, 1
>> if it was already/still powered on or runtime PM is not compiled in,
>> or a negative value on error, so shouldn't the test be (ret < 0)?
>>
>> Moreover, I'm actually wondering if it makes any sense to power up the
>> hardware just to program it and power it down again. In a system where
>> the IOMMU is located within a power domain, it would cause the IOMMU
>> block to lose its state anyway.
>
>
> This is generally for the case where the SMMU internal state remains active,
> but the programming interface needs to be powered up in order to access it.

That's true for Qualcomm SMMU, but I think that would be different for
existing users of the driver?

>
>> Actually, reflecting back on "[PATCH v7 2/6] iommu/arm-smmu: Add
>> pm_runtime/sleep ops", perhaps it would make more sense to just
>> control the clocks independently of runtime PM? Then, runtime PM could
>> be used for real power management, e.g. really powering the block up
>> and down, for further power saving.
>
>
> Unfortunately that ends up pretty much unmanageable, because there are
> numerous different SMMU microarchitectures with fundamentally different
> clock/power domain schemes (multiplied by individual SoC integration
> possibilities). Since this is fundamentally a generic architectural driver,
> adding explicit clock support would probably make the whole thing about 50%
> clock code, with complicated decision trees around every hardware access
> calculating which clocks are necessary for a given operation on a given
> system. That maintainability aspect is why we've already nacked such a
> fine-grained approach in the past.

Hmm, I think we are talking about different things here. My suggestion
would not add much more code to the driver than this patch does, calls
to arm_smmu_enable_clocks() instead of pm_runtime_get_sync() and
arm_smmu_disable_clocks() instead of pm_runtime_put(). The
implementation of both functions would be a simple call to clk_bulk_
API (possibly even no need to put this into functions, just call
directly).

Best regards,
Tomasz
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
