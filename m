From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V7 3/4] soc: tegra: pmc: Add generic PM domain support
Date: Tue, 8 Mar 2016 22:28:54 +0100
Message-ID: <CAPDyKFooBRk4Od=pgEnK8Uvq6Y+5O9uK5Ej9Z4gJn1W=imPvdw@mail.gmail.com>
References: <1457094186-15786-1-git-send-email-jonathanh@nvidia.com>
	<1457094186-15786-4-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:32844 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbcCHV24 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2016 16:28:56 -0500
Received: by mail-wm0-f51.google.com with SMTP id l68so167560355wml.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Mar 2016 13:28:55 -0800 (PST)
In-Reply-To: <1457094186-15786-4-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 4 March 2016 at 13:23, Jon Hunter <jonathanh@nvidia.com> wrote:
> Adds generic PM support to the PMC driver where the PM domains are
> populated from device-tree and the PM domain consumer devices are
> bound to their relevant PM domains via device-tree as well.
>
> Update the tegra_powergate_sequence_power_up() API so that internally
> it calls the same tegra_powergate_xxx functions that are used by the
> tegra generic power domain code for consistency.
>
> To ensure that the Tegra power domains (a.k.a powergates) cannot be
> controlled via both the legacy tegra_powergate_xxx functions as well
> as the generic PM domain framework, add a bit map for available
> powergates that can be controlled via the legacy powergate functions.
>
> Move the majority of the tegra_powergate_remove_clamping() function
> to a sub-function, so that this can be used by both the legacy and
> generic power domain code.
>
> Currently, the power domains are not removed once added because this
> is not yet supported by the PM domains framework. An error message
> will be displayed if we are unable to instantiate a power domain.
>
> This is based upon work by Thierry Reding <treding@nvidia.com>
> and Vince Hsu <vinceh@nvidia.com>.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 485 ++++++++++++++++++++++++++++++++++++++++++------
>  include/soc/tegra/pmc.h |   1 +
>  2 files changed, 425 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 08966c26d65c..bb173456bbff 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -31,10 +31,13 @@
>  #include <linux/iopoll.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/reboot.h>
>  #include <linux/reset.h>
>  #include <linux/seq_file.h>
> +#include <linux/slab.h>
>  #include <linux/spinlock.h>
>
>  #include <soc/tegra/common.h>
> @@ -102,6 +105,16 @@
>
>  #define GPU_RG_CNTRL                   0x2d4
>
> +struct tegra_powergate {
> +       struct generic_pm_domain genpd;
> +       struct tegra_pmc *pmc;
> +       unsigned int id;
> +       struct clk **clks;
> +       unsigned int num_clks;
> +       struct reset_control **resets;
> +       unsigned int num_resets;
> +};
> +
>  struct tegra_pmc_soc {
>         unsigned int num_powergates;
>         const char *const *powergates;
> @@ -132,6 +145,7 @@ struct tegra_pmc_soc {
>   * @cpu_pwr_good_en: CPU power good signal is enabled
>   * @lp0_vec_phys: physical base address of the LP0 warm boot code
>   * @lp0_vec_size: size of the LP0 warm boot code
> + * @powergates_available: Bitmap of available power gates
>   * @powergates_lock: mutex for power gate register access
>   */
>  struct tegra_pmc {
> @@ -156,6 +170,7 @@ struct tegra_pmc {
>         bool cpu_pwr_good_en;
>         u32 lp0_vec_phys;
>         u32 lp0_vec_size;
> +       DECLARE_BITMAP(powergates_available, TEGRA_POWERGATE_MAX);
>
>         struct mutex powergates_lock;
>  };
> @@ -165,6 +180,12 @@ static struct tegra_pmc *pmc = &(struct tegra_pmc) {
>         .suspend_mode = TEGRA_SUSPEND_NONE,
>  };
>
> +static inline struct tegra_powergate *
> +to_powergate(struct generic_pm_domain *domain)
> +{
> +       return container_of(domain, struct tegra_powergate, genpd);
> +}
> +
>  static u32 tegra_pmc_readl(unsigned long offset)
>  {
>         return readl(pmc->base + offset);
> @@ -188,6 +209,31 @@ static inline bool tegra_powergate_is_valid(int id)
>         return (pmc->soc && pmc->soc->powergates[id]);
>  }
>
> +static inline bool tegra_powergate_is_available(int id)
> +{
> +       return test_bit(id, pmc->powergates_available);
> +}
> +
> +static int tegra_powergate_lookup(struct tegra_pmc *pmc, const char *name)
> +{
> +       unsigned int i;
> +
> +       if (!pmc || !pmc->soc || !name)
> +               return -EINVAL;
> +
> +       for (i = 0; i < pmc->soc->num_powergates; i++) {
> +               if (!tegra_powergate_is_valid(i))
> +                       continue;
> +
> +               if (!strcmp(name, pmc->soc->powergates[i]))
> +                       return i;

Instead of having this name based lookup, why not provide the id using
DT instead?

In other words use of_genpd_add_provider_onecell() when adding the OF
genpd provider. In that way I think you will get a bit simplier code
dealing with the error path when initialzing the genpds, won't you?

Anyway, I guess it's more a matter of taste, so feel free to keep as is.

[...]

Kind regards
Uffe
