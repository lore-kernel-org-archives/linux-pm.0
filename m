From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 06/10] PM / Domains: Add genpd_opp_to_performance_state()
Date: Thu, 25 Oct 2018 12:54:37 +0200
Message-ID: <CAPDyKFqrbMRjpf8Siy3-43q0Jd+mY1jo2N+uRaoDeaq9Q-5T2w@mail.gmail.com>
References: <cover.1540446493.git.viresh.kumar@linaro.org> <e09b2960614c70e38347d52bd4093ab93af1da47.1540446493.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e09b2960614c70e38347d52bd4093ab93af1da47.1540446493.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, Niklas Cassel <niklas.cassel@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 25 October 2018 at 07:52, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The OPP core currently stores the performance state in the consumer
> device's OPP table, but that is going to change going forward and
> performance state will rather be set directly in the genpd's OPP table.
>
> For that we need to get the performance state for genpd's device
> structure (genpd->dev) instead of the consumer device's structure. Add a
> new helper to do that.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 32 ++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  9 +++++++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index fe9b0527b161..7be8c94c6b7f 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2520,6 +2520,38 @@ int of_genpd_parse_idle_states(struct device_node *dn,
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
>
> +/**
> + * pm_genpd_opp_to_performance_state - Gets performance state of the genpd from its OPP node.
> + *
> + * @genpd_dev: Genpd's device for which the performance-state needs to be found.
> + * @opp: struct dev_pm_opp of the OPP for which we need to find performance
> + *     state.
> + *
> + * Returns performance state encoded in the OPP of the genpd. This calls
> + * platform specific genpd->opp_to_performance_state() callback to translate
> + * power domain OPP to performance state.
> + *
> + * Returns performance state on success and 0 on failure.
> + */
> +unsigned int pm_genpd_opp_to_performance_state(struct device *genpd_dev,
> +                                              struct dev_pm_opp *opp)
> +{
> +       struct generic_pm_domain *genpd = NULL;
> +       int state;
> +
> +       genpd = container_of(genpd_dev, struct generic_pm_domain, dev);
> +
> +       if (unlikely(!genpd->opp_to_performance_state))
> +               return 0;
> +
> +       genpd_lock(genpd);
> +       state = genpd->opp_to_performance_state(genpd, opp);
> +       genpd_unlock(genpd);
> +
> +       return state;
> +}
> +EXPORT_SYMBOL_GPL(pm_genpd_opp_to_performance_state);
> +
>  /**
>   * of_genpd_opp_to_performance_state- Gets performance state of device's
>   * power domain corresponding to a DT node's "required-opps" property.
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 3b5d7280e52e..4f803f934308 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -258,6 +258,8 @@ int of_genpd_add_subdomain(struct of_phandle_args *parent,
>  struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
>  int of_genpd_parse_idle_states(struct device_node *dn,
>                                struct genpd_power_state **states, int *n);
> +unsigned int pm_genpd_opp_to_performance_state(struct device *genpd_dev,
> +                                              struct dev_pm_opp *opp);
>  unsigned int of_genpd_opp_to_performance_state(struct device *dev,
>                                 struct device_node *np);
>
> @@ -299,6 +301,13 @@ static inline int of_genpd_parse_idle_states(struct device_node *dn,
>         return -ENODEV;
>  }
>
> +static inline unsigned int
> +pm_genpd_opp_to_performance_state(struct device *genpd_dev,
> +                                 struct dev_pm_opp *opp)
> +{
> +       return 0;
> +}
> +
>  static inline unsigned int
>  of_genpd_opp_to_performance_state(struct device *dev,
>                                   struct device_node *np)
> --
> 2.19.1.568.g152ad8e3369a
>
