From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH V3] PM / clk: Add support for obtaining clocks from device-tree
Date: Thu, 10 Mar 2016 10:41:15 +0100
Message-ID: <CAMuHMdUToumZwuisg7HeOVuB7Amke7W=qpZ5f0dzavSqnjXygg@mail.gmail.com>
References: <1457600456-4283-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457600456-4283-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Jon,

On Thu, Mar 10, 2016 at 10:00 AM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> The PM clocks framework requires clients to pass either a con-id or a
> valid clk pointer in order to add a clock to a device. Add a new
> function of_pm_clk_add_clks() to allows device clocks to be retrieved
> from device-tree and populated for a given device. Note that
> of_clk_get_from_provider() is not defined if CONFIG_OF and
> CONFIG_COMMON_CLK are not selected. Therefore, make of_pm_clk_add_clks()
> dependent on these options.
>
> An optional function pointer may be passed to of_pm_clk_add_clks() that
> can be used to filter the clocks that are added for a device when
> calling of_pm_clk_add_clks().
>
> In order to handle errors encountered when adding clocks from
> device-tree, add a function pm_clk_remove_clk() to remove any clocks
> (using a pointer to the clk structure) that have been added
> successfully before the error occurred.
>
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Tested-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

But more comments below...

> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -137,6 +137,81 @@ int pm_clk_add_clk(struct device *dev, struct clk *clk)
>         return __pm_clk_add(dev, NULL, clk);
>  }
>
> +
> +#if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
> +/**
> + * of_pm_clk_add_clks - Start using device clock(s) for power management.
> + * @dev: Device whose clock(s) is going to be used for power management.
> + * @of_pm_clk_filter: Optional function for filtering clocks
> + *
> + * Add a series of clocks described in the 'clocks' device-tree node for
> + * a device to the list of clocks used for the power management of @dev.
> + * If 'of_pm_clk_filter' is specified, then this filter function will be
> + * called for each clock found and the clock will be added to the list
> + * of clocks if this function returns true. Return success if clocks are
> + * added successfully and return a negative error code if adding a clock
> + * fails or there are no clocks that match with the filter function.
> + */
> +int of_pm_clk_add_clks(struct device *dev, of_pm_clk_filter fn, void *data)
> +{

[...]

> +       count = of_count_phandle_with_args(dev->of_node, "clocks",
> +                                          "#clock-cells");
> +       if (count == 0)
> +               return -ENODEV;

[...]

+       return added ? 0 : -ENODEV;

Is it an error condition if no clocks were present in DT, or if no clocks have
been accepted by the filter function? If not, the caller has to check for
-ENODEV. Now the caller has to call pm_clk_create() first, before it knows if
any clocks will be added, it may want to call pm_clk_destroy() later if no
clocks have been added.

Alternatively, you could return 0 vs. the actual number of clocks added.

I hooked up your code in renesas-cpg-mssr.c, and it worked.
However, I noticed it added 27 clocks for one device node (rcar_sound), and
only then I realized that I only want to add the first clock accepted by the
filter, not all of them, as the others are under driver control.
I'm not sure this can be handled in the filter function.
So I can't use your code (for now)...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
