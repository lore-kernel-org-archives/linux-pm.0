From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: Call driver's noirq callbacks
Date: Tue, 20 Jun 2017 14:47:24 +0200
Message-ID: <CAPDyKFpgXCwErOUBcXwOVycYpro6=-vxoQeGnTMwsn0ji8iXJQ@mail.gmail.com>
References: <1497960327-22832-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497960327-22832-1-git-send-email-mperttunen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 20 June 2017 at 14:05, Mikko Perttunen <mperttunen@nvidia.com> wrote:
> Currently genpd installs its own suspend_noirq and resume_noirq
> callbacks, but never calls down to the driver's corresponding
> callbacks. Add these calls.
>
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>
>  drivers/base/power/domain.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index d3f1d96f75e9..c3b6e6018c02 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -925,6 +925,10 @@ static int pm_genpd_suspend_noirq(struct device *dev)
>                         return ret;
>         }
>
> +       ret = pm_generic_suspend_noirq(dev);
> +       if (ret)
> +               return ret;

Two things:
1) I would move this a couple of lines further above, as to avoid
pm_runtime_force_suspend() from being called before, as it may suspend
the device before the noirq callbacks gets to run.
2) pm_genpd_suspend_noirq() is also assigned to the ->poweroff_noirq()
callback. Certainly we don't want run the *suspend* variants of the
callback, but rather the *poweroff* variants in that case.

> +
>         genpd_lock(genpd);
>         genpd->suspended_count++;
>         genpd_sync_power_off(genpd, true, 0);
> @@ -958,6 +962,10 @@ static int pm_genpd_resume_noirq(struct device *dev)
>         genpd->suspended_count--;
>         genpd_unlock(genpd);
>
> +       ret = pm_generic_resume_noirq(dev);
> +       if (ret)
> +               return ret;
> +
>         if (genpd->dev_ops.stop && genpd->dev_ops.start)
>                 ret = pm_runtime_force_resume(dev);
>
> --
> 2.1.4
>

Kind regards
Uffe
