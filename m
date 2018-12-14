From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 2/7] OPP: Improve _find_table_of_opp_np()
Date: Fri, 14 Dec 2018 11:40:36 +0100
Message-ID: <CAPDyKFret-vV-jSMYtJD1JFDak6HB+xShn8ps0y337EhycGs5Q@mail.gmail.com>
References: <cover.1544782279.git.viresh.kumar@linaro.org> <184bbc28f982752cc040f0b9286516c3897e2808.1544782279.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <184bbc28f982752cc040f0b9286516c3897e2808.1544782279.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Niklas Cassel <niklas.cassel@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 14 Dec 2018 at 11:15, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Make _find_table_of_opp_np() more efficient by using of_get_parent() to
> find the parent OPP table node.
>
> Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/opp/of.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 3ef7f38c0986..8e57d257be77 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -114,19 +114,25 @@ static struct device_node *of_parse_required_opp(struct device_node *np,
>  static struct opp_table *_find_table_of_opp_np(struct device_node *opp_np)
>  {
>         struct opp_table *opp_table;
> -       struct dev_pm_opp *opp;
> +       struct device_node *opp_table_np;
>
>         lockdep_assert_held(&opp_table_lock);
>
> +       opp_table_np = of_get_parent(opp_np);
> +       if (!opp_table_np)
> +               goto err;
> +
> +       /* It is safe to put the node now as all we need now is its address */
> +       of_node_put(opp_table_np);
> +
>         list_for_each_entry(opp_table, &opp_tables, node) {
> -               opp = _find_opp_of_np(opp_table, opp_np);
> -               if (opp) {
> -                       dev_pm_opp_put(opp);
> +               if (opp_table_np == opp_table->np) {
>                         _get_opp_table_kref(opp_table);
>                         return opp_table;
>                 }
>         }
>
> +err:
>         return ERR_PTR(-ENODEV);
>  }
>
> --
> 2.19.1.568.g152ad8e3369a
>
