From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v16 1/5] iommu/arm-smmu: Add pm_runtime/sleep ops
Date: Fri, 28 Sep 2018 13:59:35 +0200
Message-ID: <CAPDyKFohpvEMfDoDooYEyxPMeQ+9dU71qz7ZAZxQ1rzyW-w8iA@mail.gmail.com>
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org> <20180830144541.17740-2-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830144541.17740-2-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org, DTML <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, robdclark@gmail.com, Linux PM <linux-pm@vger.kernel.org>, freedreno@lists.freedesktop.org, Stephen Boyd <sboyd@kernel.org>, Tomasz Figa <tfiga@chromium.org>, Jordan Crouse <jcrouse@codeaurora.org>, Sricharan <sricharan@codeaurora.org>, Marek Szyprowski <m.szyprowski@samsung.com>, architt@codeaurora.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 30 August 2018 at 16:45, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> From: Sricharan R <sricharan@codeaurora.org>
>
> The smmu needs to be functional only when the respective
> master's using it are active. The device_link feature
> helps to track such functional dependencies, so that the
> iommu gets powered when the master device enables itself
> using pm_runtime. So by adapting the smmu driver for
> runtime pm, above said dependency can be addressed.
>
> This patch adds the pm runtime/sleep callbacks to the
> driver and also the functions to parse the smmu clocks
> from DT and enable them in resume/suspend.
>
> Also, while we enable the runtime pm add a pm sleep suspend
> callback that pushes devices to low power state by turning
> the clocks off in a system sleep.
> Also add corresponding clock enable path in resume callback.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Archit Taneja <architt@codeaurora.org>
> [vivek: rework for clock and pm ops]
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/iommu/arm-smmu.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 74 insertions(+), 3 deletions(-)
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c

[...]

> -static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
> +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
>  {
>         struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = clk_bulk_enable(smmu->num_clks, smmu->clks);
> +       if (ret)
> +               return ret;
>
>         arm_smmu_device_reset(smmu);
> +
>         return 0;
>  }
>
> -static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> +{
> +       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +
> +       clk_bulk_disable(smmu->num_clks, smmu->clks);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
> +{
> +       if (pm_runtime_suspended(dev))
> +               return 0;

Looks like you should be able use pm_runtime_force_resume(), instead
of using this local trick. Unless I am missing something, of course.

In other words, just assign the system sleep callbacks for resume, to
pm_runtime_force_resume(). And vice verse for the system suspend
callbacks, pm_runtime_force_suspend(), of course.

> +
> +       return arm_smmu_runtime_resume(dev);
> +}
> +
> +static int __maybe_unused arm_smmu_pm_suspend(struct device *dev)
> +{
> +       if (pm_runtime_suspended(dev))
> +               return 0;
> +
> +       return arm_smmu_runtime_suspend(dev);
> +}
> +
> +static const struct dev_pm_ops arm_smmu_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(arm_smmu_pm_suspend, arm_smmu_pm_resume)

I am wondering if using the ->suspend|resume() callback is really
"late/early" enough in the device suspend phase?

Others is using the noirq phase and some is even using the syscore
ops. Of course it depends on the behavior of the consumers of iommu
device, and I guess not everyone is using device links, which for sure
improves things in this regards as well.

> +       SET_RUNTIME_PM_OPS(arm_smmu_runtime_suspend,
> +                          arm_smmu_runtime_resume, NULL)
> +};
>
>  static struct platform_driver arm_smmu_driver = {
>         .driver = {
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>

BTW, apologize for very late review comments.

Besides the above comments, the series looks good to me.

Kind regards
Uffe
