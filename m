From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH V5 05/14] soc: tegra: pmc: Wait for powergate state to change
Date: Fri, 29 Jan 2016 09:58:03 -0700
Message-ID: <CANLsYkycbEo+wyMX8RJ9H-S5kDTjQR4nnDZc5gvf2kShOZAv9w@mail.gmail.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
	<1453998832-27383-6-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:34495 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932495AbcA2Q6E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jan 2016 11:58:04 -0500
Received: by mail-ob0-f178.google.com with SMTP id wb13so35008482obb.1
        for <linux-pm@vger.kernel.org>; Fri, 29 Jan 2016 08:58:03 -0800 (PST)
In-Reply-To: <1453998832-27383-6-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 28 January 2016 at 09:33, Jon Hunter <jonathanh@nvidia.com> wrote:
> Currently, the function tegra_powergate_set() simply sets the desired
> powergate state but does not wait for the state to change. In most cases
> we should wait for the state to change before proceeding. Currently, there
> is a case for tegra114 and tegra124 devices where we do not wait when
> starting the secondary CPU as this is not necessary. However, this is only
> done at boot time and so waiting here will only have a small impact on
> boot time. Therefore, update tegra_powergate_set() to wait when setting
> the powergate.
>
> By adding this feature, we can also eliminate the polling loop from
> tegra30_boot_secondary().
>
> A function has been added for checking the status of the powergate and
> so update the tegra_powergate_is_powered() to use this macro as well.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  arch/arm/mach-tegra/platsmp.c | 16 +++-------------
>  drivers/soc/tegra/pmc.c       |  9 ++++++++-
>  2 files changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
> index f3f61dbbda97..75620ae73913 100644
> --- a/arch/arm/mach-tegra/platsmp.c
> +++ b/arch/arm/mach-tegra/platsmp.c
> @@ -108,19 +108,9 @@ static int tegra30_boot_secondary(unsigned int cpu, struct task_struct *idle)
>          * be un-gated by un-toggling the power gate register
>          * manually.
>          */
> -       if (!tegra_pmc_cpu_is_powered(cpu)) {
> -               ret = tegra_pmc_cpu_power_on(cpu);
> -               if (ret)
> -                       return ret;
> -
> -               /* Wait for the power to come up. */
> -               timeout = jiffies + msecs_to_jiffies(100);
> -               while (!tegra_pmc_cpu_is_powered(cpu)) {
> -                       if (time_after(jiffies, timeout))
> -                               return -ETIMEDOUT;
> -                       udelay(10);
> -               }
> -       }
> +       ret = tegra_pmc_cpu_power_on(cpu);
> +       if (ret)
> +               return ret;
>
>  remove_clamps:
>         /* CPU partition is powered. Enable the CPU clock. */
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 99cb2fdd29e1..35ee60fd17be 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -28,6 +28,7 @@
>  #include <linux/export.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/platform_device.h>
> @@ -186,6 +187,9 @@ static inline bool tegra_powergate_state(int id)
>   */
>  static int tegra_powergate_set(unsigned int id, bool new_state)
>  {
> +       bool status;
> +       int err;
> +
>         mutex_lock(&pmc->powergates_lock);
>
>         if (tegra_powergate_state(id) == new_state) {
> @@ -195,9 +199,12 @@ static int tegra_powergate_set(unsigned int id, bool new_state)
>
>         tegra_pmc_writel(PWRGATE_TOGGLE_START | id, PWRGATE_TOGGLE);
>
> +       err = readx_poll_timeout(tegra_powergate_state, id, status,
> +                                status == new_state, 10, 100000);
> +

I understand (and agree) with the goal of this patch but I wonder (and
I don't know much about the system/context) if holding a mutex while
sleeping won't incur adverse effect on other parts of the system that
weren't use to see this wait.  One way to fix this might be to use
"mutex_trylock()" and let callers retry as they see fit if an
operation is already in progress.

>         mutex_unlock(&pmc->powergates_lock);
>
> -       return 0;
> +       return err;
>  }
>
>  /**
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
