From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 2/9] OPP: Separate out custom OPP handler specific code
Date: Fri, 12 Oct 2018 17:11:30 +0200
Message-ID: <CAPDyKFpgcJ-VUpjYn5q+ut80BXe6S2ZAWVNoX2zBoLmzY9p_Fg@mail.gmail.com>
References: <cover.1539341929.git.viresh.kumar@linaro.org> <8e654324f879a04eb0c93493402520f024d2bc17.1539341929.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8e654324f879a04eb0c93493402520f024d2bc17.1539341929.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Niklas Cassel <niklas.cassel@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12 October 2018 at 13:11, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Create a separate routine to take care of custom set_opp() handler
> specific stuff.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/opp/core.c | 67 +++++++++++++++++++++++++++-------------------
>  1 file changed, 40 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 2c2df4e4fc14..ebb3b648e0fd 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -635,6 +635,34 @@ static int _generic_set_opp_regulator(const struct opp_table *opp_table,
>         return ret;
>  }
>
> +static int _set_opp_custom(const struct opp_table *opp_table,
> +                          struct device *dev, unsigned long old_freq,
> +                          unsigned long freq,
> +                          struct dev_pm_opp_supply *old_supply,
> +                          struct dev_pm_opp_supply *new_supply)
> +{
> +       struct dev_pm_set_opp_data *data;
> +       int size;
> +
> +       data = opp_table->set_opp_data;
> +       data->regulators = opp_table->regulators;
> +       data->regulator_count = opp_table->regulator_count;
> +       data->clk = opp_table->clk;
> +       data->dev = dev;
> +
> +       data->old_opp.rate = old_freq;
> +       size = sizeof(*old_supply) * opp_table->regulator_count;
> +       if (IS_ERR(old_supply))
> +               memset(data->old_opp.supplies, 0, size);
> +       else
> +               memcpy(data->old_opp.supplies, old_supply, size);
> +
> +       data->new_opp.rate = freq;
> +       memcpy(data->new_opp.supplies, new_supply, size);
> +
> +       return opp_table->set_opp(data);
> +}
> +
>  /**
>   * dev_pm_opp_set_rate() - Configure new OPP based on frequency
>   * @dev:        device for which we do this operation
> @@ -649,7 +677,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>         unsigned long freq, old_freq;
>         struct dev_pm_opp *old_opp, *opp;
>         struct clk *clk;
> -       int ret, size;
> +       int ret;
>
>         if (unlikely(!target_freq)) {
>                 dev_err(dev, "%s: Invalid target frequency %lu\n", __func__,
> @@ -702,8 +730,17 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>         dev_dbg(dev, "%s: switching OPP: %lu Hz --> %lu Hz\n", __func__,
>                 old_freq, freq);
>
> -       /* Only frequency scaling */
> -       if (!opp_table->regulators) {
> +       if (opp_table->set_opp) {
> +               ret = _set_opp_custom(opp_table, dev, old_freq, freq,
> +                                     IS_ERR(old_opp) ? NULL : old_opp->supplies,
> +                                     opp->supplies);
> +       } else if (opp_table->regulators) {
> +               ret = _generic_set_opp_regulator(opp_table, dev, old_freq, freq,
> +                                                IS_ERR(old_opp) ? NULL : old_opp->supplies,
> +                                                opp->supplies);
> +       } else {
> +               /* Only frequency scaling */
> +
>                 /*
>                  * We don't support devices with both regulator and
>                  * domain performance-state for now.
> @@ -714,30 +751,6 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>                                                       opp->pstate);
>                 else
>                         ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
> -       } else if (!opp_table->set_opp) {
> -               ret = _generic_set_opp_regulator(opp_table, dev, old_freq, freq,
> -                                                IS_ERR(old_opp) ? NULL : old_opp->supplies,
> -                                                opp->supplies);
> -       } else {
> -               struct dev_pm_set_opp_data *data;
> -
> -               data = opp_table->set_opp_data;
> -               data->regulators = opp_table->regulators;
> -               data->regulator_count = opp_table->regulator_count;
> -               data->clk = clk;
> -               data->dev = dev;
> -
> -               data->old_opp.rate = old_freq;
> -               size = sizeof(*opp->supplies) * opp_table->regulator_count;
> -               if (IS_ERR(old_opp))
> -                       memset(data->old_opp.supplies, 0, size);
> -               else
> -                       memcpy(data->old_opp.supplies, old_opp->supplies, size);
> -
> -               data->new_opp.rate = freq;
> -               memcpy(data->new_opp.supplies, opp->supplies, size);
> -
> -               ret = opp_table->set_opp(data);
>         }
>
>         dev_pm_opp_put(opp);
> --
> 2.18.0.rc1.242.g61856ae69a2c
>
