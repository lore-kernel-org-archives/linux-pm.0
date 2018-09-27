From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH v16 5/5] iommu/arm-smmu: Add support for qcom,smmu-v2 variant
Date: Thu, 27 Sep 2018 12:25:43 +0530
Message-ID: <CAFp+6iGrvVL-tbD=Mx3NV2BqRQo=7f5qh8raaYNT-oFEav+2Ug@mail.gmail.com>
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-6-vivek.gautam@codeaurora.org> <80f7a7df-9a6d-9de3-4c7c-261d96fb04e4@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <80f7a7df-9a6d-9de3-4c7c-261d96fb04e4@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, robh+dt <robh+dt@kernel.org>, Will Deacon <will.deacon@arm.com>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, alex.williamson@redhat.com, linux-arm-msm <linux-arm-msm@vger.kernel.org>, freedreno <freedreno@lists.freedesktop.org>
List-Id: linux-pm@vger.kernel.org

Hi Robin,

On Wed, Sep 26, 2018 at 9:29 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 30/08/18 15:45, Vivek Gautam wrote:
> > qcom,smmu-v2 is an arm,smmu-v2 implementation with specific
> > clock and power requirements.
> > On msm8996, multiple cores, viz. mdss, video, etc. use this
> > smmu. On sdm845, this smmu is used with gpu.
> > Add bindings for the same.
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > ---
> >   drivers/iommu/arm-smmu.c | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 166c8c6da24f..411e5ac57c64 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -119,6 +119,7 @@ enum arm_smmu_implementation {
> >       GENERIC_SMMU,
> >       ARM_MMU500,
> >       CAVIUM_SMMUV2,
> > +     QCOM_SMMUV2,
>
> Hmm, it seems we don't actually need this right now, but maybe that just
> means there's more imp-def registers and/or errata to come ;)
>
> Either way I guess there's no real harm in having it.

Thanks for the review.

Best regards
Vivek

>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>
> >   };
> >
> >   struct arm_smmu_s2cr {
> > @@ -1970,6 +1971,17 @@ ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
> >   ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
> >   ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
> >
> > +static const char * const qcom_smmuv2_clks[] = {
> > +     "bus", "iface",
> > +};
> > +
> > +static const struct arm_smmu_match_data qcom_smmuv2 = {
> > +     .version = ARM_SMMU_V2,
> > +     .model = QCOM_SMMUV2,
> > +     .clks = qcom_smmuv2_clks,
> > +     .num_clks = ARRAY_SIZE(qcom_smmuv2_clks),
> > +};
> > +
> >   static const struct of_device_id arm_smmu_of_match[] = {
> >       { .compatible = "arm,smmu-v1", .data = &smmu_generic_v1 },
> >       { .compatible = "arm,smmu-v2", .data = &smmu_generic_v2 },
> > @@ -1977,6 +1989,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
> >       { .compatible = "arm,mmu-401", .data = &arm_mmu401 },
> >       { .compatible = "arm,mmu-500", .data = &arm_mmu500 },
> >       { .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
> > +     { .compatible = "qcom,smmu-v2", .data = &qcom_smmuv2 },
> >       { },
> >   };
> >   MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
> >
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
