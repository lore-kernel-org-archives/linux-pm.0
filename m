From: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v7 3/6] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
Date: Tue, 13 Feb 2018 17:24:53 +0900
Message-ID: <CAAFQd5DxYhkK61VDAesby6bT+FtG2nqsbHQRvxkhrsSS0KWtog@mail.gmail.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org> <1517999482-17317-4-git-send-email-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:38691 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933584AbeBMIZP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Feb 2018 03:25:15 -0500
Received: by mail-vk0-f68.google.com with SMTP id z9so10366511vkd.5
        for <linux-pm@vger.kernel.org>; Tue, 13 Feb 2018 00:25:15 -0800 (PST)
Received: from mail-ua0-f175.google.com (mail-ua0-f175.google.com. [209.85.217.175])
        by smtp.gmail.com with ESMTPSA id s1sm1587136uad.45.2018.02.13.00.25.14
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Feb 2018 00:25:14 -0800 (PST)
Received: by mail-ua0-f175.google.com with SMTP id n1so11089215uaa.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Feb 2018 00:25:14 -0800 (PST)
In-Reply-To: <1517999482-17317-4-git-send-email-vivek.gautam@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Clark <robdclark@gmail.com>"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, freedreno@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Greg KH <gregkh@linuxfoundation.org>, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org

Hi Vivek,

Thanks for the patch. Please see my comments inline.

On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> From: Sricharan R <sricharan@codeaurora.org>
>
> The smmu device probe/remove and add/remove master device callbacks
> gets called when the smmu is not linked to its master, that is without
> the context of the master device. So calling runtime apis in those places
> separately.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> [vivek: Cleanup pm runtime calls]
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu.c | 42 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 9e2f917e16c2..c024f69c1682 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -913,11 +913,15 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>         struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>         struct arm_smmu_device *smmu = smmu_domain->smmu;
>         struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> -       int irq;
> +       int ret, irq;
>
>         if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
>                 return;
>
> +       ret = pm_runtime_get_sync(smmu->dev);
> +       if (ret)
> +               return;

pm_runtime_get_sync() will return 0 if the device was powered off, 1
if it was already/still powered on or runtime PM is not compiled in,
or a negative value on error, so shouldn't the test be (ret < 0)?

Moreover, I'm actually wondering if it makes any sense to power up the
hardware just to program it and power it down again. In a system where
the IOMMU is located within a power domain, it would cause the IOMMU
block to lose its state anyway.

Actually, reflecting back on "[PATCH v7 2/6] iommu/arm-smmu: Add
pm_runtime/sleep ops", perhaps it would make more sense to just
control the clocks independently of runtime PM? Then, runtime PM could
be used for real power management, e.g. really powering the block up
and down, for further power saving.

+Generally similar comments for other places in this patch.

> +
>         /*
>          * Disable the context bank and free the page tables before freeing
>          * it.
> @@ -932,6 +936,8 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>
>         free_io_pgtable_ops(smmu_domain->pgtbl_ops);
>         __arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
> +
> +       pm_runtime_put_sync(smmu->dev);

Is there any point in the put being sync here?

[snip]

> @@ -2131,6 +2152,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>         if (err)
>                 return err;
>
> +       platform_set_drvdata(pdev, smmu);
> +
> +       pm_runtime_enable(dev);

I suspect this may be a disaster for systems where IOMMUs are located
inside power domains, because the driver doesn't take care of the
IOMMU block losing its state on physical power down, as I mentioned in
my comments above.

Best regards,
Tomasz
