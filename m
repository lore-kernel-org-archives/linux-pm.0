From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v6 7/7] iommu/exynos: Use device dependency links to
 control runtime pm
Date: Thu, 10 Nov 2016 00:31:26 +0100
Message-ID: <20161109233126.GM13978@wotan.suse.de>
References: <1478611764-6473-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161108133019eucas1p1be275492ba670030324a164320866008@eucas1p1.samsung.com>
 <1478611764-6473-8-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478611764-6473-8-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Tomasz Figa <tomasz.figa@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 08, 2016 at 02:29:24PM +0100, Marek Szyprowski wrote:
> This patch uses recently introduced device dependency links to track the
> runtime pm state of the master's device. The goal is to let SYSMMU
> controller device's runtime PM to follow the runtime PM state of the
> respective master's device. This way each SYSMMU controller is active
> only when its master's device is active and can properly restore or save
> its state instead on runtime PM transition of master's device.
> This approach replaces old behavior, when SYSMMU controller was set to
> runtime active once after attaching to the master device. In the new
> approach SYSMMU controllers no longer prevents respective power domains
> to be turned off when master's device is not being used.
> 
> The dependency links also enforces proper order of suspending/restoring
> devices during system sleep transition, so there is no more need to use
> LATE_SYSTEM_SLEEP_PM_OPS-based workaround for ensuring that SYSMMUs are
> suspended after their master devices.

Patches 1-6 seems reasonable to me, however in so far as this patch is
concerned I'd appreaciate if you and Rafael can reply to Lukas Wunner's
questions.

  Luis

> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/iommu/exynos-iommu.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 5e6d7bb..4b05a15 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -633,8 +633,8 @@ static int __maybe_unused exynos_sysmmu_resume(struct device *dev)
>  
>  static const struct dev_pm_ops sysmmu_pm_ops = {
>  	SET_RUNTIME_PM_OPS(exynos_sysmmu_suspend, exynos_sysmmu_resume, NULL)
> -	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -				     pm_runtime_force_resume)
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
>  };
>  
>  static const struct of_device_id sysmmu_of_match[] __initconst = {
> @@ -781,10 +781,6 @@ static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
>  	if (!has_sysmmu(dev) || owner->domain != iommu_domain)
>  		return;
>  
> -	list_for_each_entry(data, &owner->controllers, owner_node) {
> -		pm_runtime_put_sync(data->sysmmu);
> -	}
> -
>  	mutex_lock(&owner->rpm_lock);
>  
>  	list_for_each_entry(data, &owner->controllers, owner_node) {
> @@ -848,10 +844,6 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
>  
>  	mutex_unlock(&owner->rpm_lock);
>  
> -	list_for_each_entry(data, &owner->controllers, owner_node) {
> -		pm_runtime_get_sync(data->sysmmu);
> -	}
> -
>  	dev_dbg(dev, "%s: Attached IOMMU with pgtable %pa\n", __func__,
>  		&pagetable);
>  
> @@ -1232,6 +1224,14 @@ static int exynos_iommu_of_xlate(struct device *dev,
>  
>  	list_add_tail(&data->owner_node, &owner->controllers);
>  	data->master = dev;
> +
> +	/*
> +	 * SYSMMU will be runtime activated via device link (dependency) to its
> +	 * master device, so there are no direct calls to pm_runtime_get/put
> +	 * in this driver.
> +	 */
> +	device_link_add(dev, data->sysmmu, DL_FLAG_PM_RUNTIME);
> +
>  	return 0;
>  }
>  
> -- 
> 1.9.1
> 
> 

-- 
Luis Rodriguez, SUSE LINUX GmbH
Maxfeldstrasse 5; D-90409 Nuernberg
