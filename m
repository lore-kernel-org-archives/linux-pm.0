From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH/RFC 5/6] staging: board: Add support for devices with complex dependencies
Date: Sat, 04 Apr 2015 15:46:52 +0300
Message-ID: <34835209.cQQp4PEGGk@avalon>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be> <1428064923-24950-6-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:36536 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750AbbDDMqb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 4 Apr 2015 08:46:31 -0400
In-Reply-To: <1428064923-24950-6-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <damm+renesas@opensource.se>, Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms+renesas@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marc Zyngier <marc.zyngier@arm.com>, devel@driverdev.osuosl.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Friday 03 April 2015 14:42:02 Geert Uytterhoeven wrote:
> Add support for easy registering of one ore more platform devices that
> may:
>   - need clocks that are described in DT,
>   - need pin control configuration,
>   - rely on a configured GPIO,
>   - be part of a PM Domain.
> 
> All these dependencies are optional.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/staging/board/board.c | 76 ++++++++++++++++++++++++++++++++++++++++
>  drivers/staging/board/board.h | 31 ++++++++++++++++++
>  2 files changed, 107 insertions(+)
> 
> diff --git a/drivers/staging/board/board.c b/drivers/staging/board/board.c
> index b84ac2837a20bf06..da2469e2d4262fac 100644
> --- a/drivers/staging/board/board.c
> +++ b/drivers/staging/board/board.c
> @@ -9,6 +9,9 @@
> 
>  #define pr_fmt(fmt)	"board_staging: "  fmt
> 
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/gpio.h>
>  #include <linux/init.h>
>  #include <linux/irq.h>
>  #include <linux/device.h>
> @@ -16,6 +19,9 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> +#include <linux/pinctrl/machine.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> 
>  #include "board.h"
> 
> @@ -104,3 +110,73 @@ void __init board_staging_fixup_irq_resources(struct
> resource *res, res[i].start = virq;
>  		}
>  }
> +
> +int __init board_staging_register_clock(const struct board_staging_clk
> *bsc) +{
> +	struct clk *clk;
> +	int error;
> +
> +	pr_debug("Registering clock %s for con_id %s dev_id %s\n", bsc->clk,
> +		 bsc->con_id, bsc->dev_id);
> +	clk = clk_get(NULL, bsc->clk);
> +	if (IS_ERR(clk)) {
> +		error = PTR_ERR(clk);
> +		pr_err("Failed to get clock %s (%d)\n", bsc->clk, error);
> +		return error;
> +	}
> +
> +	error = clk_register_clkdev(clk, bsc->con_id, bsc->dev_id);
> +	if (error)
> +		pr_err("Failed to register clock %s (%d)\n", bsc->clk, error);
> +		return error;
> +
> +	clk_put(clk);
> +	return 0;
> +}
> +
> +int __init board_staging_register_device(const struct board_staging_dev
> *dev) +{
> +	struct platform_device *pdev = dev->pdev;
> +	unsigned int i;
> +	int error;
> +
> +	pr_debug("Trying to register device %s\n", pdev->name);
> +	if (board_staging_dt_node_available(pdev->resource,
> +					    pdev->num_resources)) {
> +		pr_warn("Skipping %s, already in DT\n", pdev->name);
> +		return -EEXIST;
> +	}
> +
> +	board_staging_fixup_irq_resources(pdev->resource, pdev->num_resources);
> +
> +	for (i = 0; i < dev->nclocks; i++)
> +		board_staging_register_clock(&dev->clocks[i]);
> +
> +	if (dev->npinmaps)
> +		pinctrl_register_mappings(dev->pinmaps, dev->npinmaps);
> +
> +	for (i = 0; i < dev->ngpios; i++)
> +		gpio_request_one(dev->gpios[i].gpio, dev->gpios[i].flags,
> +				 pdev->name);

Aren't GPIO numbers dynamic too in DT-based systems ? Beside, shouldn't it be 
the responsibility of the drievr to request the GPIOs it needs ?

> +	error = platform_device_register(pdev);
> +	if (error) {
> +		pr_err("Failed to register device %s (%d)\n", pdev->name,
> +		       error);
> +		return error;
> +	}
> +
> +	if (dev->domain)
> +		__pm_genpd_name_add_device(dev->domain, &pdev->dev, NULL);
> +
> +	return error;
> +}
> +
> +void __init board_staging_register_devices(const struct board_staging_dev
> *devs, +					   unsigned int ndevs)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ndevs; i++)
> +		board_staging_register_device(&devs[i]);
> +}
> diff --git a/drivers/staging/board/board.h b/drivers/staging/board/board.h
> index 4cedc3c46e287eb7..7aaa0f7d6fafb9e5 100644
> --- a/drivers/staging/board/board.h
> +++ b/drivers/staging/board/board.h
> @@ -4,12 +4,43 @@
>  #include <linux/init.h>
>  #include <linux/of.h>
> 
> +struct board_staging_clk {
> +	const char *clk;
> +	const char *con_id;
> +	const char *dev_id;
> +};
> +
> +struct board_staging_gpio {
> +	unsigned int gpio;
> +	unsigned long flags;	/* See GPIOF_* */
> +};
> +
> +struct board_staging_dev {
> +	/* Platform Device */
> +	struct platform_device *pdev;
> +	/* Clocks (optional) */
> +	const struct board_staging_clk *clocks;
> +	unsigned int nclocks;
> +	/* Pin Control Maps (optional) */
> +	const struct pinctrl_map *pinmaps;
> +	unsigned int npinmaps;
> +	/* GPIOs (optional) */
> +	const struct board_staging_gpio *gpios;
> +	unsigned int ngpios;
> +	/* PM Domain (optional) */
> +	const char *domain;
> +};
> +
>  struct resource;
> 
>  bool board_staging_dt_node_available(const struct resource *resource,
>  				     unsigned int num_resources);
>  int board_staging_setup_hwirq_xlate(const char *irqc_match, unsigned int
> base); void board_staging_fixup_irq_resources(struct resource *res,
> unsigned int nres); +int board_staging_register_clock(const struct
> board_staging_clk *bsc); +int board_staging_register_device(const struct
> board_staging_dev *dev); +void board_staging_register_devices(const struct
> board_staging_dev *devs, +				    unsigned int ndevs);
> 
>  #define board_staging(str, fn)			\
>  static int __init runtime_board_check(void)	\

-- 
Regards,

Laurent Pinchart

