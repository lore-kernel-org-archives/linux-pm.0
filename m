From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v18 1/5] iommu/arm-smmu: Add pm_runtime/sleep ops
Date: Thu, 29 Nov 2018 20:25:20 +0530
Message-ID: <CAFp+6iEC8hobAdVF5nLdhQdCUqbi1xa4Vi-NLugGshV=dg+h1A@mail.gmail.com>
References: <20181127101145.7682-1-vivek.gautam@codeaurora.org>
	<20181127101145.7682-2-vivek.gautam@codeaurora.org>
	<154342225921.88331.14467967828250776155@swboyd.mtv.corp.google.com>
	<0d76b669-6c4f-7c3b-50a1-084201f2c07a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <0d76b669-6c4f-7c3b-50a1-084201f2c07a-5wv7dgnIgG8@public.gmane.org>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, robh+dt <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 28, 2018 at 10:07 PM Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>
> On 28/11/2018 16:24, Stephen Boyd wrote:
> > Quoting Vivek Gautam (2018-11-27 02:11:41)
> >> @@ -1966,6 +1970,23 @@ static const struct of_device_id arm_smmu_of_match[] = {
> >>   };
> >>   MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
> >>
> >> +static void arm_smmu_fill_clk_data(struct arm_smmu_device *smmu,
> >> +                                  const char * const *clks)
> >> +{
> >> +       int i;
> >> +
> >> +       if (smmu->num_clks < 1)
> >> +               return;
> >> +
> >> +       smmu->clks = devm_kcalloc(smmu->dev, smmu->num_clks,
> >> +                                 sizeof(*smmu->clks), GFP_KERNEL);
> >> +       if (!smmu->clks)
> >> +               return;
> >> +
> >> +       for (i = 0; i < smmu->num_clks; i++)
> >> +               smmu->clks[i].id = clks[i];
> >
> > Is this clk_bulk_get_all()?

>From what I remember, and now I could go back to v7 and check [1], we parked
clk_bulk_get out of OF's sole purview as we also have
arm_smmu_device_acpi_probe() besides arm_smmu_device_dt_probe().

arm_smmu_device_dt_probe() could get the clocks from dt and fill in
the clock bulk data, and
similarly, arm_smmu_device_acpi_probe() could fill the clock bulk data
by getting it from ACPI.

clk_bulk_get_all() seems like going only the OF way.
Is there another way here to have something common between ACPI
and OF, and then do the clk_bulk_get?

[1] https://lore.kernel.org/patchwork/patch/881365/

Thanks & regards
Vivek

>
> Ooh, did that finally get merged while we weren't looking? Great!
>
> Much as I don't want to drag this series out to a v19, it *would* be
> neat if we no longer need to open-code that bit...
>
> Robin.
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
