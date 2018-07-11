From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v12 3/4] iommu/arm-smmu: Add the device_link between masters and smmu
Date: Wed, 11 Jul 2018 11:53:48 +0200
Message-ID: <5179668.PHK6S3sxLu@aspire.rjw.lan>
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org> <20180708173413.1965-4-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180708173413.1965-4-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com, robin.murphy@arm.com, will.deacon@arm.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, robdclark@gmail.com, linux-pm@vger.kernel.org, freedreno@lists.freedesktop.org, sboyd@kernel.org, tfiga@chromium.org, sricharan@codeaurora.org, m.szyprowski@samsung.com, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, jcrouse@codeaurora.org, Lukas Wunner <lukas@wunner.de>
List-Id: linux-pm@vger.kernel.org

On Sunday, July 8, 2018 7:34:12 PM CEST Vivek Gautam wrote:
> From: Sricharan R <sricharan@codeaurora.org>
> 
> Finally add the device link between the master device and
> smmu, so that the smmu gets runtime enabled/disabled only when the
> master needs it. This is done from add_device callback which gets
> called once when the master is added to the smmu.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Lukas Wunner <lukas@wunner.de>
> ---
> 
>  - Change since v11
>    * Replaced DL_FLAG_AUTOREMOVE flag with DL_FLAG_AUTOREMOVE_SUPPLIER.
> 
>  drivers/iommu/arm-smmu.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 09265e206e2d..916cde4954d2 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1461,8 +1461,20 @@ static int arm_smmu_add_device(struct device *dev)
>  
>  	iommu_device_link(&smmu->iommu, dev);
>  
> +	if (pm_runtime_enabled(smmu->dev) &&

Why does the creation of the link depend on whether or not runtime PM
is enabled for the MMU device?

What about system-wide PM and system shutdown?  Are they always guaranteed
to happen in the right order without the link?

> +	    !device_link_add(dev, smmu->dev,
> +			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER)) {
> +		dev_err(smmu->dev, "Unable to add link to the consumer %s\n",
> +			dev_name(dev));
> +		ret = -ENODEV;
> +		goto out_unlink;
> +	}
> +
>  	return 0;
>  
> +out_unlink:
> +	iommu_device_unlink(&smmu->iommu, dev);
> +	arm_smmu_master_free_smes(fwspec);
>  out_cfg_free:
>  	kfree(cfg);
>  out_free:
> 
