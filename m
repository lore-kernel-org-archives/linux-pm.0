From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] PM / Domains: Rename opp_node to np
Date: Thu, 14 Jun 2018 09:12:20 +0200
Message-ID: <CAPDyKFpN+wLHGE4a14Me7F=dLLGZDnN23BUBd7yBifNuApQYxQ@mail.gmail.com>
References: <b90f44d35e8e0fa9c81b3a88d05449a580be5567.1528953706.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b90f44d35e8e0fa9c81b3a88d05449a580be5567.1528953706.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 14 June 2018 at 07:23, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The DT node passed here isn't necessarily an OPP node, as this routine
> can also be used for cases where the "required-opps" property is present
> directly in the device's node. Rename it.
>
> This also removes a stale comment.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 4925af5c4cf0..c298de8a8308 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2487,10 +2487,9 @@ EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
>   * power domain corresponding to a DT node's "required-opps" property.
>   *
>   * @dev: Device for which the performance-state needs to be found.
> - * @opp_node: DT node where the "required-opps" property is present. This can be
> + * @np: DT node where the "required-opps" property is present. This can be
>   *     the device node itself (if it doesn't have an OPP table) or a node
>   *     within the OPP table of a device (if device has an OPP table).
> - * @state: Pointer to return performance state.
>   *
>   * Returns performance state corresponding to the "required-opps" property of
>   * a DT node. This calls platform specific genpd->opp_to_performance_state()
> @@ -2499,7 +2498,7 @@ EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
>   * Returns performance state on success and 0 on failure.
>   */
>  unsigned int of_genpd_opp_to_performance_state(struct device *dev,
> -                                              struct device_node *opp_node)
> +                                              struct device_node *np)
>  {
>         struct generic_pm_domain *genpd;
>         struct dev_pm_opp *opp;
> @@ -2514,7 +2513,7 @@ unsigned int of_genpd_opp_to_performance_state(struct device *dev,
>
>         genpd_lock(genpd);
>
> -       opp = of_dev_pm_opp_find_required_opp(&genpd->dev, opp_node);
> +       opp = of_dev_pm_opp_find_required_opp(&genpd->dev, np);
>         if (IS_ERR(opp)) {
>                 dev_err(dev, "Failed to find required OPP: %ld\n",
>                         PTR_ERR(opp));
> --
> 2.18.0.rc1.242.g61856ae69a2c
>
