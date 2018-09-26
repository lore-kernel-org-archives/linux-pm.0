From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v16 2/5] iommu/arm-smmu: Invoke pm_runtime during probe,
	add/remove device
Date: Wed, 26 Sep 2018 11:52:03 +0530
Message-ID: <CAFp+6iEDiH5rb8Hnza19q-+X7WBHfG5PZS9Pj+wfEcDTikMtUg@mail.gmail.com>
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
	<20180830144541.17740-3-vivek.gautam@codeaurora.org>
	<CAAFQd5B7YR03Jm1upOg2nsaKOb1iDD7-WGo-qx7S8m-nounCvA@mail.gmail.com>
	<3ccc3690-dc9d-56e7-e2d1-62e73a189bff@codeaurora.org>
	<CAAFQd5DMDWEeBU=fg6arye3pXnrCqOA4tDtMSGutXk7vSz-EtQ@mail.gmail.com>
	<CAFp+6iE3+qn6-gpXEzxfoP5yPMARmUcJNn0AZk-kA2AreTLnng@mail.gmail.com>
	<CAFp+6iHnHj_PkPFBUSTdJTW57K51wLqSEw6VOMKxAVo7O+ms9g@mail.gmail.com>
	<CAFp+6iFvhdSq7upbvsEWgMewhAaaRM91iw9p7qOFPYrUxis0Hg@mail.gmail.com>
	<aedf3f32-68ae-566a-3735-ca4ec5c7559a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <aedf3f32-68ae-566a-3735-ca4ec5c7559a-5wv7dgnIgG8@public.gmane.org>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, robh+dt <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Robin,

On Wed, Sep 26, 2018 at 12:25 AM Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>
> Hi Vivek,
>
> On 2018-09-25 6:56 AM, Vivek Gautam wrote:
> > Hi Robin, Will,
> >
> > On Tue, Sep 18, 2018 at 8:41 AM Vivek Gautam
> > <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> >>
> >> Hi Robin,
> >>
> >> On Fri, Sep 7, 2018 at 3:52 PM Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> >>>
> >>> On Fri, Sep 7, 2018 at 3:22 PM Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> >>>>
> >>>> On Fri, Sep 7, 2018 at 6:38 PM Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> >>>>>
> >>>>> Hi Tomasz,
> >>>>>
> >>>>>
> >>>>> On 9/7/2018 2:46 PM, Tomasz Figa wrote:
> >>>>>> Hi Vivek,
> >>>>>>
> >>>>>> On Thu, Aug 30, 2018 at 11:46 PM Vivek Gautam
> >>>>>> <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> >>>>>>> From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> >>>>>>>
> >>>>>>> The smmu device probe/remove and add/remove master device callbacks
> >>>>>>> gets called when the smmu is not linked to its master, that is without
> >>>>>>> the context of the master device. So calling runtime apis in those places
> >>>>>>> separately.
> >>>>>>> Global locks are also initialized before enabling runtime pm as the
> >>>>>>> runtime_resume() calls device_reset() which does tlb_sync_global()
> >>>>>>> that ultimately requires locks to be initialized.
> >>>>>>>
> >>>>>>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> >>>>>>> [vivek: Cleanup pm runtime calls]
> >>>>>>> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> >>>>>>> Reviewed-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> >>>>>>> Tested-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >>>>>>> ---
> >>>>>>>    drivers/iommu/arm-smmu.c | 89 +++++++++++++++++++++++++++++++++++++++++++-----
> >>>>>>>    1 file changed, 81 insertions(+), 8 deletions(-)
> >>>>>> [snip]
> >>>>>>> @@ -2215,10 +2281,17 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
> >>>>>>>           if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
> >>>>>>>                   dev_err(&pdev->dev, "removing device with active domains!\n");
> >>>>>>>
> >>>>>>> +       arm_smmu_rpm_get(smmu);
> >>>>>>>           /* Turn the thing off */
> >>>>>>>           writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
> >>>>>>> +       arm_smmu_rpm_put(smmu);
> >>>>>>> +
> >>>>>>> +       if (pm_runtime_enabled(smmu->dev))
> >>>>>>> +               pm_runtime_force_suspend(smmu->dev);
> >>>>>>> +       else
> >>>>>>> +               clk_bulk_disable(smmu->num_clks, smmu->clks);
> >>>>>>>
> >>>>>>> -       clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
> >>>>>>> +       clk_bulk_unprepare(smmu->num_clks, smmu->clks);
> >>>>>> Aren't we missing pm_runtime_disable() here? We'll have the enable
> >>>>>> count unbalanced if the driver is removed and probed again.
> >>>>>
> >>>>> pm_runtime_force_suspend() does a pm_runtime_disable() also if i am not
> >>>>> wrong.
> >>>>> And, as mentioned in a previous thread [1], we were seeing a warning
> >>>>> which we avoided
> >>>>> by keeping force_suspend().
> >>>>>
> >>>>> [1] https://lkml.org/lkml/2018/7/8/124
> >>>>
> >>>> I see, thanks. I didn't realize that pm_runtime_force_suspend()
> >>>> already disables runtime PM indeed. Sorry for the noise.
> >>>
> >>> Hi Tomasz,
> >>> No problem. Thanks for looking back at it.
> >>>
> >>> Hi Robin,
> >>> If you are fine with this series, then can you please consider giving
> >>> Reviewed-by, so that we are certain that this series will go in the next merge
> >>> window.
> >>> Thanks
> >>
> >> Gentle ping.
> >> You ack will be very helpful in letting Will pull this series for 4.20.
> >> Thanks.
> >
> > I would really appreciate if you could provide your ack for this series.
> > Or if there are any concerns, I am willing to address them.
>
> Apologies, I thought I'd replied to say I'd be getting to this shortly,
> but apparently not :(
>
> FWIW, "shortly" is now tomorrow - I don't *think* there's anything
> outstanding, but given the number of subtleties we've turned up so far I
> do just want one last thorough double-check to make sure.

Cool. TIA for the review. I hope we have something that we can land :),
and then work further to take care of addressing other needs of this driver.
Thanks.

Best regards
Vivek
>
> Thanks,
> Robin.
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
