From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 5/7] PM / Domains: Save OPP table pointer in genpd
Date: Fri, 14 Dec 2018 11:40:47 +0100
Message-ID: <CAPDyKFrDGr_xfNeaSoiScmJAwa_NkNjqQEeSyLkZnQGLUnxQbw@mail.gmail.com>
References: <cover.1544782279.git.viresh.kumar@linaro.org> <5603371d1ad204a7314a3618d362d583b555f6b6.1544782279.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5603371d1ad204a7314a3618d362d583b555f6b6.1544782279.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, Rajendra Nayak <rnayak@codeaurora.org>, Niklas Cassel <niklas.cassel@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 14 Dec 2018 at 11:15, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> dev_pm_genpd_set_performance_state() will be required to call
> dev_pm_opp_xlate_performance_state() going forward to translate from
> performance state of a sub-domain to performance state of its master.
> And dev_pm_opp_xlate_performance_state() needs pointers to the OPP
> tables of both genpd and its master.
>
> Lets fetch and save them while the OPP tables are added. Fetching the
> OPP tables should never fail as we just added the OPP tables and so add
> a WARN_ON() for such a bug instead of full error paths.
>
> Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/base/power/domain.c | 23 +++++++++++++++++++++--
>  include/linux/pm_domain.h   |  2 ++
>  2 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 4a4e39d12354..1e98c637e069 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1896,12 +1896,21 @@ int of_genpd_add_provider_simple(struct device_node *np,
>                                 ret);
>                         goto unlock;
>                 }
> +
> +               /*
> +                * Save table for faster processing while setting performance
> +                * state.
> +                */
> +               genpd->opp_table = dev_pm_opp_get_opp_table(&genpd->dev);
> +               WARN_ON(!genpd->opp_table);
>         }
>
>         ret = genpd_add_provider(np, genpd_xlate_simple, genpd);
>         if (ret) {
> -               if (genpd->set_performance_state)
> +               if (genpd->set_performance_state) {
> +                       dev_pm_opp_put_opp_table(genpd->opp_table);
>                         dev_pm_opp_of_remove_table(&genpd->dev);
> +               }
>
>                 goto unlock;
>         }
> @@ -1954,6 +1963,13 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>                                         i, ret);
>                                 goto error;
>                         }
> +
> +                       /*
> +                        * Save table for faster processing while setting
> +                        * performance state.
> +                        */
> +                       genpd->opp_table = dev_pm_opp_get_opp_table_indexed(&genpd->dev, i);
> +                       WARN_ON(!genpd->opp_table);
>                 }
>
>                 genpd->provider = &np->fwnode;
> @@ -1978,8 +1994,10 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>                 genpd->provider = NULL;
>                 genpd->has_provider = false;
>
> -               if (genpd->set_performance_state)
> +               if (genpd->set_performance_state) {
> +                       dev_pm_opp_put_opp_table(genpd->opp_table);
>                         dev_pm_opp_of_remove_table(&genpd->dev);
> +               }
>         }
>
>         mutex_unlock(&gpd_list_lock);
> @@ -2013,6 +2031,7 @@ void of_genpd_del_provider(struct device_node *np)
>                                         if (!gpd->set_performance_state)
>                                                 continue;
>
> +                                       dev_pm_opp_put_opp_table(gpd->opp_table);
>                                         dev_pm_opp_of_remove_table(&gpd->dev);
>                                 }
>                         }
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 642036952553..9ad101362aef 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -73,6 +73,7 @@ struct genpd_power_state {
>
>  struct genpd_lock_ops;
>  struct dev_pm_opp;
> +struct opp_table;
>
>  struct generic_pm_domain {
>         struct device dev;
> @@ -94,6 +95,7 @@ struct generic_pm_domain {
>         unsigned int performance_state; /* Aggregated max performance state */
>         int (*power_off)(struct generic_pm_domain *domain);
>         int (*power_on)(struct generic_pm_domain *domain);
> +       struct opp_table *opp_table;    /* OPP table of the genpd */
>         unsigned int (*opp_to_performance_state)(struct generic_pm_domain *genpd,
>                                                  struct dev_pm_opp *opp);
>         int (*set_performance_state)(struct generic_pm_domain *genpd,
> --
> 2.19.1.568.g152ad8e3369a
>
