From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH V3] PM / Runtime: Defer resuming of the device in
 pm_runtime_force_resume()
Date: Tue, 18 Oct 2016 12:32:01 +0200
Message-ID: <dbcc7a8c-162c-1d0d-1411-02eff67d98c9@samsung.com>
References: <CGME20161013145916eucas1p1b93e63340fe16491a1d53d6e8d9a5f93@eucas1p1.samsung.com>
 <1476370734-23168-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:54448 "EHLO
        mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753891AbcJRKcH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Oct 2016 06:32:07 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OF800A30NXGAY90@mailout3.w1.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 18 Oct 2016 11:32:05 +0100 (BST)
In-reply-to: <1476370734-23168-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Ulf,


On 2016-10-13 16:58, Ulf Hansson wrote:
> When the pm_runtime_force_suspend|resume() helpers were invented, we still
> had CONFIG_PM_RUNTIME and CONFIG_PM_SLEEP as separate Kconfig options.
>
> To make sure these helpers worked for all combinations and without
> introducing too much of complexity, the device was always resumed in
> pm_runtime_force_resume().
>
> More precisely, when CONFIG_PM_SLEEP was set and CONFIG_PM_RUNTIME was
> unset, we needed to resume the device as the subsystem/driver couldn't
> rely on using runtime PM to do it.
>
> As the CONFIG_PM_RUNTIME option was merged into CONFIG_PM a while ago, it
> removed this combination, of using CONFIG_PM_SLEEP without the earlier
> CONFIG_PM_RUNTIME.
>
> For this reason we can now rely on the subsystem/driver to use runtime PM
> to resume the device, instead of forcing that to be done in all cases. In
> other words, let's defer the runtime resume to a later point when it's
> actually needed.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

I wasn't aware that You are working on this feature. I had it on my todo 
list,
because it was a waste of power to always wake up all devices in resume from
sleep. Your change solves this issue and it works fine with my use cases. :)
You can add my:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

I've tested it together with my Exynos IOMMU runtime pm rework and Rafael's
device dependency patchset (needed for my rework).

> ---
>
> Changes in v3:
> 	- Updated to take care of parent-child relations.
> 	- Improved comment in the code and updated text in a function header
> 	to better describe the changes.
>
> This patch has earlier been sent standalone, but also as a part of series. In
> the end it turned out the solution needed some improvement to take care of
> parent-child relations, as reported by Geert [1].
>
> Geert, I would really appreciate if you could help out testing to make sure the
> reported issue is fixed.
>
> [1]
> https://patches.linaro.org/patch/67940/
>
> ---
>
>   drivers/base/power/runtime.c | 35 ++++++++++++++++++++++++++++++-----
>   1 file changed, 30 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index e097d35..f662267 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1478,6 +1478,16 @@ int pm_runtime_force_suspend(struct device *dev)
>   	if (ret)
>   		goto err;
>   
> +	/*
> +	 * Increase the runtime PM usage count for the device's parent, in case
> +	 * when we find the device being used when system suspend was invoked.
> +	 * This informs pm_runtime_force_resume() to resume the parent
> +	 * immediately, which is needed to be able to resume its children,
> +	 * when not deferring the resume to be managed via runtime PM.
> +	 */
> +	if (dev->parent && atomic_read(&dev->power.usage_count) > 1)
> +		pm_runtime_get_noresume(dev->parent);
> +
>   	pm_runtime_set_suspended(dev);
>   	return 0;
>   err:
> @@ -1487,16 +1497,20 @@ err:
>   EXPORT_SYMBOL_GPL(pm_runtime_force_suspend);
>   
>   /**
> - * pm_runtime_force_resume - Force a device into resume state.
> + * pm_runtime_force_resume - Force a device into resume state if needed.
>    * @dev: Device to resume.
>    *
>    * Prior invoking this function we expect the user to have brought the device
>    * into low power state by a call to pm_runtime_force_suspend(). Here we reverse
> - * those actions and brings the device into full power. We update the runtime PM
> - * status and re-enables runtime PM.
> + * those actions and brings the device into full power, if it is expected to be
> + * used on system resume. To distinguish that, we check whether the runtime PM
> + * usage count is greater than 1 (the PM core increases the usage count in the
> + * system PM prepare phase), as that indicates a real user (such as a subsystem,
> + * driver, userspace, etc.) is using it. If that is the case, the device is
> + * expected to be used on system resume as well, so then we resume it. In the
> + * other case, we defer the resume to be managed via runtime PM.
>    *
> - * Typically this function may be invoked from a system resume callback to make
> - * sure the device is put into full power state.
> + * Typically this function may be invoked from a system resume callback.
>    */
>   int pm_runtime_force_resume(struct device *dev)
>   {
> @@ -1513,6 +1527,17 @@ int pm_runtime_force_resume(struct device *dev)
>   	if (!pm_runtime_status_suspended(dev))
>   		goto out;
>   
> +	/*
> +	 * Decrease the parent's runtime PM usage count, if we increased it
> +	 * during system suspend in pm_runtime_force_suspend().
> +	*/
> +	if (atomic_read(&dev->power.usage_count) > 1) {
> +		if (dev->parent)
> +			pm_runtime_put_noidle(dev->parent);
> +	} else {
> +		goto out;
> +	}
> +
>   	ret = pm_runtime_set_active(dev);
>   	if (ret)
>   		goto out;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

