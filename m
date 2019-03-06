From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] PM / Domains: Support enter deepest state for
 multiple states domains
Date: Wed, 6 Mar 2019 16:17:40 +0100
Message-ID: <CAPDyKFoMymoG1yUsA+aqZpYq-wNwuWQnA43kgb0SsY=p0JKgCQ@mail.gmail.com>
References: <1551878926-8455-1-git-send-email-aisheng.dong@nxp.com>
 <1551878926-8455-2-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1551878926-8455-2-git-send-email-aisheng.dong@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Aisheng Dong <aisheng.dong@nxp.com>
Cc: "dongas86@gmail.com" <dongas86@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 6 Mar 2019 at 14:35, Aisheng Dong <aisheng.dong@nxp.com> wrote:
>
> Currently the generic power domain will power off the domain if all
> devices in it have been stopped during system suspend.
>
> It is done by checking if the domain is active in genpd_sync_power_off,
> then disable it. However, for power domains supporting multiple low power
> states, it may have already entered an intermediate low power state by
> runtime PM before system suspend and the status is already
> GPD_STATE_POWER_OFF which results in then the power domain stay at an
> intermediate low power state during system suspend.
> Then genpd_sync_power_off will keep it at the low power state instead
> of completely gate off it.

I agree that this could be a concern. However, before we look for a
solution, do you have practical use case where you observes this?

>
> Let's give the power domain a chance to switch to the deepest state in
> case it's already off but in an intermediate low power state.
>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/base/power/domain.c | 18 +++++++++++++++++-
>  include/linux/pm_domain.h   |  1 +
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 61cd500..847a69e 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -959,7 +959,17 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
>  {
>         struct gpd_link *link;
>
> -       if (!genpd_status_on(genpd) || genpd_is_always_on(genpd))
> +       /*
> +        * Give the power domain a chance to switch to the deepest state in
> +        * case it's already off but in an intermediate low power state.
> +        */
> +       genpd->state_idx_saved = genpd->state_idx;
> +
> +       if (genpd_is_always_on(genpd))
> +               return;
> +
> +       if (!genpd_status_on(genpd) &&
> +           genpd->state_idx == (genpd->state_count - 1))
>                 return;

This means that the ->power_off() callback may be called twice in a
raw, for the genpd in question and in cases of multiple idle states.
It could be a problem.

Well, currently it may not be a real issue, as I doubt there is rather
few genpd backend drivers supporting multiple idle states, but still.

>
>         if (genpd->suspended_count != genpd->device_count)
> @@ -970,6 +980,9 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
>         if (_genpd_power_off(genpd, false))
>                 return;
>
> +       if (genpd->status == GPD_STATE_POWER_OFF)
> +               return;
> +
>         genpd->status = GPD_STATE_POWER_OFF;
>
>         list_for_each_entry(link, &genpd->slave_links, slave_node) {
> @@ -1017,6 +1030,9 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
>
>         _genpd_power_on(genpd, false);
>
> +       /* restore save power domain state after resume */
> +       genpd->state_idx = genpd->state_idx_saved;
> +
>         genpd->status = GPD_STATE_ACTIVE;
>  }
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 1ed5874..95db21f 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -124,6 +124,7 @@ struct generic_pm_domain {
>                 };
>         };
>
> +       unsigned int state_idx_saved; /* saved power state for recovery after system suspend/resume */
>  };
>
>  static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
> --
> 2.7.4
>

I need to think about this a bit more, let me get back to you.

Kind regards
Uffe
