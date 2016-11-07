From: "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 7/7] iommu/exynos: Use device dependency links to
	control runtime pm
Date: Mon, 7 Nov 2016 22:47:47 +0100
Message-ID: <20161107214747.GJ1764@wotan.suse.de>
References: <1476948173-21093-1-git-send-email-m.szyprowski@samsung.com>
	<CGME20161020072336eucas1p24a2b020f69b6ae1f55e1760e6e0e94f9@eucas1p2.samsung.com>
	<1476948173-21093-8-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1476948173-21093-8-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tobias Jakobi <tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Mark
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 20, 2016 at 09:22:53AM +0200, Marek Szyprowski wrote:
> This patch uses recently introduced device dependency links to track the
> runtime pm state of the master's device. This way each SYSMMU controller
> is set to runtime active only when its master's device is active and can
> restore or save its state instead of being activated all the time when
> attached to the given master device. This way SYSMMU controllers no longer
> prevents respective power domains to be turned off when master's device
> is not being used.

Its unclear why you need this based on this commit log -- is this
needed only on platforms that lack ACPI and use device tree ? If so
why? If this issue is present also on systems that only use ACPI is
this possibly due to an ACPI firmware bug  or the lack of some semantics
in ACPI to express ordering in a better way? If the issue is device
tree related only is this due to the lack of semantics in device tree
to express some more complex dependency ?

Has there been any review of the existing similar solutions out there
such as the DRM / audio component framework? Would that help ?

  Luis

> 
> Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/iommu/exynos-iommu.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 5e6d7bbf9b70..59b4f2ce4f5f 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
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
