From: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v14 0/4] iommu/arm-smmu: Add runtime pm/sleep support
Date: Mon, 20 Aug 2018 18:31:03 +0900
Message-ID: <CAAFQd5C+ctVA-ynrWy=0=pjKZj0TGmHL+bWAu2yWWjYe4Oyf8w@mail.gmail.com>
References: <20180727070224.23966-1-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180727070224.23966-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, freedreno <freedreno@lists.freedesktop.org>, Alex Williamson <alex.williamson@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Rob Clark <robdclark@gmail.com>, Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org, jcrouse@codeaurora.org, Sricharan R <sricharan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Hi Robin,

On Fri, Jul 27, 2018 at 4:02 PM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
> This series provides the support for turning on the arm-smmu's
> clocks/power domains using runtime pm. This is done using
> device links between smmu and client devices. The device link
> framework keeps the two devices in correct order for power-cycling
> across runtime PM or across system-wide PM.
>
> With addition of a new device link flag DL_FLAG_AUTOREMOVE_SUPPLIER [8]
> (available in linux-next of Rafael's linux-pm tree [9]), the device links
> created between arm-smmu and its clients will be automatically purged
> when arm-smmu driver unbinds from its device.
>
> As not all implementations support clock/power gating, we are checking
> for a valid 'smmu->dev's pm_domain' to conditionally enable the runtime
> power management for such smmu implementations that can support it.
> Otherwise, the clocks are turned to be always on in .probe until .remove.
> With conditional runtime pm now, we avoid touching dev->power.lock
> in fastpaths for smmu implementations that don't need to do anything
> useful with pm_runtime.
> This lets us to use the much-argued pm_runtime_get_sync/put_sync()
> calls in map/unmap callbacks so that the clients do not have to
> worry about handling any of the arm-smmu's power.
>
> This series also adds support for Qcom's arm-smmu-v2 variant that
> has different clocks and power requirements.
>
> Previous version of this patch series is @ [2].
>
> Tested this series on msm8996, and sdm845 after pulling in Rafael's linux-pm
> linux-next[9] and Joerg's iommu next[10] branches, and related changes for
> device tree, etc.
>
> Hi Robin, Will,
> I have addressed the comments for v13. If there's still a chance
> can you please consider pulling this for v4.19.
> Thanks.
>
> [v14]
>    * Moved arm_smmu_device_reset() from arm_smmu_pm_resume() to
>      arm_smmu_runtime_resume() so that the pm_resume callback calls
>      only runtime_resume to resume the device.
>      This should take care of restoring the state of smmu in systems
>      in which smmu lose register state on power-domain collapse.

It's been a while since this series was posted and no more comments
seem to be left anymore. Would you have some time to take a look
again? Thanks.

Best regards,
Tomasz
