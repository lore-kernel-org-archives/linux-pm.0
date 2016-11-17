From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3] PM / Runtime: Defer resuming of the device in pm_runtime_force_resume()
Date: Thu, 17 Nov 2016 21:21:05 +0100
Message-ID: <CAPDyKFp5Ay1dN2UQauD7vHxPQP+kghviAAduhpHO7QAmH-1UiA@mail.gmail.com>
References: <1476370734-23168-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35848 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752302AbcKQUVI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Nov 2016 15:21:08 -0500
Received: by mail-wm0-f41.google.com with SMTP id g23so334887350wme.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Nov 2016 12:21:07 -0800 (PST)
In-Reply-To: <1476370734-23168-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Linus Walleij <linus.walleij@linaro.org>

On 13 October 2016 at 16:58, Ulf Hansson <ulf.hansson@linaro.org> wrote:
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

Rafael, this one is ready to be queued. Unless there are other objections.

The problems that was reported by Geert for this change, has been
taken care of. Those are fixed by the patch for the smsc911x ethernet
driver [1], which you queued a while ago.
I realized that wasn't obvious unless one digested the conversations in detail.

Geert, perhaps you can confirm by providing a tested-by tag?

Kind regards
Uffe

[1]
https://www.spinics.net/lists/netdev/msg401339.html

> ---
>
> Changes in v3:
>         - Updated to take care of parent-child relations.
>         - Improved comment in the code and updated text in a function header
>         to better describe the changes.
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
>  drivers/base/power/runtime.c | 35 ++++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index e097d35..f662267 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1478,6 +1478,16 @@ int pm_runtime_force_suspend(struct device *dev)
>         if (ret)
>                 goto err;
>
> +       /*
> +        * Increase the runtime PM usage count for the device's parent, in case
> +        * when we find the device being used when system suspend was invoked.
> +        * This informs pm_runtime_force_resume() to resume the parent
> +        * immediately, which is needed to be able to resume its children,
> +        * when not deferring the resume to be managed via runtime PM.
> +        */
> +       if (dev->parent && atomic_read(&dev->power.usage_count) > 1)
> +               pm_runtime_get_noresume(dev->parent);
> +
>         pm_runtime_set_suspended(dev);
>         return 0;
>  err:
> @@ -1487,16 +1497,20 @@ err:
>  EXPORT_SYMBOL_GPL(pm_runtime_force_suspend);
>
>  /**
> - * pm_runtime_force_resume - Force a device into resume state.
> + * pm_runtime_force_resume - Force a device into resume state if needed.
>   * @dev: Device to resume.
>   *
>   * Prior invoking this function we expect the user to have brought the device
>   * into low power state by a call to pm_runtime_force_suspend(). Here we reverse
> - * those actions and brings the device into full power. We update the runtime PM
> - * status and re-enables runtime PM.
> + * those actions and brings the device into full power, if it is expected to be
> + * used on system resume. To distinguish that, we check whether the runtime PM
> + * usage count is greater than 1 (the PM core increases the usage count in the
> + * system PM prepare phase), as that indicates a real user (such as a subsystem,
> + * driver, userspace, etc.) is using it. If that is the case, the device is
> + * expected to be used on system resume as well, so then we resume it. In the
> + * other case, we defer the resume to be managed via runtime PM.
>   *
> - * Typically this function may be invoked from a system resume callback to make
> - * sure the device is put into full power state.
> + * Typically this function may be invoked from a system resume callback.
>   */
>  int pm_runtime_force_resume(struct device *dev)
>  {
> @@ -1513,6 +1527,17 @@ int pm_runtime_force_resume(struct device *dev)
>         if (!pm_runtime_status_suspended(dev))
>                 goto out;
>
> +       /*
> +        * Decrease the parent's runtime PM usage count, if we increased it
> +        * during system suspend in pm_runtime_force_suspend().
> +       */
> +       if (atomic_read(&dev->power.usage_count) > 1) {
> +               if (dev->parent)
> +                       pm_runtime_put_noidle(dev->parent);
> +       } else {
> +               goto out;
> +       }
> +
>         ret = pm_runtime_set_active(dev);
>         if (ret)
>                 goto out;
> --
> 1.9.1
>
