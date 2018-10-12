From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 1/9] OPP: Identify and mark genpd OPP tables
Date: Fri, 12 Oct 2018 17:11:25 +0200
Message-ID: <CAPDyKFrKCDnc_0fXFKpzzUJrvNx4QHft1FmHBWN26Z1v6e1FRA@mail.gmail.com>
References: <cover.1539341929.git.viresh.kumar@linaro.org> <8130f5e3128fbd0dd34b02dbca9cde2b042d2494.1539341929.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8130f5e3128fbd0dd34b02dbca9cde2b042d2494.1539341929.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Niklas Cassel <niklas.cassel@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12 October 2018 at 13:11, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> We need to handle genpd OPP tables differently, this is already the case
> at one location and will be extended going forward. Add another field to
> the OPP table to check if the table belongs to a genpd or not.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/opp/of.c  | 6 ++++--
>  drivers/opp/opp.h | 2 ++
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 5a4b47958073..5f114cd3d88c 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -92,6 +92,9 @@ void _of_init_opp_table(struct opp_table *opp_table, struct device *dev,
>         of_property_read_u32(np, "voltage-tolerance",
>                              &opp_table->voltage_tolerance_v1);
>
> +       if (of_find_property(np, "#power-domain-cells", NULL))
> +               opp_table->is_genpd = true;
> +
>         /* Get OPP table node */
>         opp_np = _opp_of_get_opp_desc_node(np, index);
>         of_node_put(np);
> @@ -326,8 +329,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>         ret = of_property_read_u64(np, "opp-hz", &rate);
>         if (ret < 0) {
>                 /* "opp-hz" is optional for devices like power domains. */
> -               if (!of_find_property(dev->of_node, "#power-domain-cells",
> -                                     NULL)) {
> +               if (!opp_table->is_genpd) {
>                         dev_err(dev, "%s: opp-hz not found\n", __func__);
>                         goto free_opp;
>                 }
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index 9c6544b4f4f9..cdb0c2b095e2 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -140,6 +140,7 @@ enum opp_table_access {
>   * @regulators: Supply regulators
>   * @regulator_count: Number of power supply regulators
>   * @genpd_performance_state: Device's power domain support performance state.
> + * @is_genpd: Marks if the OPP table belongs to a genpd.
>   * @set_opp: Platform specific set_opp callback
>   * @set_opp_data: Data to be passed to set_opp callback
>   * @dentry:    debugfs dentry pointer of the real device directory (not links).
> @@ -178,6 +179,7 @@ struct opp_table {
>         struct regulator **regulators;
>         unsigned int regulator_count;
>         bool genpd_performance_state;
> +       bool is_genpd;
>
>         int (*set_opp)(struct dev_pm_set_opp_data *data);
>         struct dev_pm_set_opp_data *set_opp_data;
> --
> 2.18.0.rc1.242.g61856ae69a2c
>
