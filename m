From: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v16 2/5] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
Date: Fri, 7 Sep 2018 18:52:07 +0900
Message-ID: <CAAFQd5DMDWEeBU=fg6arye3pXnrCqOA4tDtMSGutXk7vSz-EtQ@mail.gmail.com>
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-3-vivek.gautam@codeaurora.org> <CAAFQd5B7YR03Jm1upOg2nsaKOb1iDD7-WGo-qx7S8m-nounCvA@mail.gmail.com>
 <3ccc3690-dc9d-56e7-e2d1-62e73a189bff@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3ccc3690-dc9d-56e7-e2d1-62e73a189bff@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Clark <robdclark@gmail.com>, Linux PM <linux-pm@vger.kernel.org>, freedreno <freedreno@lists.freedesktop.org>, sboyd@kernel.org, jcrouse@codeaurora.org, Sricharan R <sricharan@codeaurora.org>, Marek
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 7, 2018 at 6:38 PM Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>
> Hi Tomasz,
>
>
> On 9/7/2018 2:46 PM, Tomasz Figa wrote:
> > Hi Vivek,
> >
> > On Thu, Aug 30, 2018 at 11:46 PM Vivek Gautam
> > <vivek.gautam@codeaurora.org> wrote:
> >> From: Sricharan R <sricharan@codeaurora.org>
> >>
> >> The smmu device probe/remove and add/remove master device callbacks
> >> gets called when the smmu is not linked to its master, that is without
> >> the context of the master device. So calling runtime apis in those places
> >> separately.
> >> Global locks are also initialized before enabling runtime pm as the
> >> runtime_resume() calls device_reset() which does tlb_sync_global()
> >> that ultimately requires locks to be initialized.
> >>
> >> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> >> [vivek: Cleanup pm runtime calls]
> >> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> >> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> >> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >> ---
> >>   drivers/iommu/arm-smmu.c | 89 +++++++++++++++++++++++++++++++++++++++++++-----
> >>   1 file changed, 81 insertions(+), 8 deletions(-)
> > [snip]
> >> @@ -2215,10 +2281,17 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
> >>          if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
> >>                  dev_err(&pdev->dev, "removing device with active domains!\n");
> >>
> >> +       arm_smmu_rpm_get(smmu);
> >>          /* Turn the thing off */
> >>          writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
> >> +       arm_smmu_rpm_put(smmu);
> >> +
> >> +       if (pm_runtime_enabled(smmu->dev))
> >> +               pm_runtime_force_suspend(smmu->dev);
> >> +       else
> >> +               clk_bulk_disable(smmu->num_clks, smmu->clks);
> >>
> >> -       clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
> >> +       clk_bulk_unprepare(smmu->num_clks, smmu->clks);
> > Aren't we missing pm_runtime_disable() here? We'll have the enable
> > count unbalanced if the driver is removed and probed again.
>
> pm_runtime_force_suspend() does a pm_runtime_disable() also if i am not
> wrong.
> And, as mentioned in a previous thread [1], we were seeing a warning
> which we avoided
> by keeping force_suspend().
>
> [1] https://lkml.org/lkml/2018/7/8/124

I see, thanks. I didn't realize that pm_runtime_force_suspend()
already disables runtime PM indeed. Sorry for the noise.

Best regards,
Tomasz
