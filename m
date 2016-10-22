From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH v5 6/7] iommu/exynos: Add runtime pm support
Date: Sat, 22 Oct 2016 11:20:12 +0530
Message-ID: <000701d22c28$2da381d0$88ea8570$@codeaurora.org>
References: <1476948173-21093-1-git-send-email-m.szyprowski@samsung.com>	<CGME20161020072335eucas1p209675d6fbf39e5045281e8023fa9d234@eucas1p2.samsung.com>
	<1476948173-21093-7-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1476948173-21093-7-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Marek Szyprowski' <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: 'Tomeu Vizoso' <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, 'Kevin Hilman' <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, 'Greg Kroah-Hartman' <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "'Rafael J. Wysocki'" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, 'Tomasz Figa' <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 'Krzysztof Kozlowski' <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, 'Inki Dae' <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Tobias Jakobi' <tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org>, "'Luis R. Rodriguez'" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, 'Kukjin Kim' <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, 'Lukas Wunner' <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Marek,

>This patch adds runtime pm implementation, which is based on previous
>suspend/resume code. SYSMMU controller is now being enabled/disabled mainly
>from the runtime pm callbacks. System sleep callbacks relies on generic
>pm_runtime_force_suspend/pm_runtime_force_resume helpers. To ensure
>internal state consistency, additional lock for runtime pm transitions
>was introduced.
>
>Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>---
> drivers/iommu/exynos-iommu.c | 45 +++++++++++++++++++++++++++++++++++---------
> 1 file changed, 36 insertions(+), 9 deletions(-)
>
>diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
>index a959443e6f33..5e6d7bbf9b70 100644
>--- a/drivers/iommu/exynos-iommu.c
>+++ b/drivers/iommu/exynos-iommu.c
>@@ -206,6 +206,7 @@ struct sysmmu_fault_info {
> struct exynos_iommu_owner {
> 	struct list_head controllers;	/* list of sysmmu_drvdata.owner_node */
> 	struct iommu_domain *domain;	/* domain this device is attached */
>+	struct mutex rpm_lock;		/* for runtime pm of all sysmmus */
> };
>
> /*
>@@ -594,40 +595,46 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
> 	return 0;
> }
>
>-#ifdef CONFIG_PM_SLEEP
>-static int exynos_sysmmu_suspend(struct device *dev)
>+static int __maybe_unused exynos_sysmmu_suspend(struct device *dev)
> {
> 	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
> 	struct device *master = data->master;
>
> 	if (master) {
>-		pm_runtime_put(dev);
>+		struct exynos_iommu_owner *owner = master->archdata.iommu;
>+
>+		mutex_lock(&owner->rpm_lock);
More of a device link question,
To understand, i see that with device link + runtime, the supplier
callbacks are not called for irqsafe clients, even if supplier is irqsafe.
Why so ?

> 		if (data->domain) {
> 			dev_dbg(data->sysmmu, "saving state\n");
> 			__sysmmu_disable(data);
> 		}
>+		mutex_unlock(&owner->rpm_lock);
> 	}
> 	return 0;
> }
>
>-static int exynos_sysmmu_resume(struct device *dev)
>+static int __maybe_unused exynos_sysmmu_resume(struct device *dev)
> {
> 	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
> 	struct device *master = data->master;
>
> 	if (master) {
>-		pm_runtime_get_sync(dev);
>+		struct exynos_iommu_owner *owner = master->archdata.iommu;
>+
>+		mutex_lock(&owner->rpm_lock);
> 		if (data->domain) {
> 			dev_dbg(data->sysmmu, "restoring state\n");
> 			__sysmmu_enable(data);
> 		}
>+		mutex_unlock(&owner->rpm_lock);
> 	}
> 	return 0;
> }
>-#endif
>
> static const struct dev_pm_ops sysmmu_pm_ops = {
>-	SET_LATE_SYSTEM_SLEEP_PM_OPS(exynos_sysmmu_suspend, exynos_sysmmu_resume)
>+	SET_RUNTIME_PM_OPS(exynos_sysmmu_suspend, exynos_sysmmu_resume, NULL)
>+	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>+				     pm_runtime_force_resume)
> };
 Is this needed to be LATE_SYSTEM_SLEEP_PM_OPS with device links to take care
  of the order ?

Regards,
 Sricharan
