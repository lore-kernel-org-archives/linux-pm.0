From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v16 2/5] iommu/arm-smmu: Invoke pm_runtime during probe,
	add/remove device
Date: Tue, 2 Oct 2018 10:58:31 +0530
Message-ID: <CAFp+6iFpm05Uu8HkYCC+O+gYwFwvxirc6=e6oOed+ZJk6QLDPw@mail.gmail.com>
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
	<20180830144541.17740-3-vivek.gautam@codeaurora.org>
	<20181001125854.GB31488@arm.com>
	<CAFp+6iGkudBtZFfk4ST+k9OMRSGgU=pzVGC4QaSmPb+Xkdp3Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAFp+6iGkudBtZFfk4ST+k9OMRSGgU=pzVGC4QaSmPb+Xkdp3Xw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, robh+dt <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 2, 2018 at 9:44 AM Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>
> Hi Will,
>
> On Mon, Oct 1, 2018 at 6:29 PM Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> >
> > Hi Vivek,
> >
> > On Thu, Aug 30, 2018 at 08:15:38PM +0530, Vivek Gautam wrote:
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
> > > ---
> > >  drivers/iommu/arm-smmu.c | 89 +++++++++++++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 81 insertions(+), 8 deletions(-)
> >
> > This doesn't apply on my tree[1], possibly because I've got Robin's non-strict
> > invalidation queued there. However, that got me thinking -- how does this
> > work in conjunction with the timer-based TLB invalidation? Do we need to
> > rpm_{get,put} around flush_iotlb_all()? If so, do we still need the calls
> > in map/unmap when non-strict mode is in use?

For map/unmap(), i think there would be no harm in having additional
power.usage_count even for the non-strict mode.
So, I will just add rpm{get,put} in arm_smmu_flush_iotlb_all(), and
arm_smmu_iotlb_sync().

Regards
Vivek

>
> I haven't tested things with flush queues, but from what it looks like
> both .flush_iotlb_all, and .iotlb_sync callbacks need rpm_get/put().
> I will respin the patches.
>
> Thanks
> Vivek
> >
> > Will
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/updates
>
>
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
