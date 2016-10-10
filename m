From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/8] PM / Domains: Make genpd state allocation dynamic
Date: Mon, 10 Oct 2016 10:40:33 +0200
Message-ID: <CAPDyKFo1wFdNo3hR9WUZJ=sonKi4_sWb1PUFvPvyHeavbvqLvw@mail.gmail.com>
References: <1475879821-8035-1-git-send-email-lina.iyer@linaro.org>
 <1475879821-8035-2-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1475879821-8035-2-git-send-email-lina.iyer@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, Axel Haslam <ahaslam+renesas@baylibre.com>, Brendan Jackman <brendan.jackman@arm.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Andy Gross <andy.gross@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 8 October 2016 at 00:36, Lina Iyer <lina.iyer@linaro.org> wrote:
> Allow PM Domain states to be defined dynamically by the drivers. This
> removes the limitation on the maximum number of states possible for a
> domain.
>
> Cc: Axel Haslam <ahaslam+renesas@baylibre.com>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  arch/arm/mach-imx/gpc.c     | 17 ++++++++++-------
>  drivers/base/power/domain.c | 36 ++++++++++++++++++++++++------------
>  include/linux/pm_domain.h   |  5 ++---
>  3 files changed, 36 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
> index 0df062d..57a410b 100644
> --- a/arch/arm/mach-imx/gpc.c
> +++ b/arch/arm/mach-imx/gpc.c
> @@ -380,13 +380,6 @@ static struct pu_domain imx6q_pu_domain = {
>                 .name = "PU",
>                 .power_off = imx6q_pm_pu_power_off,
>                 .power_on = imx6q_pm_pu_power_on,
> -               .states = {
> -                       [0] = {
> -                               .power_off_latency_ns = 25000,
> -                               .power_on_latency_ns = 2000000,
> -                       },
> -               },
> -               .state_count = 1,
>         },
>  };
>
> @@ -430,6 +423,16 @@ static int imx_gpc_genpd_init(struct device *dev, struct regulator *pu_reg)
>         if (!IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS))
>                 return 0;
>
> +       imx6q_pu_domain.base.states = devm_kzalloc(dev,
> +                                       sizeof(*imx6q_pu_domain.base.states),
> +                                       GFP_KERNEL);
> +       if (!imx6q_pu_domain.base.states)
> +               return -ENOMEM;
> +
> +       imx6q_pu_domain.base.states[0].power_off_latency_ns = 25000;
> +       imx6q_pu_domain.base.states[0].power_on_latency_ns = 2000000;
> +       imx6q_pu_domain.base.state_count = 1;
> +
>         pm_genpd_init(&imx6q_pu_domain.base, NULL, false);
>         return of_genpd_add_provider_onecell(dev->of_node,
>                                              &imx_gpc_onecell_data);
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index e023066..4e87170 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1282,6 +1282,21 @@ out:
>  }
>  EXPORT_SYMBOL_GPL(pm_genpd_remove_subdomain);
>
> +static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
> +{
> +       struct genpd_power_state *state;
> +
> +       state = kzalloc(sizeof(*state), GFP_KERNEL);
> +       if (!state)
> +               return -ENOMEM;
> +
> +       genpd->states = state;
> +       genpd->state_count = 1;
> +       genpd->free = state;
> +
> +       return 0;
> +}
> +
>  /**
>   * pm_genpd_init - Initialize a generic I/O PM domain object.
>   * @genpd: PM domain object to initialize.
> @@ -1293,6 +1308,8 @@ EXPORT_SYMBOL_GPL(pm_genpd_remove_subdomain);
>  int pm_genpd_init(struct generic_pm_domain *genpd,
>                   struct dev_power_governor *gov, bool is_off)
>  {
> +       int ret;
> +
>         if (IS_ERR_OR_NULL(genpd))
>                 return -EINVAL;
>
> @@ -1325,19 +1342,12 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>                 genpd->dev_ops.start = pm_clk_resume;
>         }
>
> -       if (genpd->state_idx >= GENPD_MAX_NUM_STATES) {
> -               pr_warn("Initial state index out of bounds.\n");
> -               genpd->state_idx = GENPD_MAX_NUM_STATES - 1;
> -       }
> -
> -       if (genpd->state_count > GENPD_MAX_NUM_STATES) {
> -               pr_warn("Limiting states to  %d\n", GENPD_MAX_NUM_STATES);
> -               genpd->state_count = GENPD_MAX_NUM_STATES;
> -       }
> -
>         /* Use only one "off" state if there were no states declared */
> -       if (genpd->state_count == 0)
> -               genpd->state_count = 1;
> +       if (genpd->state_count == 0) {
> +               ret = genpd_set_default_power_state(genpd);
> +               if (ret)
> +                       return ret;
> +       }
>
>         mutex_lock(&gpd_list_lock);
>         list_add(&genpd->gpd_list_node, &gpd_list);
> @@ -1374,6 +1384,8 @@ static int genpd_remove(struct generic_pm_domain *genpd)
>                 kfree(link);
>         }
>
> +       kfree(genpd->free);
> +

To be safe, let's move this after cancel_work_sync() - as to prevent
no accesses is made to ->states pointer after you have freed it.

>         list_del(&genpd->gpd_list_node);
>         mutex_unlock(&genpd->lock);
>         cancel_work_sync(&genpd->power_off_work);
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index a09fe5c..de1d8f3 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -19,8 +19,6 @@
>  /* Defines used for the flags field in the struct generic_pm_domain */
>  #define GENPD_FLAG_PM_CLK      (1U << 0) /* PM domain uses PM clk */
>
> -#define GENPD_MAX_NUM_STATES   8 /* Number of possible low power states */
> -
>  enum gpd_status {
>         GPD_STATE_ACTIVE = 0,   /* PM domain is active */
>         GPD_STATE_POWER_OFF,    /* PM domain is off */
> @@ -70,9 +68,10 @@ struct generic_pm_domain {
>         void (*detach_dev)(struct generic_pm_domain *domain,
>                            struct device *dev);
>         unsigned int flags;             /* Bit field of configs for genpd */
> -       struct genpd_power_state states[GENPD_MAX_NUM_STATES];
> +       struct genpd_power_state *states;
>         unsigned int state_count; /* number of states */
>         unsigned int state_idx; /* state that genpd will go to when off */
> +       void *free; /* Free the state that was allocated for default */
>
>  };
>
> --
> 2.7.4
>

After the minor change suggested above, you may add my ack.

Kind regards
Uffe
