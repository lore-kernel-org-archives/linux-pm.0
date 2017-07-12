From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: defer dev_pm_domain_set() until
 genpd->attach_dev succeeds if present
Date: Wed, 12 Jul 2017 15:59:59 +0200
Message-ID: <CAPDyKFrTSwiUFLbWp7BV4NJiuvoedEX=f4pA6wZzsrhDh4TctA@mail.gmail.com>
References: <1498759251-11709-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498759251-11709-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 29 June 2017 at 20:00, Sudeep Holla <sudeep.holla@arm.com> wrote:
> If the genpd->attach_dev or genpd->power_on fails, genpd_dev_pm_attach
> may return -EPROBE_DEFER initially. However genpd_alloc_dev_data sets
> the PM domain for the device unconditionally.
>
> When subsequent attempts are made to call genpd_dev_pm_attach, it may
> return -EEXISTS checking dev->pm_domain without re-attempting to call
> attach_dev or power_on.
>
> platform_drv_probe then attempts to call drv->probe as the return value
> -EEXIST != -EPROBE_DEFER, which may end up in a situation where the
> device is accessed without it's power domain switched on.

Right, this makes sense.

>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Could we perhaps work out which commit it fixes, or perhaps the
problem been there long time ago and we should just add a stable tag?

> ---
>  drivers/base/power/domain.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index da49a8383dc3..b195d34de888 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1168,8 +1168,6 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
>
>         spin_unlock_irq(&dev->power.lock);
>
> -       dev_pm_domain_set(dev, &genpd->domain);
> -
>         return gpd_data;
>
>   err_free:
> @@ -1221,6 +1219,8 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>         if (ret)
>                 goto out;
>
> +       dev_pm_domain_set(dev, &genpd->domain);
> +
>         genpd->device_count++;
>         genpd->max_off_time_changed = true;
>
> --
> 2.7.4
>

One piece is missing to make this fix complete.

More precisely, you must also move the call to dev_pm_domain_set(dev, NULL).

Currently that is done from genpd_free_dev_data(), as it corresponds
to genpd_alloc_dev_data(), but clearly the proper place to call it
should be from genpd_remove_device().

Kind regards
Uffe
