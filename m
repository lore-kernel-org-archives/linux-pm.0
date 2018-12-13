From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 6/6] PM / Domains: Propagate performance state updates
Date: Thu, 13 Dec 2018 16:53:44 +0100
Message-ID: <CAPDyKFpFn60O7W71v7b3fsCtmS520=GG0AQhs3GpdarVE+W--A@mail.gmail.com>
References: <cover.1544611890.git.viresh.kumar@linaro.org> <d138bd45d0eacc11ff90e27f83d8b47d692877ef.1544611890.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d138bd45d0eacc11ff90e27f83d8b47d692877ef.1544611890.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, Rajendra Nayak <rnayak@codeaurora.org>, Niklas Cassel <niklas.cassel@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 12 Dec 2018 at 11:58, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> This commit updates genpd core to start propagating performance state
> updates to master domains that have their set_performance_state()
> callback set.

I would appreciate some more words of what happens during the
propagation. For example, how OPP tables are used and how mapping
between performance states are done from a sub-domain to a
master-domain. At least a high level description would be nice, I
think.

>
> Currently a genpd only handles the performance state requirements from
> the devices under its control. This commit extends that to also handle
> the performance state requirement(s) put on the master genpd by its
> sub-domains. There is a separate value required for each master that
> the genpd has and so a new field is added to the struct gpd_link
> (link->performance_state), which represents the link between a genpd and
> its master. The struct gpd_link also got another field
> prev_performance_state, which is used by genpd core as a temporary
> variable during transitions.
>
> Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/domain.c | 105 ++++++++++++++++++++++++++++++------
>  include/linux/pm_domain.h   |   4 ++
>  2 files changed, 94 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 32ecbefbd191..5e0479b2e976 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -239,24 +239,90 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
>  static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
>  #endif
>
> +static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
> +                                          unsigned int state, int depth);
> +
>  static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
> -                                       unsigned int state)
> +                                       unsigned int state, int depth)
>  {
> +       struct generic_pm_domain *master;
> +       struct gpd_link *link;
> +       unsigned int master_state;
>         int ret;
>
> +       /* Propagate to masters of genpd */
> +       list_for_each_entry(link, &genpd->slave_links, slave_node) {
> +               master = link->master;
> +
> +               if (!master->set_performance_state)
> +                       continue;
> +
> +               if (unlikely(!state)) {
> +                       master_state = 0;
> +               } else {
> +                       /* Find master's performance state */
> +                       master_state = dev_pm_opp_xlate_performance_state(genpd->opp_table,
> +                                               master->opp_table, state);
> +                       if (unlikely(!master_state)) {
> +                               ret = -EINVAL;
> +                               goto err;
> +                       }
> +               }

According to my comment for patch3, the above can be simplified.
Moreover, the "unlikely" thingy above is a bit questionable, as we
can't really know what is "unlikely" here.

> +
> +               genpd_lock_nested(master, depth + 1);
> +
> +               link->prev_performance_state = link->performance_state;
> +               link->performance_state = master_state;
> +               ret = _genpd_reeval_performance_state(master, master_state,
> +                                                     depth + 1);
> +               if (ret)
> +                       link->performance_state = link->prev_performance_state;
> +
> +               genpd_unlock(master);
> +
> +               if (ret)
> +                       goto err;
> +       }
> +
>         ret = genpd->set_performance_state(genpd, state);
>         if (ret)
> -               return ret;
> +               goto err;
>
>         genpd->performance_state = state;
>         return 0;
> +
> +err:
> +       /* Encountered an error, lets rollback */
> +       list_for_each_entry_continue_reverse(link, &genpd->slave_links,
> +                                            slave_node) {
> +               master = link->master;
> +
> +               if (!master->set_performance_state)
> +                       continue;
> +
> +               genpd_lock_nested(master, depth + 1);
> +
> +               master_state = link->prev_performance_state;
> +               link->performance_state = master_state;
> +
> +               if (_genpd_reeval_performance_state(master, master_state,
> +                                                   depth + 1)) {
> +                       pr_err("%s: Failed to roll back to %d performance state\n",
> +                              master->name, master_state);
> +               }
> +
> +               genpd_unlock(master);
> +       }
> +
> +       return ret;
>  }
>
>  static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
> -                                          unsigned int state)
> +                                          unsigned int state, int depth)
>  {
>         struct generic_pm_domain_data *pd_data;
>         struct pm_domain_data *pdd;
> +       struct gpd_link *link;
>
>         /* New requested state is same as Max requested state */
>         if (state == genpd->performance_state)
> @@ -274,21 +340,30 @@ static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
>                         state = pd_data->performance_state;
>         }
>
> -       if (state == genpd->performance_state)
> -               return 0;
> -
>         /*
> -        * We aren't propagating performance state changes of a subdomain to its
> -        * masters as we don't have hardware that needs it. Over that, the
> -        * performance states of subdomain and its masters may not have
> -        * one-to-one mapping and would require additional information. We can
> -        * get back to this once we have hardware that needs it. For that
> -        * reason, we don't have to consider performance state of the subdomains
> -        * of genpd here.
> +        * Traverse all sub-domains within the domain. This can be
> +        * done without any additional locking as the link->performance_state
> +        * field is protected by the master genpd->lock, which is already taken.
> +        *
> +        * Also note that link->performance_state (subdomain's performance state
> +        * requirement to master domain) is different from
> +        * link->slave->performance_state (current performance state requirement
> +        * of the devices/sub-domains of the subdomain) and so can have a
> +        * different value.
> +        *
> +        * Note that we also take vote from powered-off sub-domains into account
> +        * as the same is done for devices right now.
>          */
> +       list_for_each_entry(link, &genpd->master_links, master_node) {
> +               if (link->performance_state > state)
> +                       state = link->performance_state;
> +       }
> +
> +       if (state == genpd->performance_state)
> +               return 0;
>
>  update_state:
> -       return _genpd_set_performance_state(genpd, state);
> +       return _genpd_set_performance_state(genpd, state, depth);

Instead of calling _genpd_set_performance_state() from here, I suggest
to let the caller do it. Simply return the aggregated new state, if it
needs to be updated - and zero if no update is needed.

Why? I think it may clarify and simplify the code, in regards to the
actual set/propagation of state changes. Another side-effect, is that
you should be able to avoid the forward declaration of
_genpd_reeval_performance_state(), which I think is nice as well.

I guess changing this, should already be done in patch 5, so patch 6
can build on it.

>  }
>
>  /**
> @@ -332,7 +407,7 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
>         prev = gpd_data->performance_state;
>         gpd_data->performance_state = state;
>
> -       ret = _genpd_reeval_performance_state(genpd, state);
> +       ret = _genpd_reeval_performance_state(genpd, state, 0);
>         if (ret)
>                 gpd_data->performance_state = prev;
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 9ad101362aef..dd364abb649a 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -136,6 +136,10 @@ struct gpd_link {
>         struct list_head master_node;
>         struct generic_pm_domain *slave;
>         struct list_head slave_node;
> +
> +       /* Sub-domain's per-master domain performance state */
> +       unsigned int performance_state;
> +       unsigned int prev_performance_state;

Probably a leftover from the earlier versions, please remove.

>  };
>
>  struct gpd_timing_data {
> --
> 2.19.1.568.g152ad8e3369a
>

Kind regards
Uffe
