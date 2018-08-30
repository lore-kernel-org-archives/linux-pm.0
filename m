From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [Patch v15 2/5] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
Date: Thu, 30 Aug 2018 19:29:46 +0530
Message-ID: <CAFp+6iGgePK14WGOdrE2cHLMpZ0JbS6qUvVoP-0mW55xh5haHg@mail.gmail.com>
References: <20180827105551.16346-1-vivek.gautam@codeaurora.org>
 <20180827105551.16346-3-vivek.gautam@codeaurora.org> <CAFp+6iGbfHZQjG5oEVKhQ=4rOaaU=5ePykEuwMqYbPTryX6DnA@mail.gmail.com>
 <CAAFQd5BrJppNSo8ETT6ywjuLEULk4nAvWDQEuNiMCvdddeUq1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAFQd5BrJppNSo8ETT6ywjuLEULk4nAvWDQEuNiMCvdddeUq1A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Figa <tfiga@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, alex.williamson@redhat.com, Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org, freedreno <freedreno@lists.freedesktop.org>, Will Deacon <will.deacon@arm.com>, open list <linux-kernel@vger.kernel.org>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, robh+dt <robh+dt@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Andy Gross <andy.gross@linaro.org>, Robin Murphy <robin.murphy@arm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 30, 2018 at 3:04 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> On Thu, Aug 30, 2018 at 6:22 PM Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
> >
> > On Mon, Aug 27, 2018 at 4:27 PM Vivek Gautam
> > <vivek.gautam@codeaurora.org> wrote:
> > >
> > > From: Sricharan R <sricharan@codeaurora.org>
> > >
> > > The smmu device probe/remove and add/remove master device callbacks
> > > gets called when the smmu is not linked to its master, that is without
> > > the context of the master device. So calling runtime apis in those places
> > > separately.
> > >
> > > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> > > [vivek: Cleanup pm runtime calls]
> > > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > > Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > ---
> > >
> > > Changes since v14:
> > >  - none.
> > >
> > >  drivers/iommu/arm-smmu.c | 101 +++++++++++++++++++++++++++++++++++++++++++----
> > >  1 file changed, 93 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > > index a81224bc6637..23b4a60149b6 100644
> > > --- a/drivers/iommu/arm-smmu.c
> > > +++ b/drivers/iommu/arm-smmu.c
> >
> > [snip]
> >
> > > @@ -2131,6 +2188,26 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> > >         if (err)
> > >                 return err;
> > >
> > > +       /*
> > > +        * We want to avoid touching dev->power.lock in fastpaths unless
> > > +        * it's really going to do something useful - pm_runtime_enabled()
> > > +        * can serve as an ideal proxy for that decision. So, conditionally
> > > +        * enable pm_runtime.
> > > +        */
> > > +       if (dev->pm_domain)
> > > +               pm_runtime_enable(dev);
> > > +
> > > +       err = arm_smmu_rpm_get(smmu);
> >
> > We shouldn't be doing a runtime_get() yet, as this eventually calls
> > arm_smmu_device_reset().
> > arm_smmu_device_reset() should be called only after arm_smmu_device_cfg_probe().
> > So, I plan to replace the pm_runtime_get/put() calls in probe() with
> > simple clk_bulk_enable()
> > to let the driver initialize smmu, and at the end of the probe we can
> > disable the clocks and
> > enable runtime pm over the device to let it take care of the device further-on.
> >
>
> We can avoid the explicit clock disable by just calling
> pm_runtime_set_active() before pm_runtime_enable(), assuming that what
> probe does is symmetrical with the suspend callback, which would be
> called after the latter.

Sure, that sounds reasonable. Will use pm_runtime_set_active() instead
of explicitly disabling the clocks.Thanks.

Best regards
Vivek

>
> Best regards,
> Tomasz
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
