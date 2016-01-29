From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH V5 02/14] soc: tegra: pmc: Protect public functions from
 potential race conditions
Date: Fri, 29 Jan 2016 09:20:47 -0700
Message-ID: <CANLsYkwpkDsdZ+6B-N8RWWWLJcJuoMLYmvw-VaCJdma4O6SPhg@mail.gmail.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
	<1453998832-27383-3-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36539 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756523AbcA2QUs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jan 2016 11:20:48 -0500
Received: by mail-oi0-f45.google.com with SMTP id o124so50111265oia.3
        for <linux-pm@vger.kernel.org>; Fri, 29 Jan 2016 08:20:48 -0800 (PST)
In-Reply-To: <1453998832-27383-3-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 28 January 2016 at 09:33, Jon Hunter <jonathanh@nvidia.com> wrote:
> The PMC base address pointer is initialised during early boot so that
> early platform code may used the PMC public functions. During the probe
> of the PMC driver the base address pointer is mapped again and the initial
> mapping is freed. This exposes a window where a device accessing the PMC
> registers via one of the public functions, could race with the updating
> of the pointer and lead to a invalid access. Furthermore, the only
> protection between multiple devices attempting to access the PMC registers
> is when setting the powergate state to on or off. None of the other public
> functions that access the PMC registers are protected.
>
> Use the existing mutex to protect paths that may race with regard to
> accessing the PMC registers.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 44 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 35 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 85b4e166273a..f8cdb7ce9755 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -235,7 +235,10 @@ int tegra_powergate_is_powered(int id)
>         if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
>                 return -EINVAL;
>
> +       mutex_lock(&pmc->powergates_lock);
>         status = tegra_pmc_readl(PWRGATE_STATUS) & (1 << id);
> +       mutex_unlock(&pmc->powergates_lock);
> +
>         return !!status;
>  }
>
> @@ -250,6 +253,8 @@ int tegra_powergate_remove_clamping(int id)
>         if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
>                 return -EINVAL;
>
> +       mutex_lock(&pmc->powergates_lock);
> +
>         /*
>          * On Tegra124 and later, the clamps for the GPU are controlled by a
>          * separate register (with different semantics).
> @@ -257,7 +262,7 @@ int tegra_powergate_remove_clamping(int id)
>         if (id == TEGRA_POWERGATE_3D) {
>                 if (pmc->soc->has_gpu_clamps) {
>                         tegra_pmc_writel(0, GPU_RG_CNTRL);
> -                       return 0;
> +                       goto out;
>                 }
>         }
>
> @@ -274,6 +279,9 @@ int tegra_powergate_remove_clamping(int id)
>
>         tegra_pmc_writel(mask, REMOVE_CLAMPING);
>
> +out:
> +       mutex_unlock(&pmc->powergates_lock);
> +
>         return 0;
>  }
>  EXPORT_SYMBOL(tegra_powergate_remove_clamping);
> @@ -520,9 +528,11 @@ int tegra_io_rail_power_on(int id)
>         unsigned int bit, mask;
>         int err;
>
> +       mutex_lock(&pmc->powergates_lock);
> +
>         err = tegra_io_rail_prepare(id, &request, &status, &bit);
>         if (err < 0)
> -               return err;
> +               goto error;
>
>         mask = 1 << bit;
>
> @@ -535,12 +545,15 @@ int tegra_io_rail_power_on(int id)
>         err = tegra_io_rail_poll(status, mask, 0, 250);
>         if (err < 0) {
>                 pr_info("tegra_io_rail_poll() failed: %d\n", err);
> -               return err;
> +               goto error;
>         }
>
>         tegra_io_rail_unprepare();
>
> -       return 0;
> +error:
> +       mutex_unlock(&pmc->powergates_lock);
> +
> +       return err < 0 ? err : 0;

Is this necessary?  Why simply not returning 'err'?  From what I see
'tegra_io_rail_power_on()' can only return a negative value or '0'.

>  }
>  EXPORT_SYMBOL(tegra_io_rail_power_on);
>
> @@ -550,10 +563,12 @@ int tegra_io_rail_power_off(int id)
>         unsigned int bit, mask;
>         int err;
>
> +       mutex_lock(&pmc->powergates_lock);
> +
>         err = tegra_io_rail_prepare(id, &request, &status, &bit);
>         if (err < 0) {
>                 pr_info("tegra_io_rail_prepare() failed: %d\n", err);
> -               return err;
> +               goto error;
>         }
>
>         mask = 1 << bit;
> @@ -566,11 +581,14 @@ int tegra_io_rail_power_off(int id)
>
>         err = tegra_io_rail_poll(status, mask, mask, 250);
>         if (err < 0)
> -               return err;
> +               goto error;
>
>         tegra_io_rail_unprepare();
>
> -       return 0;
> +error:
> +       mutex_unlock(&pmc->powergates_lock);
> +
> +       return err < 0 ? err : 0;

Same comment as above.

>  }
>  EXPORT_SYMBOL(tegra_io_rail_power_off);
>
> @@ -817,9 +835,15 @@ static int tegra_pmc_probe(struct platform_device *pdev)
>
>         /* take over the memory region from the early initialization */
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +       mutex_lock(&pmc->powergates_lock);
>         pmc->base = devm_ioremap_resource(&pdev->dev, res);
> -       if (IS_ERR(pmc->base))
> -               return PTR_ERR(pmc->base);
> +       mutex_unlock(&pmc->powergates_lock);

Since the mutex is released there is a window of opportunity for
devices to access an erroneous pointer.  A better approach might be to
use a temporary variable, do all the initialisation that is required
and when things look good set pmc-base to that temporary variable.

Mathieu

> +
> +       if (IS_ERR(pmc->base)) {
> +               err = PTR_ERR(pmc->base);
> +               goto error;
> +       }
>
>         pmc->clk = devm_clk_get(&pdev->dev, "pclk");
>         if (IS_ERR(pmc->clk)) {
> @@ -853,7 +877,9 @@ static int tegra_pmc_probe(struct platform_device *pdev)
>         return 0;
>
>  error:
> +       mutex_lock(&pmc->powergates_lock);
>         pmc->base = base;
> +       mutex_unlock(&pmc->powergates_lock);
>
>         return err;
>  }
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
