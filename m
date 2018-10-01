From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH v16 0/5] iommu/arm-smmu: Add runtime pm/sleep support
Date: Mon, 1 Oct 2018 14:36:24 +0530
Message-ID: <CAFp+6iFzU3vG+HZ-7drNG7fyv6PY-W-9To5-rZeLo7M3p4=2rg@mail.gmail.com>
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org> <20180928135718.GA1599@brain-police>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180928135718.GA1599@brain-police>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, alex.williamson@redhat.com, Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org, freedreno <freedreno@lists.freedesktop.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, open list <linux-kernel@vger.kernel.org>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, robh+dt <robh+dt@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Will,

On Fri, Sep 28, 2018 at 7:27 PM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Vivek,
>
> On Thu, Aug 30, 2018 at 08:15:36PM +0530, Vivek Gautam wrote:
> > This series provides the support for turning on the arm-smmu's
> > clocks/power domains using runtime pm. This is done using
> > device links between smmu and client devices. The device link
> > framework keeps the two devices in correct order for power-cycling
> > across runtime PM or across system-wide PM.
> >
> > With addition of a new device link flag DL_FLAG_AUTOREMOVE_SUPPLIER [7],
> > the device links created between arm-smmu and its clients will be
> > automatically purged when arm-smmu driver unbinds from its device.
> >
> > As not all implementations support clock/power gating, we are checking
> > for a valid 'smmu->dev's pm_domain' to conditionally enable the runtime
> > power management for such smmu implementations that can support it.
> > Otherwise, the clocks are turned to be always on in .probe until .remove.
> > With conditional runtime pm now, we avoid touching dev->power.lock
> > in fastpaths for smmu implementations that don't need to do anything
> > useful with pm_runtime.
> > This lets us to use the much-argued pm_runtime_get_sync/put_sync()
> > calls in map/unmap callbacks so that the clients do not have to
> > worry about handling any of the arm-smmu's power.
> >
> > This series also adds support for Qcom's arm-smmu-v2 variant that
> > has different clocks and power requirements.
> >
> > Previous version of this patch series is @ [1].
> >
> > Build tested the series based on 4.19-rc1.
>
> I'm going to send my pull request to Joerg early next week (probably
> Monday), but I'm not keen to include this whilst it has outstanding comments
> from Ulf. Your errata workaround patch is in a similar situation, with
> outstanding comments from Robin.

I am going to address Ulf's comments for pm_runtime_force_suspend/resume()
calls in system sleep callbacks and respin the series unless he has any more
comments regarding the early/late nature of suspend/resume.
So will it do if I respin the series today after waiting for Ulf?

The workaround series is going for a discussion now, so i think it can wait.
Thanks

Best regards
Vivek
>
> Will
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu


--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
