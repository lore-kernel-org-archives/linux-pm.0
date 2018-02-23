From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v7 3/6] iommu/arm-smmu: Invoke pm_runtime during probe,
	add/remove device
Date: Fri, 23 Feb 2018 16:06:39 +0530
Message-ID: <CAFp+6iGQ5Vckui14Jb=V0uk_Pjes95hOxo=KBijR4yxPeDDzFg@mail.gmail.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
	<1517999482-17317-4-git-send-email-vivek.gautam@codeaurora.org>
	<20180222235200.GA18743@jcrouse-lnx.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180222235200.GA18743-9PYrDHPZ2Orvke4nUoYGnHL1okKdlPRT@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, robh+dt <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>"list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>,
	" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 23, 2018 at 5:22 AM, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> On Wed, Feb 07, 2018 at 04:01:19PM +0530, Vivek Gautam wrote:
>> From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>
>> The smmu device probe/remove and add/remove master device callbacks
>> gets called when the smmu is not linked to its master, that is without
>> the context of the master device. So calling runtime apis in those places
>> separately.
>>
>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> [vivek: Cleanup pm runtime calls]
>> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>  drivers/iommu/arm-smmu.c | 42 ++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 38 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 9e2f917e16c2..c024f69c1682 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -913,11 +913,15 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>>       struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>       struct arm_smmu_device *smmu = smmu_domain->smmu;
>>       struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>> -     int irq;
>> +     int ret, irq;
>>
>>       if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
>>               return;
>>
>> +     ret = pm_runtime_get_sync(smmu->dev);
>> +     if (ret)
>> +             return;
>> +
>>       /*
>>        * Disable the context bank and free the page tables before freeing
>>        * it.
>> @@ -932,6 +936,8 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>>
>>       free_io_pgtable_ops(smmu_domain->pgtbl_ops);
>>       __arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
>> +
>> +     pm_runtime_put_sync(smmu->dev);
>>  }
>>
>>  static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>> @@ -1407,14 +1413,22 @@ static int arm_smmu_add_device(struct device *dev)
>>       while (i--)
>>               cfg->smendx[i] = INVALID_SMENDX;
>>
>> -     ret = arm_smmu_master_alloc_smes(dev);
>> +     ret = pm_runtime_get_sync(smmu->dev);
>>       if (ret)
>>               goto out_cfg_free;
>
> Hey Vivek, I just hit a problem with this on sdm845. It turns out that
> pm_runtime_get_sync() returns a positive 1 if the device is already active.
>
> I hit this in the GPU code. The a6xx has two platform devices that each use a
> different sid on the iommu. The GPU is probed normally from a platform driver
> and it in turn initializes the GMU device by way of a phandle.
>
> Because the GMU isn't probed with a platform driver we need to call
> of_dma_configure() on the device to set up the IOMMU for the device which ends
> up calling through this path and we discover that the smmu->dev is already
> powered (pm_runtime_get_sync returns 1).
>
> I'm not immediately sure if this is a bug on sdm845 or not because a cursory
> inspection says that the SMMU device shouldn't be powered at this time but there
> might be a connection that I'm not seeing. Obviously if the SMMU was left
> powered thats a bad thing. But putting that aside it is obvious that this
> code should be accommodating of the possibility that the device is already
> powered, and so this should be
>
> if (ret < 0)
>         goto out_cfg_free;

Right, as Tomasz also pointed, we should surely check the negative value of
pm_runtime_get_sync().

>From your description, it may be that the GPU has turned on the smmu, and
then once if goes and probes the GMU, the GMU device also wants to turn-on
the same smmu device. But that's already active. So pm_runtime_get_sync()
returns 1.
Am i making sense?

regards
Vivek

>
> With that the GPU/GMU successfully comes up on Sean Paul's display testing
> branch.
>
> Jordan
>
> --
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
