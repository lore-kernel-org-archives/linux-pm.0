From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RESEND PATCH v17 5/5] iommu/arm-smmu: Add support for
	qcom,smmu-v2 variant
Date: Fri, 23 Nov 2018 18:34:29 +0000
Message-ID: <20181123183428.GD21183@arm.com>
References: <20181116112430.31248-1-vivek.gautam@codeaurora.org>
	<20181116112430.31248-6-vivek.gautam@codeaurora.org>
	<20181121173803.GB9801@arm.com>
	<CAFp+6iELH7Mw3Ue2ksEyV+Ac8hG8--Ki69xrPCA4F-AcireRow@mail.gmail.com>
	<CAAFQd5B-bZR8dmjARb8L4oqgET2YAjXhexAO0GKAvU4JoVU=7g@mail.gmail.com>
	<CAFp+6iFhBRJWGY4Hj30tWedGpEUcnkBJrOvffmbpD2m9QMZB3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFp+6iFhBRJWGY4Hj30tWedGpEUcnkBJrOvffmbpD2m9QMZB3A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, robh+dt <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 23, 2018 at 03:06:29PM +0530, Vivek Gautam wrote:
> On Fri, Nov 23, 2018 at 2:52 PM Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> > On Fri, Nov 23, 2018 at 6:13 PM Vivek Gautam
> > <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> > > On Wed, Nov 21, 2018 at 11:09 PM Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> > > > On Fri, Nov 16, 2018 at 04:54:30PM +0530, Vivek Gautam wrote:
> > > > > @@ -2026,6 +2027,17 @@ ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
> > > > >  ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
> > > > >  ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
> > > > >
> > > > > +static const char * const qcom_smmuv2_clks[] = {
> > > > > +     "bus", "iface",
> > > > > +};
> > > > > +
> > > > > +static const struct arm_smmu_match_data qcom_smmuv2 = {
> > > > > +     .version = ARM_SMMU_V2,
> > > > > +     .model = QCOM_SMMUV2,
> > > > > +     .clks = qcom_smmuv2_clks,
> > > > > +     .num_clks = ARRAY_SIZE(qcom_smmuv2_clks),
> > > > > +};
> > > >
> > > > These seems redundant if we go down the route proposed by Thor, where we
> > > > just pull all of the clocks out of the device-tree. In which case, why
> > > > do we need this match_data at all?
> > >
> > > Which is better? Driver relying solely on the device tree to tell
> > > which all clocks
> > > are required to be enabled,
> > > or, the driver deciding itself based on the platform's match data,
> > > that it should
> > > have X, Y, & Z clocks that should be supplied from the device tree.
> >
> > The former would simplify the driver, but would also make it
> > impossible to spot mistakes in DT, which would ultimately surface out
> > as very hard to debug bugs (likely complete system lockups).
> 
> Thanks.
> Yea, this is how I understand things presently. Relying on device tree
> puts the things out of driver's control.

But it also has the undesirable effect of having to update the driver
code whenever we want to add support for a new SMMU implementation. If
we do this all in the DT, as Thor is trying to do, then older kernels
will work well with new hardware.

> Hi Will,
> Am I unable to understand the intentions here for Thor's clock-fetch
> design change?

I'm having trouble parsing your question, sorry. Please work with Thor
so that we have a single way to get the clock information. My preference
is to take it from the firmware, for the reason I stated above.

Will
