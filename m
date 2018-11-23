From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RESEND PATCH v17 2/5] iommu/arm-smmu: Invoke pm_runtime during
	probe, add/remove device
Date: Fri, 23 Nov 2018 18:36:01 +0000
Message-ID: <20181123183555.GE21183@arm.com>
References: <20181116112430.31248-1-vivek.gautam@codeaurora.org>
	<20181116112430.31248-3-vivek.gautam@codeaurora.org>
	<20181121173757.GA9801@arm.com>
	<CAFp+6iEH7_XEcZNsbZfn6iBF5_o-ZKBj=DpturH7N85LU289qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFp+6iEH7_XEcZNsbZfn6iBF5_o-ZKBj=DpturH7N85LU289qg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>,
	" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, robh+dt <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 22, 2018 at 05:32:24PM +0530, Vivek Gautam wrote:
> Hi Will,
> 
> On Wed, Nov 21, 2018 at 11:09 PM Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> >
> > On Fri, Nov 16, 2018 at 04:54:27PM +0530, Vivek Gautam wrote:
> > > From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> > >
> > > The smmu device probe/remove and add/remove master device callbacks
> > > gets called when the smmu is not linked to its master, that is without
> > > the context of the master device. So calling runtime apis in those places
> > > separately.
> > > Global locks are also initialized before enabling runtime pm as the
> > > runtime_resume() calls device_reset() which does tlb_sync_global()
> > > that ultimately requires locks to be initialized.
> > >
> > > Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> > > [vivek: Cleanup pm runtime calls]
> > > Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> > > Reviewed-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > > Tested-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> > > ---
> > >  drivers/iommu/arm-smmu.c | 101 ++++++++++++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 91 insertions(+), 10 deletions(-)
> >
> > Given that you're doing the get/put in the TLBI ops unconditionally:
> >
> > >  static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
> > >  {
> > >       struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> > > +     struct arm_smmu_device *smmu = smmu_domain->smmu;
> > >
> > > -     if (smmu_domain->tlb_ops)
> > > +     if (smmu_domain->tlb_ops) {
> > > +             arm_smmu_rpm_get(smmu);
> > >               smmu_domain->tlb_ops->tlb_flush_all(smmu_domain);
> > > +             arm_smmu_rpm_put(smmu);
> > > +     }
> > >  }
> > >
> > >  static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
> > >  {
> > >       struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> > > +     struct arm_smmu_device *smmu = smmu_domain->smmu;
> > >
> > > -     if (smmu_domain->tlb_ops)
> > > +     if (smmu_domain->tlb_ops) {
> > > +             arm_smmu_rpm_get(smmu);
> > >               smmu_domain->tlb_ops->tlb_sync(smmu_domain);
> > > +             arm_smmu_rpm_put(smmu);
> > > +     }
> >
> > Why do you need them around the map/unmap calls as well?
> 
> We still have .tlb_add_flush path?

Ok, so we could add the ops around that as well. Right now, we've got
the runtime pm hooks crossing two parts of the API.

Will
