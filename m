From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 4/7] OPP: Don't return 0 on error from of_get_required_opp_performance_state()
Date: Fri, 14 Dec 2018 11:40:44 +0100
Message-ID: <CAPDyKFr9RW6G-Nj994w_F_quQNWOZiXTbOBGtjKPACaYLap-kg@mail.gmail.com>
References: <cover.1544782279.git.viresh.kumar@linaro.org> <b8efe7f3f52c7d5736df279173467cd6c40f28d2.1544782279.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b8efe7f3f52c7d5736df279173467cd6c40f28d2.1544782279.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Niklas Cassel <niklas.cassel@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 14 Dec 2018 at 11:15, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> of_get_required_opp_performance_state() returns 0 on errors currently
> and a positive performance state otherwise. Since 0 is a valid
> performance state (representing off), it would be better if this routine
> returns negative values on error.
>
> That will also make it behave similar to
> dev_pm_opp_xlate_performance_state(), which also returns performance
> states and returns negative values on error. Change the return type of
> the function to "int" in order to return negative values.
>
> This doesn't have any users for now and so no other part of the kernel
> will be impacted with this change.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/opp/of.c       | 10 +++++-----
>  include/linux/pm_opp.h |  6 +++---
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 8e57d257be77..68b512846d72 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -995,19 +995,19 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_sharing_cpus);
>   * Returns the performance state of the OPP pointed out by the "required-opps"
>   * property at @index in @np.
>   *
> - * Return: Positive performance state on success, otherwise 0 on errors.
> + * Return: Zero or positive performance state on success, otherwise negative
> + * value on errors.
>   */
> -unsigned int of_get_required_opp_performance_state(struct device_node *np,
> -                                                  int index)
> +int of_get_required_opp_performance_state(struct device_node *np, int index)
>  {
>         struct dev_pm_opp *opp;
>         struct device_node *required_np;
>         struct opp_table *opp_table;
> -       unsigned int pstate = 0;
> +       int pstate = -EINVAL;
>
>         required_np = of_parse_required_opp(np, index);
>         if (!required_np)
> -               return 0;
> +               return -EINVAL;
>
>         opp_table = _find_table_of_opp_np(required_np);
>         if (IS_ERR(opp_table)) {
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 0b04c2093eb9..0a2a88e5a383 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -321,7 +321,7 @@ void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask);
>  int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
>  struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
>  struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
> -unsigned int of_get_required_opp_performance_state(struct device_node *np, int index);
> +int of_get_required_opp_performance_state(struct device_node *np, int index);
>  #else
>  static inline int dev_pm_opp_of_add_table(struct device *dev)
>  {
> @@ -360,9 +360,9 @@ static inline struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
>  {
>         return NULL;
>  }
> -static inline unsigned int of_get_required_opp_performance_state(struct device_node *np, int index)
> +static inline int of_get_required_opp_performance_state(struct device_node *np, int index)
>  {
> -       return 0;
> +       return -ENOTSUPP;
>  }
>  #endif
>
> --
> 2.19.1.568.g152ad8e3369a
>
