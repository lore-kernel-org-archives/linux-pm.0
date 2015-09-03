From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 5/7] staging: board: Add support for devices with
 complex dependencies
Date: Thu, 3 Sep 2015 14:53:56 +0200
Message-ID: <CAPDyKFqouMeTKuXyyohH-VDmWXH+TiLNDT-7MKFa_-TqeF2WSw@mail.gmail.com>
References: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
	<1434530336-15073-6-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1434530336-15073-6-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <damm+renesas@opensource.se>, Arnd Bergmann <arnd@arndb.de>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marc Zyngier <marc.zyngier@arm.com>, devel@driverdev.osuosl.org, Linux-sh list <linux-sh@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 17 June 2015 at 10:38, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> Add support for easy registering of one ore more platform devices that
> may:
>   - need clocks that are described in DT,
>   - be part of a PM Domain.
>
> All these dependencies are optional.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Drop support for pinctrl, use standard pinctrl in DT instead,
>   - Drop support for configured GPIOs, use "gpio-hog" in DT instead,
>   - Use clk_add_alias() instead of open coding,
>   - Update for changed function names,
>   - Drop RFC status.
> ---
>  drivers/staging/board/board.c | 56 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/staging/board/board.h | 20 ++++++++++++++++
>  2 files changed, 76 insertions(+)
>
> diff --git a/drivers/staging/board/board.c b/drivers/staging/board/board.c
> index 8712f566b31196e0..29d456e29f38feac 100644
> --- a/drivers/staging/board/board.c
> +++ b/drivers/staging/board/board.c
> @@ -9,6 +9,7 @@
>
>  #define pr_fmt(fmt)    "board_staging: "  fmt
>
> +#include <linux/clkdev.h>
>  #include <linux/init.h>
>  #include <linux/irq.h>
>  #include <linux/device.h>
> @@ -16,6 +17,8 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>
>  #include "board.h"
>
> @@ -118,3 +121,56 @@ void __init board_staging_gic_fixup_resources(struct resource *res,
>         for (i = 0; i < nres; i++)
>                 gic_fixup_resource(&res[i]);
>  }
> +
> +int __init board_staging_register_clock(const struct board_staging_clk *bsc)
> +{
> +       int error;
> +
> +       pr_debug("Aliasing clock %s for con_id %s dev_id %s\n", bsc->clk,
> +                bsc->con_id, bsc->dev_id);
> +       error = clk_add_alias(bsc->con_id, bsc->dev_id, bsc->clk, NULL);
> +       if (error)
> +               pr_err("Failed to alias clock %s (%d)\n", bsc->clk, error);
> +
> +       return error;
> +}
> +
> +int __init board_staging_register_device(const struct board_staging_dev *dev)
> +{
> +       struct platform_device *pdev = dev->pdev;
> +       unsigned int i;
> +       int error;
> +
> +       pr_debug("Trying to register device %s\n", pdev->name);
> +       if (board_staging_dt_node_available(pdev->resource,
> +                                           pdev->num_resources)) {
> +               pr_warn("Skipping %s, already in DT\n", pdev->name);
> +               return -EEXIST;
> +       }
> +
> +       board_staging_gic_fixup_resources(pdev->resource, pdev->num_resources);
> +
> +       for (i = 0; i < dev->nclocks; i++)
> +               board_staging_register_clock(&dev->clocks[i]);
> +
> +       error = platform_device_register(pdev);
> +       if (error) {
> +               pr_err("Failed to register device %s (%d)\n", pdev->name,
> +                      error);
> +               return error;
> +       }
> +
> +       if (dev->domain)
> +               __pm_genpd_name_add_device(dev->domain, &pdev->dev, NULL);

Urgh, this managed to slip through my filters.

It seems like we almost managed to remove all users of the
"..._name_add..." APIs for genpd. If hasn't been for $subject patch.
:-)

Now, I realize this is already too late here, but let's try to fix
this before it turns into a bigger issue.

Geert, do you think it's possible to convert into using the non-named
bases APIs?

Kind regards
Uffe
