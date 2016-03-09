From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH V2] PM / clk: Add support for obtaining clocks from device-tree
Date: Wed, 9 Mar 2016 15:13:40 +0100
Message-ID: <CAMuHMdXsP=nqC7fkecnSQQjT4cg=LrY3mWoS4TrJ=GwAkRWASw@mail.gmail.com>
References: <1457529213-2581-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457529213-2581-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Jon,

On Wed, Mar 9, 2016 at 2:13 PM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
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
> ---
>
> Changes v1-v2:
> - Added support for optional filter function as suggested by Geert U.

Thanks for the update!

> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> index 272a52ebafc0..0c2213145b4a 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -137,6 +137,82 @@ int pm_clk_add_clk(struct device *dev, struct clk *clk)
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
> +int of_pm_clk_add_clks(struct device *dev,
> +                      bool (*of_pm_clk_filter)(struct of_phandle_args *args))

const struct of_phandle_args *args

I'd also like a "void *data" argument, for both of_pm_clk_add_clks and
of_pm_clk_filter, to be passed to the filter function.

The code looks OK to me.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
