From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 1/2] PM / Domains: Add time accounting to various genpd states.
Date: Tue, 11 Jul 2017 11:06:24 +0200
Message-ID: <CAPDyKFq5imu+f+ovD9tTo=chwycMJDjBjmfU3_Dc_79_grYyPQ@mail.gmail.com>
References: <1498235543-30064-1-git-send-email-thara.gopinath@linaro.org> <1498235543-30064-2-git-send-email-thara.gopinath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:36233 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932158AbdGKJG1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2017 05:06:27 -0400
Received: by mail-qt0-f171.google.com with SMTP id i2so93347179qta.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2017 02:06:26 -0700 (PDT)
In-Reply-To: <1498235543-30064-2-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 23 June 2017 at 18:32, Thara Gopinath <thara.gopinath@linaro.org> wrote:
> This patch adds support to calculate the time spent by the generic
> power domains in on and various idle states.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 32 ++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  3 +++
>  2 files changed, 35 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index da49a83..40768cc 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -207,6 +207,34 @@ static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
>         smp_mb__after_atomic();
>  }
>
> +#ifdef CONFIG_DEBUG_FS
> +static void genpd_update_accounting(struct generic_pm_domain *genpd)
> +{
> +       ktime_t delta, now;
> +
> +       now = ktime_get();
> +       delta = ktime_sub(now, genpd->accounting_time);
> +
> +       /*
> +        * If genpd->status is active, it means we are just
> +        * out of off and so update the idle time and vice
> +        * versa.
> +        */
> +       if (genpd->status == GPD_STATE_ACTIVE) {
> +               int state_idx = genpd->state_idx;
> +
> +               genpd->states[state_idx].idle_time =
> +                       ktime_add(genpd->states[state_idx].idle_time, delta);
> +       } else {
> +               genpd->on_time = ktime_add(genpd->on_time, delta);
> +       }
> +
> +       genpd->accounting_time = now;
> +}
> +#else
> +static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
> +#endif
> +
>  static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>  {
>         unsigned int state_idx = genpd->state_idx;
> @@ -359,6 +387,7 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
>         }
>
>         genpd->status = GPD_STATE_POWER_OFF;
> +       genpd_update_accounting(genpd);
>
>         list_for_each_entry(link, &genpd->slave_links, slave_node) {
>                 genpd_sd_counter_dec(link->master);
> @@ -411,6 +440,8 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
>                 goto err;
>
>         genpd->status = GPD_STATE_ACTIVE;
> +       genpd_update_accounting(genpd);
> +
>         return 0;
>
>   err:
> @@ -1486,6 +1517,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>         genpd->max_off_time_changed = true;
>         genpd->provider = NULL;
>         genpd->has_provider = false;
> +       genpd->accounting_time = ktime_get();
>         genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
>         genpd->domain.ops.runtime_resume = genpd_runtime_resume;
>         genpd->domain.ops.prepare = pm_genpd_prepare;
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index b7803a2..9c8b334 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -43,6 +43,7 @@ struct genpd_power_state {
>         s64 power_on_latency_ns;
>         s64 residency_ns;
>         struct fwnode_handle *fwnode;
> +       ktime_t idle_time;
>  };
>
>  struct genpd_lock_ops;
> @@ -78,6 +79,8 @@ struct generic_pm_domain {
>         unsigned int state_count; /* number of states */
>         unsigned int state_idx; /* state that genpd will go to when off */
>         void *free; /* Free the state that was allocated for default */
> +       ktime_t on_time;
> +       ktime_t accounting_time;
>         const struct genpd_lock_ops *lock_ops;
>         union {
>                 struct mutex mlock;
> --
> 2.1.4
>
