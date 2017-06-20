From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] PM / Domains: Call driver's noirq callbacks
Date: Tue, 20 Jun 2017 16:18:48 +0200
Message-ID: <CAPDyKFr-e3rJ0XU8snbLVgz3vh=mtL787e4fyb=2GqnPa7rYfA@mail.gmail.com>
References: <CAPDyKFpgXCwErOUBcXwOVycYpro6=-vxoQeGnTMwsn0ji8iXJQ@mail.gmail.com>
 <1497965895-11486-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:33223 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbdFTOSz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jun 2017 10:18:55 -0400
Received: by mail-qt0-f169.google.com with SMTP id u12so134628979qth.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Jun 2017 07:18:54 -0700 (PDT)
In-Reply-To: <1497965895-11486-1-git-send-email-mperttunen@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 20 June 2017 at 15:38, Mikko Perttunen <mperttunen@nvidia.com> wrote:
> Currently genpd installs its own suspend_noirq, resume_noirq,
> and poweroff_noirq callbacks, but never calls down to the driver's
> corresponding callbacks. Add these calls.
>
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> v2:
> - Moved pm_generic_suspend_noirq to before pm_runtime_force_suspend,
>   and correspondingly pm_generic_resume_noirq after
>   pm_runtime_force_resume
> - Added new pm_genpd_poweroff_noirq callback that is identical to
>   pm_genpd_suspend_noirq but calls the appropriate driver callback
>
>  drivers/base/power/domain.c | 50 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index d3f1d96f75e9..b070ee58186d 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -919,6 +919,10 @@ static int pm_genpd_suspend_noirq(struct device *dev)
>         if (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
>                 return 0;
>
> +       ret = pm_generic_suspend_noirq(dev);
> +       if (ret)
> +               return ret;
> +
>         if (genpd->dev_ops.stop && genpd->dev_ops.start) {
>                 ret = pm_runtime_force_suspend(dev);
>                 if (ret)
> @@ -961,6 +965,10 @@ static int pm_genpd_resume_noirq(struct device *dev)
>         if (genpd->dev_ops.stop && genpd->dev_ops.start)
>                 ret = pm_runtime_force_resume(dev);
>
> +       ret = pm_generic_resume_noirq(dev);
> +       if (ret)
> +               return ret;
> +
>         return ret;
>  }
>
> @@ -1015,6 +1023,46 @@ static int pm_genpd_thaw_noirq(struct device *dev)
>  }
>
>  /**
> + * pm_genpd_poweroff_noirq - Completion of hibernation of device in an
> + *   I/O PM domain.
> + * @dev: Device to poweroff.
> + *
> + * Stop the device and remove power from the domain if all devices in it have
> + * been stopped.
> + */
> +static int pm_genpd_poweroff_noirq(struct device *dev)
> +{
> +       struct generic_pm_domain *genpd;
> +       int ret;
> +
> +       dev_dbg(dev, "%s()\n", __func__);
> +
> +       genpd = dev_to_genpd(dev);
> +       if (IS_ERR(genpd))
> +               return -EINVAL;
> +
> +       if (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
> +               return 0;
> +
> +       ret = pm_generic_poweroff_noirq(dev);

The only difference between  pm_genpd_suspend_noirq() and
pm_genpd_poweroff_noirq() is the above line. Can we re-factor the code
so we avoid open code here, please.

> +       if (ret)
> +               return ret;
> +
> +       if (genpd->dev_ops.stop && genpd->dev_ops.start) {
> +               ret = pm_runtime_force_suspend(dev);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       genpd_lock(genpd);
> +       genpd->suspended_count++;
> +       genpd_sync_power_off(genpd, true, 0);
> +       genpd_unlock(genpd);
> +
> +       return 0;
> +}
> +
> +/**
>   * pm_genpd_restore_noirq - Start of restore of device in an I/O PM domain.
>   * @dev: Device to resume.
>   *
> @@ -1493,7 +1541,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>         genpd->domain.ops.resume_noirq = pm_genpd_resume_noirq;
>         genpd->domain.ops.freeze_noirq = pm_genpd_freeze_noirq;
>         genpd->domain.ops.thaw_noirq = pm_genpd_thaw_noirq;
> -       genpd->domain.ops.poweroff_noirq = pm_genpd_suspend_noirq;
> +       genpd->domain.ops.poweroff_noirq = pm_genpd_poweroff_noirq;
>         genpd->domain.ops.restore_noirq = pm_genpd_restore_noirq;

The pm_genpd_restore_noirq() doesn't invokes the lower level
->restore_noirq() callbacks. If you are going to change that for the
*poweroff* callback, certainly we should change that also for the
*restore* callbacks as well. Don't you think?

Moreover, what about the freeze and thaw callbacks, should these also
walk the lower level callbacks?

>         genpd->domain.ops.complete = pm_genpd_complete;
>
> --
> 2.1.4
>

Kind regards
Uffe
