From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 4/9] OPP: Populate OPPs from "required-opps" property
Date: Fri, 12 Oct 2018 17:11:39 +0200
Message-ID: <CAPDyKFoQh9W9yxjYrcMaLu9A8KPQ+PS71=6fOh4j1122R6JQsQ@mail.gmail.com>
References: <cover.1539341929.git.viresh.kumar@linaro.org> <16fe09d146a2bcd892a62fec595252b1cb2e539d.1539341929.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <16fe09d146a2bcd892a62fec595252b1cb2e539d.1539341929.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Niklas Cassel <niklas.cassel@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12 October 2018 at 13:11, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> An earlier commit populated the OPP tables from the "required-opps"
> property, this commit populates the individual OPPs. This is repeated
> for each OPP in the OPP table and these populated OPPs will be used by
> later commits.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/opp/core.c |  1 +
>  drivers/opp/of.c   | 81 ++++++++++++++++++++++++++++++++++++++++++++--
>  drivers/opp/opp.h  |  6 ++++
>  3 files changed, 86 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 85174a5c4850..02a69a62dac8 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -976,6 +976,7 @@ static void _opp_kref_release(struct kref *kref)
>          * frequency/voltage list.
>          */
>         blocking_notifier_call_chain(&opp_table->head, OPP_EVENT_REMOVE, opp);
> +       _of_opp_free_required_opps(opp_table, opp);
>         opp_debug_remove_one(opp);
>         list_del(&opp->node);
>         kfree(opp);
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index b5605196122a..ffaeefef98ce 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -259,6 +259,77 @@ void _of_clear_opp_table(struct opp_table *opp_table)
>         _opp_table_free_required_tables(opp_table);
>  }
>
> +/*
> + * Release all resources previously acquired with a call to
> + * _of_opp_alloc_required_opps().
> + */
> +void _of_opp_free_required_opps(struct opp_table *opp_table,
> +                               struct dev_pm_opp *opp)
> +{
> +       struct dev_pm_opp **required_opps = opp->required_opps;
> +       int i;
> +
> +       if (!required_opps)
> +               return;
> +
> +       for (i = 0; i < opp_table->required_opp_count; i++) {
> +               if (!required_opps[i])
> +                       break;
> +
> +               /* Put the reference back */
> +               dev_pm_opp_put(required_opps[i]);
> +       }
> +
> +       kfree(required_opps);
> +       opp->required_opps = NULL;
> +}
> +
> +/* Populate all required OPPs which are part of "required-opps" list */
> +static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
> +                                      struct dev_pm_opp *opp)
> +{
> +       struct dev_pm_opp **required_opps;
> +       struct opp_table *required_table;
> +       struct device_node *np;
> +       int i, ret, count = opp_table->required_opp_count;
> +
> +       if (!count)
> +               return 0;
> +
> +       required_opps = kcalloc(count, sizeof(*required_opps), GFP_KERNEL);
> +       if (!required_opps)
> +               return -ENOMEM;
> +
> +       opp->required_opps = required_opps;
> +
> +       for (i = 0; i < count; i++) {
> +               required_table = opp_table->required_opp_tables[i];
> +
> +               np = of_parse_required_opp(opp->np, i);
> +               if (unlikely(!np)) {
> +                       ret = -ENODEV;
> +                       goto free_required_opps;
> +               }
> +
> +               required_opps[i] = _find_opp_of_np(required_table, np);
> +               of_node_put(np);
> +
> +               if (!required_opps[i]) {
> +                       pr_err("%s: Unable to find required OPP node: %pOF (%d)\n",
> +                              __func__, opp->np, i);
> +                       ret = -ENODEV;
> +                       goto free_required_opps;
> +               }
> +       }
> +
> +       return 0;
> +
> +free_required_opps:
> +       _of_opp_free_required_opps(opp_table, opp);
> +
> +       return ret;
> +}
> +
>  static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
>                               struct device_node *np)
>  {
> @@ -503,6 +574,10 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>         new_opp->dynamic = false;
>         new_opp->available = true;
>
> +       ret = _of_opp_alloc_required_opps(opp_table, new_opp);
> +       if (ret)
> +               goto free_opp;
> +
>         if (!of_property_read_u32(np, "clock-latency-ns", &val))
>                 new_opp->clock_latency_ns = val;
>
> @@ -510,14 +585,14 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>
>         ret = opp_parse_supplies(new_opp, dev, opp_table);
>         if (ret)
> -               goto free_opp;
> +               goto free_required_opps;
>
>         ret = _opp_add(dev, new_opp, opp_table, rate_not_available);
>         if (ret) {
>                 /* Don't return error for duplicate OPPs */
>                 if (ret == -EBUSY)
>                         ret = 0;
> -               goto free_opp;
> +               goto free_required_opps;
>         }
>
>         /* OPP to select on device suspend */
> @@ -547,6 +622,8 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>         blocking_notifier_call_chain(&opp_table->head, OPP_EVENT_ADD, new_opp);
>         return new_opp;
>
> +free_required_opps:
> +       _of_opp_free_required_opps(opp_table, new_opp);
>  free_opp:
>         _opp_free(new_opp);
>
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index 024e1be23d37..24b340ad18d1 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -63,6 +63,7 @@ extern struct list_head opp_tables;
>   * @supplies:  Power supplies voltage/current values
>   * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
>   *             frequency from any other OPP's frequency.
> + * @required_opps: List of OPPs that are required by this OPP.
>   * @opp_table: points back to the opp_table struct this opp belongs to
>   * @np:                OPP's device node.
>   * @dentry:    debugfs dentry pointer (per opp)
> @@ -84,6 +85,7 @@ struct dev_pm_opp {
>
>         unsigned long clock_latency_ns;
>
> +       struct dev_pm_opp **required_opps;
>         struct opp_table *opp_table;
>
>         struct device_node *np;
> @@ -216,10 +218,14 @@ void _put_opp_list_kref(struct opp_table *opp_table);
>  void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index);
>  void _of_clear_opp_table(struct opp_table *opp_table);
>  struct opp_table *_managed_opp(struct device *dev, int index);
> +void _of_opp_free_required_opps(struct opp_table *opp_table,
> +                               struct dev_pm_opp *opp);
>  #else
>  static inline void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index) {}
>  static inline void _of_clear_opp_table(struct opp_table *opp_table) {}
>  static inline struct opp_table *_managed_opp(struct device *dev, int index) { return NULL; }
> +static inline void _of_opp_free_required_opps(struct opp_table *opp_table,
> +                                             struct dev_pm_opp *opp) {}
>  #endif
>
>  #ifdef CONFIG_DEBUG_FS
> --
> 2.18.0.rc1.242.g61856ae69a2c
>
