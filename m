From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/8] PM / Domains: Make genpd state allocation dynamic
Date: Thu, 6 Oct 2016 10:36:57 +0200
Message-ID: <CAPDyKFpNnJxueNNk9g7KzHPAsJVQ8xeiaw8OHMevBZ3myhd-xA@mail.gmail.com>
References: <1475699519-109623-1-git-send-email-lina.iyer@linaro.org>
 <1475699519-109623-2-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1475699519-109623-2-git-send-email-lina.iyer@linaro.org>
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

On 5 October 2016 at 22:31, Lina Iyer <lina.iyer@linaro.org> wrote:
> Allow PM Domain states to be defined dynamically by the drivers. This
> removes the limitation on the maximum number of states possible for a
> domain.
>
> Cc: Axel Haslam <ahaslam+renesas@baylibre.com>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  arch/arm/mach-imx/gpc.c     | 17 ++++++++++-------
>  drivers/base/power/domain.c | 10 ----------
>  include/linux/pm_domain.h   |  4 +---
>  3 files changed, 11 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
> index 0df062d..b92dad5 100644
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
> +       mx6q_pu_domain.base.state_count = 1,
> +
>         pm_genpd_init(&imx6q_pu_domain.base, NULL, false);
>         return of_genpd_add_provider_onecell(dev->of_node,
>                                              &imx_gpc_onecell_data);
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index e023066..740afa9 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1325,16 +1325,6 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
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
>         if (genpd->state_count == 0)
>                 genpd->state_count = 1;
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index a09fe5c..bd1ffb9 100644
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
> @@ -70,7 +68,7 @@ struct generic_pm_domain {
>         void (*detach_dev)(struct generic_pm_domain *domain,
>                            struct device *dev);
>         unsigned int flags;             /* Bit field of configs for genpd */
> -       struct genpd_power_state states[GENPD_MAX_NUM_STATES];
> +       struct genpd_power_state *states;
>         unsigned int state_count; /* number of states */
>         unsigned int state_idx; /* state that genpd will go to when off */
>
> --
> 2.7.4
>

In general I like the improvement, but..

This change implies that ->states may very well be NULL. This isn't
validated by genpd's internal logic when power off/on the domain
(genpd_power_on|off(), __default_power_down_ok()). You need to fix
this, somehow.

Perhaps the easiest solutions is, when pm_genpd_init() finds that
->state is NULL, that we allocate a struct genpd_power_state with
array size of 1 and assign it to ->states. Although, doing this also
means you need to track that genpd was responsible for the the
allocation, so it must also free the data from within genpd_remove().

Unless you have other ideas!?

Kind regards
Uffe
