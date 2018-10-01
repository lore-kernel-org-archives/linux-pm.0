From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH v16 1/5] iommu/arm-smmu: Add pm_runtime/sleep ops
Date: Mon, 1 Oct 2018 11:19:34 +0530
Message-ID: <CAFp+6iHZysBmMZj+pZghPocEwDzU7KfR1gLQAQRBui+-gdiSTQ@mail.gmail.com>
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-2-vivek.gautam@codeaurora.org> <CAPDyKFohpvEMfDoDooYEyxPMeQ+9dU71qz7ZAZxQ1rzyW-w8iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFohpvEMfDoDooYEyxPMeQ+9dU71qz7ZAZxQ1rzyW-w8iA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, alex.williamson@redhat.com, Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, open list <linux-kernel@vger.kernel.org>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, robh+dt <robh+dt@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, freedreno <freedreno@lists.freedesktop.org>, Robin Murphy <robin.murphy@arm.com>
List-Id: linux-pm@vger.kernel.org

HI Ulf,

On Fri, Sep 28, 2018 at 5:30 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On 30 August 2018 at 16:45, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> > From: Sricharan R <sricharan@codeaurora.org>
> >
> > The smmu needs to be functional only when the respective
> > master's using it are active. The device_link feature
> > helps to track such functional dependencies, so that the
> > iommu gets powered when the master device enables itself
> > using pm_runtime. So by adapting the smmu driver for
> > runtime pm, above said dependency can be addressed.
> >
> > This patch adds the pm runtime/sleep callbacks to the
> > driver and also the functions to parse the smmu clocks
> > from DT and enable them in resume/suspend.
> >
> > Also, while we enable the runtime pm add a pm sleep suspend
> > callback that pushes devices to low power state by turning
> > the clocks off in a system sleep.
> > Also add corresponding clock enable path in resume callback.
> >
> > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> > Signed-off-by: Archit Taneja <architt@codeaurora.org>
> > [vivek: rework for clock and pm ops]
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > ---
> >  drivers/iommu/arm-smmu.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 74 insertions(+), 3 deletions(-)
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>
> [...]
>
> > -static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
> > +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
> >  {
> >         struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > +       int ret;
> > +
> > +       ret = clk_bulk_enable(smmu->num_clks, smmu->clks);
> > +       if (ret)
> > +               return ret;
> >
> >         arm_smmu_device_reset(smmu);
> > +
> >         return 0;
> >  }
> >
> > -static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
> > +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> > +{
> > +       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > +
> > +       clk_bulk_disable(smmu->num_clks, smmu->clks);
> > +
> > +       return 0;
> > +}
> > +
> > +static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
> > +{
> > +       if (pm_runtime_suspended(dev))
> > +               return 0;
>
> Looks like you should be able use pm_runtime_force_resume(), instead
> of using this local trick. Unless I am missing something, of course.
>
> In other words, just assign the system sleep callbacks for resume, to
> pm_runtime_force_resume(). And vice verse for the system suspend
> callbacks, pm_runtime_force_suspend(), of course.

Thanks for the review. I will change this as suggested.

>
> > +
> > +       return arm_smmu_runtime_resume(dev);
> > +}
> > +
> > +static int __maybe_unused arm_smmu_pm_suspend(struct device *dev)
> > +{
> > +       if (pm_runtime_suspended(dev))
> > +               return 0;
> > +
> > +       return arm_smmu_runtime_suspend(dev);
> > +}
> > +
> > +static const struct dev_pm_ops arm_smmu_pm_ops = {
> > +       SET_SYSTEM_SLEEP_PM_OPS(arm_smmu_pm_suspend, arm_smmu_pm_resume)
>
> I am wondering if using the ->suspend|resume() callback is really
> "late/early" enough in the device suspend phase?
>
> Others is using the noirq phase and some is even using the syscore
> ops. Of course it depends on the behavior of the consumers of iommu
> device, and I guess not everyone is using device links, which for sure
> improves things in this regards as well.

Well yes, as you said the device links should be able to take care of
maintaining the correct suspend/resume order of smmu and its clients,
or am I missing your point here?
Let me know and I will be happy to incorporate any suggestions.
Thanks

Regards
Vivek

>
> > +       SET_RUNTIME_PM_OPS(arm_smmu_runtime_suspend,
> > +                          arm_smmu_runtime_resume, NULL)
> > +};
> >
> >  static struct platform_driver arm_smmu_driver = {
> >         .driver = {
> > --
> > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> > of Code Aurora Forum, hosted by The Linux Foundation
> >
>
> BTW, apologize for very late review comments.
>
> Besides the above comments, the series looks good to me.
>
> Kind regards
> Uffe
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
