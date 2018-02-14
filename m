From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Freedreno] [PATCH v7 6/6] drm/msm: iommu: Replace runtime calls
 with runtime suppliers
Date: Wed, 14 Feb 2018 11:12:23 -0500
Message-ID: <CAF6AEGtFOwBtXw7HvDSpEj+w78dsg9+p2SVk9e-uDuCE23Fpbw@mail.gmail.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-7-git-send-email-vivek.gautam@codeaurora.org>
 <CAAFQd5AjopiX6fDgD+mO+-+d0yj-swEnVCNvccWRBSMO+XVJkA@mail.gmail.com>
 <20180213164205.GA7599@jcrouse-lnx.qualcomm.com> <CAAFQd5CjQRFATfh-mRQv5J=WefYuxBVTkk=Ju09FoqA-Or5Cvg@mail.gmail.com>
 <20180214154850.GA25422@jcrouse-lnx.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180214154850.GA25422-9PYrDHPZ2Orvke4nUoYGnHL1okKdlPRT@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Joerg
        Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>," <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 14, 2018 at 10:48 AM, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> On Wed, Feb 14, 2018 at 12:31:29PM +0900, Tomasz Figa wrote:
>>
>> - When submitting commands to the GPU, the GPU driver will
>> pm_runtime_get_sync() on the GPU device, which will automatically do
>> the same on all the linked suppliers, which would also include the
>> SMMU itself. The role of device links here is exactly that the GPU
>> driver doesn't have to care which other devices need to be brought up.
>
> This is true.  Assuming that the device link works correctly we would not need
> to explicitly power the SMMU which makes my point entirely moot.

Just to point out what motivated this patchset, the biggest problem is
iommu_unmap() because that can happen when GPU is not powered on (or
in the v4l2 case, because some other device dropped it's reference to
the dma-buf allowing it to be free'd).  Currently we pm get/put the
GPU device around unmap, but it is kinda silly to boot up the GPU just
to unmap a buffer.

(Semi-related, I would also like to batch map/unmap's, I just haven't
gotten around to implementing it yet.. but that would be another case
where a single get_supplier()/put_supplier() outside of the iommu
would make sense instead of pm_get/put() inside the iommu driver's
->unmap().)

If you really dislike the get/put_supplier() approach, then perhaps we
need iommu_pm_get()/iommu_pm_put() operations that the iommu user
could use to accomplish the same thing?

BR,
-R
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
