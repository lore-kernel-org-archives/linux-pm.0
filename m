From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] PM / Domains: Support in context powering off parent domain
Date: Thu, 9 Feb 2017 10:02:55 +0100
Message-ID: <CAPDyKFpYJ+M4girUxS5TP7+fzvDZOxUbN1oE0BJtgsuycKf3pQ@mail.gmail.com>
References: <1486571692-33212-1-git-send-email-lina.iyer@linaro.org> <1486571692-33212-4-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:34619 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752098AbdBIJC5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Feb 2017 04:02:57 -0500
Received: by mail-ua0-f178.google.com with SMTP id 35so129632694uak.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Feb 2017 01:02:56 -0800 (PST)
In-Reply-To: <1486571692-33212-4-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Brendan Jackman <brendan.jackman@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Juri Lelli <Juri.Lelli@arm.com>

On 8 February 2017 at 17:34, Lina Iyer <lina.iyer@linaro.org> wrote:
> Powering off a domain schedules a work to opportunistically power off
> the parent domains. Domains that are IRQ safe may have parents that are
> also IRQ safe. It would be beneficial to power off such IRQ safe parents
> in the same context as well.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  drivers/base/power/domain.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 3825bb9..51e2254 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -375,7 +375,8 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
>   * If all of the @genpd's devices have been suspended and all of its subdomains
>   * have been powered down, remove power from @genpd.
>   */
> -static int genpd_power_off(struct generic_pm_domain *genpd, bool is_async)
> +static int genpd_power_off(struct generic_pm_domain *genpd, bool is_async,
> +                                       unsigned int depth)
>  {
>         struct pm_domain_data *pdd;
>         struct gpd_link *link;
> @@ -442,7 +443,17 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool is_async)
>
>         list_for_each_entry(link, &genpd->slave_links, slave_node) {
>                 genpd_sd_counter_dec(link->master);
> -               genpd_queue_power_off_work(link->master);
> +               /*
> +                * Power off the parent in the same context if the parent
> +                * domain is also IRQ safe.
> +                */
> +               if (genpd_is_irq_safe(genpd) &&
> +                               genpd_is_irq_safe(link->master)) {
> +                       genpd_lock_nested(link->master, depth + 1);
> +                       genpd_power_off(link->master, false, depth + 1);

This doesn't work. You must not call genpd_power_off() using "false" here.

That's because "true" in the recursive call, for the master domain
tells genpd_power_off() that is has been called from genpd's
->runtime_suspend() callback. That means genpd_power_off() thinks it's
okay to allow *one* device in the domain to not be runtime suspended
when allowing a power off to be done. This assumption is not correct
for the master domain.

> +                       genpd_unlock(link->master);
> +               } else
> +                       genpd_queue_power_off_work(link->master);
>         }
>
>         return 0;
> @@ -459,7 +470,7 @@ static void genpd_power_off_work_fn(struct work_struct *work)
>         genpd = container_of(work, struct generic_pm_domain, power_off_work);
>
>         genpd_lock(genpd);
> -       genpd_power_off(genpd, true);
> +       genpd_power_off(genpd, true, 0);
>         genpd_unlock(genpd);
>  }
>
> @@ -578,7 +589,7 @@ static int genpd_runtime_suspend(struct device *dev)
>                 return 0;
>
>         genpd_lock(genpd);
> -       genpd_power_off(genpd, false);
> +       genpd_power_off(genpd, false, 0);
>         genpd_unlock(genpd);
>
>         return 0;
> @@ -658,7 +669,7 @@ static int genpd_runtime_resume(struct device *dev)
>         if (!pm_runtime_is_irq_safe(dev) ||
>                 (pm_runtime_is_irq_safe(dev) && genpd_is_irq_safe(genpd))) {
>                 genpd_lock(genpd);
> -               genpd_power_off(genpd, 0);
> +               genpd_power_off(genpd, 0, 0);
>                 genpd_unlock(genpd);
>         }
>
> --
> 2.7.4
>

Some more thoughts..

Actually, I have been thinking of changing genpd to avoid queuing
power off works, no matter if the PM domain are IRQ safe or not. There
are several reasons, but primarily it helps to avoid wasting power.

Currently I don't see any reasons to why such change shouldn't be
feasible. As a matter of fact, changing this became possible while we
removed the intermediate states in genpd in commit ba2bbfbf6307 ("PM /
Domains: Remove intermediate states from the power off sequence").

Allow me to help out and cook a patch for this, it's already in the pipe. :-)

Kind regards
Uffe
