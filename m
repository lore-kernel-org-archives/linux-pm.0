From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 6/7] PM / Domains: Factorize dev_pm_genpd_set_performance_state()
Date: Fri, 14 Dec 2018 11:40:50 +0100
Message-ID: <CAPDyKFr7_Cn0N=pctuTdqzcUy9fg-fmpd5OgEFS9eRz-SFh1Fw@mail.gmail.com>
References: <cover.1544782279.git.viresh.kumar@linaro.org> <f6153683d88cce25319945e4308bef46edaaaa54.1544782279.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f6153683d88cce25319945e4308bef46edaaaa54.1544782279.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, Rajendra Nayak <rnayak@codeaurora.org>, Niklas Cassel <niklas.cassel@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 14 Dec 2018 at 11:15, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Separate out _genpd_set_performance_state() and
> _genpd_reeval_performance_state() from
> dev_pm_genpd_set_performance_state() to handle performance state update
> related stuff. This will be used by a later commit.
>
> Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Nitpick: Would be nice to remove the beginning "_" from both
_genpd_reeval_performance_state() and _genpd_set_performance_state(),
as to be consistent with existing function naming in genpd. However,
it's not a big deal and can be done on top.



> ---
>  drivers/base/power/domain.c | 95 +++++++++++++++++++++----------------
>  1 file changed, 55 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 1e98c637e069..808ba41b6580 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -239,6 +239,56 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
>  static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
>  #endif
>
> +static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
> +                                          unsigned int state)
> +{
> +       struct generic_pm_domain_data *pd_data;
> +       struct pm_domain_data *pdd;
> +
> +       /* New requested state is same as Max requested state */
> +       if (state == genpd->performance_state)
> +               return state;
> +
> +       /* New requested state is higher than Max requested state */
> +       if (state > genpd->performance_state)
> +               return state;
> +
> +       /* Traverse all devices within the domain */
> +       list_for_each_entry(pdd, &genpd->dev_list, list_node) {
> +               pd_data = to_gpd_data(pdd);
> +
> +               if (pd_data->performance_state > state)
> +                       state = pd_data->performance_state;
> +       }
> +
> +       /*
> +        * We aren't propagating performance state changes of a subdomain to its
> +        * masters as we don't have hardware that needs it. Over that, the
> +        * performance states of subdomain and its masters may not have
> +        * one-to-one mapping and would require additional information. We can
> +        * get back to this once we have hardware that needs it. For that
> +        * reason, we don't have to consider performance state of the subdomains
> +        * of genpd here.
> +        */
> +       return state;
> +}
> +
> +static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
> +                                       unsigned int state)
> +{
> +       int ret;
> +
> +       if (state == genpd->performance_state)
> +               return 0;
> +
> +       ret = genpd->set_performance_state(genpd, state);
> +       if (ret)
> +               return ret;
> +
> +       genpd->performance_state = state;
> +       return 0;
> +}
> +
>  /**
>   * dev_pm_genpd_set_performance_state- Set performance state of device's power
>   * domain.
> @@ -257,10 +307,9 @@ static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
>  int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
>  {
>         struct generic_pm_domain *genpd;
> -       struct generic_pm_domain_data *gpd_data, *pd_data;
> -       struct pm_domain_data *pdd;
> +       struct generic_pm_domain_data *gpd_data;
>         unsigned int prev;
> -       int ret = 0;
> +       int ret;
>
>         genpd = dev_to_genpd(dev);
>         if (IS_ERR(genpd))
> @@ -281,45 +330,11 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
>         prev = gpd_data->performance_state;
>         gpd_data->performance_state = state;
>
> -       /* New requested state is same as Max requested state */
> -       if (state == genpd->performance_state)
> -               goto unlock;
> -
> -       /* New requested state is higher than Max requested state */
> -       if (state > genpd->performance_state)
> -               goto update_state;
> -
> -       /* Traverse all devices within the domain */
> -       list_for_each_entry(pdd, &genpd->dev_list, list_node) {
> -               pd_data = to_gpd_data(pdd);
> -
> -               if (pd_data->performance_state > state)
> -                       state = pd_data->performance_state;
> -       }
> -
> -       if (state == genpd->performance_state)
> -               goto unlock;
> -
> -       /*
> -        * We aren't propagating performance state changes of a subdomain to its
> -        * masters as we don't have hardware that needs it. Over that, the
> -        * performance states of subdomain and its masters may not have
> -        * one-to-one mapping and would require additional information. We can
> -        * get back to this once we have hardware that needs it. For that
> -        * reason, we don't have to consider performance state of the subdomains
> -        * of genpd here.
> -        */
> -
> -update_state:
> -       ret = genpd->set_performance_state(genpd, state);
> -       if (ret) {
> +       state = _genpd_reeval_performance_state(genpd, state);
> +       ret = _genpd_set_performance_state(genpd, state);
> +       if (ret)
>                 gpd_data->performance_state = prev;
> -               goto unlock;
> -       }
>
> -       genpd->performance_state = state;
> -
> -unlock:
>         genpd_unlock(genpd);
>
>         return ret;
> --
> 2.19.1.568.g152ad8e3369a
>
